Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbRE2UtZ>; Tue, 29 May 2001 16:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbRE2UtF>; Tue, 29 May 2001 16:49:05 -0400
Received: from femail17.sdc1.sfba.home.com ([24.0.95.144]:18906 "EHLO
	femail17.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S261628AbRE2Us5>; Tue, 29 May 2001 16:48:57 -0400
Message-ID: <3B140B2E.D2FEC34E@didntduck.org>
Date: Tue, 29 May 2001 16:48:46 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 asm cleanups
Content-Type: multipart/mixed;
 boundary="------------AD324C0B6451143FA6D0B4C3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AD324C0B6451143FA6D0B4C3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch replaces several hardcoded .byte sequences with the proper
mnemonics or macros.  I have tested this patch with the minimum required
binutils and current binutils.

-- 

						Brian Gerst
--------------AD324C0B6451143FA6D0B4C3
Content-Type: text/plain; charset=us-ascii;
 name="diff-asm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-asm"

diff -urN linux-2.4.5/arch/i386/boot/video.S linux/arch/i386/boot/video.S
--- linux-2.4.5/arch/i386/boot/video.S	Sun Nov 21 03:09:51 1999
+++ linux/arch/i386/boot/video.S	Tue May 29 15:13:35 2001
@@ -496,7 +496,7 @@
 	jnc	setbad
 	
 	addw	%bx, %bx
-	.word	0xa7ff, spec_inits		# JMP [BX+spec_inits]
+	jmp	*spec_inits(%bx)
 
 setmenu:
 	orb	%al, %al			# 80x25 is an exception
@@ -1008,7 +1008,7 @@
 vesa1:
 # gas version 2.9.1, using BFD version 2.9.1.0.23 buggers the next inst.
 # XXX:	lodsw	%gs:(%si), %ax			# Get next mode in the list
-	.byte	0x65, 0xAD			# %gs seg prefix + lodsw
+	gs; lodsw
 	cmpw	$0xffff, %ax			# End of the table?
 	jz	vesar
 	
diff -urN linux-2.4.5/arch/i386/math-emu/reg_u_div.S linux/arch/i386/math-emu/reg_u_div.S
--- linux-2.4.5/arch/i386/math-emu/reg_u_div.S	Sat Apr 28 11:11:46 2001
+++ linux/arch/i386/math-emu/reg_u_div.S	Tue May 29 15:09:28 2001
@@ -89,10 +89,8 @@
 	movl	REGB,%ebx
 	movl	DEST,%edi
 
-	movw	EXP(%esi),%dx
-	movw	EXP(%ebx),%ax
-	.byte	0x0f,0xbf,0xc0	/* movsx	%ax,%eax */
-	.byte	0x0f,0xbf,0xd2	/* movsx	%dx,%edx */
+	movswl	EXP(%esi),%edx
+	movswl	EXP(%ebx),%eax
 	subl	%eax,%edx
 	addl	EXP_BIAS,%edx
 
diff -urN linux-2.4.5/drivers/char/random.c linux/drivers/char/random.c
--- linux-2.4.5/drivers/char/random.c	Sat May 26 09:41:28 2001
+++ linux/drivers/char/random.c	Tue May 29 15:09:28 2001
@@ -712,8 +712,7 @@
 #if defined (__i386__)
 	if ( test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability) ) {
 		__u32 high;
-		__asm__(".byte 0x0f,0x31"
-			:"=a" (time), "=d" (high));
+		rdtsc(time, high);
 		num ^= high;
 	} else {
 		time = jiffies;
diff -urN linux-2.4.5/drivers/char/rocket.c linux/drivers/char/rocket.c
--- linux-2.4.5/drivers/char/rocket.c	Sun Mar 25 21:24:31 2001
+++ linux/drivers/char/rocket.c	Tue May 29 15:09:28 2001
@@ -485,14 +485,10 @@
 	unsigned char CtlMask, AiopMask;
 
 #ifdef TIME_STAT
-	unsigned long low=0, high=0, loop_time;
+	unsigned long loop_time;
 	unsigned long long time_stat_tmp=0, time_stat_tmp2=0;
 
-	__asm__(".byte 0x0f,0x31"
-		:"=a" (low), "=d" (high));
-	time_stat_tmp = high;
-	time_stat_tmp <<= 32;
-	time_stat_tmp += low;
+	rdtscll(time_stat_tmp);
 #endif /* TIME_STAT */
 
 	for (ctrl=0; ctrl < max_board; ctrl++) {
@@ -532,11 +528,7 @@
 		mod_timer(&rocket_timer, jiffies + 1);
 	}
 #ifdef TIME_STAT
-	__asm__(".byte 0x0f,0x31"
-		:"=a" (low), "=d" (high));
-	time_stat_tmp2 = high;
-	time_stat_tmp2 <<= 32;
-	time_stat_tmp2 += low;
+	rdtscll(time_stat_tmp2);
 	time_stat_tmp2 -= time_stat_tmp;
 	time_stat += time_stat_tmp2;
 	if (time_counter == 0) 
diff -urN linux-2.4.5/drivers/net/hamradio/soundmodem/sm.h linux/drivers/net/hamradio/soundmodem/sm.h
--- linux-2.4.5/drivers/net/hamradio/soundmodem/sm.h	Mon Dec 11 16:22:15 2000
+++ linux/drivers/net/hamradio/soundmodem/sm.h	Tue May 29 15:09:28 2001
@@ -299,6 +299,8 @@
 
 #ifdef __i386__
 
+#include <asm/msr.h>
+
 /*
  * only do 32bit cycle counter arithmetic; we hope we won't overflow.
  * in fact, overflowing modems would require over 2THz CPU clock speeds :-)
@@ -307,10 +309,10 @@
 #define time_exec(var,cmd)                                              \
 ({                                                                      \
 	if (cpu_has_tsc) {                                              \
-		unsigned int cnt1, cnt2, cnt3;                          \
-		__asm__(".byte 0x0f,0x31" : "=a" (cnt1), "=d" (cnt3));  \
+		unsigned int cnt1, cnt2;                                \
+		rdtscl(cnt1);                                           \
 		cmd;                                                    \
-		__asm__(".byte 0x0f,0x31" : "=a" (cnt2), "=d" (cnt3));  \
+		rdtscl(cnt2);                                           \
 		var = cnt2-cnt1;                                        \
 	} else {                                                        \
 		cmd;                                                    \
diff -urN linux-2.4.5/include/asm-i386/page.h linux/include/asm-i386/page.h
--- linux-2.4.5/include/asm-i386/page.h	Sat May 26 10:56:53 2001
+++ linux/include/asm-i386/page.h	Tue May 29 15:09:28 2001
@@ -88,7 +88,7 @@
  */
 #define BUG() do { \
 	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	__asm__ __volatile__(".byte 0x0f,0x0b"); \
+	__asm__ __volatile__("ud2"); \
 } while (0)
 
 #define PAGE_BUG(page) do { \

--------------AD324C0B6451143FA6D0B4C3--

