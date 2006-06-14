Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWFNOE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWFNOE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWFNOE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:04:27 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:60442 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964946AbWFNOEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:04:25 -0400
Date: Wed, 14 Jun 2006 16:04:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch 16/24] s390: head.S code moving.
Message-ID: <20060614140424.GQ9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] head.S code moving.

There is almost no room left for any new code between 0x10000
and 0x10480. Move the code from 0x10000 to 0x11000.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head.S   |   22 ++++++------
 arch/s390/kernel/head31.S |   77 ++++++++++++++++++++++----------------------
 arch/s390/kernel/head64.S |   79 ++++++++++++++++++++++------------------------
 3 files changed, 88 insertions(+), 90 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
--- linux-2.6/arch/s390/kernel/head31.S	2006-06-14 14:29:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head31.S	2006-06-14 14:29:53.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * arch/s390/kernel/head31.S
  *
- * (C) Copyright IBM Corp. 2005
+ * Copyright (C) IBM Corp. 2005,2006
  *
  *   Author(s):	Hartmut Penner <hp@de.ibm.com>
  *		Martin Schwidefsky <schwidefsky@de.ibm.com>
@@ -16,12 +16,31 @@
 # or linload or SALIPL
 #
 	.org	0x10000
-startup:basr	%r13,0			 # get base
-.LPG1:	l	%r1, .Lget_ipl_device_addr-.LPG1(%r13)
-	basr	%r14, %r1
+startup:basr	%r13,0			# get base
+.LPG0:	l	%r13,0f-.LPG0(%r13)
+	b	0(%r13)
+0:	.long	startup_continue
+
+#
+# params at 10400 (setup.h)
+#
+	.org	PARMAREA
+	.long	0,0			# IPL_DEVICE
+	.long	0,RAMDISK_ORIGIN	# INITRD_START
+	.long	0,RAMDISK_SIZE		# INITRD_SIZE
+
+	.org	COMMAND_LINE
+	.byte	"root=/dev/ram0 ro"
+	.byte	0
+
+	.org	0x11000
+
+startup_continue:
+	basr	%r13,0			# get base
+.LPG1:	GET_IPL_DEVICE
 	lctl	%c0,%c15,.Lctl-.LPG1(%r13) # load control registers
-	la	%r12,_pstart-.LPG1(%r13) # pointer to parameter area
-					 # move IPL device to lowcore
+	l	%r12,.Lparmaddr-.LPG1(%r13) # pointer to parameter area
+					# move IPL device to lowcore
 	mvc	__LC_IPLDEV(4),IPL_DEVICE-PARMAREA(%r12)
 
 #
@@ -51,8 +70,8 @@ startup:basr	%r13,0			 # get base
 	a	%r1,__LC_EXT_NEW_PSW+4	# set handler
 	st	%r1,__LC_EXT_NEW_PSW+4
 
-	la	%r4,_pstart-.LPG1(%r13)	# %r4 is our index for sccb stuff
-	la	%r1, .Lsccb-PARMAREA(%r4)	# our sccb
+	l	%r4,.Lsccbaddr-.LPG1(%r13) # %r4 is our index for sccb stuff
+	lr	%r1,%r4			# our sccb
 	.insn	rre,0xb2200000,%r2,%r1	# service call
 	ipm	%r1
 	srl	%r1,28			# get cc code
@@ -63,7 +82,7 @@ startup:basr	%r13,0			 # get base
 	be	.Lservicecall-.LPG1(%r13)
 	lpsw	.Lwaitsclp-.LPG1(%r13)
 .Lsclph:
-	lh	%r1,.Lsccbr-PARMAREA(%r4)
+	lh	%r1,.Lsccbr-.Lsccb(%r4)
 	chi	%r1,0x10		# 0x0010 is the sucess code
 	je	.Lprocsccb		# let's process the sccb
 	chi	%r1,0x1f0
@@ -74,7 +93,7 @@ startup:basr	%r13,0			 # get base
 	b	.Lservicecall-.LPG1(%r13)
 .Lprocsccb:
 	lhi	%r1,0
-	icm	%r1,3,.Lscpincr1-PARMAREA(%r4) # use this one if != 0
+	icm	%r1,3,.Lscpincr1-.Lsccb(%r4) # use this one if != 0
 	jnz	.Lscnd
 	lhi	%r1,0x800		# otherwise report 2GB
 .Lscnd:
@@ -84,10 +103,10 @@ startup:basr	%r13,0			 # get base
 	lr	%r1,%r3
 .Lno2gb:
 	xr	%r3,%r3			# same logic
-	ic	%r3,.Lscpa1-PARMAREA(%r4)
+	ic	%r3,.Lscpa1-.Lsccb(%r4)
 	chi	%r3,0x00
 	jne	.Lcompmem
-	l	%r3,.Lscpa2-PARMAREA(%r4)
+	l	%r3,.Lscpa2-.Lsccb(%r4)
 .Lcompmem:
 	mr	%r2,%r1			# mem in MB on 128-bit
 	l	%r1,.Lonemb-.LPG1(%r13)
@@ -95,8 +114,6 @@ startup:basr	%r13,0			 # get base
 	b	.Lfchunk-.LPG1(%r13)
 
 	.align 4
-.Lget_ipl_device_addr:
-	.long	.Lget_ipl_device
 .Lpmask:
 	.byte	0
 .align 8
@@ -242,6 +259,8 @@ startup:basr	%r13,0			 # get base
 	.long	0			# cr13: home space segment table
 	.long	0xc0000000		# cr14: machine check handling off
 	.long	0			# cr15: linkage stack operations
+.Lduct:	.long	0,0,0,0,0,0,0,0
+	.long	0,0,0,0,0,0,0,0
 .Lpcmem:.long	0x00080000,0x80000000 + .Lchkmem
 .Lpcfpu:.long	0x00080000,0x80000000 + .Lchkfpu
 .Lpccsp:.long	0x00080000,0x80000000 + .Lchkcsp
@@ -252,25 +271,9 @@ startup:basr	%r13,0			 # get base
 .Lmflags:.long	machine_flags
 .Lbss_bgn:  .long __bss_start
 .Lbss_end:  .long _end
-
-	.org	PARMAREA-64
-.Lduct:	.long	0,0,0,0,0,0,0,0
-	.long	0,0,0,0,0,0,0,0
-
-#
-# params at 10400 (setup.h)
-#
-	.org	PARMAREA
-	.global _pstart
-_pstart:
-	.long	0,0			# IPL_DEVICE
-	.long	0,RAMDISK_ORIGIN	# INITRD_START
-	.long	0,RAMDISK_SIZE		# INITRD_SIZE
-
-	.org	COMMAND_LINE
-	.byte	"root=/dev/ram0 ro"
-	.byte	0
-	.org	0x11000
+.Lparmaddr: .long PARMAREA
+.Lsccbaddr: .long .Lsccb
+	.align	4096
 .Lsccb:
 	.hword	0x1000			# length, one page
 	.byte	0x00,0x00,0x00
@@ -287,18 +290,14 @@ _pstart:
 .Lscpincr2:
 	.quad	0x00
 	.fill	3984,1,0
-	.org	0x12000
-	.global	_pend
-_pend:
-
-	GET_IPL_DEVICE
+	.align	4096
 
 #ifdef CONFIG_SHARED_KERNEL
 	.org	0x100000
 #endif
 
 #
-# startup-code, running in virtual mode
+# startup-code, running in absolute addressing mode
 #
 	.globl	_stext
 _stext:	basr	%r13,0			# get base
diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2006-06-14 14:29:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-06-14 14:29:53.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * arch/s390/kernel/head64.S
  *
- * (C) Copyright IBM Corp. 1999,2005
+ * Copyright (C) IBM Corp. 1999,2006
  *
  *   Author(s):	Hartmut Penner <hp@de.ibm.com>
  *		Martin Schwidefsky <schwidefsky@de.ibm.com>
@@ -15,18 +15,37 @@
 # this is called either by the ipl loader or directly by PSW restart
 # or linload or SALIPL
 #
-        .org  0x10000
-startup:basr  %r13,0                     # get base
+	.org  0x10000
+startup:basr  %r13,0			 # get base
+.LPG0:	l     %r13,0f-.LPG0(%r13)
+	b     0(%r13)
+0:	.long startup_continue
+
+#
+# params at 10400 (setup.h)
+#
+	.org   PARMAREA
+	.quad  0			# IPL_DEVICE
+	.quad  RAMDISK_ORIGIN		# INITRD_START
+	.quad  RAMDISK_SIZE		# INITRD_SIZE
+
+	.org   COMMAND_LINE
+	.byte  "root=/dev/ram0 ro"
+	.byte  0
+
+	.org   0x11000
+
+startup_continue:
+	basr  %r13,0			 # get base
 .LPG1:  sll   %r13,1                     # remove high order bit
         srl   %r13,1
-	l     %r1,.Lget_ipl_device_addr-.LPG1(%r13)
-	basr  %r14,%r1
+	GET_IPL_DEVICE
         lhi   %r1,1                      # mode 1 = esame
         slr   %r0,%r0                    # set cpuid to zero
         sigp  %r1,%r0,0x12               # switch to esame mode
 	sam64				 # switch to 64 bit mode
 	lctlg %c0,%c15,.Lctl-.LPG1(%r13) # load control registers
-	larl  %r12,_pstart               # pointer to parameter area
+	lg    %r12,.Lparmaddr-.LPG1(%r13)# pointer to parameter area
 					 # move IPL device to lowcore
         mvc   __LC_IPLDEV(4),IPL_DEVICE+4-PARMAREA(%r12)
 
@@ -55,8 +74,8 @@ startup:basr  %r13,0                    
 	larl  %r1,.Lsclph
 	stg   %r1,__LC_EXT_NEW_PSW+8	# set handler
 
-	larl  %r4,_pstart		# %r4 is our index for sccb stuff
-	la    %r1,.Lsccb-PARMAREA(%r4)	# our sccb
+	larl  %r4,.Lsccb		# %r4 is our index for sccb stuff
+	lgr   %r1,%r4			# our sccb
 	.insn rre,0xb2200000,%r2,%r1	# service call
 	ipm   %r1
 	srl   %r1,28			# get cc code
@@ -67,7 +86,7 @@ startup:basr  %r13,0                    
 	be    .Lservicecall-.LPG1(%r13)
 	lpswe .Lwaitsclp-.LPG1(%r13)
 .Lsclph:
-	lh    %r1,.Lsccbr-PARMAREA(%r4)
+	lh    %r1,.Lsccbr-.Lsccb(%r4)
 	chi   %r1,0x10			# 0x0010 is the sucess code
 	je    .Lprocsccb		# let's process the sccb
 	chi   %r1,0x1f0
@@ -78,15 +97,15 @@ startup:basr  %r13,0                    
 	b     .Lservicecall-.LPG1(%r13)
 .Lprocsccb:
 	lghi  %r1,0
-	icm   %r1,3,.Lscpincr1-PARMAREA(%r4) # use this one if != 0
+	icm   %r1,3,.Lscpincr1-.Lsccb(%r4) # use this one if != 0
 	jnz   .Lscnd
-	lg    %r1,.Lscpincr2-PARMAREA(%r4) # otherwise use this one
+	lg    %r1,.Lscpincr2-.Lsccb(%r4) # otherwise use this one
 .Lscnd:
 	xr    %r3,%r3			# same logic
-	ic    %r3,.Lscpa1-PARMAREA(%r4)
+	ic    %r3,.Lscpa1-.Lsccb(%r4)
 	chi   %r3,0x00
 	jne   .Lcompmem
-	l     %r3,.Lscpa2-PARMAREA(%r4)
+	l     %r3,.Lscpa2-.Lsccb(%r4)
 .Lcompmem:
 	mlgr  %r2,%r1			# mem in MB on 128-bit
 	l     %r1,.Lonemb-.LPG1(%r13)
@@ -94,8 +113,6 @@ startup:basr  %r13,0                    
 	b     .Lfchunk-.LPG1(%r13)
 
 	.align 4
-.Lget_ipl_device_addr:
-	.long .Lget_ipl_device
 .Lpmask:
 	.byte 0
 	.align 8
@@ -242,29 +259,16 @@ startup:basr  %r13,0                    
         .quad  0                        # cr13: home space segment table
         .quad  0xc0000000               # cr14: machine check handling off
         .quad  0                        # cr15: linkage stack operations
+.Lduct: .long 0,0,0,0,0,0,0,0
+	.long 0,0,0,0,0,0,0,0
 .Lpcmsk:.quad  0x0000000180000000
 .L4malign:.quad 0xffffffffffc00000
 .Lscan2g:.quad 0x80000000 + 0x20000 - 8 # 2GB + 128K - 8
 .Lnop:	.long  0x07000700
+.Lparmaddr:
+	.quad	PARMAREA
 
-	.org PARMAREA-64
-.Lduct:	.long 0,0,0,0,0,0,0,0
-	.long 0,0,0,0,0,0,0,0
-
-#
-# params at 10400 (setup.h)
-#
-	.org   PARMAREA
-	.global _pstart
-_pstart:
-	.quad  0                        # IPL_DEVICE
-        .quad  RAMDISK_ORIGIN           # INITRD_START
-        .quad  RAMDISK_SIZE             # INITRD_SIZE
-
-        .org   COMMAND_LINE
-    	.byte  "root=/dev/ram0 ro"
-        .byte  0
-	.org   0x11000
+	.align 4096
 .Lsccb:
 	.hword 0x1000			# length, one page
 	.byte 0x00,0x00,0x00
@@ -281,18 +285,14 @@ _pstart:
 .Lscpincr2:
 	.quad 0x00
 	.fill 3984,1,0
-	.org 0x12000
-	.global _pend
-_pend:	
-
-	GET_IPL_DEVICE
+	.align 4096
 
 #ifdef CONFIG_SHARED_KERNEL
 	.org   0x100000
 #endif
 	
 #
-# startup-code, running in virtual mode
+# startup-code, running in absolute addressing mode
 #
         .globl _stext
 _stext:	basr  %r13,0                    # get base
@@ -326,4 +326,3 @@ _stext:	basr  %r13,0                    
             .align 8
 .Ldw:       .quad  0x0002000180000000,0x0000000000000000
 .Laregs:    .long  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
-
diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head.S	2006-06-14 14:29:53.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  arch/s390/kernel/head.S
  *
- * (C) Copyright IBM Corp. 1999, 2005
+ * Copyright (C) IBM Corp. 1999,2006
  *
  *    Author(s): Hartmut Penner <hp@de.ibm.com>
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
@@ -482,24 +482,23 @@ start:
 
 .macro GET_IPL_DEVICE
 .Lget_ipl_device:
-	basr  %r12,0
-.LGID:	l     %r1,0xb8			# get sid
+	l     %r1,0xb8			# get sid
 	sll   %r1,15			# test if subchannel is enabled
 	srl   %r1,31
 	ltr   %r1,%r1
-	bz    0(%r14)			# subchannel disabled
+	bz    2f-.LPG1(%r13)		# subchannel disabled
 	l     %r1,0xb8
-	la    %r5,.Lipl_schib-.LGID(%r12)
+	la    %r5,.Lipl_schib-.LPG1(%r13)
 	stsch 0(%r5)		        # get schib of subchannel
-	bnz   0(%r14)			# schib not available
+	bnz   2f-.LPG1(%r13)		# schib not available
 	tm    5(%r5),0x01		# devno valid?
-	bno   0(%r14)
-	la    %r6,ipl_parameter_flags-.LGID(%r12)
+	bno   2f-.LPG1(%r13)
+	la    %r6,ipl_parameter_flags-.LPG1(%r13)
 	oi    3(%r6),0x01		# set flag
-	la    %r2,ipl_devno-.LGID(%r12)
+	la    %r2,ipl_devno-.LPG1(%r13)
 	mvc   0(2,%r2),6(%r5)		# store devno
 	tm    4(%r5),0x80		# qdio capable device?
-	bno   0(%r14)
+	bno   2f-.LPG1(%r13)
 	oi    3(%r6),0x02		# set flag
 
 	# copy ipl parameters
@@ -523,7 +522,7 @@ start:
 	ar    %r2,%r1
 	sr    %r0,%r4
 	jne   1b
-	b     0(%r14)
+	b     2f-.LPG1(%r13)
 
 	.align 4
 .Lipl_schib:
@@ -537,6 +536,7 @@ ipl_parameter_flags:
 	.globl ipl_devno
 ipl_devno:
 	.word 0
+2:
 .endm
 
 #ifdef CONFIG_64BIT
