Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313384AbSEUMOG>; Tue, 21 May 2002 08:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSEUMOF>; Tue, 21 May 2002 08:14:05 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:29397 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313384AbSEUMN7>;
	Tue, 21 May 2002 08:13:59 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15594.14763.1333.244929@argo.ozlabs.ibm.com>
Date: Tue, 21 May 2002 22:12:27 +1000 (EST)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] important PPC bugfix for 2.4.19-pre
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

The patch below fixes two bugs in the PPC code.  The first bug was
caused by an exception table entry pointing to the wrong instruction.
As a result of this bug, a copy_to_user() with an unmapped or
inaccessible destination address could cause an oops.  The second bug
was that clear_user on PPC was returning -EFAULT rather than the
number of bytes not cleared.

Thanks to Rusty Russell for demonstrating the existence of these bugs
with his test-read.c program.

Since the first bug is one where an ordinary user can cause an oops,
and the fixes are quite simple, I would like this patch to go into the
next 2.4.19-pre or -rc release.

Thanks,
Paul.

diff -urN linux-2.4.19-pre8/arch/ppc/lib/string.S linuxppc_2_4/arch/ppc/lib/string.S
--- linux-2.4.19-pre8/arch/ppc/lib/string.S	Tue Nov  6 18:21:30 2001
+++ linuxppc_2_4/arch/ppc/lib/string.S	Tue May 21 21:44:46 2002
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.string.S 1.9 10/25/01 10:08:51 trini
+ * BK Id: SCCS/s.string.S 1.11 05/21/02 21:44:32 paulus
  */
 /*
  * String handling functions for PowerPC.
@@ -468,7 +468,7 @@
 53:
 #if !defined(CONFIG_8xx)
 	dcbt	r3,r4
-	dcbz	r11,r6
+54:	dcbz	r11,r6
 #endif
 /* had to move these to keep extable in order */
 	.section __ex_table,"a"
@@ -477,7 +477,9 @@
 	.long	71b,101f
 	.long	72b,102f
 	.long	73b,103f
-	.long	53b,105f
+#if !defined(CONFIG_8xx)
+	.long	54b,105f
+#endif
 	.text
 /* the main body of the cacheline loop */
 	COPY_16_BYTES_WITHEX(0)
@@ -621,11 +623,11 @@
 	add	r4,r0,r4
 	subf	r6,r0,r6
 	srwi	r0,r4,2
+	andi.	r4,r4,3
 	mtctr	r0
-	bdz	6f
+	bdz	7f
 1:	stwu	r5,4(r6)
 	bdnz	1b
-6:	andi.	r4,r4,3
 	/* clear byte sized chunks */
 7:	cmpwi	0,r4,0
 	beqlr
@@ -634,14 +636,20 @@
 8:	stbu	r5,1(r6)
 	bdnz	8b
 	blr
-99:	li	r3,-EFAULT
+90:	mr	r3,r4
+	blr
+91:	mfctr	r3
+	slwi	r3,r3,2
+	add	r3,r3,r4
+	blr
+92:	mfctr	r3
 	blr
 
 	.section __ex_table,"a"
 	.align	2
-	.long	11b,99b
-	.long	1b,99b
-	.long	8b,99b
+	.long	11b,90b
+	.long	1b,91b
+	.long	8b,92b
 	.text
 
 	.globl	__strncpy_from_user
diff -urN linux-2.4.19-pre8/include/asm-ppc/uaccess.h linuxppc_2_4/include/asm-ppc/uaccess.h
--- linux-2.4.19-pre8/include/asm-ppc/uaccess.h	Mon Sep 24 09:31:36 2001
+++ linuxppc_2_4/include/asm-ppc/uaccess.h	Tue May 21 21:44:46 2002
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.uaccess.h 1.8 09/11/01 18:10:06 paulus
+ * BK Id: SCCS/s.uaccess.h 1.10 05/21/02 21:44:32 paulus
  */
 #ifdef __KERNEL__
 #ifndef _PPC_UACCESS_H
@@ -272,7 +272,11 @@
 {
 	if (access_ok(VERIFY_WRITE, addr, size))
 		return __clear_user(addr, size);
-	return size? -EFAULT: 0;
+	if ((unsigned long)addr < TASK_SIZE) {
+		unsigned long over = (unsigned long)addr + size - TASK_SIZE;
+		return __clear_user(addr, size - over) + over;
+	}
+	return size;
 }
 
 extern int __strncpy_from_user(char *dst, const char *src, long count);
