Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTJVLOb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 07:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbTJVLOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 07:14:31 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:47887 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263526AbTJVLOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 07:14:09 -0400
Date: Wed, 22 Oct 2003 21:13:53 +1000
To: claus@momo.math.rwth-aachen.de, ak@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FTAPE] Merge alpha/x86-64 fixes from 2.4
Message-ID: <20031022111353.GA24957@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This is my attempt to merge the alpha/x86-64 fix from 2.4.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/drivers/char/ftape/lowlevel/ftape-calibr.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/ftape/lowlevel/ftape-calibr.c,v
retrieving revision 1.1.1.3
retrieving revision 1.2
diff -u -r1.1.1.3 -r1.2
--- kernel-source-2.5/drivers/char/ftape/lowlevel/ftape-calibr.c	27 Jul 2003 16:59:38 -0000	1.1.1.3
+++ kernel-source-2.5/drivers/char/ftape/lowlevel/ftape-calibr.c	22 Oct 2003 11:08:21 -0000	1.2
@@ -31,7 +31,10 @@
 #include <asm/io.h>
 #if defined(__alpha__)
 # include <asm/hwrpb.h>
-#elif defined(__i386__) || defined(__x86_64__)
+#elif defined(__x86_64__)
+# include <asm/msr.h>
+# include <asm/timex.h>
+#elif defined(__i386__) 
 # include <linux/timex.h>
 #endif
 #include <linux/ftape.h>
@@ -45,7 +48,7 @@
 # error Ftape is not implemented for this architecture!
 #endif
 
-#if defined(__alpha__)
+#if defined(__alpha__) || defined(__x86_64__)
 static unsigned long ps_per_cycle = 0;
 #endif
 
@@ -72,7 +75,18 @@
 
 	asm volatile ("rpcc %0" : "=r" (r));
 	return r;
-#elif defined(__i386__) || defined(__x86_64__)
+#elif defined(__x86_64__)
+	unsigned long r;
+	rdtscl(r);
+	return r;
+#elif defined(__i386__)
+
+/*
+ * Note that there is some time between counter underflowing and jiffies
+ * increasing, so the code below won't always give correct output.
+ * -Vojtech
+ */
+
 	unsigned long flags;
 	__u16 lo;
 	__u16 hi;
@@ -89,9 +103,9 @@
 
 static unsigned int short_ftape_timestamp(void)
 {
-#if defined(__alpha__)
+#if defined(__alpha__) || defined(__x86_64__)
 	return ftape_timestamp();
-#elif defined(__i386__) || defined(__x86_64__)
+#elif defined(__i386__)
 	unsigned int count;
  	unsigned long flags;
  
@@ -106,9 +120,9 @@
 
 static unsigned int diff(unsigned int t0, unsigned int t1)
 {
-#if defined(__alpha__)
-	return (t1 <= t0) ? t1 + (1UL << 32) - t0 : t1 - t0;
-#elif defined(__i386__) || defined(__x86_64__)
+#if defined(__alpha__) || defined(__x86_64__)
+	return (t1 - t0);
+#elif defined(__i386__)
 	/*
 	 * This is tricky: to work for both short and full ftape_timestamps
 	 * we'll have to discriminate between these.
@@ -122,9 +136,9 @@
 
 static unsigned int usecs(unsigned int count)
 {
-#if defined(__alpha__)
+#if defined(__alpha__) || defined(__x86_64__)
 	return (ps_per_cycle * count) / 1000000UL;
-#elif defined(__i386__) || defined(__x86_64__)
+#elif defined(__i386__)
 	return (10000 * count) / ((CLOCK_TICK_RATE + 50) / 100);
 #endif
 }
@@ -163,38 +177,13 @@
 
 static void init_clock(void)
 {
-#if defined(__i386__) || defined(__x86_64__)
-	unsigned int t;
-	int i;
 	TRACE_FUN(ft_t_any);
 
-	/*  Haven't studied on why, but there sometimes is a problem
-	 *  with the tick timer readout. The two bytes get swapped.
-	 *  This hack solves that problem by doing one extra input.
-	 */
-	for (i = 0; i < 1000; ++i) {
-		t = short_ftape_timestamp();
-		if (t > LATCH) {
-			inb_p(0x40);	/* get in sync again */
-			TRACE(ft_t_warn, "clock counter fixed");
-			break;
-		}
-	}
+#if defined(__x86_64__)
+	ps_per_cycle = 1000000000UL / cpu_khz;
 #elif defined(__alpha__)
-#if CONFIG_FT_ALPHA_CLOCK == 0
-#error You must define and set CONFIG_FT_ALPHA_CLOCK in 'make config' !
-#endif
 	extern struct hwrpb_struct *hwrpb;
-	TRACE_FUN(ft_t_any);
-
-	if (hwrpb->cycle_freq != 0) {
-		ps_per_cycle = (1000*1000*1000*1000UL) / hwrpb->cycle_freq;
-	} else {
-		/*
-		 * HELP:  Linux 2.0.x doesn't set cycle_freq on my noname !
-		 */
-		ps_per_cycle = (1000*1000*1000*1000UL) / CONFIG_FT_ALPHA_CLOCK;
-	}
+	ps_per_cycle = (1000*1000*1000*1000UL) / hwrpb->cycle_freq;
 #endif
 	TRACE_EXIT;
 }
@@ -213,7 +202,7 @@
 	unsigned int tc = 0;
 	unsigned int count;
 	unsigned int time;
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__i386__)
 	unsigned int old_tc = 0;
 	unsigned int old_count = 1;
 	unsigned int old_time = 1;
@@ -255,7 +244,7 @@
 		tc = (1000 * time) / (count - 1);
 		TRACE(ft_t_any, "once:%3d us,%6d times:%6d us, TC:%5d ns",
 			usecs(once), count - 1, usecs(multiple), tc);
-#if defined(__alpha__)
+#if defined(__alpha__) || defined(__x86_64__)
 		/*
 		 * Increase the calibration count exponentially until the
 		 * calibration time exceeds 100 ms.
@@ -263,7 +252,7 @@
 		if (time >= 100*1000) {
 			break;
 		}
-#elif defined(__i386__) || defined(__x86_64__)
+#elif defined(__i386__)
 		/*
 		 * increase the count until the resulting time nears 2/HZ,
 		 * then the tc will drop sharply because we lose LATCH counts.

--UlVJffcvxoiEqYs2--
