Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268106AbTBSAYk>; Tue, 18 Feb 2003 19:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268107AbTBSAYk>; Tue, 18 Feb 2003 19:24:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:525 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268106AbTBSAYj>; Tue, 18 Feb 2003 19:24:39 -0500
Subject: PATCH: ndelay resend
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Wed, 19 Feb 2003 00:35:02 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lICU-0006lk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunno where it went before. The implementation is not ideal. Thats something
to tidy up.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/arch/i386/kernel/i386_ksyms.c linux-2.5.61-ac2/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.61/arch/i386/kernel/i386_ksyms.c	2003-02-10 18:39:01.000000000 +0000
+++ linux-2.5.61-ac2/arch/i386/kernel/i386_ksyms.c	2003-02-18 14:41:51.000000000 +0000
@@ -104,6 +104,7 @@
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
 /* Delay loops */
+EXPORT_SYMBOL(__ndelay);
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__delay);
 EXPORT_SYMBOL(__const_udelay);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/arch/i386/lib/delay.c linux-2.5.61-ac2/arch/i386/lib/delay.c
--- linux-2.5.61/arch/i386/lib/delay.c	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.61-ac2/arch/i386/lib/delay.c	2003-02-18 14:41:35.000000000 +0000
@@ -41,3 +41,8 @@
 {
 	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
 }
+
+void __ndelay(unsigned long nsecs)
+{
+	__const_udelay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
+}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/asm-i386/delay.h linux-2.5.61-ac2/include/asm-i386/delay.h
--- linux-2.5.61/include/asm-i386/delay.h	2003-02-10 18:37:54.000000000 +0000
+++ linux-2.5.61-ac2/include/asm-i386/delay.h	2003-02-18 14:40:31.000000000 +0000
@@ -8,13 +8,19 @@
  */
  
 extern void __bad_udelay(void);
+extern void __bad_ndelay(void);
 
 extern void __udelay(unsigned long usecs);
+extern void __ndelay(unsigned long nsecs);
 extern void __const_udelay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
 #define udelay(n) (__builtin_constant_p(n) ? \
 	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
 	__udelay(n))
+	
+#define ndelay(n) (__builtin_constant_p(n) ? \
+	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
+	__ndelay(n))
 
 #endif /* defined(_I386_DELAY_H) */
