Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWH3Mhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWH3Mhl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWH3Mhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:37:41 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:46864 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750707AbWH3Mhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:37:40 -0400
Date: Wed, 30 Aug 2006 14:37:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] broken copy_in_user function.
Message-ID: <20060830123738.GA21193@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] broken copy_in_user function.

The copy_in_user primitive does not work as advertised. If the source
and target area are available copy_in_user copies one byte too much.
If one of the memory areas is not available it does not copy as much
data as it can, but up to 257 bytes less.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/lib/uaccess.S   |   33 +++++++++++++++++----------------
 arch/s390/lib/uaccess64.S |   35 ++++++++++++++++++-----------------
 2 files changed, 35 insertions(+), 33 deletions(-)

diff -urpN linux-2.6/arch/s390/lib/uaccess64.S linux-2.6-patched/arch/s390/lib/uaccess64.S
--- linux-2.6/arch/s390/lib/uaccess64.S	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/uaccess64.S	2006-08-30 14:24:31.000000000 +0200
@@ -88,30 +88,31 @@ __copy_to_user_asm:
         .globl __copy_in_user_asm
 	# %r2 = from, %r3 = n, %r4 = to
 __copy_in_user_asm:
+	aghi	%r3,-1
+	jo	6f
 	sacf	256
-	bras	1,1f
-	mvc	0(1,%r4),0(%r2)
-0:	mvc	0(256,%r4),0(%r2)
-	la	%r2,256(%r2)
-	la	%r4,256(%r4)
-1:	aghi	%r3,-256
-	jnm	0b
-2:	ex	%r3,0(%r1)
-	sacf	0
-	slgr	%r2,%r2
-	br	14
-3:	mvc	0(1,%r4),0(%r2)
+	bras	%r1,4f
+0:	aghi	%r3,257
+1:	mvc	0(1,%r4),0(%r2)
 	la	%r2,1(%r2)
 	la	%r4,1(%r4)
 	aghi	%r3,-1
+	jnz	1b
+2:	lgr	%r2,%r3
+	br	%r14
+3:	mvc	0(256,%r4),0(%r2)
+	la	%r2,256(%r2)
+	la	%r4,256(%r4)
+4:	aghi	%r3,-256
 	jnm	3b
-4:	lgr	%r2,%r3
+5:	ex	%r3,4(%r1)
 	sacf	0
-	br	%r14
+6:	slgr	%r2,%r2
+	br	14
         .section __ex_table,"a"
-	.quad	0b,3b
-	.quad	2b,3b
-	.quad	3b,4b
+	.quad	1b,2b
+	.quad	3b,0b
+	.quad	5b,0b
         .previous
 
         .align 4
diff -urpN linux-2.6/arch/s390/lib/uaccess.S linux-2.6-patched/arch/s390/lib/uaccess.S
--- linux-2.6/arch/s390/lib/uaccess.S	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/uaccess.S	2006-08-30 14:24:31.000000000 +0200
@@ -88,30 +88,31 @@ __copy_to_user_asm:
         .globl __copy_in_user_asm
 	# %r2 = from, %r3 = n, %r4 = to
 __copy_in_user_asm:
+	ahi	%r3,-1
+	jo	6f
 	sacf	256
-	bras	1,1f
-	mvc	0(1,%r4),0(%r2)
-0:	mvc	0(256,%r4),0(%r2)
-	la	%r2,256(%r2)
-	la	%r4,256(%r4)
-1:	ahi	%r3,-256
-	jnm	0b
-2:	ex	%r3,0(%r1)
-	sacf	0
-	slr	%r2,%r2
-	br	14
-3:	mvc	0(1,%r4),0(%r2)
+	bras	%r1,4f
+0:	ahi	%r3,257
+1:	mvc	0(1,%r4),0(%r2)
 	la	%r2,1(%r2)
 	la	%r4,1(%r4)
 	ahi	%r3,-1
+	jnz	1b
+2:	lr	%r2,%r3
+	br	%r14
+3:	mvc	0(256,%r4),0(%r2)
+	la	%r2,256(%r2)
+	la	%r4,256(%r4)
+4:	ahi	%r3,-256
 	jnm	3b
-4:	lr	%r2,%r3
+5:	ex	%r3,4(%r1)
 	sacf	0
+6:	slr	%r2,%r2
 	br	%r14
         .section __ex_table,"a"
-	.long	0b,3b
-	.long	2b,3b
-	.long	3b,4b
+	.long	1b,2b
+	.long	3b,0b
+	.long	5b,0b
         .previous
 
         .align 4
