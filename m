Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265208AbSJPQrW>; Wed, 16 Oct 2002 12:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265205AbSJPQp7>; Wed, 16 Oct 2002 12:45:59 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:49307 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265182AbSJPQpp> convert rfc822-to-8bit; Wed, 16 Oct 2002 12:45:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.43 s390 (3/6): uaccess bug.
Date: Wed, 16 Oct 2002 18:47:46 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210161847.46058.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't rely on lowcore information in __copy_{from,to}_user_asm.

diff -urN linux-2.5.43/arch/s390/lib/uaccess.S linux-2.5.43-s390/arch/s390/lib/uaccess.S
--- linux-2.5.43/arch/s390/lib/uaccess.S	Wed Oct 16 05:27:18 2002
+++ linux-2.5.43-s390/arch/s390/lib/uaccess.S	Wed Oct 16 17:54:05 2002
@@ -1,9 +1,9 @@
 /*
  *  arch/s390/lib/uaccess.S
- *    fixup routines for copy_{from|to}_user functions.
+ *    __copy_{from|to}_user functions.
  *
  *  s390
- *    Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) 2000,2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Authors(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
  *  These functions have standard call interface
@@ -22,17 +22,23 @@
 1:	sacf	0
 	lr	%r2,%r5
 	br	%r14
-2:      sll	%r4,1
-        srl	%r4,1
-        lhi	%r3,-4096
-        sll	%r3,1
-        srl	%r3,1
-        n	%r3,__LC_TRANS_EXC_ADDR
-        sr	%r3,%r4
-        jm	1b
-	j	0b
+2:	lhi	%r1,-4096
+	lr	%r3,%r4
+	slr	%r3,%r1      # %r3 = %r4 + 4096
+	nr	%r3,%r1      # %r3 = (%r4 + 4096) & -4096
+	slr	%r3,%r4      # %r3 = #bytes to next user page boundary
+	clr	%r5,%r3      # copy crosses next page boundary ?
+	jnh	1b           # no, this page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+3:	mvcle	%r2,%r4,0
+	jo	3b
+	j	1b
         .section __ex_table,"a"
 	.long	0b,2b
+	.long	3b,1b
         .previous
 
         .align 4
@@ -46,17 +52,23 @@
 1:	sacf	0
 	lr	%r2,%r3
 	br	%r14
-2:      sll	%r4,1
-        srl	%r4,1
-        lhi	%r5,-4096
-        sll	%r5,1
-        srl	%r5,1
-        n	%r5,__LC_TRANS_EXC_ADDR
-        sr	%r5,%r4
-        jm	1b
-	j	0b
+2:	lhi	%r1,-4096
+	lr	%r5,%r4
+	slr	%r5,%r1      # %r5 = %r4 + 4096
+	nr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
+	slr	%r5,%r4      # %r5 = #bytes to next user page boundary
+	clr	%r3,%r5      # copy crosses next page boundary ?
+	jnh	1b           # no, the current page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+3:	mvcle	%r4,%r2,0
+	jo	3b
+	j	1b
         .section __ex_table,"a"
-	.long   0b,2b
+	.long	0b,2b
+	.long	3b,1b
         .previous
 
         .align 4
@@ -71,18 +83,26 @@
 0:	mvcle	%r4,%r2,0
 	jo	0b
 1:	sacf	0
-	lr	%r2,%r3
 	br	%r14
-2:      sll	%r4,1
-        srl	%r4,1
-        lhi	%r5,-4096
-        sll	%r5,1
-        srl	%r5,1
-        n	%r5,__LC_TRANS_EXC_ADDR
-        sr	%r5,%r4
-	jm	1b
-	j	0b
+2:	lr	%r2,%r5
+	lhi	%r1,-4096
+	slr	%r5,%r1      # %r5 = %r4 + 4096
+	nr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
+	slr	%r5,%r4      # %r5 = #bytes to next user page boundary
+	clr	%r2,%r5      # copy crosses next page boundary ?
+	jnh	1b           # no, the current page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+	slr	%r2,%r5
+3:	mvcle	%r4,%r2,0
+	jo	3b
+	j	1b
+4:	alr	%r2,%r5
+	j	1b
         .section __ex_table,"a"
-	.long   0b,2b
+	.long	0b,2b
+        .long	3b,4b
         .previous
 
diff -urN linux-2.5.43/arch/s390x/lib/uaccess.S linux-2.5.43-s390/arch/s390x/lib/uaccess.S
--- linux-2.5.43/arch/s390x/lib/uaccess.S	Wed Oct 16 05:28:33 2002
+++ linux-2.5.43-s390/arch/s390x/lib/uaccess.S	Wed Oct 16 17:54:05 2002
@@ -1,9 +1,9 @@
 /*
  *  arch/s390x/lib/uaccess.S
- *    fixup routines for copy_{from|to}_user functions.
+ *    __copy_{from|to}_user functions.
  *
- *  S390
- *    Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *  s390
+ *    Copyright (C) 2000,2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Authors(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
  *  These functions have standard call interface
@@ -22,14 +22,23 @@
 1:	sacf	0
 	lgr	%r2,%r5
 	br	%r14
-2:	lghi	%r3,-4096
-        ng	%r3,__LC_TRANS_EXC_ADDR
-        sgr	%r3,%r4
-        jm	1b
-	j	0b
+2:	lghi	%r1,-4096
+	lgr	%r3,%r4
+	slgr	%r3,%r1      # %r3 = %r4 + 4096
+	ngr	%r3,%r1      # %r3 = (%r4 + 4096) & -4096
+	slgr	%r3,%r4      # %r3 = #bytes to next user page boundary
+	clgr	%r5,%r3      # copy crosses next page boundary ?
+	jnh	1b           # no, this page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+3:	mvcle	%r2,%r4,0
+	jo	3b
+	j	1b
         .section __ex_table,"a"
-        .align	8
 	.quad	0b,2b
+	.quad	3b,1b
         .previous
 
         .align 4
@@ -43,14 +52,23 @@
 1:	sacf	0
 	lgr	%r2,%r3
 	br	%r14
-2:      lghi	%r5,-4096
-        ng	%r5,__LC_TRANS_EXC_ADDR
-        sgr	%r5,%r4
-	jm	1b
-	j	0b
+2:	lghi	%r1,-4096
+	lgr	%r5,%r4
+	slgr	%r5,%r1      # %r5 = %r4 + 4096
+	ngr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
+	slgr	%r5,%r4      # %r5 = #bytes to next user page boundary
+	clgr	%r3,%r5      # copy crosses next page boundary ?
+	jnh	1b           # no, the current page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+3:	mvcle	%r4,%r2,0
+	jo	3b
+	j	1b
         .section __ex_table,"a"
-        .align	8
-        .quad	0b,2b
+	.quad	0b,2b
+	.quad	3b,1b
         .previous
 
         .align 4
@@ -65,14 +83,25 @@
 0:	mvcle	%r4,%r2,0
 	jo	0b
 1:	sacf	0
-	lgr	%r2,%r5
 	br	%r14
-2:      lghi	%r5,-4096
-        ng	%r5,__LC_TRANS_EXC_ADDR
-        sgr	%r5,%r4
-	jm	1b
-	j	0b
+2:	lgr	%r2,%r5
+	lghi	%r1,-4096
+	slgr	%r5,%r1      # %r5 = %r4 + 4096
+	ngr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
+	slgr	%r5,%r4      # %r5 = #bytes to next user page boundary
+	clgr	%r2,%r5      # copy crosses next page boundary ?
+	jnh	1b           # no, the current page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+	slgr	%r2,%r5
+3:	mvcle	%r4,%r2,0
+	jo	3b
+	j	1b
+4:	algr	%r2,%r5
+	j	1b
         .section __ex_table,"a"
-        .align	8
-        .quad	0b,2b
+	.quad	0b,2b
+        .quad	3b,4b
         .previous

