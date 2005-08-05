Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVHEXb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVHEXb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVHEXaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:30:15 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:40205 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262064AbVHEXaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:30:09 -0400
Message-ID: <42F3F61F.30305@vmware.com>
Date: Fri, 05 Aug 2005 16:28:31 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: [PATCH,experimental] i386 Allow the fixmap to be relocated at boot
 time
Content-Type: multipart/mixed;
 boundary="------------010805070801000208010007"
X-OriginalArrivalTime: 05 Aug 2005 23:28:32.0015 (UTC) FILETIME=[647299F0:01C59A15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010805070801000208010007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This most curious patch allows the fixmap on i386 to be unfixed.  The 
result is that we can create a dynamically sizable hole at the top of 
kernel linear address space.  I know at least some virtualization 
developers are interested in being able to achieve this to achieve 
run-time sizing of a hole in which a hypervisor can live, or at least to 
test out the performance characteristics of different sized holes.

I have not run any performance numbers yet to see how much the cost of 
making this dynamic affects native performance, but again I would stress 
this is a highly experimental patch and I am looking for feedback and 
any performance data from other systems that people are kind enough to 
share.  I'm not advocating that this get pushed into the mainline Linux 
tree at this point by any means!

I believe at least the Xen folks would be interested in playing around 
with this for experimenting with different MPT and frame table sizes for 
PAE support in a way that doesn't require recompiling the Linux guest 
each time - if the performance impact proves to be negligble, this gives 
a lot of flexibility to any virtual machine which runs a hypervisor 
aware kernel.

Although I did as much as possible to make the vsyscall relocation 
appear clean to userspace, I can't guarantee this patch won't set fire 
to your chair and electrocute your cat.  Please move all pets to a safe 
location before attempting to use this.

Zachary Amsden <zach@vmware.com>

--------------010805070801000208010007
Content-Type: text/plain;
 name="linear-hole"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linear-hole"

Allow creation of an compile time hole at the top of linear address space.

Extended to allow a dynamic hole in linear address space, 7/2005.  This
required some serious hacking to get everything perfect, but the end result
appears to function quite nicely.  Everyone can now share the appreciation
of pseudo-undocumented ELF OS fields, which means core dumps, debuggers
and even broken or obsolete linkers may continue to work.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/Kconfig
===================================================================
--- linux-2.6.13.orig/arch/i386/Kconfig	2005-08-04 14:14:24.000000000 -0700
+++ linux-2.6.13/arch/i386/Kconfig	2005-08-05 15:28:42.000000000 -0700
@@ -127,6 +127,20 @@
 
 endchoice
 
+config RELOCATABLE_FIXMAP
+	bool "Allow the fixmap to be placed dynamically at runtime"
+	depends on EXPERIMENTAL
+	help
+	  Crazy hackers only.
+
+config MEMORY_HOLE
+	int "Create hole at top of memory (0-512 MB)"
+	range 0 512
+	default "0"
+	help
+	  Useful for creating a hole in the top of memory when running
+	  inside of a virtual machine monitor.
+
 config ACPI_SRAT
 	bool
 	default y
Index: linux-2.6.13/arch/i386/kernel/sysenter.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/sysenter.c	2005-08-02 17:04:12.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/sysenter.c	2005-08-05 15:47:53.000000000 -0700
@@ -46,22 +46,90 @@
 extern const char vsyscall_int80_start, vsyscall_int80_end;
 extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
 
+#ifdef CONFIG_RELOCATABLE_FIXMAP
+extern const char SYSENTER_RETURN;
+const char *SYSENTER_RETURN_ADDR;
+
+static void fixup_vsyscall_elf(char *page)
+{
+	Elf32_Ehdr *hdr;
+	Elf32_Shdr *sechdrs;
+	Elf32_Phdr *phdr;
+	char *secstrings;
+	int i, j, n;
+
+	hdr = (Elf32_Ehdr *)page;
+
+	/* Sanity checks against insmoding binaries or wrong arch,
+           weird elf version */
+	if (memcmp(hdr->e_ident, ELFMAG, 4) != 0 ||
+		!elf_check_arch(hdr) ||
+		hdr->e_type != ET_DYN)
+		panic("Bogus ELF in vsyscall DSO\n");
+
+	hdr->e_entry += VSYSCALL_RELOCATION;
+
+	sechdrs = (void *)hdr + hdr->e_shoff;
+	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (i = 1; i < hdr->e_shnum; i++) {
+		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
+			continue;
+
+		sechdrs[i].sh_addr += VSYSCALL_RELOCATION;
+		if (strcmp(secstrings+sechdrs[i].sh_name, ".dynsym") == 0) {
+			Elf32_Sym  *sym =  (void *)hdr + sechdrs[i].sh_offset;
+			n = sechdrs[i].sh_size / sizeof(*sym);
+			for (j = 1; j < n;  j++) {
+				int ndx = sym[j].st_shndx;
+				if (ndx == SHN_UNDEF || ndx == SHN_ABS)
+					continue;
+				sym[j].st_value += VSYSCALL_RELOCATION;
+			}
+		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".dynamic") == 0) {
+			Elf32_Dyn *dyn = (void *)hdr + sechdrs[i].sh_offset;
+			int tag;
+			while ((tag = (++dyn)->d_tag) != DT_NULL) {
+				if (tag == DT_PLTGOT || tag == DT_HASH ||
+				    tag == DT_STRTAB || tag == DT_SYMTAB ||
+				    tag == DT_RELA || tag == DT_INIT ||
+				    tag == DT_FINI || tag == DT_REL ||
+				    tag == DT_JMPREL || tag == DT_VERSYM ||
+				    tag == DT_VERDEF || tag == DT_VERNEED)
+					dyn->d_un.d_val += VSYSCALL_RELOCATION;
+			}
+		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".useless") == 0) {
+			uint32_t *got = (void *)hdr + sechdrs[i].sh_offset;
+			*got += VSYSCALL_RELOCATION;
+		}
+	}
+	phdr = (void *)hdr + hdr->e_phoff;
+	for (i = 0; i < hdr->e_phnum; i++) {
+		phdr[i].p_vaddr += VSYSCALL_RELOCATION;
+		phdr[i].p_paddr += VSYSCALL_RELOCATION;
+	}
+	SYSENTER_RETURN_ADDR = (char *)&SYSENTER_RETURN + VSYSCALL_RELOCATION;
+}
+#endif
+
 int __init sysenter_setup(void)
 {
 	void *page = (void *)get_zeroed_page(GFP_ATOMIC);
 
-	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY_EXEC);
-
-	if (!boot_cpu_has(X86_FEATURE_SEP)) {
+	if (!boot_cpu_has(X86_FEATURE_SEP))
 		memcpy(page,
 		       &vsyscall_int80_start,
 		       &vsyscall_int80_end - &vsyscall_int80_start);
-		return 0;
-	}
+	else
+		memcpy(page,
+			&vsyscall_sysenter_start,
+			&vsyscall_sysenter_end - &vsyscall_sysenter_start);
 
-	memcpy(page,
-	       &vsyscall_sysenter_start,
-	       &vsyscall_sysenter_end - &vsyscall_sysenter_start);
+#ifdef CONFIG_RELOCATABLE_FIXMAP
+	fixup_vsyscall_elf((char *)page);
+#endif
+
+	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY_EXEC);
 
 	return 0;
 }
Index: linux-2.6.13/arch/i386/kernel/asm-offsets.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/asm-offsets.c	2005-08-04 14:28:35.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/asm-offsets.c	2005-08-05 15:11:45.000000000 -0700
@@ -68,5 +68,9 @@
 		 sizeof(struct tss_struct));
 
 	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
+#ifdef CONFIG_RELOCATABLE_FIXMAP
+	DEFINE(VSYSCALL_BASE, 0);
+#else
 	DEFINE(VSYSCALL_BASE, __fix_to_virt(FIX_VSYSCALL));
+#endif
 }
Index: linux-2.6.13/arch/i386/kernel/signal.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/signal.c	2005-08-03 23:36:46.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/signal.c	2005-08-05 15:11:33.000000000 -0700
@@ -345,6 +345,8 @@
    See vsyscall-sigreturn.S.  */
 extern void __user __kernel_sigreturn;
 extern void __user __kernel_rt_sigreturn;
+#define kernel_sigreturn  (VSYSCALL_RELOCATION + (void __user *)&__kernel_sigreturn)
+#define kernel_rt_sigreturn  (VSYSCALL_RELOCATION + (void __user *)&__kernel_rt_sigreturn)
 
 static int setup_frame(int sig, struct k_sigaction *ka,
 		       sigset_t *set, struct pt_regs * regs)
@@ -380,7 +382,7 @@
 			goto give_sigsegv;
 	}
 
-	restorer = &__kernel_sigreturn;
+	restorer = kernel_sigreturn;
 	if (ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 
@@ -476,7 +478,7 @@
 		goto give_sigsegv;
 
 	/* Set up to return from userspace.  */
-	restorer = &__kernel_rt_sigreturn;
+	restorer = kernel_rt_sigreturn;
 	if (ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 	err |= __put_user(restorer, &frame->pretcode);
Index: linux-2.6.13/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/entry.S	2005-08-04 14:17:15.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/entry.S	2005-08-05 14:09:15.000000000 -0700
@@ -200,7 +200,11 @@
 	pushl %ebp
 	pushfl
 	pushl $(__USER_CS)
+#ifdef CONFIG_RELOCATABLE_FIXMAP
+	pushl %ss:SYSENTER_RETURN_ADDR
+#else
 	pushl $SYSENTER_RETURN
+#endif
 
 /*
  * Load the potential sixth argument from user stack.
Index: linux-2.6.13/arch/i386/mm/init.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/init.c	2005-08-04 14:39:17.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/init.c	2005-08-05 15:20:04.000000000 -0700
@@ -42,6 +42,10 @@
 
 unsigned int __VMALLOC_RESERVE = 128 << 20;
 
+#ifdef CONFIG_RELOCATABLE_FIXMAP
+unsigned long __FIXADDR_TOP = 0;
+#endif
+
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long highstart_pfn, highend_pfn;
 
@@ -478,6 +482,12 @@
 		printk("NX (Execute Disable) protection: active\n");
 #endif
 
+#ifdef CONFIG_RELOCATABLE_FIXMAP
+	if (!__FIXADDR_TOP) 
+		__FIXADDR_TOP =  0xfffff000UL-(CONFIG_MEMORY_HOLE << 20);
+	printk(KERN_INFO "Fixmap top relocated to %lxh\n", __FIXADDR_TOP);
+#endif
+
 	pagetable_init();
 
 	load_cr3(swapper_pg_dir);
Index: linux-2.6.13/include/asm-i386/fixmap.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/fixmap.h	2005-08-04 14:14:24.000000000 -0700
+++ linux-2.6.13/include/asm-i386/fixmap.h	2005-08-05 15:36:13.000000000 -0700
@@ -20,7 +20,13 @@
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  */
-#define __FIXADDR_TOP	0xfffff000
+#ifdef CONFIG_RELOCATABLE_FIXMAP
+extern unsigned long __FIXADDR_TOP;
+#define VSYSCALL_RELOCATION __fix_to_virt(FIX_VSYSCALL)
+#else
+#define __FIXADDR_TOP	(0xfffff000-(CONFIG_MEMORY_HOLE << 20))
+#define VSYSCALL_RELOCATION 0
+#endif
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
Index: linux-2.6.13/include/asm-i386/elf.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/elf.h	2005-08-02 17:06:23.000000000 -0700
+++ linux-2.6.13/include/asm-i386/elf.h	2005-08-05 15:31:32.000000000 -0700
@@ -129,7 +129,7 @@
 
 #define VSYSCALL_BASE	(__fix_to_virt(FIX_VSYSCALL))
 #define VSYSCALL_EHDR	((const struct elfhdr *) VSYSCALL_BASE)
-#define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
+#define VSYSCALL_ENTRY	((unsigned long) (VSYSCALL_RELOCATION+&__kernel_vsyscall))
 extern void __kernel_vsyscall;
 
 #define ARCH_DLINFO						\
Index: linux-2.6.13/include/linux/elf.h
===================================================================
--- linux-2.6.13.orig/include/linux/elf.h	2005-08-02 17:06:24.000000000 -0700
+++ linux-2.6.13/include/linux/elf.h	2005-08-05 12:06:17.000000000 -0700
@@ -138,6 +138,9 @@
 #define DT_DEBUG	21
 #define DT_TEXTREL	22
 #define DT_JMPREL	23
+#define DT_VERSYM	0x6ffffff0
+#define DT_VERDEF	0x6ffffffc
+#define DT_VERNEED	0x6ffffffe
 #define DT_LOPROC	0x70000000
 #define DT_HIPROC	0x7fffffff
 

--------------010805070801000208010007--
