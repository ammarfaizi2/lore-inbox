Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264202AbUFKRcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbUFKRcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUFKRcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:32:23 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:8177 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S264202AbUFKRb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:31:59 -0400
Date: Fri, 11 Jun 2004 19:32:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: speedup strn{cpy,len}_from_user.
Message-ID: <20040611173204.GB3279@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: speedup strn{cpy,len}_from_user.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Speedup strncpy_from_user and strnlen_from_user by using
the search string instruction in the secondary space mode.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/lib/uaccess.S    |   67 ++++++++++++++++++++++++++-------------------
 arch/s390/lib/uaccess64.S  |   65 ++++++++++++++++++++++++-------------------
 include/asm-s390/uaccess.h |   11 ++++---
 3 files changed, 82 insertions(+), 61 deletions(-)

diff -urN linux-2.6/arch/s390/lib/uaccess.S linux-2.6-s390/arch/s390/lib/uaccess.S
--- linux-2.6/arch/s390/lib/uaccess.S	Mon May 10 04:32:53 2004
+++ linux-2.6-s390/arch/s390/lib/uaccess.S	Fri Jun 11 19:09:54 2004
@@ -154,46 +154,57 @@
         .align 4
         .text
         .globl __strncpy_from_user_asm
-	# %r2 = dst, %r3 = src, %r4 = count
+	# %r2 = count, %r3 = dst, %r4 = src
 __strncpy_from_user_asm:
 	lhi	%r0,0
-	lhi	%r1,1
-	lhi	%r5,0
-0:	mvcp	0(%r1,%r2),0(%r3),%r0
-	tm	0(%r2),0xff
-	jz	1f
-	la	%r2,1(%r2)
-	la	%r3,1(%r3)
-	ahi	%r5,1
-	clr	%r5,%r4
-	jl	0b
-1:	lr	%r2,%r5
+	lr	%r1,%r4
+	la	%r4,0(%r4)	# clear high order bit from %r4
+	la	%r2,0(%r2,%r4)	# %r2 points to first byte after string
+	sacf	256
+0:	srst	%r2,%r1
+	jo	0b
+	sacf	0
+	lr	%r1,%r2
+	jh	1f		# \0 found in string ?
+	ahi	%r1,1		# include \0 in copy
+1:	slr	%r1,%r4		# %r1 = copy length (without \0)
+	slr	%r2,%r4		# %r2 = return length (including \0)
+2:	mvcp	0(%r1,%r3),0(%r4),%r0
+	jnz	3f
 	br	%r14
-2:	lhi	%r2,-EFAULT
+3:	la	%r3,256(%r3)
+	la	%r4,256(%r4)
+	ahi	%r1,-256
+	mvcp	0(%r1,%r3),0(%r4),%r0
+	jnz	3b
 	br	%r14
-        .section __ex_table,"a"
-	.long	0b,2b
+4:	sacf	0
+	lhi	%r2,-EFAULT
+	br	%r14
+	.section __ex_table,"a"
+	.long	0b,4b
 	.previous
 
         .align 4
         .text
         .globl __strnlen_user_asm
-	# %r2 = src, %r3 = count
+	# %r2 = count, %r3 = src
 __strnlen_user_asm:
 	lhi	%r0,0
-	lhi	%r1,1
-	lhi	%r5,0
-0:	mvcp	24(%r1,%r15),0(%r2),%r0
-	ahi	%r5,1
-	tm	24(%r15),0xff
-	jz	1f
-	la	%r2,1(%r2)
-	clr	%r5,%r3
-	jl	0b
-1:	lr	%r2,%r5
+	lr	%r1,%r3
+	la	%r3,0(%r3)	# clear high order bit from %r4
+	la	%r2,0(%r2,%r3)	# %r2 points to first byte after string
+	sacf	256
+0:	srst	%r2,%r1
+	jo	0b
+	sacf	0
+	jh	1f		# \0 found in string ?
+	ahi	%r2,1		# strnlen_user result includes the \0
+1:	slr	%r2,%r3
 	br	%r14
-2:	lhi	%r2,-EFAULT
+2:	sacf	0
+	lhi	%r2,-EFAULT
 	br	%r14
-        .section __ex_table,"a"
+	.section __ex_table,"a"
 	.long	0b,2b
 	.previous
diff -urN linux-2.6/arch/s390/lib/uaccess64.S linux-2.6-s390/arch/s390/lib/uaccess64.S
--- linux-2.6/arch/s390/lib/uaccess64.S	Mon May 10 04:33:13 2004
+++ linux-2.6-s390/arch/s390/lib/uaccess64.S	Fri Jun 11 19:09:54 2004
@@ -152,46 +152,55 @@
         .align 4
         .text
         .globl __strncpy_from_user_asm
-	# %r2 = dst, %r3 = src, %r4 = count
+	# %r2 = count, %r3 = dst, %r4 = src
 __strncpy_from_user_asm:
 	lghi	%r0,0
-	lghi	%r1,1
-	lghi	%r5,0
-0:	mvcp	0(%r1,%r2),0(%r3),%r0
-	tm	0(%r2),0xff
-	jz	1f
-	la	%r2,1(%r2)
-	la	%r3,1(%r3)
-	aghi	%r5,1
-	clgr	%r5,%r4
-	jl	0b
-1:	lgr	%r2,%r5
+	lgr	%r1,%r4
+	la	%r2,0(%r2,%r4)	# %r2 points to first byte after string
+	sacf	256
+0:	srst	%r2,%r1
+	jo	0b
+	sacf	0
+	lgr	%r1,%r2
+	jh	1f		# \0 found in string ?
+	aghi	%r1,1		# include \0 in copy
+1:	slgr	%r1,%r4		# %r1 = copy length (without \0)
+	slgr	%r2,%r4		# %r2 = return length (including \0)
+2:	mvcp	0(%r1,%r3),0(%r4),%r0
+	jnz	3f
 	br	%r14
-2:	lghi	%r2,-EFAULT
+3:	la	%r3,256(%r3)
+	la	%r4,256(%r4)
+	aghi	%r1,-256
+	mvcp	0(%r1,%r3),0(%r4),%r0
+	jnz	3b
 	br	%r14
-        .section __ex_table,"a"
-	.quad	0b,2b
+4:	sacf	0
+	lghi	%r2,-EFAULT
+	br	%r14
+	.section __ex_table,"a"
+	.quad	0b,4b
 	.previous
 
         .align 4
         .text
         .globl __strnlen_user_asm
-	# %r2 = src, %r3 = count
+	# %r2 = count, %r3 = src
 __strnlen_user_asm:
 	lghi	%r0,0
-	lghi	%r1,1
-	lghi	%r5,0
-0:	mvcp	24(%r1,%r15),0(%r2),%r0
-	aghi	%r5,1
-	tm	24(%r15),0xff
-	jz	1f
-	la	%r2,1(%r2)
-	clgr	%r5,%r3
-	jl	0b
-1:	lgr	%r2,%r5
+	lgr	%r1,%r3
+	la	%r2,0(%r2,%r3)	# %r2 points to first byte after string
+	sacf	256
+0:	srst	%r2,%r1
+	jo	0b
+	sacf	0
+	jh	1f		# \0 found in string ?
+	aghi	%r2,1		# strnlen_user result includes the \0
+1:	slgr	%r2,%r3
 	br	%r14
-2:	lghi	%r2,-EFAULT
+2:	sacf	0
+	lghi	%r2,-EFAULT
 	br	%r14
-        .section __ex_table,"a"
+	.section __ex_table,"a"
 	.quad	0b,2b
 	.previous
diff -urN linux-2.6/include/asm-s390/uaccess.h linux-2.6-s390/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	Fri Jun 11 19:09:28 2004
+++ linux-2.6-s390/include/asm-s390/uaccess.h	Fri Jun 11 19:09:54 2004
@@ -346,26 +346,27 @@
 /*
  * Copy a null terminated string from userspace.
  */
-extern long __strncpy_from_user_asm(char *dst, const char *src, long count);
+extern long __strncpy_from_user_asm(long count, char *dst, const char *src);
 
 static inline long
 strncpy_from_user(char *dst, const char *src, long count)
 {
         long res = -EFAULT;
         might_sleep();
-        if (access_ok(VERIFY_READ, src, 1))
-                res = __strncpy_from_user_asm(dst, src, count);
+        if (access_ok(VERIFY_READ, src, 1)) {
+                res = __strncpy_from_user_asm(count, dst, src);
+	}
         return res;
 }
 
 
-extern long __strnlen_user_asm(const char *src, long count);
+extern long __strnlen_user_asm(long count, const char *src);
 
 static inline unsigned long
 strnlen_user(const char * src, unsigned long n)
 {
 	might_sleep();
-	return __strnlen_user_asm(src, n);
+	return __strnlen_user_asm(n, src);
 }
 
 /**
