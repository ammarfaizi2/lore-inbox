Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWCNHQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWCNHQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 02:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbWCNHQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 02:16:53 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47116 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752292AbWCNHQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 02:16:52 -0500
Message-ID: <44166D6B.4090701@vmware.com>
Date: Mon, 13 Mar 2006 23:14:51 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 7/24] i386 Vmi memory hole
References: <200603131804.k2DI4N6s005678@zach-dev.vmware.com> <20060314064107.GK12807@sorel.sous-sol.org>
In-Reply-To: <20060314064107.GK12807@sorel.sous-sol.org>
Content-Type: multipart/mixed;
 boundary="------------010109000308060700020800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010109000308060700020800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
>   
>> Create a configurable hole in the linear address space at the top
>> of memory.  A more advanced interface is needed to negotiate how
>> much space the hypervisor is allowed to steal, but in the end, it
>> seems most likely that a fixed constant size will be chosen for
>> the compiled kernel, potentially propagated to an information
>> page used by paravirtual initialization to determine interface
>> compatibility.
>>
>> Signed-off-by: Zachary Amsden <zach@vmware.com>
>>
>> Index: linux-2.6.16-rc3/arch/i386/Kconfig
>> ===================================================================
>> --- linux-2.6.16-rc3.orig/arch/i386/Kconfig	2006-02-22 16:09:04.000000000 -0800
>> +++ linux-2.6.16-rc3/arch/i386/Kconfig	2006-02-22 16:33:27.000000000 -0800
>> @@ -201,6 +201,15 @@ config VMI_DEBUG
>>  
>>  endmenu
>>  
>> +config MEMORY_HOLE
>> +	int "Create hole at top of memory (0-256 MB)"
>> +	range 0 256
>> +	default "64" if X86_VMI
>> +	default "0" if !X86_VMI
>>     
>
> Deja-vu ;-)  And still works in context of Xen, but we've just let the
> subarch define the __FIXADDR_TOP.  Having it be dynamic could be
> interesting.
>   

Here's dynamic.  I hope it still applies.

--------------010109000308060700020800
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
 


--------------010109000308060700020800--
