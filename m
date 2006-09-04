Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWIDJYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWIDJYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWIDJYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:24:23 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:53848 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751253AbWIDJYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:24:21 -0400
Date: Mon, 4 Sep 2006 11:24:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] convert some assembler to C.
Message-ID: <20060904092420.GA9215@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] convert some assembler to C.

Convert GET_IPL_DEVICE assembler macro to C function.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head.S    |   59 ---------------------------------------------
 arch/s390/kernel/head31.S  |   43 ++++++++++++++++++++++----------
 arch/s390/kernel/head64.S  |   39 +++++++++++++++++++----------
 arch/s390/kernel/ipl.c     |    4 +--
 drivers/s390/cio/cio.c     |   38 +++++++++++++++++++++++++++-
 include/asm-s390/lowcore.h |    1 
 include/asm-s390/setup.h   |    8 +++---
 7 files changed, 99 insertions(+), 93 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
--- linux-2.6/arch/s390/kernel/head31.S	2006-09-04 11:08:46.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head31.S	2006-09-04 11:08:58.000000000 +0200
@@ -37,13 +37,23 @@ startup:basr	%r13,0			# get base
 
 startup_continue:
 	basr	%r13,0			# get base
-.LPG1:	GET_IPL_DEVICE
-	mvi	__LC_AR_MODE_ID,0	# set ESA flag (mode 0)
+.LPG1:	mvi	__LC_AR_MODE_ID,0	# set ESA flag (mode 0)
 	lctl	%c0,%c15,.Lctl-.LPG1(%r13) # load control registers
 	l	%r12,.Lparmaddr-.LPG1(%r13) # pointer to parameter area
 					# move IPL device to lowcore
 	mvc	__LC_IPLDEV(4),IPL_DEVICE-PARMAREA(%r12)
+#
+# Setup stack
+#
+	l	%r15,.Linittu-.LPG1(%r13)
+	mvc	__LC_CURRENT(4),__TI_task(%r15)
+	ahi	%r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union+THREAD_SIZE
+	st	%r15,__LC_KERNEL_STACK	# set end of kernel stack
+	ahi	%r15,-96
+	xc	__SF_BACKCHAIN(4,%r15),__SF_BACKCHAIN(%r15) # clear backchain
 
+	l	%r14,.Lipl_save_parameters-.LPG1(%r13)
+	basr	%r14,%r14
 #
 # clear bss memory
 #
@@ -115,6 +125,10 @@ startup_continue:
 	b	.Lfchunk-.LPG1(%r13)
 
 	.align 4
+.Lipl_save_parameters:
+	.long	ipl_save_parameters
+.Linittu:
+	.long	init_thread_union
 .Lpmask:
 	.byte	0
 .align 8
@@ -274,6 +288,20 @@ startup_continue:
 .Lbss_end:  .long _end
 .Lparmaddr: .long PARMAREA
 .Lsccbaddr: .long .Lsccb
+
+	.globl ipl_schib
+ipl_schib:
+	.rept 13
+	.long 0
+	.endr
+
+	.globl ipl_flags
+ipl_flags:
+	.long 0
+	.globl ipl_devno
+ipl_devno:
+	.word 0
+
 	.org	0x12000
 .globl s390_readinfo_sccb
 s390_readinfo_sccb:
@@ -305,16 +333,6 @@ s390_readinfo_sccb:
 	.globl	_stext
 _stext:	basr	%r13,0			# get base
 .LPG3:
-#
-# Setup stack
-#
-	l	%r15,.Linittu-.LPG3(%r13)
-	mvc	__LC_CURRENT(4),__TI_task(%r15)
-	ahi	%r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union+THREAD_SIZE
-	st	%r15,__LC_KERNEL_STACK	# set end of kernel stack
-	ahi	%r15,-96
-	xc	__SF_BACKCHAIN(4,%r15),__SF_BACKCHAIN(%r15) # clear backchain
-
 # check control registers
 	stctl	%c0,%c15,0(%r15)
 	oi	2(%r15),0x40		# enable sigp emergency signal
@@ -333,6 +351,5 @@ _stext:	basr	%r13,0			# get base
 #
 	.align	8
 .Ldw:	.long	0x000a0000,0x00000000
-.Linittu:.long	init_thread_union
 .Lstart:.long	start_kernel
 .Laregs:.long	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2006-09-04 11:08:46.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-09-04 11:08:58.000000000 +0200
@@ -39,7 +39,6 @@ startup_continue:
 	basr  %r13,0			 # get base
 .LPG1:  sll   %r13,1                     # remove high order bit
         srl   %r13,1
-	GET_IPL_DEVICE
         lhi   %r1,1                      # mode 1 = esame
 	mvi   __LC_AR_MODE_ID,1		 # set esame flag
         slr   %r0,%r0                    # set cpuid to zero
@@ -49,7 +48,18 @@ startup_continue:
 	lg    %r12,.Lparmaddr-.LPG1(%r13)# pointer to parameter area
 					 # move IPL device to lowcore
         mvc   __LC_IPLDEV(4),IPL_DEVICE+4-PARMAREA(%r12)
+#
+# Setup stack
+#
+	larl  %r15,init_thread_union
+	lg    %r14,__TI_task(%r15)	# cache current in lowcore
+	stg   %r14,__LC_CURRENT
+	aghi  %r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union + THREAD_SIZE
+	stg   %r15,__LC_KERNEL_STACK	# set end of kernel stack
+	aghi  %r15,-160
+	xc    __SF_BACKCHAIN(4,%r15),__SF_BACKCHAIN(%r15) # clear backchain
 
+	brasl %r14,ipl_save_parameters
 #
 # clear bss memory
 #
@@ -269,6 +279,19 @@ startup_continue:
 .Lparmaddr:
 	.quad	PARMAREA
 
+	.globl ipl_schib
+ipl_schib:
+	.rept 13
+	.long 0
+	.endr
+
+	.globl ipl_flags
+ipl_flags:
+	.long 0
+	.globl ipl_devno
+ipl_devno:
+	.word 0
+
 	.org	0x12000
 .globl s390_readinfo_sccb
 s390_readinfo_sccb:
@@ -300,24 +323,12 @@ s390_readinfo_sccb:
         .globl _stext
 _stext:	basr  %r13,0                    # get base
 .LPG3:
-#
-# Setup stack
-#
-	larl  %r15,init_thread_union
-	lg    %r14,__TI_task(%r15)      # cache current in lowcore
-	stg   %r14,__LC_CURRENT
-        aghi  %r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union + THREAD_SIZE
-        stg   %r15,__LC_KERNEL_STACK    # set end of kernel stack
-        aghi  %r15,-160
-        xc    __SF_BACKCHAIN(4,%r15),__SF_BACKCHAIN(%r15) # clear backchain
-
 # check control registers
         stctg  %c0,%c15,0(%r15)
 	oi     6(%r15),0x40             # enable sigp emergency signal
 	oi     4(%r15),0x10             # switch on low address proctection
         lctlg  %c0,%c15,0(%r15)
 
-#
         lam    0,15,.Laregs-.LPG3(%r13) # load access regs needed by uaccess
         brasl  %r14,start_kernel        # go to C code
 #
@@ -325,7 +336,7 @@ _stext:	basr  %r13,0                    
 #
         basr  %r13,0
 	lpswe .Ldw-.(%r13)           # load disabled wait psw
-#
+
             .align 8
 .Ldw:       .quad  0x0002000180000000,0x0000000000000000
 .Laregs:    .long  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2006-09-04 11:08:43.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head.S	2006-09-04 11:08:58.000000000 +0200
@@ -481,65 +481,6 @@ start:
 	.byte 0xf0,0xf1,0xf2,0xf3,0xf4,0xf5,0xf6,0xf7 
 	.byte 0xf8,0xf9,0xfa,0xfb,0xfc,0xfd,0xfe,0xff
 
-.macro GET_IPL_DEVICE
-.Lget_ipl_device:
-	l     %r1,0xb8			# get sid
-	sll   %r1,15			# test if subchannel is enabled
-	srl   %r1,31
-	ltr   %r1,%r1
-	bz    2f-.LPG1(%r13)		# subchannel disabled
-	l     %r1,0xb8
-	la    %r5,.Lipl_schib-.LPG1(%r13)
-	stsch 0(%r5)		        # get schib of subchannel
-	bnz   2f-.LPG1(%r13)		# schib not available
-	tm    5(%r5),0x01		# devno valid?
-	bno   2f-.LPG1(%r13)
-	la    %r6,ipl_parameter_flags-.LPG1(%r13)
-	oi    3(%r6),0x01		# set flag
-	la    %r2,ipl_devno-.LPG1(%r13)
-	mvc   0(2,%r2),6(%r5)		# store devno
-	tm    4(%r5),0x80		# qdio capable device?
-	bno   2f-.LPG1(%r13)
-	oi    3(%r6),0x02		# set flag
-
-	# copy ipl parameters
-
-	lhi   %r0,4096
-	l     %r2,20(%r0)		# get address of parameter list
-	lhi   %r3,IPL_PARMBLOCK_ORIGIN
-	st    %r3,20(%r0)
-	lhi   %r4,1
-	cr    %r2,%r3			# start parameters < destination ?
-	jl    0f
-	lhi   %r1,1			# copy direction is upwards
-	j     1f
-0:	lhi   %r1,-1			# copy direction is downwards
-	ar    %r2,%r0
-	ar    %r3,%r0
-	ar    %r2,%r1
-	ar    %r3,%r1
-1:	mvc   0(1,%r3),0(%r2)		# finally copy ipl parameters
-	ar    %r3,%r1
-	ar    %r2,%r1
-	sr    %r0,%r4
-	jne   1b
-	b     2f-.LPG1(%r13)
-
-	.align 4
-.Lipl_schib:
-	.rept 13
-	.long 0
-	.endr
-
-	.globl ipl_parameter_flags
-ipl_parameter_flags:
-	.long 0
-	.globl ipl_devno
-ipl_devno:
-	.word 0
-2:
-.endm
-
 #ifdef CONFIG_64BIT
 #include "head64.S"
 #else
diff -urpN linux-2.6/arch/s390/kernel/ipl.c linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c	2006-09-04 11:08:47.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/ipl.c	2006-09-04 11:08:58.000000000 +0200
@@ -189,9 +189,9 @@ static enum ipl_type ipl_get_type(void)
 {
 	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
 
-	if (!IPL_DEVNO_VALID)
+	if (!(ipl_flags & IPL_DEVNO_VALID))
 		return IPL_TYPE_UNKNOWN;
-	if (!IPL_PARMBLOCK_VALID)
+	if (!(ipl_flags & IPL_PARMBLOCK_VALID))
 		return IPL_TYPE_CCW;
 	if (ipl->hdr.version > IPL_MAX_SUPPORTED_VERSION)
 		return IPL_TYPE_UNKNOWN;
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-09-04 11:08:47.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-09-04 11:08:58.000000000 +0200
@@ -16,11 +16,10 @@
 #include <linux/device.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
-
 #include <asm/cio.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
-
+#include <asm/setup.h>
 #include "airq.h"
 #include "cio.h"
 #include "css.h"
@@ -909,3 +908,38 @@ void reipl_ccw_dev(struct ccw_dev_id *de
 	cio_reset_channel_paths();
 	do_reipl_asm(*((__u32*)&schid));
 }
+
+extern struct schib ipl_schib;
+
+/*
+ * ipl_save_parameters gets called very early. It is not allowed to access
+ * anything in the bss section at all. The bss section is not cleared yet,
+ * but may contain some ipl parameters written by the firmware.
+ * These parameters (if present) are copied to 0x2000.
+ * To avoid corruption of the ipl parameters, all variables used by this
+ * function must reside on the stack or in the data section.
+ */
+void ipl_save_parameters(void)
+{
+	struct subchannel_id schid;
+	unsigned int *ipl_ptr;
+	void *src, *dst;
+
+	schid = *(struct subchannel_id *)__LC_SUBCHANNEL_ID;
+	if (!schid.one)
+		return;
+	if (stsch(schid, &ipl_schib))
+		return;
+	if (!ipl_schib.pmcw.dnv)
+		return;
+	ipl_devno = ipl_schib.pmcw.dev;
+	ipl_flags |= IPL_DEVNO_VALID;
+	if (!ipl_schib.pmcw.qf)
+		return;
+	ipl_flags |= IPL_PARMBLOCK_VALID;
+	ipl_ptr = (unsigned int *)__LC_IPL_PARMBLOCK_PTR;
+	src = (void *)(unsigned long)*ipl_ptr;
+	dst = (void *)IPL_PARMBLOCK_ORIGIN;
+	memmove(dst, src, PAGE_SIZE);
+	*ipl_ptr = IPL_PARMBLOCK_ORIGIN;
+}
diff -urpN linux-2.6/include/asm-s390/lowcore.h linux-2.6-patched/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	2006-09-04 11:08:47.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/lowcore.h	2006-09-04 11:08:58.000000000 +0200
@@ -35,6 +35,7 @@
 #define __LC_IO_NEW_PSW                 0x01f0
 #endif /* !__s390x__ */
 
+#define __LC_IPL_PARMBLOCK_PTR		0x014
 #define __LC_EXT_PARAMS                 0x080
 #define __LC_CPU_ADDRESS                0x084
 #define __LC_EXT_INT_CODE               0x086
diff -urpN linux-2.6/include/asm-s390/setup.h linux-2.6-patched/include/asm-s390/setup.h
--- linux-2.6/include/asm-s390/setup.h	2006-09-04 11:08:47.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/setup.h	2006-09-04 11:08:58.000000000 +0200
@@ -125,13 +125,15 @@ struct ipl_parameter_block {
 /*
  * IPL validity flags and parameters as detected in head.S
  */
-extern u32 ipl_parameter_flags;
+extern u32 ipl_flags;
 extern u16 ipl_devno;
 
 void do_reipl(void);
 
-#define IPL_DEVNO_VALID		(ipl_parameter_flags & 1)
-#define IPL_PARMBLOCK_VALID	(ipl_parameter_flags & 2)
+enum {
+	IPL_DEVNO_VALID	= 1,
+	IPL_PARMBLOCK_VALID = 2,
+};
 
 #define IPL_PARMBLOCK_START	((struct ipl_parameter_block *) \
 				 IPL_PARMBLOCK_ORIGIN)

-- 
VGER BF report: U 0.5
