Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVD2GE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVD2GE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 02:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVD2GE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 02:04:56 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:42747 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262429AbVD2GCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 02:02:35 -0400
Date: Fri, 29 Apr 2005 08:02:32 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Milton Miller <miltonm@bga.com>
Subject: [PATCH] s390: kexec fixes for -mm
Message-ID: <20050429060232.GA1894@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

could you please add the patch below to your mm tree? It fixes some issues
with the current kexec implementation on s390. This one needs to be applied
after kexec-s390-support.patch.

Thanks,
Heiko

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This patch is mostly based on comments which I received from
Milton Miller <miltonm@bga.com>. Changes are:

- Fix passing of first argument to relocate_kernel assembly.
- Fix Kconfig description.
- Remove wrong comment and comments that describe obvious things.
- Allow only KEXEC_TYPE_DEFAULT as image type -> dump not supported.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 arch/s390/Kconfig                    |   14 --------
 arch/s390/kernel/machine_kexec.c     |   61 ++++++++---------------------------
 arch/s390/kernel/relocate_kernel.S   |   14 +++-----
 arch/s390/kernel/relocate_kernel64.S |   14 +++-----
 4 files changed, 27 insertions(+), 76 deletions(-)

diff -urN a/arch/s390/Kconfig b/arch/s390/Kconfig
--- a/arch/s390/Kconfig	2005-04-27 13:18:09.000000000 +0200
+++ b/arch/s390/Kconfig	2005-04-27 13:19:11.000000000 +0200
@@ -461,19 +461,7 @@
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.   And like a reboot
-	  you can start any kernel with it, not just Linux.
-	  
-	  The name comes from the similiarity to the exec system call.
-	  
-	  It is an ongoing process to be certain the hardware in a machine
-	  is properly shutdown, so do not be surprised if this code does not
-	  initially work for you.  It may help to enable device hotplugging
-	  support.  As of this writing the exact hardware interface is
-	  strongly in flux, so no good recommendation can be made.
-	  
-	  In the GAMECUBE implementation, kexec allows you to load and
-	  run DOL files, including kernel and homebrew DOLs.
+	  but is independent of hardware/microcode support.
 
 endmenu
 
diff -urN a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
--- a/arch/s390/kernel/machine_kexec.c	2005-04-27 13:18:09.000000000 +0200
+++ b/arch/s390/kernel/machine_kexec.c	2005-04-27 13:19:11.000000000 +0200
@@ -22,29 +22,22 @@
 #include <asm/pgalloc.h>
 #include <asm/system.h>
 
-int machine_kexec_prepare(struct kimage *);
-void machine_kexec_cleanup(struct kimage *);
-void machine_shutdown(void);
-void machine_kexec(struct kimage *);
 static void kexec_halt_all_cpus(void *);
 
-typedef void (*relocate_kernel_t) (unsigned long indirection_page,
-				   unsigned long reboot_code_buffer,
-				   unsigned long start_address);
+typedef void (*relocate_kernel_t) (kimage_entry_t *, unsigned long);
 
 const extern unsigned char relocate_kernel[];
 const extern unsigned long long relocate_kernel_len;
 
-/*
- * Do whatever setup is needed on image and the reboot code buffer to
- * allow us to aviood allocations later.
- */
-
 int
-machine_kexec_prepare(struct kimage * image)
+machine_kexec_prepare(struct kimage *image)
 {
 	unsigned long reboot_code_buffer;
 
+	/* We don't support anything but the default image type for now. */
+	if (image->type != KEXEC_TYPE_DEFAULT)
+		return -EINVAL;
+
 	/* Get the destination where the assembler code should be copied to.*/
 	reboot_code_buffer = page_to_pfn(image->control_code_page)<<PAGE_SHIFT;
 
@@ -54,45 +47,20 @@
 	return 0;
 }
 
-
-/*
- * We don't have to do anything here, because we didn't have to prepare
- * (i.e. allocate or the like) anything in 'machine_kexec_prepare'.
- */
 void
 machine_kexec_cleanup(struct kimage *image)
 {
 }
 
-/*
- * Just print a message in the kernel log.
- */
 void
 machine_shutdown(void)
 {
 	printk(KERN_INFO "kexec: machine_shutdown called\n");
 }
 
-/*
- * The addresses for the reboot_code_buffer, the indirection page and the
- * data_mover can already be assigned here.
- * Also, we can here clear all subchannels.
- * In any case we have to disable the lowcore protection, because we will
- * write a new PSW to address 0.
- * Then we call the function 'kexec_halt_all_cpus'.
- */
-
-static unsigned long indirection_page;
-static unsigned long reboot_code_buffer;
-static relocate_kernel_t data_mover;
-
 NORET_TYPE void
 machine_kexec(struct kimage *image)
 {
-	reboot_code_buffer = page_to_pfn(image->control_code_page)<<PAGE_SHIFT;
-	indirection_page = image->head & PAGE_MASK;
-	data_mover = (relocate_kernel_t) reboot_code_buffer;
-	
 	clear_all_subchannels();
 
 	/* Disable lowcore protection */
@@ -102,20 +70,15 @@
 	for(;;);
 }
 
-/*
- * Make sure that all except one CPU are stopped. The first CPU
- * that enters this function is going to halt all the others and then, if it is
- * the only one left, the 'data_mover' function will be called.
- */
 static void
 kexec_halt_all_cpus(void *kernel_image)
 {
 	static atomic_t cpuid = ATOMIC_INIT(-1);
 	int cpu;
+	struct kimage *image;
+	relocate_kernel_t data_mover;
 
-	struct kimage *image = (struct kimage *) kernel_image;
-
-	if(atomic_compare_and_swap(-1, smp_processor_id(), &cpuid))
+	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid))
 		signal_processor(smp_processor_id(), sigp_stop);
 
 	/* Wait for all other cpus to enter stopped state */
@@ -126,6 +89,10 @@
 			cpu_relax();
 	}
 
+	image = (struct kimage *) kernel_image;
+	data_mover = (relocate_kernel_t)
+		(page_to_pfn(image->control_code_page) << PAGE_SHIFT);
+
 	/* Call the moving routine */
-	(*data_mover) (indirection_page, reboot_code_buffer, image->start);
+	(*data_mover) (&image->head, image->start);
 }
diff -urN a/arch/s390/kernel/relocate_kernel64.S b/arch/s390/kernel/relocate_kernel64.S
--- a/arch/s390/kernel/relocate_kernel64.S	2005-04-27 13:18:09.000000000 +0200
+++ b/arch/s390/kernel/relocate_kernel64.S	2005-04-27 13:20:02.000000000 +0200
@@ -9,9 +9,8 @@
 
 /*
  * moves the new kernel to its destination...
- * %r2 = indirection page
- * %r3 = reboot_code_buffer
- * %r4 = start address - where to jump to after the job is done...
+ * %r2 = pointer to first kimage_entry_t
+ * %r3 = start address - where to jump to after the job is done...
  *
  * %r5 will be used as temp. storage
  * %r6 holds the destination address
@@ -59,11 +58,10 @@
 		j       .top
 	.done:
 		sgr     %r0,%r0		#clear register r0
-		la      %r3,load_psw-.base(%r13)	#load psw-address into the register
-		mvc     0(4,%r0),0(%r3)	#copy the first part of it
-		l	%r1,4(0,%r3)	#copy the second part of load_psw in %r1
-		or	%r1,%r4		#OR it with the given psw --> %r1 = (%r1 | %r4)
-		st	%r1,4(0,%r0)	#store it at addr 0+4B, i.e. second part of psw
+		la      %r4,load_psw-.base(%r13)	#load psw-address into the register
+		o	%r3,4(%r4)	#or load address into psw
+		st	%r3,4(%r4)
+		mvc     0(8,%r0),0(%r4)	#copy psw to absolute address 0
 		sam31			#31 bit mode
 		sr      %r1,%r1		#erase register r1
 		sr      %r2,%r2		#erase register r2
diff -urN a/arch/s390/kernel/relocate_kernel.S b/arch/s390/kernel/relocate_kernel.S
--- a/arch/s390/kernel/relocate_kernel.S	2005-04-27 13:18:09.000000000 +0200
+++ b/arch/s390/kernel/relocate_kernel.S	2005-04-27 13:19:37.000000000 +0200
@@ -9,9 +9,8 @@
 
 /*
  * moves the new kernel to its destination...
- * %r2 = indirection page
- * %r3 = reboot_code_buffer
- * %r4 = start address - where to jump to after the job is done...
+ * %r2 = pointer to first kimage_entry_t
+ * %r3 = start address - where to jump to after the job is done...
  *
  * %r5 will be used as temp. storage
  * %r6 holds the destination address
@@ -60,11 +59,10 @@
 		j	.top
 	.done:
 		sr	%r0,%r0		#clear register r0
-		la	%r3,load_psw-.base(%r13)	#load psw-address into the register
-		mvc	0(4,%r0),0(%r3)	#copy the first part of psw
-		l	%r1,4(0,%r3)	#get the second part of psw in %r1
-		or	%r1,%r4		#OR the load address with the 2nd part of psw
-		st	%r1,4(0,%r0)	#store it at add 0+4B
+		la	%r4,load_psw-.base(%r13)	#load psw-address into the register
+		o	%r3,4(%r4)	#or load address into psw
+		st	%r3,4(%r4)
+		mvc	0(8,%r0),0(%r4)	#copy psw to absolute address 0
 		sr	%r1,%r1		#clear %r1
 		sr	%r2,%r2		#clear %r2
 		sigp	%r1,%r2,0x12	#set cpuid to zero
