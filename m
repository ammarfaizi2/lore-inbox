Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316488AbSEUCOM>; Mon, 20 May 2002 22:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316489AbSEUCOL>; Mon, 20 May 2002 22:14:11 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:22501 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S316488AbSEUCOK>; Mon, 20 May 2002 22:14:10 -0400
Message-ID: <3CE9AC93.5050107@didntduck.org>
Date: Mon, 20 May 2002 22:10:27 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpu_has_tsc
Content-Type: multipart/mixed;
 boundary="------------030509000305050207080006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030509000305050207080006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch converts drivers/char/random.c and 
drivers/input/joystick/analog.c to use the cpu_has_tsc macro.

--

						Brian Gerst

--------------030509000305050207080006
Content-Type: text/plain;
 name="cpu_has_tsc-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu_has_tsc-1"

diff -urN linux-bk/drivers/char/random.c linux/drivers/char/random.c
--- linux-bk/drivers/char/random.c	Wed May 15 10:27:26 2002
+++ linux/drivers/char/random.c	Mon May 20 22:03:58 2002
@@ -735,18 +735,14 @@
 	__s32		delta, delta2, delta3;
 	int		entropy = 0;
 
-#if defined (__i386__)
-	if ( test_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability) ) {
+#if defined (__i386__) || defined (__x86_64__)
+	if (cpu_has_tsc)
 		__u32 high;
 		rdtsc(time, high);
 		num ^= high;
 	} else {
 		time = jiffies;
 	}
-#elif defined (__x86_64__)
-	__u32 high;
-	rdtsc(time, high);
-	num ^= high;
 #else
 	time = jiffies;
 #endif
diff -urN linux-bk/drivers/input/joystick/analog.c linux/drivers/input/joystick/analog.c
--- linux-bk/drivers/input/joystick/analog.c	Thu Mar  7 21:18:24 2002
+++ linux/drivers/input/joystick/analog.c	Mon May 20 22:05:48 2002
@@ -137,10 +137,9 @@
  */
 
 #ifdef __i386__
-#define TSC_PRESENT	(test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability))
-#define GET_TIME(x)	do { if (TSC_PRESENT) rdtscl(x); else x = get_time_pit(); } while (0)
-#define DELTA(x,y)	(TSC_PRESENT?((y)-(x)):((x)-(y)+((x)<(y)?1193180L/HZ:0)))
-#define TIME_NAME	(TSC_PRESENT?"TSC":"PIT")
+#define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x = get_time_pit(); } while (0)
+#define DELTA(x,y)	(cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?1193180L/HZ:0)))
+#define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
 static unsigned int get_time_pit(void)
 {
         extern spinlock_t i8253_lock;

--------------030509000305050207080006--

