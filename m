Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbTCERuU>; Wed, 5 Mar 2003 12:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbTCERuU>; Wed, 5 Mar 2003 12:50:20 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:49402 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S267218AbTCERuR>;
	Wed, 5 Mar 2003 12:50:17 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15974.15180.311304.526712@gargle.gargle.HOWL>
Date: Wed, 5 Mar 2003 19:00:44 +0100
To: ak@suse.de
Subject: x86-64 fixes for 2.4.21-pre5
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a linkage error caused by the IDE layer's use of the
new ndelay() macro. I simply cloned the i386 implementation.

This also silences two assembler warnings in bootsect.S and setup.S.
Those warnings are caused by a change in binutils' behaviour a LONG
time ago. This can't be fixed for i386 in the official stable kernel
since it breaks old tool chains, but that's not an issue for x86-64.

Boots and runs Ok on Simics.

/Mikael

--- linux-2.4.21-pre5/arch/x86_64/boot/bootsect.S.~1~	2003-03-05 17:37:42.000000000 +0100
+++ linux-2.4.21-pre5/arch/x86_64/boot/bootsect.S	2003-03-05 18:33:12.000000000 +0100
@@ -236,7 +236,7 @@
 rp_read:
 #ifdef __BIG_KERNEL__			# look in setup.S for bootsect_kludge
 	bootsect_kludge = 0x220		# 0x200 + 0x20 which is the size of the
-	lcall	bootsect_kludge		# bootsector + bootsect_kludge offset
+	lcall	*bootsect_kludge	# bootsector + bootsect_kludge offset
 #else
 	movw	%es, %ax
 	subw	$SYSSEG, %ax
--- linux-2.4.21-pre5/arch/x86_64/boot/setup.S.~1~	2002-11-30 17:12:24.000000000 +0100
+++ linux-2.4.21-pre5/arch/x86_64/boot/setup.S	2003-03-05 18:33:32.000000000 +0100
@@ -449,7 +449,7 @@
 	cmpw	$0, %cs:realmode_swtch
 	jz	rmodeswtch_normal
 
-	lcall	%cs:realmode_swtch
+	lcall	*%cs:realmode_swtch
 
 	jmp	rmodeswtch_end
 
--- linux-2.4.21-pre5/arch/x86_64/lib/delay.c.~1~	2002-11-30 17:12:24.000000000 +0100
+++ linux-2.4.21-pre5/arch/x86_64/lib/delay.c	2003-03-05 18:24:25.000000000 +0100
@@ -41,3 +41,8 @@
 {
 	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
 }
+
+void __ndelay(unsigned long usecs)
+{
+	__const_udelay(usecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
+}
--- linux-2.4.21-pre5/include/asm-x86_64/delay.h.~1~	2002-11-30 17:12:31.000000000 +0100
+++ linux-2.4.21-pre5/include/asm-x86_64/delay.h	2003-03-05 18:22:04.000000000 +0100
@@ -8,13 +8,19 @@
  */
  
 extern void __bad_udelay(void);
+extern void __bad_ndelay(void);
 
 extern void __udelay(unsigned long usecs);
+extern void __ndelay(unsigned long usecs);
 extern void __const_udelay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
 #define udelay(n) (__builtin_constant_p(n) ? \
 	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
 	__udelay(n))
+	
+#define ndelay(n) (__builtin_constant_p(n) ? \
+	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
+	__ndelay(n))
 
 #endif /* defined(_X8664_DELAY_H) */
