Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSKRIqt>; Mon, 18 Nov 2002 03:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSKRIqt>; Mon, 18 Nov 2002 03:46:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19283 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261664AbSKRIq3>; Mon, 18 Nov 2002 03:46:29 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andy Pfiffer <andyp@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linuxbios <linuxbios@clustermatic.org>
Subject: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
	<m1el9j2zwb.fsf@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Nov 2002 01:53:02 -0700
In-Reply-To: <m1el9j2zwb.fsf@frodo.biederman.org>
Message-ID: <m11y5j2r9t.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kexec is a set of systems call that allows you to load another kernel
from the currently executing Linux kernel.  The current implementation
has only been tested, and had the kinks worked out on x86, but the
generic code should work on any architecture.

Could I get some feed back on where this work and where this breaks.
With the maturation of kexec-tools to skip attempting bios calls,
I expect a new the linux kernel to load for most people.  Though I
also expect some device drivers will not reinitialize after the reboot.

The patch is archived at:
http://www.xmission.com/~ebiederm/files/kexec/

And is currently kept in two pieces.
The pure system call.
http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.48.x86kexec.diff

And the set of hardware fixes known to help kexec.
http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.48.x86kexec-hwfixes.diff

A compatible user space is at:
http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.7.tar.gz
This code boots either a static ELF executable or a bzImage.

As of version 1.6 /sbin/kexec now works much more like /sbin/reboot.
It is recommend you place /sbin/kexec -e in /etc/init.d/reboot
just before the the call to /sbin/reboot.  If you haven't called
/sbin/kexec previously it will fail, and you can then call
/sbin/reboot.  Given the similiarity it is now the plan to merge in
reboot via kexec into /sbin/reboot.  

One bug was fixed in the move to 2.5.48.  Previously I had failed to
clear PAE and PSE in the kernel.  This caused reboot failures when
CONFIG_HIGHMEM_64G was enabled, as the new kernel would fail when
enabling paging, as these bits remained set.  Is %cr4 present on all
386+ intel cpus, or do I need to conditionalize the code that accesses
it?

As of version 1.6 /sbin/kexec when presented with a bzImage by default
avoids all BIOS calls and jumps directly to the kernels 32 bit entry
point.  The information it would usually get from the BIOS is instead
collected from the current kernel.  Accurately getting things like
the BIOS memory map from the current kernel is a challenge, still
needs to be addressed.  Safe defaults have been provided for the cases
I do not currently have good code to gather the information from the
running kernel.

In bug reports please include the serial console output of 
kexec kexec_test.  kexec_test exercises most of the interesting code
paths that are needed to load a kernel (mainly BIOS calls) with lots
of debugging print statements, so hangs can easily be detected.   

Eric


 MAINTAINERS                        |    7 
 arch/i386/Kconfig                  |   17 
 arch/i386/kernel/Makefile          |    1 
 arch/i386/kernel/entry.S           |    2 
 arch/i386/kernel/machine_kexec.c   |  142 ++++++++
 arch/i386/kernel/relocate_kernel.S |  107 ++++++
 include/asm-i386/kexec.h           |   25 +
 include/asm-i386/unistd.h          |    2 
 include/linux/kexec.h              |   45 ++
 include/linux/reboot.h             |    2 
 kernel/Makefile                    |    1 
 kernel/kexec.c                     |  640 +++++++++++++++++++++++++++++++++++++
 kernel/sys.c                       |   23 +
 13 files changed, 1012 insertions, 2 deletions

diff -uNr linux-2.5.48/MAINTAINERS linux-2.5.48.x86kexec/MAINTAINERS
--- linux-2.5.48/MAINTAINERS	Mon Nov 11 00:22:33 2002
+++ linux-2.5.48.x86kexec/MAINTAINERS	Sun Nov 17 22:53:09 2002
@@ -968,6 +968,13 @@
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
diff -uNr linux-2.5.48/arch/i386/Kconfig linux-2.5.48.x86kexec/arch/i386/Kconfig
--- linux-2.5.48/arch/i386/Kconfig	Sun Nov 17 22:51:14 2002
+++ linux-2.5.48.x86kexec/arch/i386/Kconfig	Sun Nov 17 22:53:09 2002
@@ -784,6 +784,23 @@
 	depends on (SMP || PREEMPT) && X86_CMPXCHG
 	default y
 
+config KEXEC
+	bool "kexec system call (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  kexec is a system call that implements the ability to  shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is indepedent of the system firmware.   And like a reboot
+	  you can start any kernel with it not just Linux.  
+	
+	  The name comes from the similiarity to the exec system call. 
+	
+	  It is on an going process to be certain the hardware in a machine
+	  is properly shutdown, so do not be surprised if this code does not
+	  initially work for you.  It may help to enable device hotplugging
+	  support.  As of this writing the exact hardware interface is
+	  strongly in flux, so no good recommendation can be made.
+
 endmenu
 
 
diff -uNr linux-2.5.48/arch/i386/kernel/Makefile linux-2.5.48.x86kexec/arch/i386/kernel/Makefile
--- linux-2.5.48/arch/i386/kernel/Makefile	Sun Nov 17 22:51:14 2002
+++ linux-2.5.48.x86kexec/arch/i386/kernel/Makefile	Sun Nov 17 22:53:09 2002
@@ -24,6 +24,7 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_PROFILING)		+= profile.o
diff -uNr linux-2.5.48/arch/i386/kernel/entry.S linux-2.5.48.x86kexec/arch/i386/kernel/entry.S
--- linux-2.5.48/arch/i386/kernel/entry.S	Sun Nov 17 22:51:14 2002
+++ linux-2.5.48.x86kexec/arch/i386/kernel/entry.S	Sun Nov 17 22:56:43 2002
@@ -768,7 +768,7 @@
 	.long sys_epoll_wait
  	.long sys_remap_file_pages
  	.long sys_set_tid_address
-
+	.long sys_kexec_load
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -uNr linux-2.5.48/arch/i386/kernel/machine_kexec.c linux-2.5.48.x86kexec/arch/i386/kernel/machine_kexec.c
--- linux-2.5.48/arch/i386/kernel/machine_kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.5.48.x86kexec/arch/i386/kernel/machine_kexec.c	Sun Nov 17 22:53:09 2002
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
diff -uNr linux-2.5.48/arch/i386/kernel/relocate_kernel.S linux-2.5.48.x86kexec/arch/i386/kernel/relocate_kernel.S
--- linux-2.5.48/arch/i386/kernel/relocate_kernel.S	Wed Dec 31 17:00:00 1969
+++ linux-2.5.48.x86kexec/arch/i386/kernel/relocate_kernel.S	Sun Nov 17 23:58:29 2002
@@ -0,0 +1,107 @@
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
+	
+	/* Set cr4 to a known state:
+	 * Setting everything to zero seems safe.
+	 */
+	movl	%cr4, %eax
+	andl	$0, %eax
+	movl	%eax, %cr4
+	
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
diff -uNr linux-2.5.48/include/asm-i386/kexec.h linux-2.5.48.x86kexec/include/asm-i386/kexec.h
--- linux-2.5.48/include/asm-i386/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.48.x86kexec/include/asm-i386/kexec.h	Sun Nov 17 22:53:09 2002
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
diff -uNr linux-2.5.48/include/asm-i386/unistd.h linux-2.5.48.x86kexec/include/asm-i386/unistd.h
--- linux-2.5.48/include/asm-i386/unistd.h	Sun Nov 17 22:51:25 2002
+++ linux-2.5.48.x86kexec/include/asm-i386/unistd.h	Sun Nov 17 22:54:03 2002
@@ -263,7 +263,7 @@
 #define __NR_sys_epoll_wait	256
 #define __NR_remap_file_pages	257
 #define __NR_set_tid_address	258
-
+#define __NR_sys_kexec_load	259
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -uNr linux-2.5.48/include/linux/kexec.h linux-2.5.48.x86kexec/include/linux/kexec.h
--- linux-2.5.48/include/linux/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.48.x86kexec/include/linux/kexec.h	Sun Nov 17 22:53:09 2002
@@ -0,0 +1,45 @@
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
+struct kexec_segment {
+	void *buf;
+	size_t bufsz;
+	void *mem;
+	size_t memsz;
+};
+
+/* kexec interface functions */
+extern void machine_kexec(struct kimage *image);
+extern asmlinkage long sys_kexec(unsigned long entry, long nr_segments, 
+	struct kexec_segment *segments);
+extern struct kimage *kexec_image;
+#endif
+#endif /* LINUX_KEXEC_H */
+
diff -uNr linux-2.5.48/include/linux/reboot.h linux-2.5.48.x86kexec/include/linux/reboot.h
--- linux-2.5.48/include/linux/reboot.h	Fri Oct 11 22:22:47 2002
+++ linux-2.5.48.x86kexec/include/linux/reboot.h	Sun Nov 17 22:53:09 2002
@@ -21,6 +21,7 @@
  * POWER_OFF   Stop OS and remove all power from system, if possible.
  * RESTART2    Restart system using given command string.
  * SW_SUSPEND  Suspend system using Software Suspend if compiled in
+ * KEXEC       Restart the system using a different kernel.
  */
 
 #define	LINUX_REBOOT_CMD_RESTART	0x01234567
@@ -30,6 +31,7 @@
 #define	LINUX_REBOOT_CMD_POWER_OFF	0x4321FEDC
 #define	LINUX_REBOOT_CMD_RESTART2	0xA1B2C3D4
 #define	LINUX_REBOOT_CMD_SW_SUSPEND	0xD000FCE2
+#define LINUX_REBOOT_CMD_KEXEC		0x45584543
 
 
 #ifdef __KERNEL__
diff -uNr linux-2.5.48/kernel/Makefile linux-2.5.48.x86kexec/kernel/Makefile
--- linux-2.5.48/kernel/Makefile	Sun Nov 17 22:51:26 2002
+++ linux-2.5.48.x86kexec/kernel/Makefile	Sun Nov 17 22:53:09 2002
@@ -21,6 +21,7 @@
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_KEXEC) += kexec.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -uNr linux-2.5.48/kernel/kexec.c linux-2.5.48.x86kexec/kernel/kexec.c
--- linux-2.5.48/kernel/kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.5.48.x86kexec/kernel/kexec.c	Sun Nov 17 22:53:09 2002
@@ -0,0 +1,640 @@
+#include <linux/mm.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/version.h>
+#include <linux/compile.h>
+#include <linux/kexec.h>
+#include <linux/spinlock.h>
+#include <net/checksum.h>
+#include <asm/page.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/system.h>
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
+static struct kimage *kimage_alloc(void)
+{
+	struct kimage *image;
+	image = kmalloc(sizeof(*image), GFP_KERNEL);
+	if (!image)
+		return 0;
+	memset(image, 0, sizeof(*image));
+	image->head = 0;
+	image->entry = &image->head;
+	image->last_entry = &image->head;
+	return image;
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
+	/* NOTE: The caller is responsible for making certain we
+	 * don't attempt to load the new image into invalid or
+	 * reserved areas of RAM.
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
+static void kimage_free(struct kimage *image)
+{
+	kimage_entry_t *ptr, entry;
+	kimage_entry_t ind = 0;
+	if (!image)
+		return;
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
+	kfree(image);
+}
+
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
+static int do_kexec(unsigned long start, unsigned long nr_segments,
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
+	 *
+	 * The kernel mapping is of the reboot code buffer is passed to
+	 * the machine dependent code.  If it needs something else
+	 * it is free to set that up.
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
+	/* Now hide the extra source pages for the reboot code buffer.
+	 */
+	image->entry = end;
+	result = kimage_terminate(image);
+	if (result)
+		goto out;
+
+	result = 0;
+ out:
+	/* cleanup and exit */
+	if (segments)	kfree(segments);
+	return result;
+}
+
+
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
+struct kimage *kexec_image = 0;
+
+asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments, 
+	struct kexec_segment *segments, unsigned long flags)
+{
+	/* Am I using to much stack space here? */
+	struct kimage *image, *old_image;
+	int result;
+		
+	/* We only trust the superuser with rebooting the system. */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* In case we need just a little bit of special behavior for
+	 * reboot on panic 
+	 */
+	if (flags != 0)
+		return -EINVAL;
+
+	image = 0;
+	if (nr_segments > 0) {
+		image = kimage_alloc();
+		if (!image) {
+			return -ENOMEM;
+		}
+		result = do_kexec(entry, nr_segments, segments, image);
+		if (result) {
+			kimage_free(image);
+			return result;
+		}
+	}
+
+	old_image = xchg(&kexec_image, image);
+
+	kimage_free(old_image);
+	return 0;
+}
diff -uNr linux-2.5.48/kernel/sys.c linux-2.5.48.x86kexec/kernel/sys.c
--- linux-2.5.48/kernel/sys.c	Sun Nov 17 22:51:26 2002
+++ linux-2.5.48.x86kexec/kernel/sys.c	Sun Nov 17 22:53:09 2002
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/fs.h>
+#include <linux/kexec.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/times.h>
@@ -206,6 +207,7 @@
 cond_syscall(sys_lookup_dcookie)
 cond_syscall(sys_swapon)
 cond_syscall(sys_swapoff)
+cond_syscall(sys_kexec_load)
 cond_syscall(sys_init_module)
 cond_syscall(sys_delete_module)
 
@@ -416,6 +418,27 @@
 		machine_restart(buffer);
 		break;
 
+#ifdef CONFIG_KEXEC
+	case LINUX_REBOOT_CMD_KEXEC:
+	{
+		struct kimage *image;
+		if (arg) {
+			unlock_kernel();
+			return -EINVAL;
+		}
+		image = xchg(&kexec_image, 0);
+		if (!image) {
+			unlock_kernel();
+			return -EINVAL;
+		}
+		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
+		system_running = 0;
+		device_shutdown();
+		printk(KERN_EMERG "Starting new kernel\n");
+		machine_kexec(image);
+		break;
+	}
+#endif
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
 		if (!software_suspend_enabled) {
