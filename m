Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280600AbRKYNf6>; Sun, 25 Nov 2001 08:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280666AbRKYNfv>; Sun, 25 Nov 2001 08:35:51 -0500
Received: from femail45.sdc1.sfba.home.com ([24.254.60.39]:14769 "EHLO
	femail45.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S280600AbRKYNfe>; Sun, 25 Nov 2001 08:35:34 -0500
Message-ID: <3C00F2E9.13488AAB@didntduck.org>
Date: Sun, 25 Nov 2001 08:32:25 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Small asm cleanups
Content-Type: multipart/mixed;
 boundary="------------B753385E6E25AAFCBBD317CB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B753385E6E25AAFCBBD317CB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Changes two asm's to use appropriate macros, and relaxes constraints on
another.

-- 

						Brian Gerst
--------------B753385E6E25AAFCBBD317CB
Content-Type: text/plain; charset=us-ascii;
 name="diff-asm2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-asm2"

diff -urN linux-2.5.1-pre1/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux-2.5.1-pre1/arch/i386/kernel/traps.c	Sun Sep 30 15:26:08 2001
+++ linux/arch/i386/kernel/traps.c	Sun Nov 25 01:02:08 2001
@@ -697,7 +697,7 @@
  */
 asmlinkage void math_state_restore(struct pt_regs regs)
 {
-	__asm__ __volatile__("clts");		/* Allow maths ops (or we recurse) */
+	clts();		/* Allow maths ops (or we recurse) */
 
 	if (current->used_math) {
 		restore_fpu(current);
diff -urN linux-2.5.1-pre1/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.5.1-pre1/arch/i386/mm/init.c	Sun Nov 11 13:09:32 2001
+++ linux/arch/i386/mm/init.c	Sun Nov 25 01:02:08 2001
@@ -333,7 +333,7 @@
 {
 	pagetable_init();
 
-	__asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swapper_pg_dir)));
+	__asm__( "movl %0,%%cr3\n" ::"r"(__pa(swapper_pg_dir)));
 
 #if CONFIG_X86_PAE
 	/*
diff -urN linux-2.5.1-pre1/drivers/net/hamradio/baycom_epp.c linux/drivers/net/hamradio/baycom_epp.c
--- linux-2.5.1-pre1/drivers/net/hamradio/baycom_epp.c	Mon Sep 10 12:04:53 2001
+++ linux/drivers/net/hamradio/baycom_epp.c	Sun Nov 25 01:02:08 2001
@@ -807,10 +807,11 @@
 /* --------------------------------------------------------------------- */
 
 #ifdef __i386__
+#include <asm/msr.h>
 #define GETTICK(x)                                                \
 ({                                                                \
 	if (cpu_has_tsc)                                          \
-		__asm__ __volatile__("rdtsc" : "=a" (x) : : "dx");\
+		rdtscl(x);                                        \
 })
 #else /* __i386__ */
 #define GETTICK(x)

--------------B753385E6E25AAFCBBD317CB--

