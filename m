Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbVKWKL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbVKWKL7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 05:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVKWKL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 05:11:59 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23757
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030375AbVKWKL6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 05:11:58 -0500
Subject: [PATCH -mm2] ktimers rounding fix
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 23 Nov 2005 11:17:04 +0100
Message-Id: <1132741024.32542.121.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The rounding for the 64bit scalar representation was taking only
the lower 32bit into account, which is wrong because 2^32 is not a
multiple of 10. The patch implements seperate ktime_modulo 
macros / functions for the hybrid and the scalar representation of
ktime_t.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.15-rc1-mm2/include/linux/ktime.h
===================================================================
--- linux-2.6.15-rc1-mm2.orig/include/linux/ktime.h
+++ linux-2.6.15-rc1-mm2/include/linux/ktime.h
@@ -133,6 +133,14 @@ typedef s64 ktime_t;
 /* Convert ktime_t to nanoseconds - NOP in the scalar storage format: */
 #define ktime_to_ns(kt)			(kt)
 
+#if (BITS_PER_LONG == 64)
+/*
+ * Calc ktime_t modulo div.
+ * div is less than NSEC_PER_SEC and (NSEC_PER_SEC % div) = 0 !
+ */
+#define ktime_modulo(kt, div)		(unsigned long)(kt % div)
+#endif
+
 #else
 
 /*
@@ -341,6 +349,12 @@ static inline u64 ktime_to_ns(ktime_t kt
 	return (u64) kt.tv.sec * NSEC_PER_SEC + kt.tv.nsec;
 }
 
+/*
+ * Calc ktime_t modulo div.
+ * div is less than NSEC_PER_SEC and (NSEC_PER_SEC % div) = 0 !
+ */
+#define ktime_modulo(kt, div)		((unsigned long)kt.tv.nsec % div)
+
 #endif
 
 /*
Index: linux-2.6.15-rc1-mm2/kernel/ktimers.c
===================================================================
--- linux-2.6.15-rc1-mm2.orig/kernel/ktimers.c
+++ linux-2.6.15-rc1-mm2/kernel/ktimers.c
@@ -243,8 +243,9 @@ lock_ktimer_base(struct ktimer *timer, u
  * Functions for the union type storage format of ktime_t which are
  * too large for inlining:
  */
-#if (BITS_PER_LONG < 64) && !defined(CONFIG_KTIME_SCALAR)
+#if (BITS_PER_LONG < 64)
 
+#ifndef CONFIG_KTIME_SCALAR
 /**
  * ktime_add_ns - Add a scalar nanoseconds value to a ktime_t variable
  *
@@ -267,6 +268,25 @@ ktime_t ktime_add_ns(ktime_t kt, u64 nse
 
 	return ktime_add(kt, tmp);
 }
+
+#else
+
+/**
+ * ktime_modulo - Calc ktime_t modulo div
+ *
+ * @kt:		dividend
+ * @div:	divisor
+ *
+ * Return ktime_t modulo div.
+ *
+ * div is less than NSEC_PER_SEC and (NSEC_PER_SEC % div) = 0 !
+ */
+static unsigned long ktime_modulo(ktime_t kt, unsigned long div)
+{
+	return do_div(kt, div);
+}
+
+#endif
 #endif
 
 /*
@@ -394,8 +414,7 @@ static int enqueue_ktimer(struct ktimer 
 	if (mode & KTIMER_ROUND) {
 		unsigned long rem;
 
-		rem = ((unsigned long)ktime_get_low(timer->expires)) %
-			base->resolution;
+		rem = ktime_modulo(timer->expires, base->resolution);
 		if (rem)
 			timer->expires = ktime_add_ns(timer->expires,
 						      base->resolution - rem);


