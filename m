Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbSLVLA0>; Sun, 22 Dec 2002 06:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSLVLA0>; Sun, 22 Dec 2002 06:00:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60717 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264963AbSLVLAM>; Sun, 22 Dec 2002 06:00:12 -0500
To: <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>, Andy Pfiffer <andyp@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH][CFT] kexec (rewrite) for 2.5.52
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Dec 2002 04:07:52 -0700
Message-ID: <m1smwql3av.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have recently taken the time to dig through the internals of
kexec to see if I could make my code any simpler and have managed
to trim off about 100 lines, and have made the code much more
obviously correct.

The key realization was that I had a much simpler test to detect
if a page was a destination page.  Allowing me to remove the second
pass, and put all of the logic to avoid stepping on my own
toes in the page allocator.

I have also made the small changes necessary to allow using high
memory pages.  Since I cannot push the request for memory below 4GB
into alloc_pages, I simply keep push the unusable pages on a list, and
keep requesting memory.  This should be o.k. on a large memory machine
but I can also see it as being pathological.  The advantage to using
high memory is that I should be able to use most of the memory below
4GB for a kernel image, and depending on how the zones are setup this
keeps me from artificially limiting myself.  I get the feeling what I
really want is my own special zone, maybe later...

With all of the strange logic in the kimage_alloc_page the code 
is much more obviously correct, and in most cases should run in O(N)
time, though it can still get pathological and run in O(N^2).

I have also made allocation of the reboot code buffer a little less
clever, removing a very small pathological case that was previously
present.

Anyway, I would love to know in what entertaining ways this code blows
up, or if I get lucky and it doesn't.  I probably will not reply back
in a timely manner as I am off to visit my parents, for Christmas and
New Years.  

Eric

 MAINTAINERS                        |    8 
 arch/i386/Kconfig                  |   17 +
 arch/i386/kernel/Makefile          |    1 
 arch/i386/kernel/entry.S           |    1 
 arch/i386/kernel/machine_kexec.c   |  140 +++++++++
 arch/i386/kernel/relocate_kernel.S |  107 +++++++
 include/asm-i386/kexec.h           |   23 +
 include/asm-i386/unistd.h          |    1 
 include/linux/kexec.h              |   54 +++
 include/linux/reboot.h             |    2 
 kernel/Makefile                    |    1 
 kernel/kexec.c                     |  547 +++++++++++++++++++++++++++++++++++++
 kernel/sys.c                       |   23 +
 13 files changed, 925 insertions

diff -uNr linux-2.5.52/MAINTAINERS linux-2.5.52.x86kexec-2/MAINTAINERS
--- linux-2.5.52/MAINTAINERS	Thu Dec 12 07:41:16 2002
+++ linux-2.5.52.x86kexec-2/MAINTAINERS	Mon Dec 16 02:24:32 2002
@@ -997,6 +997,14 @@
 W:	http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/
 S:	Maintained
 
+KEXEC
+P:	Eric Biederman
+M:	ebiederm@xmission.com
+M:	ebiederman@lnxi.com
+W:	http://www.xmission.com/~ebiederm/files/kexec/
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 LANMEDIA WAN CARD DRIVER
 P:	Andrew Stanley-Jones
 M:	asj@lanmedia.com
diff -uNr linux-2.5.52/arch/i386/Kconfig linux-2.5.52.x86kexec-2/arch/i386/Kconfig
--- linux-2.5.52/arch/i386/Kconfig	Mon Dec 16 02:18:32 2002
+++ linux-2.5.52.x86kexec-2/arch/i386/Kconfig	Mon Dec 16 02:23:00 2002
@@ -686,6 +686,23 @@
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
 
 
diff -uNr linux-2.5.52/arch/i386/kernel/Makefile linux-2.5.52.x86kexec-2/arch/i386/kernel/Makefile
--- linux-2.5.52/arch/i386/kernel/Makefile	Mon Dec 16 02:18:32 2002
+++ linux-2.5.52.x86kexec-2/arch/i386/kernel/Makefile	Mon Dec 16 02:23:00 2002
@@ -24,6 +24,7 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_PROFILING)		+= profile.o
diff -uNr linux-2.5.52/arch/i386/kernel/entry.S linux-2.5.52.x86kexec-2/arch/i386/kernel/entry.S
--- linux-2.5.52/arch/i386/kernel/entry.S	Thu Dec 12 07:41:17 2002
+++ linux-2.5.52.x86kexec-2/arch/i386/kernel/entry.S	Sat Dec 21 23:36:10 2002
@@ -743,6 +743,7 @@
 	.long sys_epoll_wait
  	.long sys_remap_file_pages
  	.long sys_set_tid_address
+	.long sys_kexec_load
 
 
 	.rept NR_syscalls-(.-sys_call_table)/4
diff -uNr linux-2.5.52/arch/i386/kernel/machine_kexec.c linux-2.5.52.x86kexec-2/arch/i386/kernel/machine_kexec.c
--- linux-2.5.52/arch/i386/kernel/machine_kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.5.52.x86kexec-2/arch/i386/kernel/machine_kexec.c	Sat Dec 21 16:07:05 2002
@@ -0,0 +1,140 @@
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
+				mk_pte(pfn_to_page(address >> PAGE_SHIFT), PAGE_SHARED));
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
+	unsigned long indirection_page;
+	unsigned long reboot_code_buffer;
+	void *ptr;
+	relocate_new_kernel_t rnk;
+
+	/* Interrupts aren't acceptable while we reboot */
+	local_irq_disable();
+	reboot_code_buffer = page_to_pfn(image->reboot_code_pages) << PAGE_SHIFT;
+	indirection_page = image->head & PAGE_MASK;
+
+	identity_map_page(reboot_code_buffer);
+
+	/* copy it out */
+	memcpy((void *)reboot_code_buffer, relocate_new_kernel, relocate_new_kernel_size);
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
+	rnk = (relocate_new_kernel_t) reboot_code_buffer;
+	(*rnk)(indirection_page, reboot_code_buffer, image->start);
+}
+
diff -uNr linux-2.5.52/arch/i386/kernel/relocate_kernel.S linux-2.5.52.x86kexec-2/arch/i386/kernel/relocate_kernel.S
--- linux-2.5.52/arch/i386/kernel/relocate_kernel.S	Wed Dec 31 17:00:00 1969
+++ linux-2.5.52.x86kexec-2/arch/i386/kernel/relocate_kernel.S	Mon Dec 16 02:23:00 2002
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
diff -uNr linux-2.5.52/include/asm-i386/kexec.h linux-2.5.52.x86kexec-2/include/asm-i386/kexec.h
--- linux-2.5.52/include/asm-i386/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.52.x86kexec-2/include/asm-i386/kexec.h	Sat Dec 21 14:18:31 2002
@@ -0,0 +1,23 @@
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
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+
+#define KEXEC_REBOOT_CODE_SIZE	4096
+
+#endif /* _I386_KEXEC_H */
diff -uNr linux-2.5.52/include/asm-i386/unistd.h linux-2.5.52.x86kexec-2/include/asm-i386/unistd.h
--- linux-2.5.52/include/asm-i386/unistd.h	Thu Dec 12 07:41:35 2002
+++ linux-2.5.52.x86kexec-2/include/asm-i386/unistd.h	Sat Dec 21 23:36:55 2002
@@ -264,6 +264,7 @@
 #define __NR_epoll_wait		256
 #define __NR_remap_file_pages	257
 #define __NR_set_tid_address	258
+#define __NR_sys_kexec_load	259
 
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
diff -uNr linux-2.5.52/include/linux/kexec.h linux-2.5.52.x86kexec-2/include/linux/kexec.h
--- linux-2.5.52/include/linux/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.52.x86kexec-2/include/linux/kexec.h	Sat Dec 21 15:27:17 2002
@@ -0,0 +1,54 @@
+#ifndef LINUX_KEXEC_H
+#define LINUX_KEXEC_H
+
+#if CONFIG_KEXEC
+#include <linux/types.h>
+#include <linux/list.h>
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
+#define KEXEC_SEGMENT_MAX 8
+struct kexec_segment {
+	void *buf;
+	size_t bufsz;
+	void *mem;
+	size_t memsz;
+};
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
+	struct page *reboot_code_pages;
+
+	unsigned long nr_segments;
+	struct kexec_segment segment[KEXEC_SEGMENT_MAX+1];
+
+	struct list_head dest_pages;
+	struct list_head unuseable_pages;
+};
+
+
+/* kexec interface functions */
+extern void machine_kexec(struct kimage *image);
+extern asmlinkage long sys_kexec(unsigned long entry, long nr_segments, 
+	struct kexec_segment *segments);
+extern struct kimage *kexec_image;
+#endif
+#endif /* LINUX_KEXEC_H */
+
diff -uNr linux-2.5.52/include/linux/reboot.h linux-2.5.52.x86kexec-2/include/linux/reboot.h
--- linux-2.5.52/include/linux/reboot.h	Thu Dec 12 07:41:37 2002
+++ linux-2.5.52.x86kexec-2/include/linux/reboot.h	Mon Dec 16 02:23:00 2002
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
diff -uNr linux-2.5.52/kernel/Makefile linux-2.5.52.x86kexec-2/kernel/Makefile
--- linux-2.5.52/kernel/Makefile	Mon Dec 16 02:19:15 2002
+++ linux-2.5.52.x86kexec-2/kernel/Makefile	Mon Dec 16 02:23:00 2002
@@ -21,6 +21,7 @@
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
 
 ifneq ($(CONFIG_IA64),y)
diff -uNr linux-2.5.52/kernel/kexec.c linux-2.5.52.x86kexec-2/kernel/kexec.c
--- linux-2.5.52/kernel/kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.5.52.x86kexec-2/kernel/kexec.c	Sun Dec 22 02:58:12 2002
@@ -0,0 +1,547 @@
+#include <linux/mm.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/version.h>
+#include <linux/compile.h>
+#include <linux/kexec.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/highmem.h>
+#include <net/checksum.h>
+#include <asm/page.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/system.h>
+
+/* When kexec transitions to the new kernel there is a one to one
+ * mapping between physical and virtual addresses.  On processors
+ * where you can disable the MMU this is trivial, and easy.  For
+ * others it is still a simple predictable page table to setup.
+ *
+ * In that environment kexec copies the new kernel to it's final
+ * resting place.  This means I can only support memory whose
+ * physical address can fit in an unsigned long.  In particular
+ * addresses where (pfn << PAGE_SHIFT) > ULONG_MAX cannot be handled.
+ * If the assembly stub has more restrictive requirements
+ * KEXEC_SOURCE_MEMORY_LIMIT and KEXEC_DEST_MEMORY_LIMIT can be
+ * defined more restrictively in <asm/kexec.h>.
+ *
+ * The code for the transition from the current kernel to the 
+ * the new kernel is placed in the reboot_code_buffer, whose size
+ * is given by KEXEC_REBOOT_CODE_SIZE.  In the best case only a single
+ * page of memory is necessary, but some architectures require more.
+ * Because this memory must be identity mapped in the transition from
+ * virtual to physical addresses it must live in the range
+ * 0 - TASK_SIZE, as only the user space mappings are arbitrarily
+ * modifyable.
+ *
+ * The assembly stub in the reboot code buffer is passed a linked list
+ * of descriptor pages detailing the source pages of the new kernel,
+ * and the destination addresses of those source pages.  As this data
+ * structure is not used in the context of the current OS, it must
+ * be self contained.
+ *
+ * The code has been made to work with highmem pages and will use a
+ * destination page in it's final resting place (if it happens 
+ * to allocate it).  The end product of this is that most of the
+ * physical address space, and most of ram can be used.
+ *
+ * Future directions include:
+ *  - allocating a page table with the reboot code buffer identity
+ *    mapped, to simplify machine_kexec and make kexec_on_panic, more
+ *    reliable.  
+ *  - allocating the pages for a page table for machines that cannot
+ *    disable their MMUs.  (Hammer, Alpha...)
+ */
+
+/* KIMAGE_NO_DEST is an impossible destination address..., for
+ * allocating pages whose destination address we do not care about.
+ */
+#define KIMAGE_NO_DEST (-1UL)
+
+static int kimage_is_destination_range(
+	struct kimage *image, unsigned long start, unsigned long end);
+static struct page *kimage_alloc_reboot_code_pages(struct kimage *image);
+static struct page *kimage_alloc_page(struct kimage *image, unsigned int gfp_mask, unsigned long dest);
+
+static int kimage_alloc(struct kimage **rimage, 
+	unsigned long nr_segments, struct kexec_segment *segments)
+{
+	int result;
+	struct kimage *image;
+	size_t segment_bytes;
+	struct page *reboot_pages;
+	unsigned long i;
+
+	/* Allocate a controlling structure */
+	result = -ENOMEM;
+	image = kmalloc(sizeof(*image), GFP_KERNEL);
+	if (!image) {
+		goto out;
+	}
+	memset(image, 0, sizeof(*image));
+	image->head = 0;
+	image->entry = &image->head;
+	image->last_entry = &image->head;
+
+	/* Initialize the list of destination pages */
+	INIT_LIST_HEAD(&image->dest_pages);
+
+	/* Initialize the list of unuseable pages */
+	INIT_LIST_HEAD(&image->unuseable_pages);
+
+	/* Read in the segments */
+	image->nr_segments = nr_segments;
+	segment_bytes = nr_segments * sizeof*segments;
+	result = copy_from_user(image->segment, segments, segment_bytes);
+	if (result) 
+		goto out;
+
+	/* Verify we have good destination addresses.  The caller is
+	 * responsible for making certain we don't attempt to load
+	 * the new image into invalid or reserved areas of RAM.  This
+	 * just verifies it is an address we can use. 
+	 */
+	result = -EADDRNOTAVAIL;
+	for(i = 0; i < nr_segments; i++) {
+		unsigned long mend;
+		mend = ((unsigned long)(image->segment[i].mem)) + 
+			image->segment[i].memsz;
+		if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)
+			goto out;
+	}
+
+	/* Find a location for the reboot code buffer, and add it
+	 * the vector of segments so that it's pages will also be
+	 * counted as destination pages.  
+	 */
+	result = -ENOMEM;
+	reboot_pages = kimage_alloc_reboot_code_pages(image);
+	if (!reboot_pages) {
+		printk(KERN_ERR "Could not allocate reboot_code_buffer\n");
+		goto out;
+	}
+	image->reboot_code_pages = reboot_pages;
+	image->segment[nr_segments].buf = 0;
+	image->segment[nr_segments].bufsz = 0;
+	image->segment[nr_segments].mem = (void *)(page_to_pfn(reboot_pages) << PAGE_SHIFT);
+	image->segment[nr_segments].memsz = KEXEC_REBOOT_CODE_SIZE;
+	image->nr_segments++;
+
+	result = 0;
+ out:
+	if (result == 0) {
+		*rimage = image;
+	} else {
+		kfree(image);
+	}
+	return result;
+}
+
+static int kimage_is_destination_range(
+	struct kimage *image, unsigned long start, unsigned long end)
+{
+	unsigned long i;
+	for(i = 0; i < image->nr_segments; i++) {
+		unsigned long mstart, mend;
+		mstart = (unsigned long)image->segment[i].mem;
+		mend   = mstart + image->segment[i].memsz;
+		if ((end > mstart) && (start < mend)) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+struct page *kimage_alloc_reboot_code_pages(struct kimage *image)
+{
+	/* The reboot code buffer is special.  It is the only set of
+	 * pages that must be allocated in their final resting place,
+	 * and the only set of pages whose final resting place we can
+	 * pick. 
+	 *
+	 * At worst this runs in O(N) of the image size.
+	 */
+	struct list_head extra_pages, *pos, *next;
+	struct page *pages;
+	unsigned long addr;
+	int order;
+	order = get_order(KEXEC_REBOOT_CODE_SIZE);
+	INIT_LIST_HEAD(&extra_pages);
+	do {
+		pages = alloc_pages(GFP_HIGHUSER, order);
+		addr = page_to_pfn(pages) << PAGE_SHIFT;
+		if ((page_to_pfn(pages) >= (TASK_SIZE >> PAGE_SHIFT)) ||
+			kimage_is_destination_range(image, addr, addr + KEXEC_REBOOT_CODE_SIZE)) {
+			list_add(&pages->list, &extra_pages);
+			pages = 0;
+		}
+	} while(!pages);
+	/* If I could convert a multi page allocation into a buch of
+	 * single page allocations I could add these pages to
+	 * image->dest_pages.  For now it is simpler to just free the
+	 * pages again.
+	 */
+	list_for_each_safe(pos, next, &extra_pages) {
+		struct page *page;
+		page = list_entry(pos, struct page, list);
+		list_del(&extra_pages);
+		__free_pages(page, order);
+	}
+	return pages;
+}
+
+static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
+{
+	if (image->offset != 0) {
+		image->entry++;
+	}
+	if (image->entry == image->last_entry) {
+		kimage_entry_t *ind_page;
+		struct page *page;
+		page = kimage_alloc_page(image, GFP_KERNEL, KIMAGE_NO_DEST);
+		if (!page) {
+			return -ENOMEM;
+		}
+		ind_page = page_address(page);
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
+static int kimage_set_destination(
+	struct kimage *image, unsigned long destination) 
+{
+	int result;
+	destination &= PAGE_MASK;
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
+	result = kimage_add_entry(image, page | IND_SOURCE);
+	if (result == 0) {
+		image->destination += PAGE_SIZE;
+	}
+	return result;
+}
+
+
+static void kimage_free_extra_pages(struct kimage *image)
+{
+	/* Walk through and free any extra destination pages I may have */
+	struct list_head *pos, *next;
+	list_for_each_safe(pos, next, &image->dest_pages) {
+		struct page *page;
+		page = list_entry(pos, struct page, list);
+		list_del(&page->list);
+		__free_page(page);
+	}
+	/* Walk through and free any unuseable pages I have cached */
+	list_for_each_safe(pos, next, &image->unuseable_pages) {
+		struct page *page;
+		page = list_entry(pos, struct page, list);
+		list_del(&page->list);
+		__free_page(page);
+	}
+
+}
+static int kimage_terminate(struct kimage *image)
+{
+	int result;
+	result = kimage_add_entry(image, IND_DONE);
+	if (result == 0) {
+		/* Point at the terminating element */
+		image->entry--;
+		kimage_free_extra_pages(image);
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
+	kimage_free_extra_pages(image);
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
+	__free_pages(image->reboot_code_pages, get_order(KEXEC_REBOOT_CODE_SIZE));
+	kfree(image);
+}
+
+static kimage_entry_t *kimage_dst_used(struct kimage *image, unsigned long page)
+{
+	kimage_entry_t *ptr, entry;
+	unsigned long destination = 0;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_DESTINATION) {
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
+static struct page *kimage_alloc_page(struct kimage *image, unsigned int gfp_mask, unsigned long destination)
+{
+	/* Here we implment safe guards to ensure that a source page
+	 * is not copied to it's destination page before the data on
+	 * the destination page is no longer useful.
+	 *
+	 * To do this we maintain the invariant that a source page is
+	 * either it's own destination page, or it is not a
+	 * destination page at all.  
+	 *
+	 * That is slightly stronger than required, but the proof
+	 * that no problems will not occur is trivial, and the
+	 * implemenation is simply to verify.
+	 *
+	 * When allocating all pages normally this algorithm will run
+	 * in O(N) time, but in the worst case it will run in O(N^2)
+	 * time.   If the runtime is a problem the data structures can
+	 * be fixed.
+	 */
+	struct page *page;
+	unsigned long addr;
+
+	/* Walk through the list of destination pages, and see if I
+	 * have a match.
+	 */
+	list_for_each_entry(page, &image->dest_pages, list) {
+		addr = page_to_pfn(page) << PAGE_SHIFT;
+		if (addr == destination) {
+			list_del(&page->list);
+			return page;
+		}
+	}
+	page = 0;
+	while(1) {
+		kimage_entry_t *old;
+		/* Allocate a page, if we run out of memory give up */
+		page = alloc_page(gfp_mask);
+		if (!page) {
+			return 0;
+		}
+
+		/* If the page cannot be used file it away */
+		if (page_to_pfn(page) > (KEXEC_SOURCE_MEMORY_LIMIT >> PAGE_SHIFT)) {
+			list_add(&page->list, &image->unuseable_pages);
+			continue;
+		}
+		addr = page_to_pfn(page) << PAGE_SHIFT;
+
+		/* If it is the destination page we want use it */
+		if (addr == destination)
+			break;
+
+		/* If the page is not a destination page use it */
+		if (!kimage_is_destination_range(image, addr, addr + PAGE_SIZE))
+			break;
+
+		/* I know that the page is someones destination page.
+		 * See if there is already a source page for this
+		 * destination page.  And if so swap the source pages.
+		 */
+		old = kimage_dst_used(image, addr);
+		if (old) {
+			/* If so move it */
+			unsigned long old_addr;
+			struct page *old_page;
+			
+			old_addr = *old & PAGE_MASK;
+			old_page = pfn_to_page(old_addr >> PAGE_SHIFT);
+			copy_highpage(page, old_page);
+			*old = addr | (*old & ~PAGE_MASK);
+
+			/* The old page I have found cannot be a
+			 * destination page, so return it.
+			 */
+			addr = old_addr;
+			page = old_page;
+			break;
+		}
+		else {
+			/* Place the page on the destination list I
+			 * will use it later.
+			 */
+			list_add(&page->list, &image->dest_pages);
+		}
+	}
+	return page;
+}
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
+		struct page *page;
+		char *ptr;
+		size_t size, leader;
+		page = kimage_alloc_page(image, GFP_HIGHUSER, mstart + offset);
+		if (page == 0) {
+			result  = -ENOMEM;
+			goto out;
+		}
+		result = kimage_add_page(image, page_to_pfn(page) << PAGE_SHIFT);
+		if (result < 0) {
+			goto out;
+		}
+		ptr = kmap(page);
+		if (segment->bufsz < offset) {
+			/* We are past the end zero the whole page */
+			memset(ptr, 0, PAGE_SIZE);
+			kunmap(page);
+			continue;
+		}
+		size = PAGE_SIZE;
+		leader = 0;
+		if ((offset == 0)) {
+			leader = mstart & ~PAGE_MASK;
+		}
+		if (leader) {
+			/* We are on the first page zero the unused portion */
+			memset(ptr, 0, leader);
+			size -= leader;
+			ptr += leader;
+		}
+		if (size > (segment->bufsz - offset)) {
+			size = segment->bufsz - offset;
+		}
+		if (size < (PAGE_SIZE - leader)) {
+			/* zero the trailing part of the page */
+			memset(ptr + size, 0, (PAGE_SIZE - leader) - size);
+		}
+		result = copy_from_user(ptr, buf + offset, size);
+		kunmap(page);
+		if (result) {
+			result = (result < 0)?result : -EIO;
+			goto out;
+		}
+	}
+ out:
+	return result;
+}
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
+	struct kimage *image;
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
+	if (nr_segments > KEXEC_SEGMENT_MAX)
+		return -EINVAL;
+	image = 0;
+
+	result = 0;
+	if (nr_segments > 0) {
+		unsigned long i;
+		result = kimage_alloc(&image, nr_segments, segments);
+		if (result) {
+			goto out;
+		}
+		image->start = entry;
+		for(i = 0; i < nr_segments; i++) {
+			result = kimage_load_segment(image, &segments[i]);
+			if (result) {
+				goto out;
+			}
+		}
+		result = kimage_terminate(image);
+		if (result) {
+			goto out;
+		}
+	}
+
+	image = xchg(&kexec_image, image);
+
+ out:
+	kimage_free(image);
+	return result;
+}
diff -uNr linux-2.5.52/kernel/sys.c linux-2.5.52.x86kexec-2/kernel/sys.c
--- linux-2.5.52/kernel/sys.c	Thu Dec 12 07:41:37 2002
+++ linux-2.5.52.x86kexec-2/kernel/sys.c	Mon Dec 16 02:23:00 2002
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/fs.h>
+#include <linux/kexec.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/times.h>
@@ -207,6 +208,7 @@
 cond_syscall(sys_lookup_dcookie)
 cond_syscall(sys_swapon)
 cond_syscall(sys_swapoff)
+cond_syscall(sys_kexec_load)
 cond_syscall(sys_init_module)
 cond_syscall(sys_delete_module)
 
@@ -419,6 +421,27 @@
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
