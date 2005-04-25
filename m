Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVDYLaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVDYLaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 07:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVDYLaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 07:30:46 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:64511 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262586AbVDYL3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 07:29:49 -0400
Date: Mon, 25 Apr 2005 13:29:47 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org, Eric Biederman <ebiederm@xmission.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Rolf Adelsberger <adelsberger@gmail.com>
Subject: [PATCH] s390: add kexec support to 2.6.12-rc2-mm3
Message-ID: <20050425112947.GB676@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

the patch below adds kexec support for s390. The patch applies against
2.6.12-rc2-mm3. Could you apply this patch to your -mm tree please?

Thanks,
Heiko

From: Rolf Adelsberger <adelsberger@de.ibm.com>
From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add kexec support for s390 architecture.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 arch/s390/Kconfig                    |   20 +++++
 arch/s390/kernel/Makefile            |   10 ++
 arch/s390/kernel/compat_wrapper.S    |    8 ++
 arch/s390/kernel/crash.c             |   17 ++++
 arch/s390/kernel/machine_kexec.c     |  131 +++++++++++++++++++++++++++++++++++
 arch/s390/kernel/relocate_kernel.S   |   83 ++++++++++++++++++++++
 arch/s390/kernel/relocate_kernel64.S |   84 ++++++++++++++++++++++
 arch/s390/kernel/syscalls.S          |    2 
 include/asm-s390/kexec.h             |   42 +++++++++++
 include/asm-s390/unistd.h            |    2 
 include/linux/kexec.h                |    1 
 11 files changed, 398 insertions(+), 2 deletions(-)

diff -urN a/arch/s390/Kconfig b/arch/s390/Kconfig
--- a/arch/s390/Kconfig	2005-04-14 09:50:38.000000000 +0200
+++ b/arch/s390/Kconfig	2005-04-22 13:19:00.000000000 +0200
@@ -455,6 +455,26 @@
 	  The HZ timer is switched off in idle by default. That means the
 	  HZ timer is already disabled at boot time.
 
+config KEXEC
+	bool "kexec system call (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is indepedent of the system firmware.   And like a reboot
+	  you can start any kernel with it, not just Linux.
+	  
+	  The name comes from the similiarity to the exec system call.
+	  
+	  It is an ongoing process to be certain the hardware in a machine
+	  is properly shutdown, so do not be surprised if this code does not
+	  initially work for you.  It may help to enable device hotplugging
+	  support.  As of this writing the exact hardware interface is
+	  strongly in flux, so no good recommendation can be made.
+	  
+	  In the GAMECUBE implementation, kexec allows you to load and
+	  run DOL files, including kernel and homebrew DOLs.
+
 endmenu
 
 config PCMCIA
diff -urN a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
--- a/arch/s390/kernel/compat_wrapper.S	2005-04-14 09:50:24.000000000 +0200
+++ b/arch/s390/kernel/compat_wrapper.S	2005-04-22 14:13:56.000000000 +0200
@@ -1441,3 +1441,11 @@
 	lgfr	%r5,%r5			# int
 	llgtr	%r6,%r6			# struct rusage_emu31 *
 	jg	compat_sys_waitid
+
+	.globl	compat_sys_kexec_load_wrapper
+compat_sys_kexec_load_wrapper:
+	llgfr	%r2,%r2			# unsigned long
+	llgfr	%r3,%r3			# unsigned long
+	llgtr	%r4,%r4			# struct kexec_segment *
+	llgfr	%r5,%r5			# unsigned long
+	jg	compat_sys_kexec_load
diff -urN a/arch/s390/kernel/crash.c b/arch/s390/kernel/crash.c
--- a/arch/s390/kernel/crash.c	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/s390/kernel/crash.c	2005-04-22 13:45:08.000000000 +0200
@@ -0,0 +1,17 @@
+/*
+ * arch/s390/kernel/crash.c
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ *
+ */
+
+#include <linux/threads.h>
+#include <linux/kexec.h>
+
+note_buf_t crash_notes[NR_CPUS];
+
+void machine_crash_shutdown(void)
+{
+}
diff -urN a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
--- a/arch/s390/kernel/machine_kexec.c	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/s390/kernel/machine_kexec.c	2005-04-22 13:44:28.000000000 +0200
@@ -0,0 +1,131 @@
+/*
+ * arch/s390/kernel/machine_kexec.c
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * Author(s): Rolf Adelsberger <adelsberger@de.ibm.com>
+ *
+ */
+
+/*
+ * s390_machine_kexec.c - handle the transition of Linux booting another kernel
+ * on the S390 architecture.
+ */
+
+#include <asm/cio.h>
+#include <asm/setup.h>
+#include <linux/device.h>
+#include <linux/mm.h>
+#include <linux/kexec.h>
+#include <linux/delay.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/system.h>
+
+int machine_kexec_prepare(struct kimage *);
+void machine_kexec_cleanup(struct kimage *);
+void machine_shutdown(void);
+void machine_kexec(struct kimage *);
+static void kexec_halt_all_cpus(void *);
+
+typedef void (*relocate_kernel_t) (unsigned long indirection_page,
+				   unsigned long reboot_code_buffer,
+				   unsigned long start_address);
+
+const extern unsigned char relocate_kernel[];
+const extern unsigned long long relocate_kernel_len;
+
+/*
+ * Do whatever setup is needed on image and the reboot code buffer to
+ * allow us to aviood allocations later.
+ */
+
+int
+machine_kexec_prepare(struct kimage * image)
+{
+	unsigned long reboot_code_buffer;
+
+	/* Get the destination where the assembler code should be copied to.*/
+	reboot_code_buffer = page_to_pfn(image->control_code_page)<<PAGE_SHIFT;
+
+	/* Then copy it */
+	memcpy((void *) reboot_code_buffer, relocate_kernel,
+	       relocate_kernel_len);
+	return 0;
+}
+
+
+/*
+ * We don't have to do anything here, because we didn't have to prepare
+ * (i.e. allocate or the like) anything in 'machine_kexec_prepare'.
+ */
+void
+machine_kexec_cleanup(struct kimage *image)
+{
+}
+
+/*
+ * Just print a message in the kernel log.
+ */
+void
+machine_shutdown(void)
+{
+	printk(KERN_INFO "kexec: machine_shutdown called\n");
+}
+
+/*
+ * The addresses for the reboot_code_buffer, the indirection page and the
+ * data_mover can already be assigned here.
+ * Also, we can here clear all subchannels.
+ * In any case we have to disable the lowcore protection, because we will
+ * write a new PSW to address 0.
+ * Then we call the function 'kexec_halt_all_cpus'.
+ */
+
+static unsigned long indirection_page;
+static unsigned long reboot_code_buffer;
+static relocate_kernel_t data_mover;
+
+NORET_TYPE void
+machine_kexec(struct kimage *image)
+{
+	reboot_code_buffer = page_to_pfn(image->control_code_page)<<PAGE_SHIFT;
+	indirection_page = image->head & PAGE_MASK;
+	data_mover = (relocate_kernel_t) reboot_code_buffer;
+	
+	clear_all_subchannels();
+
+	/* Disable lowcore protection */
+	ctl_clear_bit(0,28);
+
+	on_each_cpu(kexec_halt_all_cpus, image, 0, 0);
+	for(;;);
+}
+
+/*
+ * Make sure that all except one CPU are stopped. The first CPU
+ * that enters this function is going to halt all the others and then, if it is
+ * the only one left, the 'data_mover' function will be called.
+ */
+static void
+kexec_halt_all_cpus(void *kernel_image)
+{
+	static atomic_t cpuid = ATOMIC_INIT(-1);
+	int cpu;
+
+	struct kimage *image = (struct kimage *) kernel_image;
+
+	if(atomic_compare_and_swap(-1, smp_processor_id(), &cpuid))
+		signal_processor(smp_processor_id(), sigp_stop);
+
+	/* Wait for all other cpus to enter stopped state */
+	for_each_online_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+		while(!smp_cpu_not_running(cpu))
+			cpu_relax();
+	}
+
+	/* Call the moving routine */
+	(*data_mover) (indirection_page, reboot_code_buffer, image->start);
+}
diff -urN a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
--- a/arch/s390/kernel/Makefile	2005-03-02 08:38:32.000000000 +0100
+++ b/arch/s390/kernel/Makefile	2005-04-22 13:19:00.000000000 +0200
@@ -25,6 +25,16 @@
 
 obj-$(CONFIG_VIRT_TIMER)	+= vtime.o
 
+# Kexec part
+S390_KEXEC_OBJS := machine_kexec.o crash.o
+ifeq ($(CONFIG_ARCH_S390X),y)
+S390_KEXEC_OBJS += relocate_kernel64.o
+else
+S390_KEXEC_OBJS += relocate_kernel.o
+endif
+obj-$(CONFIG_KEXEC) += $(S390_KEXEC_OBJS)
+
+
 #
 # This is just to get the dependencies...
 #
diff -urN a/arch/s390/kernel/relocate_kernel64.S b/arch/s390/kernel/relocate_kernel64.S
--- a/arch/s390/kernel/relocate_kernel64.S	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/s390/kernel/relocate_kernel64.S	2005-04-22 13:43:07.000000000 +0200
@@ -0,0 +1,84 @@
+/*
+ * arch/s390/kernel/relocate_kernel64.S
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * Author(s): Rolf Adelsberger <adelsberger@de.ibm.com>
+ *
+ */
+
+/*
+ * moves the new kernel to its destination...
+ * %r2 = indirection page
+ * %r3 = reboot_code_buffer
+ * %r4 = start address - where to jump to after the job is done...
+ *
+ * %r5 will be used as temp. storage
+ * %r6 holds the destination address
+ * %r7 = PAGE_SIZE
+ * %r8 holds the source address
+ * %r9 = PAGE_SIZE
+ * 
+ * 0xf000 is a page_mask
+ */
+
+	.text
+	.globl		relocate_kernel
+	relocate_kernel:
+		basr	%r13,0		#base address
+	.base:
+		spx	zero64-.base(%r13)	#absolute addressing mode
+		stnsm	sys_msk-.base(%r13),0xf8	#disable DAT and IRQ (external)
+	.top:	
+		lghi	%r7,4096	#load PAGE_SIZE in r7
+		lghi	%r9,4096	#load PAGE_SIZE in r9
+		lg	%r5,0(%r2)	#read another word for indirection page
+		aghi	%r2,8		#increment pointer
+		tml	%r5,0x1		#is it a destination page?
+		je	.indir_check	#NO, goto "indir_check"
+		lgr	%r6,%r5		#r6 = r5
+		nill	%r6,0xf000	#mask it out and...
+		j	.top		#...next iteration
+	.indir_check:
+		tml     %r5,0x2		#is it a indirection page?
+		je      .done_test	#NO, goto "done_test"
+		nill    %r5,0xf000	#YES, mask out,
+		lgr     %r2,%r5		#move it into the right register,
+		j       .top		#and read next...
+	.done_test:
+		tml     %r5,0x4		#is it the done indicator?
+		je      .source_test	#NO! Well, then it should be the source indicator...
+		j       .done		#ok, lets finish it here...
+	.source_test:
+		tml     %r5,0x8		#it should be a source indicator...
+		je      .top		#NO, ignore it...
+		lgr     %r8,%r5		#r8 = r5
+		nill    %r8,0xf000	#masking
+	0:	mvcle   %r6,%r8,0x0	#copy PAGE_SIZE bytes from r8 to r6 - pad with 0
+		jo	0b
+		j       .top
+	.done:
+		sgr     %r0,%r0		#clear register r0
+		la      %r3,load_psw-.base(%r13)	#load psw-address into the register
+		mvc     0(4,%r0),0(%r3)	#copy the first part of it
+		l	%r1,4(0,%r3)	#copy the second part of load_psw in %r1
+		or	%r1,%r4		#OR it with the given psw --> %r1 = (%r1 | %r4)
+		st	%r1,4(0,%r0)	#store it at addr 0+4B, i.e. second part of psw
+		sam31			#31 bit mode
+		sr      %r1,%r1		#erase register r1
+		sr      %r2,%r2		#erase register r2
+		sigp    %r1,%r2,0x12	#set cpuid to zero
+		lpsw    0		#hopefully start new kernel...
+
+	        .align	8
+	zero64:	
+		.quad	0
+	load_psw:
+		.long	0x00080000,0x80000000
+	sys_msk:
+		.quad	0
+	relocate_kernel_end:
+	.globl	relocate_kernel_len
+	relocate_kernel_len:
+		.quad	relocate_kernel_end - relocate_kernel
+	
diff -urN a/arch/s390/kernel/relocate_kernel.S b/arch/s390/kernel/relocate_kernel.S
--- a/arch/s390/kernel/relocate_kernel.S	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/s390/kernel/relocate_kernel.S	2005-04-22 13:40:52.000000000 +0200
@@ -0,0 +1,83 @@
+/*
+ * arch/s390/kernel/relocate_kernel.S
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * Author(s): Rolf Adelsberger <adelsberger@de.ibm.com>
+ *
+ */
+
+/*
+ * moves the new kernel to its destination...
+ * %r2 = indirection page
+ * %r3 = reboot_code_buffer
+ * %r4 = start address - where to jump to after the job is done...
+ *
+ * %r5 will be used as temp. storage
+ * %r6 holds the destination address
+ * %r7 = PAGE_SIZE
+ * %r8 holds the source address
+ * %r9 = PAGE_SIZE
+ * %r10 is a page mask
+ */
+
+	.text
+	.globl		relocate_kernel
+	relocate_kernel:
+		basr	%r13,0		#base address
+	.base:
+		spx	zero64-.base(%r13)	#absolute addressing mode
+		stnsm	sys_msk-.base(%r13),0xf8	#disable DAT and IRQ (external)
+		lhi	%r10,-1		#preparing the mask
+		sll	%r10,12		#shift it such that it becomes 0xf000
+	.top:	
+		lhi	%r7,4096	#load PAGE_SIZE in r7
+		lhi	%r9,4096	#load PAGE_SIZE in r9
+		l	%r5,0(%r2)	#read another word for indirection page
+		ahi	%r2,4		#increment pointer
+		tml	%r5,0x1		#is it a destination page?
+		je	.indir_check	#NO, goto "indir_check"
+		lr	%r6,%r5		#r6 = r5
+		nr	%r6,%r10	#mask it out and...
+		j	.top		#...next iteration
+	.indir_check:
+		tml	%r5,0x2		#is it a indirection page?
+		je	.done_test	#NO, goto "done_test"
+		nr	%r5,%r10	#YES, mask out,
+		lr	%r2,%r5		#move it into the right register,
+		j	.top		#and read next...
+	.done_test:
+		tml	%r5,0x4		#is it the done indicator?
+		je	.source_test	#NO! Well, then it should be the source indicator...
+		j	.done		#ok, lets finish it here...
+	.source_test:
+		tml	%r5,0x8		#it should be a source indicator...
+		je	.top		#NO, ignore it...
+		lr	%r8,%r5		#r8 = r5
+		nr	%r8,%r10	#masking
+	0:	mvcle	%r6,%r8,0x0	#copy PAGE_SIZE bytes from r8 to r6 - pad with 0
+		jo	0b
+		j	.top
+	.done:
+		sr	%r0,%r0		#clear register r0
+		la	%r3,load_psw-.base(%r13)	#load psw-address into the register
+		mvc	0(4,%r0),0(%r3)	#copy the first part of psw
+		l	%r1,4(0,%r3)	#get the second part of psw in %r1
+		or	%r1,%r4		#OR the load address with the 2nd part of psw
+		st	%r1,4(0,%r0)	#store it at add 0+4B
+		sr	%r1,%r1		#clear %r1
+		sr	%r2,%r2		#clear %r2
+		sigp	%r1,%r2,0x12	#set cpuid to zero
+		lpsw	0		#hopefully start new kernel...
+
+		.align	8
+	zero64:	
+		.quad	0
+	load_psw:
+		.long	0x00080000,0x80000000
+	sys_msk:
+		.quad	0
+	relocate_kernel_end:
+	.globl	relocate_kernel_len
+	relocate_kernel_len:
+		.quad	relocate_kernel_end - relocate_kernel
diff -urN a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
--- a/arch/s390/kernel/syscalls.S	2005-04-14 09:50:24.000000000 +0200
+++ b/arch/s390/kernel/syscalls.S	2005-04-22 14:12:04.000000000 +0200
@@ -285,7 +285,7 @@
 SYSCALL(sys_mq_timedreceive,sys_mq_timedreceive,compat_sys_mq_timedreceive_wrapper)
 SYSCALL(sys_mq_notify,sys_mq_notify,compat_sys_mq_notify_wrapper) /* 275 */
 SYSCALL(sys_mq_getsetattr,sys_mq_getsetattr,compat_sys_mq_getsetattr_wrapper)
-NI_SYSCALL							/* reserved for kexec */
+SYSCALL(sys_kexec_load,sys_kexec_load,compat_sys_kexec_load_wrapper)
 SYSCALL(sys_add_key,sys_add_key,compat_sys_add_key_wrapper)
 SYSCALL(sys_request_key,sys_request_key,compat_sys_request_key_wrapper)
 SYSCALL(sys_keyctl,sys_keyctl,compat_sys_keyctl)		/* 280 */
diff -urN a/include/asm-s390/kexec.h b/include/asm-s390/kexec.h
--- a/include/asm-s390/kexec.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/asm-s390/kexec.h	2005-04-22 13:47:29.000000000 +0200
@@ -0,0 +1,42 @@
+/*
+ * include/asm-s390/kexec.h
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * Author(s): Rolf Adelsberger <adelsberger@de.ibm.com>
+ *
+ */
+
+#ifndef _S390_KEXEC_H
+#define _S390_KEXEC_H
+
+#include <asm/page.h>
+#include <asm/processor.h>
+/*
+ * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
+ * I.e. Maximum page that is mapped directly into kernel memory,
+ * and kmap is not required.
+ */
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can use for the control pages */
+/* Not more than 2GB */
+#define KEXEC_CONTROL_MEMORY_LIMIT (1<<31)
+
+/* Allocate one page for the pdp and the second for the code */
+#define KEXEC_CONTROL_CODE_SIZE 4096
+
+/* The native architecture */
+#define KEXEC_ARCH KEXEC_ARCH_S390
+
+#define MAX_NOTE_BYTES 1024
+typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
+
+extern note_buf_t crash_notes[];
+
+#endif /*_S390_KEXEC_H */
diff -urN a/include/asm-s390/unistd.h b/include/asm-s390/unistd.h
--- a/include/asm-s390/unistd.h	2005-04-14 09:50:32.000000000 +0200
+++ b/include/asm-s390/unistd.h	2005-04-22 13:19:00.000000000 +0200
@@ -269,7 +269,7 @@
 #define __NR_mq_timedreceive	274
 #define __NR_mq_notify		275
 #define __NR_mq_getsetattr	276
-/* Number 277 is reserved for new sys_kexec_load */
+#define __NR_kexec_load		277
 #define __NR_add_key		278
 #define __NR_request_key	279
 #define __NR_keyctl		280
diff -urN a/include/linux/kexec.h b/include/linux/kexec.h
--- a/include/linux/kexec.h	2005-04-14 09:50:42.000000000 +0200
+++ b/include/linux/kexec.h	2005-04-22 13:19:00.000000000 +0200
@@ -115,6 +115,7 @@
 #define KEXEC_ARCH_PPC     (20 << 16)
 #define KEXEC_ARCH_PPC64   (21 << 16)
 #define KEXEC_ARCH_IA_64   (50 << 16)
+#define KEXEC_ARCH_S390    (22 << 16)
 
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH)  /* List of defined/legal kexec flags */
 
