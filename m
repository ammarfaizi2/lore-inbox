Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263178AbSJ1IM5>; Mon, 28 Oct 2002 03:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263181AbSJ1IM5>; Mon, 28 Oct 2002 03:12:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36918 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S263178AbSJ1IMj>; Mon, 28 Oct 2002 03:12:39 -0500
To: linux-kernel@vger.kernel.org
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>, Pavel Machek <pavel@ucw.cz>,
       Andy Pfiffer <andyp@osdl.org>, "Ph. Marek" <marek@bmlv.gv.at>,
       Pavel Roskin <proski@gnu.org>, Torrey Hoffman <thoffman@arnor.net>,
       "Rob Landley" <landley@trommello.org>,
       Kasper Dupont <kasperd@daimi.au.dk>
Subject: [CFT] [PATCH] kexec 2.5.44 (minimal)
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Oct 2002 01:16:46 -0700
In-Reply-To: <20021020190939.GA913@elf.ucw.cz>
Message-ID: <m1lm4jj7v5.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kexec is a system call that allows you to load another kernel from the
currently executing Linux kernel.  The current implementation has only
been tested, and had the kinks worked out on x86, but the generic
code should work on any architecture.

Some machines have BIOSes that are either extremely slow to reboot,
or that cannot reliably perform a reboot.  In which case kexec
may be the only alternative to reboot in a reliable and timely manner.

The patch is archived at:
http://www.xmission.com/~ebiederm/files/kexec/

And is currently kept in two pieces.
The pure system call.
http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.44.x86kexec-2.diff

And the set of hardware fixes known to help kexec.
http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.44.x86kexec-hwfixes.diff

A compatible user space is at:
http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.?.tar.gz
This code boots either a static ELF executable or a bzImage.

A kernel reformater that bypasses setup.S in favor of a version that
uses fewer BIOS calls, (increasing the reliability) is at:
ftp://ftp.lnxi.com/pub/mkelfImage/mkelfImage-1.17.tar.gz

In bug reports please include the serial console output of 
kexec kexec_test.  kexec_test exercises most of the interesting code
paths that are needed to load a kernel (mainly BIOS calls) with lots
of debugging print statements, so hangs can easily be detected.  

I have been using this technique for the last several years and 
what the kernel needs to do is well understood, and currently
implemented.  I have also been working with etherboot which is a very 
minimal kernel whose sole purpose is to download a kernel over the
network and boot it.   

>From etherboot it is possible to download a DOS image and run it.
I have not yet reached this level of firmware reliably after using the
kexec syscall, but the fact that etherboot does it shows it can be
done.  Having worked with etherboot as a primary bootloader I had
forgotten how challenging it is theoretically to shut down a kernel
that uses it's own hardware drivers and have the firmware still work
reliably. 

My expectation is that I can have complete BIOS functionality when
I compile a kernel whose sole user space is a ramdisk, the kernel has
no hardware drivers, and I use a bootloader that does not mess up
the BIOS.  And I expect that using kernel drivers will only mess up
the firmware drivers where they work with the same hardware.

So far failures have broken into three categories.  Broken kernels
even without kexec.  Kernels that hang when running setup.S during
bootup.  Kernels that don't quite boot because a the kernel driver
cannot reinitialize the hardware from the state that same driver left
the hardware in.

For failures during setup.S I have seen three cases.  DOS running
before loadlin modified the real mode IDT so as to be useless without
DOS.  Interrupt 0x13 ah=0x15 print dasd type.  And the new EDD code.
These failures fall into the expected cases.  But except for the loadlin
case which is hopeless have not been completely tracked.

In the plan forward there are several goals.  To find what it takes
to have the BIOS work reliably after a kexec system call.  To boot
bzImages reliably, by bypassing setup.S completely.  To fix the linux
device drivers that prevent a kernel called with sys_kexec from
initializing. 

An important point is that none of these future projects require
modifying the current kexec system call.  The needed work is either in
user space or in the device drivers.

Shortly Linus will be getting back and I will be submitting the kexec
system call to him.  Below is the patch I will be aiming at getting into
the kernel.  All of the device driver fixes have been removed in the
interest of having a clean patch to submit.  In particular to use this
from an SMP kernel you will also need to apply
linux-2.5.44.x86kexec-hwfixes.diff.  

Thanks to everyone who has provided me with feedback so far.

Eric

 MAINTAINERS                        |    7 
 arch/i386/Config.help              |   14 
 arch/i386/config.in                |    3 
 arch/i386/kernel/Makefile          |    1 
 arch/i386/kernel/entry.S           |    1 
 arch/i386/kernel/machine_kexec.c   |  142 ++++++++
 arch/i386/kernel/relocate_kernel.S |   99 +++++
 include/asm-i386/kexec.h           |   25 +
 include/asm-i386/unistd.h          |    2 
 include/linux/kexec.h              |   48 ++
 kernel/Makefile                    |    1 
 kernel/kexec.c                     |  624 +++++++++++++++++++++++++++++++++++++
 kernel/sys.c                       |   61 +++
 13 files changed, 1027 insertions, 1 deletion

diff -uNr linux-2.5.44/MAINTAINERS linux-2.5.44.x86kexec-2/MAINTAINERS
--- linux-2.5.44/MAINTAINERS	Sat Oct 19 00:57:56 2002
+++ linux-2.5.44.x86kexec-2/MAINTAINERS	Sun Oct 27 15:21:51 2002
@@ -934,6 +934,13 @@
 W:	http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/
 S:	Maintained
 
+KEXEC
+P:	Eric Biederman
+M:	ebiederm@xmission.com
+M:	ebiederman@lnxi.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 LANMEDIA WAN CARD DRIVER
 P:	Andrew Stanley-Jones
 M:	asj@lanmedia.com
diff -uNr linux-2.5.44/arch/i386/Config.help linux-2.5.44.x86kexec-2/arch/i386/Config.help
--- linux-2.5.44/arch/i386/Config.help	Sat Oct 19 00:57:56 2002
+++ linux-2.5.44.x86kexec-2/arch/i386/Config.help	Sun Oct 27 15:57:34 2002
@@ -417,6 +417,20 @@
   you have use for it; the module is called binfmt_misc.o. If you
   don't know what to answer at this point, say Y.
 
+CONFIG_KEXEC
+  kexec is a system call that implements the ability to  shutdown your
+  current kernel, and to start another kernel.  It is like a reboot
+  but it is indepedent of the system firmware.   And like a reboot the
+  you can start any kernel with it not just Linux.  
+
+  The name comes from the similiarity to the exec system call. 
+
+  It is on an going process to be certain the hardware in a machine
+  is properly shutdown, so do not be surprised if this code does not
+  initially work for you.  It may help to enable device hotplugging
+  support.  As of this writing the exact hardware interface is
+  strongly in flux, so no good recommendation can be made.
+
 CONFIG_M386
   This is the processor type of your CPU. This information is used for
   optimizing purposes. In order to compile a kernel that can run on
diff -uNr linux-2.5.44/arch/i386/config.in linux-2.5.44.x86kexec-2/arch/i386/config.in
--- linux-2.5.44/arch/i386/config.in	Sat Oct 19 00:57:56 2002
+++ linux-2.5.44.x86kexec-2/arch/i386/config.in	Sun Oct 27 15:32:53 2002
@@ -247,6 +247,9 @@
    fi
 fi
 
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+   bool 'kexec system call (EXPERIMENTAL)' CONFIG_KEXEC
+fi
 endmenu
 
 mainmenu_option next_comment
diff -uNr linux-2.5.44/arch/i386/kernel/Makefile linux-2.5.44.x86kexec-2/arch/i386/kernel/Makefile
--- linux-2.5.44/arch/i386/kernel/Makefile	Sat Oct 19 00:57:56 2002
+++ linux-2.5.44.x86kexec-2/arch/i386/kernel/Makefile	Sun Oct 27 15:21:51 2002
@@ -25,6 +25,7 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_PROFILING)		+= profile.o
diff -uNr linux-2.5.44/arch/i386/kernel/entry.S linux-2.5.44.x86kexec-2/arch/i386/kernel/entry.S
--- linux-2.5.44/arch/i386/kernel/entry.S	Fri Oct 18 11:59:14 2002
+++ linux-2.5.44.x86kexec-2/arch/i386/kernel/entry.S	Sun Oct 27 15:21:51 2002
@@ -737,6 +737,7 @@
 	.long sys_free_hugepages
 	.long sys_exit_group
 	.long sys_lookup_dcookie
+	.long sys_kexec
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -uNr linux-2.5.44/arch/i386/kernel/machine_kexec.c linux-2.5.44.x86kexec-2/arch/i386/kernel/machine_kexec.c
--- linux-2.5.44/arch/i386/kernel/machine_kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.5.44.x86kexec-2/arch/i386/kernel/machine_kexec.c	Sun Oct 27 15:57:10 2002
@@ -0,0 +1,142 @@
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/kexec.h>
+#include <linux/delay.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/io.h>
+#include <asm/apic.h>
+
+
+/*
+ * machine_kexec
+ * =======================
+ */
+
+
+static void set_idt(void *newidt, __u16 limit)
+{
+	unsigned char curidt[6];
+
+	/* ia32 supports unaliged loads & stores */
+	(*(__u16 *)(curidt)) = limit;
+	(*(__u32 *)(curidt +2)) = (unsigned long)(newidt);
+
+	__asm__ __volatile__ (
+		"lidt %0\n" 
+		: "=m" (curidt)
+		);
+};
+
+
+static void set_gdt(void *newgdt, __u16 limit)
+{
+	unsigned char curgdt[6];
+
+	/* ia32 supports unaliged loads & stores */
+	(*(__u16 *)(curgdt)) = limit;
+	(*(__u32 *)(curgdt +2)) = (unsigned long)(newgdt);
+
+	__asm__ __volatile__ (
+		"lgdt %0\n" 
+		: "=m" (curgdt)
+		);
+};
+
+static void load_segments(void)
+{
+#define __STR(X) #X
+#define STR(X) __STR(X)
+
+	__asm__ __volatile__ (
+		"\tljmp $"STR(__KERNEL_CS)",$1f\n"
+		"\t1:\n"
+		"\tmovl $"STR(__KERNEL_DS)",%eax\n"
+		"\tmovl %eax,%ds\n"
+		"\tmovl %eax,%es\n"
+		"\tmovl %eax,%fs\n"
+		"\tmovl %eax,%gs\n"
+		"\tmovl %eax,%ss\n"
+		);
+#undef STR
+#undef __STR
+}
+
+static void identity_map_page(unsigned long address)
+{
+	/* This code is x86 specific...
+	 * general purpose code must be more carful 
+	 * of caches and tlbs...
+	 */
+	pgd_t *pgd;
+	pmd_t *pmd;
+	struct mm_struct *mm = current->mm;
+	spin_lock(&mm->page_table_lock);
+	
+	pgd = pgd_offset(mm, address);
+	pmd = pmd_alloc(mm, pgd, address);
+
+	if (pmd) {
+		pte_t *pte = pte_alloc_map(mm, pmd, address);
+		if (pte) {
+			set_pte(pte, 
+				mk_pte(virt_to_page(phys_to_virt(address)), 
+					PAGE_SHARED));
+			__flush_tlb_one(address);
+		}
+	}
+	spin_unlock(&mm->page_table_lock);
+}
+
+
+typedef void (*relocate_new_kernel_t)(
+	unsigned long indirection_page, unsigned long reboot_code_buffer,
+	unsigned long start_address);
+
+const extern unsigned char relocate_new_kernel[];
+extern void relocate_new_kernel_end(void);
+const extern unsigned int relocate_new_kernel_size;
+
+void machine_kexec(struct kimage *image)
+{
+	unsigned long *indirection_page;
+	void *reboot_code_buffer;
+	relocate_new_kernel_t rnk;
+
+	/* Interrupts aren't acceptable while we reboot */
+	local_irq_disable();
+	reboot_code_buffer = image->reboot_code_buffer;
+	indirection_page = phys_to_virt(image->head & PAGE_MASK);
+
+	identity_map_page(virt_to_phys(reboot_code_buffer));
+
+	/* copy it out */
+	memcpy(reboot_code_buffer, relocate_new_kernel, 
+		relocate_new_kernel_size);
+
+	/* The segment registers are funny things, they are
+	 * automatically loaded from a table, in memory wherever you
+	 * set them to a specific selector, but this table is never
+	 * accessed again you set the segment to a different selector.
+	 *
+	 * The more common model is are caches where the behide
+	 * the scenes work is done, but is also dropped at arbitrary
+	 * times.
+	 *
+	 * I take advantage of this here by force loading the
+	 * segments, before I zap the gdt with an invalid value.
+	 */
+	load_segments();
+	/* The gdt & idt are now invalid.
+	 * If you want to load them you must set up your own idt & gdt.
+	 */
+	set_gdt(phys_to_virt(0),0);
+	set_idt(phys_to_virt(0),0);
+
+	/* now call it */
+	rnk = (relocate_new_kernel_t) virt_to_phys(reboot_code_buffer);
+	(*rnk)(virt_to_phys(indirection_page), virt_to_phys(reboot_code_buffer), 
+		image->start);
+}
+
diff -uNr linux-2.5.44/arch/i386/kernel/relocate_kernel.S linux-2.5.44.x86kexec-2/arch/i386/kernel/relocate_kernel.S
--- linux-2.5.44/arch/i386/kernel/relocate_kernel.S	Wed Dec 31 17:00:00 1969
+++ linux-2.5.44.x86kexec-2/arch/i386/kernel/relocate_kernel.S	Sun Oct 27 15:21:51 2002
@@ -0,0 +1,99 @@
+#include <linux/config.h>
+#include <linux/linkage.h>
+
+	/* Must be relocatable PIC code callable as a C function, that once
+	 * it starts can not use the previous processes stack.
+	 *
+	 */
+	.globl relocate_new_kernel
+relocate_new_kernel:
+	/* read the arguments and say goodbye to the stack */
+	movl  4(%esp), %ebx /* indirection_page */
+	movl  8(%esp), %ebp /* reboot_code_buffer */
+	movl  12(%esp), %edx /* start address */
+
+	/* zero out flags, and disable interrupts */
+	pushl $0
+	popfl
+
+	/* set a new stack at the bottom of our page... */
+	lea   4096(%ebp), %esp
+
+	/* store the parameters back on the stack */
+	pushl   %edx /* store the start address */
+
+	/* Set cr0 to a known state:
+	 * 31 0 == Paging disabled
+	 * 18 0 == Alignment check disabled
+	 * 16 0 == Write protect disabled
+	 * 3  0 == No task switch
+	 * 2  0 == Don't do FP software emulation.
+	 * 0  1 == Proctected mode enabled
+	 */
+	movl	%cr0, %eax
+	andl	$~((1<<31)|(1<<18)|(1<<16)|(1<<3)|(1<<2)), %eax
+	orl	$(1<<0), %eax
+	movl	%eax, %cr0
+	jmp 1f
+1:	
+
+	/* Flush the TLB (needed?) */
+	xorl	%eax, %eax
+	movl	%eax, %cr3
+
+	/* Do the copies */
+	cld
+0:	/* top, read another word for the indirection page */
+	movl    %ebx, %ecx
+	movl	(%ebx), %ecx
+	addl	$4, %ebx
+	testl	$0x1,   %ecx  /* is it a destination page */
+	jz	1f
+	movl	%ecx,	%edi
+	andl	$0xfffff000, %edi
+	jmp     0b
+1:
+	testl	$0x2,	%ecx  /* is it an indirection page */
+	jz	1f
+	movl	%ecx,	%ebx
+	andl	$0xfffff000, %ebx
+	jmp     0b
+1:
+	testl   $0x4,   %ecx /* is it the done indicator */
+	jz      1f
+	jmp     2f
+1:
+	testl   $0x8,   %ecx /* is it the source indicator */
+	jz      0b	     /* Ignore it otherwise */
+	movl    %ecx,   %esi /* For every source page do a copy */
+	andl    $0xfffff000, %esi
+
+	movl    $1024, %ecx
+	rep ; movsl
+	jmp     0b
+
+2:
+
+	/* To be certain of avoiding problems with self modifying code
+	 * I need to execute a serializing instruction here.
+	 * So I flush the TLB, it's handy, and not processor dependent.
+	 */
+	xorl	%eax, %eax
+	movl	%eax, %cr3
+	
+	/* set all of the registers to known values */
+	/* leave %esp alone */
+	
+	xorl	%eax, %eax
+	xorl	%ebx, %ebx
+	xorl    %ecx, %ecx
+	xorl    %edx, %edx
+	xorl    %esi, %esi
+	xorl    %edi, %edi
+	xorl    %ebp, %ebp
+	ret
+relocate_new_kernel_end:
+
+	.globl relocate_new_kernel_size
+relocate_new_kernel_size:	
+	.long relocate_new_kernel_end - relocate_new_kernel
diff -uNr linux-2.5.44/include/asm-i386/kexec.h linux-2.5.44.x86kexec-2/include/asm-i386/kexec.h
--- linux-2.5.44/include/asm-i386/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.44.x86kexec-2/include/asm-i386/kexec.h	Sun Oct 27 15:21:51 2002
@@ -0,0 +1,25 @@
+#ifndef _I386_KEXEC_H
+#define _I386_KEXEC_H
+
+#include <asm/fixmap.h>
+
+/*
+ * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
+ * I.e. Maximum page that is mapped directly into kernel memory,
+ * and kmap is not required.
+ *
+ * Someone correct me if FIXADDR_START - PAGEOFFSET is not the correct
+ * calculation for the amount of memory directly mappable into the
+ * kernel memory space.
+ */
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (FIXADDR_START - PAGE_OFFSET) 
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+
+#define KEXEC_REBOOT_CODE_SIZE	4096
+#define KEXEC_REBOOT_CODE_ALIGN 0
+
+
+#endif /* _I386_KEXEC_H */
diff -uNr linux-2.5.44/include/asm-i386/unistd.h linux-2.5.44.x86kexec-2/include/asm-i386/unistd.h
--- linux-2.5.44/include/asm-i386/unistd.h	Fri Oct 18 11:59:28 2002
+++ linux-2.5.44.x86kexec-2/include/asm-i386/unistd.h	Sun Oct 27 15:21:51 2002
@@ -258,7 +258,7 @@
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
-  
+#define __NR_kexec		254
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -uNr linux-2.5.44/include/linux/kexec.h linux-2.5.44.x86kexec-2/include/linux/kexec.h
--- linux-2.5.44/include/linux/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.44.x86kexec-2/include/linux/kexec.h	Sun Oct 27 15:21:51 2002
@@ -0,0 +1,48 @@
+#ifndef LINUX_KEXEC_H
+#define LINUX_KEXEC_H
+
+#if CONFIG_KEXEC
+#include <linux/types.h>
+#include <asm/kexec.h>
+
+/* 
+ * This structure is used to hold the arguments that are used when loading
+ * kernel binaries.
+ */
+
+typedef unsigned long kimage_entry_t;
+#define IND_DESTINATION  0x1
+#define IND_INDIRECTION  0x2
+#define IND_DONE         0x4
+#define IND_SOURCE       0x8
+
+struct kimage {
+	kimage_entry_t head;
+	kimage_entry_t *entry;
+	kimage_entry_t *last_entry;
+
+	unsigned long destination;
+	unsigned long offset;
+
+	unsigned long start;
+	void *reboot_code_buffer;
+};
+
+/* kexec helper functions */
+void kimage_init(struct kimage *image);
+void kimage_free(struct kimage *image);
+
+struct kexec_segment {
+	void *buf;
+	size_t bufsz;
+	void *mem;
+	size_t memsz;
+};
+
+/* kexec interface functions */
+extern void machine_kexec(struct kimage *image);
+extern int do_kexec(unsigned long entry, long nr_segments, 
+	struct kexec_segment *segments, struct kimage *image);
+#endif
+#endif /* LINUX_KEXEC_H */
+
diff -uNr linux-2.5.44/kernel/Makefile linux-2.5.44.x86kexec-2/kernel/Makefile
--- linux-2.5.44/kernel/Makefile	Fri Oct 18 11:59:29 2002
+++ linux-2.5.44.x86kexec-2/kernel/Makefile	Sun Oct 27 15:21:51 2002
@@ -21,6 +21,7 @@
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_KEXEC) += kexec.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -uNr linux-2.5.44/kernel/kexec.c linux-2.5.44.x86kexec-2/kernel/kexec.c
--- linux-2.5.44/kernel/kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.5.44.x86kexec-2/kernel/kexec.c	Sun Oct 27 15:21:51 2002
@@ -0,0 +1,624 @@
+#include <linux/mm.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/version.h>
+#include <linux/compile.h>
+#include <linux/kexec.h>
+#include <net/checksum.h>
+#include <asm/page.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#define DEBUG 0
+
+/* As designed kexec can only use the memory that you don't
+ * need to use kmap to access.  Memory that you can use virt_to_phys()
+ * on an call get_free_page to allocate.
+ *
+ * In the best case you need one page for the transition from
+ * virtual to physical memory.  And this page must be identity
+ * mapped.  Which pretty much leaves you with pages < PAGE_OFFSET
+ * as you can only mess with user pages.
+ * 
+ * As the only subset of memory that it is easy to restrict allocation
+ * to is the physical memory mapped into the kernel, I do that
+ * with get_free_page and hope it is enough.
+ *
+ * I don't know of a good way to do this calcuate which pages get_free_page
+ * will return independent of architecture so I depend on
+ * <asm/kexec.h> to properly set 
+ * KEXEC_SOURCE_MEMORY_LIMIT and KEXEC_DESTINATION_MEMORY_LIMIT
+ * 
+ */
+
+void kimage_init(struct kimage *image)
+{
+	memset(image, 0, sizeof(*image));
+	image->head = 0;
+	image->entry = &image->head;
+	image->last_entry = &image->head;
+}
+static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
+{
+	if (image->offset != 0) {
+		image->entry++;
+	}
+	if (image->entry == image->last_entry) {
+		kimage_entry_t *ind_page;
+		ind_page = (void *)__get_free_page(GFP_KERNEL);
+		if (!ind_page) {
+			return -ENOMEM;
+		}
+		*image->entry = virt_to_phys(ind_page) | IND_INDIRECTION;
+		image->entry = ind_page;
+		image->last_entry = 
+			ind_page + ((PAGE_SIZE/sizeof(kimage_entry_t)) - 1);
+	}
+	*image->entry = entry;
+	image->entry++;
+	image->offset = 0;
+	return 0;
+}
+
+static int kimage_verify_destination(unsigned long destination)
+{
+	int result;
+	
+	/* Assume the page is bad unless we pass the checks */
+	result = -EADDRNOTAVAIL;
+
+	if (destination >= KEXEC_DESTINATION_MEMORY_LIMIT) {
+		goto out;
+	}
+
+	/* FIXME:
+	 * add checking to ensure the new image doesn't go into
+	 * invalid or reserved areas of RAM.
+	 */
+	result =  0;
+out:
+	return result;
+}
+
+static int kimage_set_destination(
+	struct kimage *image, unsigned long destination) 
+{
+	int result;
+	destination &= PAGE_MASK;
+	result = kimage_verify_destination(destination);
+	if (result) {
+		return result;
+	}
+	result = kimage_add_entry(image, destination | IND_DESTINATION);
+	if (result == 0) {
+		image->destination = destination;
+	}
+	return result;
+}
+
+
+static int kimage_add_page(struct kimage *image, unsigned long page)
+{
+	int result;
+	page &= PAGE_MASK;
+	result = kimage_verify_destination(image->destination);
+	if (result) {
+		return result;
+	}
+	result = kimage_add_entry(image, page | IND_SOURCE);
+	if (result == 0) {
+		image->destination += PAGE_SIZE;
+	}
+	return result;
+}
+
+
+static int kimage_terminate(struct kimage *image)
+{
+	int result;
+	result = kimage_add_entry(image, IND_DONE);
+	if (result == 0) {
+		/* Point at the terminating element */
+		image->entry--;
+	}
+	return result;
+}
+
+#define for_each_kimage_entry(image, ptr, entry) \
+	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
+		ptr = (entry & IND_INDIRECTION)? \
+			phys_to_virt((entry & PAGE_MASK)): ptr +1)
+
+void kimage_free(struct kimage *image)
+{
+	kimage_entry_t *ptr, entry;
+	kimage_entry_t ind = 0;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_INDIRECTION) {
+			/* Free the previous indirection page */
+			if (ind & IND_INDIRECTION) {
+				free_page((unsigned long)phys_to_virt(ind & PAGE_MASK));
+			}
+			/* Save this indirection page until we are
+			 * done with it.
+			 */
+			ind = entry;
+		}
+		else if (entry & IND_SOURCE) {
+			free_page((unsigned long)phys_to_virt(entry & PAGE_MASK));
+		}
+	}
+}
+
+#if DEBUG
+static void kimage_print_image(struct kimage *image)
+{
+	kimage_entry_t *ptr, entry;
+	int i;
+	printk(KERN_EMERG "kimage_print_image\n");
+	i = 0;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_DESTINATION) {
+			printk(KERN_EMERG "%5d DEST\n", i);
+		}
+		else if (entry & IND_INDIRECTION) {
+			printk(KERN_EMERG "%5d IND\n", i);
+		}
+		else if (entry & IND_SOURCE) {
+			printk(KERN_EMERG "%5d SOURCE\n", i);
+		}
+		else if (entry & IND_DONE) {
+			printk(KERN_EMERG "%5d DONE\n", i);
+		}
+		else {
+			printk(KERN_EMERG "%5d ?\n", i);
+		}
+		i++;
+	}
+	printk(KERN_EMERG "kimage_print_image: %5d\n", i);
+}
+#endif
+static int kimage_is_destination_page(
+	struct kimage *image, unsigned long page)
+{
+	kimage_entry_t *ptr, entry;
+	unsigned long destination;
+	destination = 0;
+	page &= PAGE_MASK;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_DESTINATION) {
+			destination = entry & PAGE_MASK;
+		}
+		else if (entry & IND_SOURCE) {
+			if (page == destination) {
+				return 1;
+			}
+			destination += PAGE_SIZE;
+		}
+	}
+	return 0;
+}
+
+static int kimage_get_unused_area(
+	struct kimage *image, unsigned long size, unsigned long align,
+	unsigned long *area)
+{
+	/* Walk through mem_map and find the first chunk of
+	 * ununsed memory that is at least size bytes long.
+	 */
+	/* Since the kernel plays with Page_Reseved mem_map is less
+	 * than ideal for this purpose, but it will give us a correct
+	 * conservative estimate of what we need to do. 
+	 */
+	/* For now we take advantage of the fact that all kernel pages
+	 * are marked with PG_resereved to allocate a large
+	 * contiguous area for the reboot code buffer.
+	 */
+	unsigned long addr;
+	unsigned long start, end;
+	unsigned long mask;
+	mask = ((1 << align) -1);
+	start = end = PAGE_SIZE;
+	for(addr = PAGE_SIZE; addr < KEXEC_SOURCE_MEMORY_LIMIT; addr += PAGE_SIZE) {
+		struct page *page;
+		unsigned long aligned_start;
+		page = virt_to_page(phys_to_virt(addr));
+		if (PageReserved(page) ||
+			kimage_is_destination_page(image, addr)) {
+			/* The current page is reserved so the start &
+			 * end of the next area must be atleast at the
+			 * next page.
+			 */
+			start = end = addr + PAGE_SIZE;
+		}
+		else {
+			/* O.k.  The current page isn't reserved
+			 * so push up the end of the area.
+			 */
+			end = addr;
+		}
+		aligned_start = (start + mask) & ~mask;
+		if (aligned_start > start) {
+			continue;
+		}
+		if (aligned_start > end) {
+			continue;
+		}
+		if (end - aligned_start >= size) {
+			*area = aligned_start;
+			return 0;
+		}
+	}
+	*area = 0;
+	return -ENOSPC;
+}
+
+static kimage_entry_t *kimage_dst_conflict(
+	struct kimage *image, unsigned long page, kimage_entry_t *limit)
+{
+	kimage_entry_t *ptr, entry;
+	unsigned long destination = 0;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (ptr == limit) {
+			return 0;
+		}
+		else if (entry & IND_DESTINATION) {
+			destination = entry & PAGE_MASK;
+		}
+		else if (entry & IND_SOURCE) {
+			if (page == destination) {
+				return ptr;
+			}
+			destination += PAGE_SIZE;
+		}
+	}
+	return 0;
+}
+
+static kimage_entry_t *kimage_src_conflict(
+	struct kimage *image, unsigned long destination, kimage_entry_t *limit)
+{
+	kimage_entry_t *ptr, entry;
+	for_each_kimage_entry(image, ptr, entry) {
+		unsigned long page;
+		if (ptr == limit) {
+			return 0;
+		}
+		else if (entry & IND_DESTINATION) {
+			/* nop */
+		}
+		else if (entry & IND_DONE) {
+			/* nop */
+		}
+		else {
+			/* SOURCE & INDIRECTION */
+			page = entry & PAGE_MASK;
+			if (page == destination) {
+				return ptr;
+			}
+		}
+	}
+	return 0;
+}
+
+static int kimage_get_off_destination_pages(struct kimage *image)
+{
+	kimage_entry_t *ptr, *cptr, entry;
+	unsigned long buffer, page;
+	unsigned long destination = 0;
+
+	/* Here we implement safe guards to insure that
+	 * a source page is not copied to it's destination
+	 * page before the data on the destination page is
+	 * no longer useful.
+	 *
+	 * To make it work we actually wind up with a 
+	 * stronger condition.  For every page considered
+	 * it is either it's own destination page or it is
+	 * not a destination page of any page considered.
+	 *
+	 * Invariants 
+	 * 1. buffer is not a destination of a previous page.
+	 * 2. page is not a destination of a previous page.
+	 * 3. destination is not a previous source page.
+	 *
+	 * Result: Either a source page and a destination page 
+	 * are the same or the page is not a destination page.
+	 *
+	 * These checks could be done when we allocate the pages,
+	 * but doing it as a final pass allows us more freedom
+	 * on how we allocate pages.
+	 * 
+	 * Also while the checks are necessary, in practice nothing
+	 * happens.  The destination kernel wants to sit in the
+	 * same physical addresses as the current kernel so we never
+	 * actually allocate a destination page.
+	 *
+	 * BUGS: This is a O(N^2) algorithm.
+	 */
+
+	
+	buffer = __get_free_page(GFP_KERNEL);
+	if (!buffer) {
+		return -ENOMEM;
+	}
+	buffer = virt_to_phys((void *)buffer);
+	for_each_kimage_entry(image, ptr, entry) {
+		/* Here we check to see if an allocated page */
+		kimage_entry_t *limit;
+		if (entry & IND_DESTINATION) {
+			destination = entry & PAGE_MASK;
+		}
+		else if (entry & IND_INDIRECTION) {
+			/* Indirection pages must include all of their
+			 * contents in limit checking.
+			 */
+			limit = phys_to_virt(page + PAGE_SIZE - sizeof(*limit));
+		}
+		if (!((entry & IND_SOURCE) | (entry & IND_INDIRECTION))) {
+			continue;
+		}
+		page = entry & PAGE_MASK;
+		limit = ptr;
+
+		/* See if a previous page has the current page as it's 
+		 * destination.
+		 * i.e. invariant 2
+		 */
+		cptr = kimage_dst_conflict(image, page, limit);
+		if (cptr) {
+			unsigned long cpage;
+ 			kimage_entry_t centry;
+			centry = *cptr;
+			cpage = centry & PAGE_MASK;
+			memcpy(phys_to_virt(buffer), phys_to_virt(page), PAGE_SIZE);
+			memcpy(phys_to_virt(page), phys_to_virt(cpage), PAGE_SIZE);
+			*cptr = page | (centry & ~PAGE_MASK);
+			*ptr = buffer | (entry & ~PAGE_MASK);
+			buffer = cpage;
+		}
+		if (!(entry & IND_SOURCE)) {
+			continue;
+		}
+
+		/* See if a previous page is our destination page.
+		 * If so claim it now.
+		 * i.e. invariant 3
+		 */
+		cptr = kimage_src_conflict(image, destination, limit);
+		if (cptr) {
+			unsigned long cpage;
+ 			kimage_entry_t centry;
+			centry = *cptr;
+			cpage = centry & PAGE_MASK;
+			memcpy(phys_to_virt(buffer), phys_to_virt(cpage), PAGE_SIZE);
+			memcpy(phys_to_virt(cpage), phys_to_virt(page), PAGE_SIZE);
+			*cptr = buffer | (centry & ~PAGE_MASK);
+			*ptr = cpage | ( entry & ~PAGE_MASK);
+			buffer = page;
+		}
+		/* If the buffer is my destination page do the copy now 
+		 * i.e. invariant 3 & 1
+		 */
+		if (buffer == destination) {
+			memcpy(phys_to_virt(buffer), phys_to_virt(page), PAGE_SIZE);
+			*ptr = buffer | (entry & ~PAGE_MASK);
+			buffer = page;
+		}
+	}
+	free_page((unsigned long)phys_to_virt(buffer));
+	return 0;
+}
+
+static int kimage_add_empty_pages(struct kimage *image,
+	unsigned long len)
+{
+	unsigned long pos;
+	int result;
+	for(pos = 0; pos < len; pos += PAGE_SIZE) {
+		char *page;
+		result = -ENOMEM;
+		page = (void *)__get_free_page(GFP_KERNEL);
+		if (!page) {
+			goto out;
+		}
+		result = kimage_add_page(image, virt_to_phys(page));
+		if (result) {
+			goto out;
+		}
+	}
+	result = 0;
+ out:
+	return result;
+}
+
+
+static int kimage_load_segment(struct kimage *image,
+	struct kexec_segment *segment)
+{	
+	unsigned long mstart;
+	int result;
+	unsigned long offset;
+	unsigned long offset_end;
+	unsigned char *buf;
+
+	result = 0;
+	buf = segment->buf;
+	mstart = (unsigned long)segment->mem;
+
+	offset_end = segment->memsz;
+
+	result = kimage_set_destination(image, mstart);
+	if (result < 0) {
+		goto out;
+	}
+	for(offset = 0;  offset < segment->memsz; offset += PAGE_SIZE) {
+		char *page;
+		size_t size, leader;
+		page = (char *)__get_free_page(GFP_KERNEL);
+		if (page == 0) {
+			result  = -ENOMEM;
+			goto out;
+		}
+		result = kimage_add_page(image, virt_to_phys(page));
+		if (result < 0) {
+			goto out;
+		}
+		if (segment->bufsz < offset) {
+			/* We are past the end zero the whole page */
+			memset(page, 0, PAGE_SIZE);
+			continue;
+		}
+		size = PAGE_SIZE;
+		leader = 0;
+		if ((offset == 0)) {
+			leader = mstart & ~PAGE_MASK;
+		}
+		if (leader) {
+			/* We are on the first page zero the unused portion */
+			memset(page, 0, leader);
+			size -= leader;
+			page += leader;
+		}
+		if (size > (segment->bufsz - offset)) {
+			size = segment->bufsz - offset;
+		}
+		result = copy_from_user(page, buf + offset, size);
+		if (result) {
+			result = (result < 0)?result : -EIO;
+			goto out;
+		}
+		if (size < (PAGE_SIZE - leader)) {
+			/* zero the trailing part of the page */
+			memset(page + size, 0, (PAGE_SIZE - leader) - size);
+		}
+	}
+ out:
+	return result;
+}
+
+
+/* do_kexec executes a new kernel 
+ */
+int do_kexec(unsigned long start, long nr_segments,
+	struct kexec_segment *arg_segments, struct kimage *image)
+{
+	struct kexec_segment *segments;
+	size_t segment_bytes;
+	int i;
+
+	int result; 
+	unsigned long reboot_code_buffer;
+	kimage_entry_t *end;
+
+	/* Initialize variables */
+	segments = 0;
+
+	/* We only trust the superuser with rebooting the system. */
+	if (nr_segments <= 0) {
+		result = -EINVAL;
+		goto out;
+	}
+	segment_bytes = nr_segments * sizeof(*segments);
+	segments = kmalloc(GFP_KERNEL, segment_bytes);
+	if (segments == 0) {
+		result = -ENOMEM;
+		goto out;
+	}
+	result = copy_from_user(segments, arg_segments, segment_bytes);
+	if (result) {
+		goto out;
+	}
+#if DEBUG
+	for(i = 0; i < nr_segments; i++) {
+		printk(KERN_EMERG "k_segment[%d].buf   = %p\n",   i, segments[i].buf);
+		printk(KERN_EMERG "k_segment[%d].bufsz = 0x%x\n", i, segments[i].bufsz);
+		printk(KERN_EMERG "k_segment[%d].mem   = %p\n",   i, segments[i].mem);
+		printk(KERN_EMERG "k_segment[%d].memsz = 0x%x\n", i, segments[i].memsz);
+	}
+	printk(KERN_EMERG "k_entry       = 0x%08lx\n", start);
+	printk(KERN_EMERG "k_nr_segments = %d\n", nr_segments);
+	printk(KERN_EMERG "k_segments    = %p\n", segments);
+#endif
+
+	/* Read in the data from user space */
+	image->start = start;
+	for(i = 0; i < nr_segments; i++) {
+		result = kimage_load_segment(image, &segments[i]);
+		if (result) {
+			goto out;
+		}
+	}
+	
+	/* Terminate early so I can get a place holder. */
+	result = kimage_terminate(image);
+	if (result)
+		goto out;
+	end = image->entry;
+
+	/* Usage of the reboot code buffer is subtle.  We first
+	 * find a continguous area of ram, that is not one
+	 * of our destination pages.  We do not allocate the ram.
+	 *
+	 * The algorithm to make certain we do not have address
+	 * conflicts requires each destination region to have some
+	 * backing store so we allocate abitrary source pages.
+	 *
+	 * Later in machine_kexec when we copy data to the
+	 * reboot_code_buffer it still may be allocated for other
+	 * purposes, but we do know there are no source or destination
+	 * pages in that area.  And since the rest of the kernel
+	 * is already shutdown those pages are free for use,
+	 * regardless of their page->count values.
+	 */
+	result = kimage_get_unused_area(
+		image, KEXEC_REBOOT_CODE_SIZE, KEXEC_REBOOT_CODE_ALIGN,
+		&reboot_code_buffer);
+	if (result) 
+		goto out;
+
+	/* Allocating pages we should never need  is silly but the
+	 * code won't work correctly unless we have dummy pages to
+	 * work with. 
+	 */
+	result = kimage_set_destination(image, reboot_code_buffer);
+	if (result) 
+		goto out;
+	result = kimage_add_empty_pages(image, KEXEC_REBOOT_CODE_SIZE);
+	if (result)
+		goto out;
+	image->reboot_code_buffer = phys_to_virt(reboot_code_buffer);
+
+	result = kimage_terminate(image);
+	if (result)
+		goto out;
+
+	result = kimage_get_off_destination_pages(image);
+	if (result)
+		goto out;
+
+#if DEBUG
+	kimage_print_image(image);
+#endif
+
+	/* Now hide the extra source pages for the reboot code buffer 
+	 * What is the logic with the reboot code buffer, should it
+	 * be mapped 1-1 by this point FIXME verify this?
+	 */
+	image->entry = end;
+	result = kimage_terminate(image);
+	if (result)
+		goto out;
+
+#if DEBUG
+	kimage_print_image(image);
+#endif
+
+	result = 0;
+ out:
+	/* cleanup and exit */
+	if (segments)	kfree(segments);
+	return result;
+}
+
diff -uNr linux-2.5.44/kernel/sys.c linux-2.5.44.x86kexec-2/kernel/sys.c
--- linux-2.5.44/kernel/sys.c	Fri Oct 18 11:59:29 2002
+++ linux-2.5.44.x86kexec-2/kernel/sys.c	Sun Oct 27 15:21:51 2002
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/fs.h>
+#include <linux/kexec.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/times.h>
@@ -430,6 +431,66 @@
 	unlock_kernel();
 	return 0;
 }
+
+#ifdef CONFIG_KEXEC
+/*
+ * Exec Kernel system call: for obvious reasons only root may call it.
+ * 
+ * This call breaks up into three pieces.  
+ * - A generic part which loads the new kernel from the current
+ *   address space, and very carefully places the data in the
+ *   allocated pages.
+ *
+ * - A generic part that interacts with the kernel and tells all of
+ *   the devices to shut down.  Preventing on-going dmas, and placing
+ *   the devices in a consistent state so a later kernel can
+ *   reinitialize them.
+ *
+ * - A machine specific part that includes the syscall number
+ *   and the copies the image to it's final destination.  And
+ *   jumps into the image at entry.
+ *
+ * kexec does not sync, or unmount filesystems so if you need
+ * that to happen you need to do that yourself.
+ */
+asmlinkage long sys_kexec(unsigned long entry, long nr_segments, 
+	struct kexec_segment *segments)
+{
+	/* Am I using to much stack space here? */
+	struct kimage image;
+	int result;
+		
+	/* We only trust the superuser with rebooting the system. */
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	lock_kernel();
+	kimage_init(&image);
+	result = do_kexec(entry, nr_segments, segments, &image);
+	if (result) {
+		kimage_free(&image);
+		unlock_kernel();
+		return result;
+	}
+	
+	/* The point of no return is here... */
+	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
+	system_running = 0;
+	device_shutdown();
+	printk(KERN_EMERG "kexecing image\n");
+	machine_kexec(&image);
+	/* We never get here but... */
+	kimage_free(&image);
+	unlock_kernel();
+	return -EINVAL; 
+}
+#else
+asmlinkage long sys_kexec(unsigned long entry, long nr_segments,
+	struct kexec_segment *segments)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_KEXEC */
 
 static void deferred_cad(void *dummy)
 {

