Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290488AbSAQWUE>; Thu, 17 Jan 2002 17:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290494AbSAQWTw>; Thu, 17 Jan 2002 17:19:52 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:11727 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S290488AbSAQWTb>; Thu, 17 Jan 2002 17:19:31 -0500
Date: Thu, 17 Jan 2002 17:19:30 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] syscalls-by-name (aka dynamic syscalls / vsyscalls)
Message-ID: <20020117171930.G18086@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch implements syscalls-by-name in an initial and 
rather crud method -- the x86isms need tidying up, but the technique 
is usable across platforms.  Syscalls provided by name are made 
available to userland by means of a dynamic shared library that 
maps and provides a jumptable into a set of vsyscalls.  The vsyscalls 
can then enter the kernel through whatever mechanism (the only means 
implemented right now is via a new syscall, sys_dynamic_syscall) the 
kernel choses.  Version mismatch between the kernel and the library 
is prevented by means of a unique fingerprint the library checks on 
load against what the kernel provides via /dev/vsys.

/dev/vsys is a simple device node that allows user code to map the 
vsyscall area into their address space.  This is different from the 
fixed address that x86-64 uses to allow UML emulation of vsyscalls, 
and prevent other problems that could crop up with the intrusion of 
unexpected code into user address space.

For a quick example on how a new syscall is declared, I added the following 
lines into fs/aio.c in the aio patch:

	#include <asm/vsyscall.h>
 	... rest of file ...
	add_dynamic_syscall(sys_io_setup);
	add_dynamic_syscall(sys_io_destroy);
	add_dynamic_syscall(sys_io_submit);
	add_dynamic_syscall(sys_io_cancel);
	add_dynamic_syscall(sys_io_wait);
	add_dynamic_syscall(sys_io_getevents);

Similarly, vsyscalls can be added by means of adding an attribute to a 
function declaration that puts the code into the VSYSCALL segment.  This 
segment is linked at a virtual address just above the top of the default 
user stack, but is kept within the kernel image and mapped via /dev/vsys.

My current todos on the code are to clean it up so that the arch specific 
parts are better seperated, add symbol versions, and resurrect the 
sysenter / sysexit code as the means of entering the dynamic syscalls.  
There's also TSC based gettimeofday() code to finish off and add...

The patch is against 2.4.9-acsomething + aio + stuff, but should be pretty 
easy to merge into recent kernels.  If anyone has any comments or tweaks, 
I'd like to hear about them.  Cheers,

		-ben

:r ~/syscall-by-name-A4.diff
diff -urN linux.wrk.orig/Makefile linux.wrk.diff/Makefile
--- linux.wrk.orig/Makefile	Mon Jan 14 23:22:42 2002
+++ linux.wrk.diff/Makefile	Thu Jan 17 16:00:55 2002
@@ -236,7 +236,7 @@
 	drivers/sound/pndsperm.c \
 	drivers/sound/pndspini.c \
 	drivers/atm/fore200e_*_fw.c drivers/atm/.fore200e_*.fw \
-	.version .config* config.in config.old \
+	.uniquebytes .version .config* config.in config.old \
 	scripts/tkparse scripts/kconfig.tk scripts/kconfig.tmp \
 	scripts/lxdialog/*.o scripts/lxdialog/lxdialog \
 	.menuconfig.log \
@@ -283,6 +283,7 @@
 
 vmlinux: include/linux/version.h $(CONFIGURATION) init/main.o init/version.o linuxsubdirs
 	@$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" kallsyms
+	@$(MAKE) -C ulib
 
 .PHONY:	kallsyms
 
@@ -332,14 +333,17 @@
 
 linuxsubdirs: $(patsubst %, _dir_%, $(SUBDIRS))
 
-$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/version.h include/config/MARKER
+$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/compile.h include/config/MARKER
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" -C $(patsubst _dir_%, %, $@)
 
 $(TOPDIR)/include/linux/version.h: include/linux/version.h
 $(TOPDIR)/include/linux/compile.h: include/linux/compile.h
 
 newversion:
-	. scripts/mkversion > .version
+	. scripts/mkversion > .tmpversion
+	@mv -f .tmpversion .version
+	rm -f .uniquebytes
+	dd if=/dev/urandom of=.uniquebytes bs=1 count=16
 
 include/linux/compile.h: $(CONFIGURATION) include/linux/version.h newversion
 	@echo -n \#define UTS_VERSION \"\#`cat .version` > .ver
@@ -357,9 +361,10 @@
 	   echo \#define LINUX_COMPILE_DOMAIN ; \
 	 fi >> .ver
 	@echo \#define LINUX_COMPILER \"`$(CC) $(CFLAGS) -v 2>&1 | tail -1`\" >> .ver
+	@echo \#define LINUX_UNIQUE_BYTES `hexdump -e '1/1 "0x%02x, "' .uniquebytes | sed -e 's/, \$$//g'` >>.ver
 	@mv -f .ver $@
 
-include/linux/version.h: ./Makefile include/linux/autoconf.h 
+include/linux/version.h: ./Makefile include/linux/autoconf.h
 	@echo \#define UTS_RELEASE \"$(KERNELRELEASE)\" > .ver
 	@echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)` >> .ver
 	@echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))' >>.ver
@@ -453,6 +458,7 @@
 	rm -f $(CLEAN_FILES)
 	rm -rf $(CLEAN_DIRS)
 	$(MAKE) -C Documentation/DocBook clean
+	$(MAKE) -C ulib clean
 
 mrproper: clean archmrproper
 	find . \( -size 0 -o -name .depend \) -type f -print | xargs rm -f
diff -urN linux.wrk.orig/arch/i386/Makefile linux.wrk.diff/arch/i386/Makefile
--- linux.wrk.orig/arch/i386/Makefile	Mon Jan 14 23:22:41 2002
+++ linux.wrk.diff/arch/i386/Makefile	Thu Jan 17 15:13:37 2002
@@ -127,7 +127,7 @@
 zlilo: vmlinux
 	@$(MAKEBOOT) BOOTIMAGE=zImage zlilo
 
-tmp:
+tmp: ulib
 	@$(MAKEBOOT) BOOTIMAGE=bzImage zlilo
 bzlilo: vmlinux
 	@$(MAKEBOOT) BOOTIMAGE=bzImage zlilo
diff -urN linux.wrk.orig/arch/i386/kernel/Makefile linux.wrk.diff/arch/i386/kernel/Makefile
--- linux.wrk.orig/arch/i386/kernel/Makefile	Mon Jan 14 23:22:40 2002
+++ linux.wrk.diff/arch/i386/kernel/Makefile	Thu Jan 17 15:08:43 2002
@@ -23,8 +23,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
-		bootflag.o
-
+		bootflag.o vsysdata.o vunique.o dynamic_syscall.o
 
 ifdef CONFIG_PCI
 obj-y			+= pci-i386.o
@@ -53,3 +52,4 @@
 
 abi-machdep.o: $(abi-machdep-objs)
 	$(LD) -r -o $@ $(abi-machdep-objs)
+
diff -urN linux.wrk.orig/arch/i386/kernel/dynamic_syscall.c linux.wrk.diff/arch/i386/kernel/dynamic_syscall.c
--- linux.wrk.orig/arch/i386/kernel/dynamic_syscall.c	Wed Dec 31 19:00:00 1969
+++ linux.wrk.diff/arch/i386/kernel/dynamic_syscall.c	Thu Jan 17 13:39:07 2002
@@ -0,0 +1,66 @@
+/* arch/i386/kernel/dynamic_syscall.c
+ *	Entry code for dynamic syscalls on i386.
+ */
+#include <linux/kernel.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+
+struct dummy_args {
+	long data[8];
+};
+
+extern struct vsyscall_entry {
+	long eip;
+	long (*call)(struct dummy_args args);
+} vsyscall_list_begin, vsyscall_list_end;
+
+long sys_dynamic_syscall(struct pt_regs regs) __attribute__((regparm(0)));
+
+long sys_dynamic_syscall(struct pt_regs regs)
+{
+	struct dummy_args dummy_args;
+	struct vsyscall_entry *ent = (void *)regs.edx;
+	void *args = (void *)regs.ecx;
+	long ret;
+
+	pr_debug("ent = %p  args = %p\n", ent, args);
+	pr_debug("eip = 0x%08lx\n", regs.eip);
+
+	/* The pointer must be aligned in the table. */
+	if (unlikely((long)ent & (sizeof(*ent) - 1))) {
+		pr_debug("unaligned\n");
+		goto err;
+	}
+
+	/* Bounds checking... */
+	if (unlikely(ent < &vsyscall_list_begin) ||
+	    unlikely(ent >= &vsyscall_list_end)) {
+		pr_debug("out of range %p <= %p < %p\n", 
+			&vsyscall_list_begin, ent,
+			&vsyscall_list_end);
+		goto err;
+	}
+	/* The entry should be valid now.  Verify that the caller's eip 
+	 * is correct.
+	 */
+	if (unlikely(ent->eip != regs.eip)) {
+		pr_debug("eip mismatch (0x%lx vs 0x%lx)\n", ent->eip, regs.eip);
+		goto err;
+	}
+
+	pr_debug("ent->call = %p\n", ent->call);
+
+	if (unlikely(copy_from_user(&dummy_args, args, sizeof(dummy_args))))
+		return -EFAULT;
+
+	ret = ent->call(dummy_args);
+
+	pr_debug("ret = 0x%08lx\n", ret);
+
+	return ret;
+err:
+	return -ENOSYS;
+}
diff -urN linux.wrk.orig/arch/i386/kernel/entry.S linux.wrk.diff/arch/i386/kernel/entry.S
--- linux.wrk.orig/arch/i386/kernel/entry.S	Wed Jan 16 00:34:52 2002
+++ linux.wrk.diff/arch/i386/kernel/entry.S	Wed Jan 16 17:02:37 2002
@@ -46,6 +46,7 @@
 #include <asm/segment.h>
 #define ASSEMBLY
 #include <asm/smp.h>
+#include <asm/unistd.h>
 
 EBX		= 0x00
 ECX		= 0x04
@@ -635,6 +636,11 @@
 # endif
 #endif
 
+	.rept __NR_sys_dynamic_syscall-(.-sys_call_table)/4
+		.long SYMBOL_NAME(sys_ni_syscall)
+	.endr
+	.long SYMBOL_NAME(sys_dynamic_syscall)
+
 	/* More patch resilient means of adding syscalls */
 	.rept 244-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN linux.wrk.orig/arch/i386/kernel/vsysdata.c linux.wrk.diff/arch/i386/kernel/vsysdata.c
--- linux.wrk.orig/arch/i386/kernel/vsysdata.c	Wed Dec 31 19:00:00 1969
+++ linux.wrk.diff/arch/i386/kernel/vsysdata.c	Wed Jan 16 00:35:39 2002
@@ -0,0 +1,11 @@
+/* vsysdata.c	- declarations for variables shared with the kernel
+ *
+ *	Items placed in .data.vsyscall have a kernel virtual address 
+ *	and are read/write from kernel space only.  The copy placed 
+ *	in .vsyscall_data are linked at a userspace address and are 
+ *	read only accessible from userland.
+ */
+#include <linux/vsyscall.h>
+
+union vsys_union user_vsys_cpudata[256] __attribute__((section(".vsyscall_data")));
+//asm(".globl vsys_cpudata ; bobbob = user_vsys_cpudata - vsyscall_text_begin ; vsys_cpudata = bobbob + VSYSCALL_text");
diff -urN linux.wrk.orig/arch/i386/kernel/vunique.S linux.wrk.diff/arch/i386/kernel/vunique.S
--- linux.wrk.orig/arch/i386/kernel/vunique.S	Wed Dec 31 19:00:00 1969
+++ linux.wrk.diff/arch/i386/kernel/vunique.S	Thu Jan 17 15:09:09 2002
@@ -0,0 +1,7 @@
+#include <linux/compile.h>
+
+	.section .first_vsyscall_text,"xa"
+	.globl	signature
+signature:
+	.byte	LINUX_UNIQUE_BYTES
+	.size	signature,.-signature
diff -urN linux.wrk.orig/arch/i386/vmlinux.lds linux.wrk.diff/arch/i386/vmlinux.lds
--- linux.wrk.orig/arch/i386/vmlinux.lds	Mon Jan 14 23:22:37 2002
+++ linux.wrk.diff/arch/i386/vmlinux.lds	Thu Jan 17 16:31:17 2002
@@ -13,6 +13,26 @@
         *(.fixup)
         *(.gnu.warning)
         } = 0x9090
+        /* Note: most of these declarations are in kernel/vsysdata.c,vsyscall.S.
+	 * We use two segments for the data liked at a kernel virtual address 
+	 * (.data.vsyscall) and user virtual address (.vsyscall_data).
+	 * .vsyscall_text is linked at a kernel virtual address
+	 */
+        . = ALIGN(4096);
+        VSYSCALL_text = .;
+        VSYSCALL 0xbfff0000 : AT ( VSYSCALL_text ) {
+                vsyscall_text_begin = .;
+                *(.first_vsyscall_text)
+                *(.vsyscall_text)
+                . = ALIGN(4096);
+                vsyscall_text_end = .;
+                *(.vsyscall_data)
+                . = ALIGN(4096);
+                vsyscall_data_end = .;
+        }
+        vsys_cpudata = user_vsys_cpudata - vsyscall_text_begin + VSYSCALL_text;
+        . = VSYSCALL_text + SIZEOF(VSYSCALL);
+        VSYSCALL_text_end = .;
   .text.lock : { *(.text.lock) } /* out-of-line lock text */
   .rodata : { *(.rodata) }
   .kstrtab : { *(.kstrtab) }
@@ -23,12 +43,21 @@
   __start___ksymtab = .; /* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
-   __start___kallsyms = .;	/* All kernel symbols */
+   __start___kallsyms = .; /* All kernel symbols */
    __kallsyms : { *(__kallsyms) }
    __stop___kallsyms = .;
   _etext = .; /* End of text section */
   .data : { /* Data */
         *(.data)
+        . = ALIGN(8);
+        vsyscall_list_begin = .;
+        *(.data.vsyscall_list)
+        vsyscall_list_end = .;
+        . = ALIGN(4096);
+        kernel_vsyscall_data_begin = .;
+        *(.data.vsyscall)
+        . = ALIGN(4096);
+        kernel_vsyscall_data_end = .;
         CONSTRUCTORS
         }
   _edata = .; /* End of data section */
@@ -70,4 +99,15 @@
   .stab.index 0 : { *(.stab.index) }
   .stab.indexstr 0 : { *(.stab.indexstr) }
   .comment 0 : { *(.comment) }
+/*
+#  VSYSCALL : {
+#	/ * vsyscall area *i /
+#	__vsyscall_begin = .;
+#	*(vsyscall_text)
+#	. = ALIGN(4096);
+#	*(.data.vsyscall)
+#	. = ALIGN(4096);
+#	__vsyscall_end = .;
+#  } >vsyscall_area
+*/
 }
diff -urN linux.wrk.orig/arch/i386/vmlinux.lds.S linux.wrk.diff/arch/i386/vmlinux.lds.S
--- linux.wrk.orig/arch/i386/vmlinux.lds.S	Mon Jan 14 23:22:37 2002
+++ linux.wrk.diff/arch/i386/vmlinux.lds.S	Thu Jan 17 15:09:34 2002
@@ -13,6 +13,28 @@
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
+
+	/* Note: most of these declarations are in kernel/vsysdata.c,vsyscall.S.
+	 * We use two segments for the data liked at a kernel virtual address 
+	 * (.data.vsyscall) and user virtual address (.vsyscall_data).
+	 * .vsyscall_text is linked at a kernel virtual address
+	 */
+	. = ALIGN(4096);
+	VSYSCALL_text = .;
+	VSYSCALL 0xbfff0000 : AT ( VSYSCALL_text ) {
+		vsyscall_text_begin = .;
+		*(.first_vsyscall_text)
+		*(.vsyscall_text)
+		. = ALIGN(4096);
+		vsyscall_text_end = .;
+		*(.vsyscall_data)
+		. = ALIGN(4096);
+		vsyscall_data_end = .;
+	}
+	vsys_cpudata = user_vsys_cpudata - vsyscall_text_begin + VSYSCALL_text;
+	. = VSYSCALL_text + SIZEOF(VSYSCALL);
+	VSYSCALL_text_end = .;
+
   .text.lock : { *(.text.lock) }	/* out-of-line lock text */
   .rodata : { *(.rodata) }
   .kstrtab : { *(.kstrtab) }
@@ -34,6 +56,18 @@
 
   .data : {			/* Data */
 	*(.data)
+
+	. = ALIGN(8);
+	vsyscall_list_begin = .;
+	*(.data.vsyscall_list)
+	vsyscall_list_end = .;
+
+	. = ALIGN(4096);
+	kernel_vsyscall_data_begin = .;
+	*(.data.vsyscall)
+	. = ALIGN(4096);
+	kernel_vsyscall_data_end = .;
+
 	CONSTRUCTORS
 	}
 
@@ -83,4 +117,16 @@
   .stab.index 0 : { *(.stab.index) }
   .stab.indexstr 0 : { *(.stab.indexstr) }
   .comment 0 : { *(.comment) }
+
+/*
+#  VSYSCALL : {
+#	/ * vsyscall area *i /
+#	__vsyscall_begin = .;
+#	*(vsyscall_text)
+#	. = ALIGN(4096);
+#	*(.data.vsyscall)
+#	. = ALIGN(4096);
+#	__vsyscall_end = .;
+#  } >vsyscall_area
+*/
 }
diff -urN linux.wrk.orig/drivers/char/mem.c linux.wrk.diff/drivers/char/mem.c
--- linux.wrk.orig/drivers/char/mem.c	Mon Jan 14 23:22:37 2002
+++ linux.wrk.diff/drivers/char/mem.c	Thu Jan 17 13:47:22 2002
@@ -25,6 +25,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
+#include <asm/a.out.h>
 
 #ifdef CONFIG_SENSORS
 extern void sensors_init_all(void);
@@ -539,6 +540,77 @@
 	write:		write_full,
 };
 
+int vsys_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	extern unsigned char vsyscall_text_begin, vsyscall_text_end, VSYSCALL_text[];
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long len = vma->vm_end - vma->vm_start;
+	unsigned long actual_len = &vsyscall_text_end - &vsyscall_text_begin;
+
+	if ((offset + len) > actual_len)
+		len = actual_len - offset;
+
+	pr_debug("len = 0x%lx, actual_len = 0x%lx\n", len, actual_len);
+
+	vma->vm_start = (unsigned long)&vsyscall_text_begin + offset;
+	vma->vm_end = vma->vm_start + len;
+	vma->vm_flags |= VM_RESERVED;
+
+	pr_debug("vm_start = 0x%lx, vm_end = 0x%lx\n",
+		vma->vm_start, vma->vm_end);
+	pr_debug("va=%p  pa=0x%lx\n",
+		VSYSCALL_text + offset,
+		__pa(VSYSCALL_text) + offset);
+
+	if (vma->vm_start < (unsigned long)&vsyscall_text_begin) {
+		pr_debug("vsys_mmap: start < begin\n");
+		return -EINVAL;
+	}
+
+	if (vma->vm_end < (unsigned long)&vsyscall_text_begin) {
+		pr_debug("vsys_mmap: end < begin\n");
+		return -EINVAL;
+	}
+
+	if (vma->vm_end > (unsigned long)&vsyscall_text_end) {
+		pr_debug("vsys_mmap: end(%lx) > text_end(%p)\n",
+			vma->vm_end, &vsyscall_text_end);
+		return -EINVAL;
+	}
+
+	if (vma->vm_start >= vma->vm_end) {
+		pr_debug("vsys_mmap: end\n");
+		return -EINVAL;
+	}
+
+	if (find_vma_intersection(current->mm, vma->vm_start, vma->vm_end)) {
+		pr_debug("vsyscall: mapping collision\n");
+		return -EINVAL;
+	}
+
+	if ((vma->vm_flags & (VM_SHARED | VM_WRITE)) == (VM_SHARED | VM_WRITE)) {
+		pr_debug("vsyscall: attempt to write to mapping\n");
+		return -EPERM;
+	}
+
+	if (remap_page_range(vma->vm_start,
+			     __pa(VSYSCALL_text) + offset,
+			     vma->vm_end-vma->vm_start,
+			     vma->vm_page_prot))
+		return -EAGAIN;
+
+	pr_debug("VSYSCALL_text(%p): %02x %02x %02x %02x\n",
+		VSYSCALL_text,
+		VSYSCALL_text[0], VSYSCALL_text[1],
+		VSYSCALL_text[2], VSYSCALL_text[3]);
+
+	return 0;
+}
+
+static struct file_operations vsys_fops = {
+	mmap:		vsys_mmap,
+};
+
 static int memory_open(struct inode * inode, struct file * filp)
 {
 	switch (MINOR(inode->i_rdev)) {
@@ -568,6 +640,9 @@
 		case 9:
 			filp->f_op = &urandom_fops;
 			break;
+		case 11:
+			filp->f_op = &vsys_fops;
+			break;
 		default:
 			return -ENXIO;
 	}
@@ -592,7 +667,8 @@
 	{5, "zero",    S_IRUGO | S_IWUGO,           &zero_fops},
 	{7, "full",    S_IRUGO | S_IWUGO,           &full_fops},
 	{8, "random",  S_IRUGO | S_IWUSR,           &random_fops},
-	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops}
+	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops},
+	{11,"vsys",    S_IRUGO | S_IWUSR,           &vsys_fops},
     };
     int i;
 
diff -urN linux.wrk.orig/include/asm-i386/a.out.h linux.wrk.diff/include/asm-i386/a.out.h
--- linux.wrk.orig/include/asm-i386/a.out.h	Fri Jun 16 14:33:06 1995
+++ linux.wrk.diff/include/asm-i386/a.out.h	Thu Jan 17 16:25:31 2002
@@ -19,7 +19,9 @@
 
 #ifdef __KERNEL__
 
-#define STACK_TOP	TASK_SIZE
+#define VSYSCALL_SIZE		0x10000		/* 64KB for vsyscalls */
+#define STACK_GUARD_SIZE	0x02000		/* 8KB guard area */
+#define STACK_TOP	(TASK_SIZE - VSYSCALL_SIZE - STACK_GUARD_SIZE)
 
 #endif
 
diff -urN linux.wrk.orig/include/asm-i386/unistd.h linux.wrk.diff/include/asm-i386/unistd.h
--- linux.wrk.orig/include/asm-i386/unistd.h	Wed Jan 16 00:34:52 2002
+++ linux.wrk.diff/include/asm-i386/unistd.h	Wed Jan 16 17:09:10 2002
@@ -228,6 +228,8 @@
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
 
+#define __NR_sys_dynamic_syscall	230
+
 /* gap here for now */
 #define	__NR_io_setup		244
 #define	__NR_io_destroy		245
diff -urN linux.wrk.orig/include/asm-i386/vsyscall.h linux.wrk.diff/include/asm-i386/vsyscall.h
--- linux.wrk.orig/include/asm-i386/vsyscall.h	Wed Dec 31 19:00:00 1969
+++ linux.wrk.diff/include/asm-i386/vsyscall.h	Thu Jan 17 01:53:32 2002
@@ -0,0 +1,41 @@
+#ifndef __ASM__VSYSCALL_H
+#define __ASM__VSYSCALL_H
+/* include/asm-i386/vsyscall.h
+ *	Copyright 2002 Red Hat, Inc.
+ */
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+
+/* We call sys_dynamic_syscall(long nr, void *args) using regparm(2)
+ * convention.  The .text.vsyscall section is mapped into userspace, 
+ * whereas .data.vsyscall_list is a kernel-only array of the vsyscalls 
+ * and the valid userspace address to call them from.  All vsyscalls 
+ * are called with C calling convention (ie args on the stack for x86).
+ *
+ * Note: the layout of .data.vsyscall_list must match the entries in
+ * dynamic_syscall.c.
+ */
+#define STRINGIFYa(x)	#x
+#define STRINGIFY(x)	STRINGIFYa(x)
+#define NR_dyn_sys	STRINGIFY(__NR_sys_dynamic_syscall)
+#define add_dynamic_syscall(name)				\
+	__asm__("						\n\
+	.section .vsyscall_text, \"xa\"				\n\
+	.globl v" #name "					\n\
+	v" #name ":						\n\
+		push %ecx					\n\
+		push %edx					\n\
+		movl $" NR_dyn_sys ",%eax			\n\
+		movl $2f,%edx					\n\
+		leal 12(%esp),%ecx				\n\
+		int $0x80					\n\
+	1:							\n\
+		popl %edx					\n\
+		popl %ecx					\n\
+		ret						\n\
+	.size v" #name ",.-v" #name "				\n\
+	.section .data.vsyscall_list,\"a\"			\n\
+	2:	.long	1b," #name "				\n\
+	.previous")
+
+#endif
diff -urN linux.wrk.orig/include/linux/vsyscall.h linux.wrk.diff/include/linux/vsyscall.h
--- linux.wrk.orig/include/linux/vsyscall.h	Wed Dec 31 19:00:00 1969
+++ linux.wrk.diff/include/linux/vsyscall.h	Wed Jan 16 00:35:39 2002
@@ -0,0 +1,20 @@
+#ifndef _LINUX__VSYSCALL_H
+#define _LINUX__VSYSCALL_H
+
+struct vsys_cpudata {
+	unsigned long	context_switches;
+	unsigned long	tv_sec;
+	unsigned long	tsc_low, tsc_high;
+	unsigned long	cycles_per_sec;
+};
+
+union vsys_union {
+	struct vsys_cpudata	data;
+	char			pad[128];
+};
+
+extern union vsys_union	vsys_cpudata[256] __attribute__((section(".data.vsyscall")));
+
+#define vsys_data(cpu)	(&vsys_cpudata[cpu].data)
+
+#endif /*ndef _LINUX__VSYSCALL_H*/
diff -urN linux.wrk.orig/ulib/Makefile linux.wrk.diff/ulib/Makefile
--- linux.wrk.orig/ulib/Makefile	Wed Dec 31 19:00:00 1969
+++ linux.wrk.diff/ulib/Makefile	Thu Jan 17 13:56:25 2002
@@ -0,0 +1,26 @@
+all: libkernel.so
+
+ASFLAGS=-D__KERNEL__ -D__ASSEMBLY__ -I../include -nostdlib -nostartfiles
+CFLAGS=-D__KERNEL__ -I../include -nostdlib -nostartfiles
+
+vsysaddr.S: ../System.map stub.S Makefile
+	rm -f vsysaddr.S
+	echo '#include "stub.S"' >vsysaddr.S
+	awk -- "/^bfff.* vsys_/ { print \"dynamic_syscall(\"\$$3 \",0x\" \$$1 \")\"; }" <../System.map >>vsysaddr.S
+
+vsysaddr.o: vsysaddr.S
+
+kso_init.o: ../include/linux/compile.h
+
+libkernel.so.1: vsysaddr.o kso_init.o
+	ld -E -symbolic -shared -soname=libkernel.so -o $@ vsysaddr.o kso_init.o
+
+libkernel.so: libkernel.so.1
+	ln -sf $< $@
+
+clean:
+	rm -f *.o libkernel.so myln libkernel.so.1 vsysaddr.S
+
+# test app
+myln: myln.c libkernel.so Makefile
+	cc -g -o myln myln.c -L. -lkernel
diff -urN linux.wrk.orig/ulib/kso_init.c linux.wrk.diff/ulib/kso_init.c
--- linux.wrk.orig/ulib/kso_init.c	Wed Dec 31 19:00:00 1969
+++ linux.wrk.diff/ulib/kso_init.c	Thu Jan 17 16:16:15 2002
@@ -0,0 +1,48 @@
+#include <linux/compile.h>
+#include <linux/types.h>
+#include <asm/unistd.h>
+#include <asm/fcntl.h>
+#include <asm/mman.h>
+#include <asm/a.out.h>
+
+char libkernel_enosys = 1;	/* the asm in stub.S depends on this */
+
+long _init(void)
+{
+	static char unique[] = { LINUX_UNIQUE_BYTES };
+	int errno;
+	long addr;
+	int fd;
+	int i;
+
+	_syscall6(int, mmap2, unsigned long, addr, unsigned long, len,
+        	  unsigned long, prot, unsigned long, flags,
+        	  unsigned long, fd, unsigned long, pgoff)
+	_syscall2(long, munmap, unsigned long, addr, size_t, len)
+	_syscall2(int, open, const char *, name, int, flags)
+	_syscall1(int, close, int, fd)
+
+	if (sizeof(unique) != 16)
+		return -1;
+
+	fd = open("/dev/vsys", O_RDONLY);
+	if (-1 == fd)
+		return -1;
+
+	addr = mmap2(0, VSYSCALL_SIZE, PROT_READ | PROT_EXEC, MAP_SHARED, fd, 0);
+	if (-1 == addr)
+		return -1;
+
+	close(fd);
+
+	for (i=0; i<sizeof(unique); i++)
+		if (unique[i] != ((char *)addr)[i]) {
+			munmap(addr, VSYSCALL_SIZE);
+			return -1;
+		}
+
+	/* okay, all the syscalls we provide are now good */
+	libkernel_enosys = 0;
+	return 0;
+}
+
diff -urN linux.wrk.orig/ulib/myln.c linux.wrk.diff/ulib/myln.c
--- linux.wrk.orig/ulib/myln.c	Wed Dec 31 19:00:00 1969
+++ linux.wrk.diff/ulib/myln.c	Thu Jan 17 09:18:59 2002
@@ -0,0 +1,25 @@
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+int main ()
+{
+	long ctx = 0;
+	extern long vsys_io_setup(long, long *);
+	unsigned char *bob = (void*)&vsys_io_setup;
+	long ret;
+	int i;
+	printf("%p\n", bob);
+	//printf("%p\n", mmap(0, 65536, PROT_READ | PROT_EXEC, MAP_SHARED,
+	//	open("/dev/vsys", O_RDONLY), 0));
+	//for (i=0; i<16; i++)
+	//	printf(" %02x\n", bob[i]);
+	//printf("\n");
+
+	ret = vsys_io_setup(100, &ctx);
+
+	printf("ret=%ld, ctx=0x%lx\n", ret, ctx);
+	return 0;
+}
diff -urN linux.wrk.orig/ulib/stub.S linux.wrk.diff/ulib/stub.S
--- linux.wrk.orig/ulib/stub.S	Wed Dec 31 19:00:00 1969
+++ linux.wrk.diff/ulib/stub.S	Thu Jan 17 16:25:38 2002
@@ -0,0 +1,18 @@
+/* stub.S */
+#include <asm/segment.h>
+#include <asm/errno.h>
+
+	.text
+
+#define dynamic_syscall(x,a) \
+	.globl	x				;\
+	.align 16				;\
+	x:					;\
+		cmpb $0,libkernel_enosys	;\
+		jne 1f				;\
+		ljmp $__USER_CS, $a		;\
+	1:					;\
+		movl	$-ENOSYS,%eax		;\
+		ret				;\
+	.size	 x,.-x
+
