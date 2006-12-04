Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936923AbWLDOtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936923AbWLDOtn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936925AbWLDOtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:49:43 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:45434 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S936923AbWLDOtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:49:42 -0500
Date: Mon, 4 Dec 2006 15:49:33 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cborntra@de.ibm.com
Subject: [S390] remove salipl memory detection.
Message-ID: <20061204144933.GA32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[S390] remove salipl memory detection.

The SALIPL entry point has an needless memory detection routine as we
later check the memory size again. The SALIPL code also uses diagnose
0x060 if we are running under VM, but this diagnose is not compatible
with the 64 bit addressing mode. The solution is to get rid of this
code and rely on the memory detection in the startup code.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head.S |   21 ---------------------
 1 files changed, 21 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head.S	2006-12-04 14:50:28.000000000 +0100
@@ -418,24 +418,6 @@ start:
 .gotr:
 	l	%r10,.tbl		# EBCDIC to ASCII table
 	tr	0(240,%r8),0(%r10)
-	stidp	__LC_CPUID		# Are we running on VM maybe
-	cli	__LC_CPUID,0xff
-	bnz	.test
-	.long	0x83300060		# diag 3,0,x'0060' - storage size
-	b	.done
-.test:
-	mvc	0x68(8),.pgmnw		# set up pgm check handler
-	l	%r2,.fourmeg
-	lr	%r3,%r2
-	bctr	%r3,%r0			# 4M-1
-.loop:	iske	%r0,%r3
-	ar	%r3,%r2
-.pgmx:
-	sr	%r3,%r2
-	la	%r3,1(%r3)
-.done:
-	l	%r1,.memsize
-	st	%r3,ARCH_OFFSET(%r1)
 	slr	%r0,%r0
 	st	%r0,INITRD_SIZE+ARCH_OFFSET-PARMAREA(%r11)
 	st	%r0,INITRD_START+ARCH_OFFSET-PARMAREA(%r11)
@@ -443,9 +425,6 @@ start:
 .tbl:	.long	_ebcasc			# translate table
 .cmd:	.long	COMMAND_LINE		# address of command line buffer
 .parm:	.long	PARMAREA
-.memsize: .long memory_size
-.fourmeg: .long 0x00400000      	# 4M
-.pgmnw:	.long	0x00080000,.pgmx
 .lowcase:
 	.byte 0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07
 	.byte 0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f
