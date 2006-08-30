Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWH3Iky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWH3Iky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 04:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWH3Iky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 04:40:54 -0400
Received: from www.osadl.org ([213.239.205.134]:47021 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750703AbWH3Ikx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 04:40:53 -0400
Subject: [PATCH] prevent timespec/timeval to ktime_t overflow
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Frank v Waveren <fvw@var.cx>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 10:44:28 +0200
Message-Id: <1156927468.29250.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank v. Waveren pointed out that on 64bit machines the timespec to
ktime_t conversion might overflow. This is also true for timeval to
ktime_t conversions. This breaks a "sleep inf" on 64bit machines.

While a timespec/timeval with tx.sec = MAX_LONG is valid by
specification the internal representation of ktime_t is based on
nanoseconds. The conversion of seconds to nanoseconds overflows for
seconds values >= (MAX_LONG / NSEC_PER_SEC).

Check the seconds argument to the conversion and limit it to the maximum
time which can be represented by ktime_t.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index ed3396d..1beafb3 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -57,6 +57,7 @@ typedef union {
 } ktime_t;
 
 #define KTIME_MAX			(~((u64)1 << 63))
+#define KTIME_SEC_MAX			(KTIME_MAX / NSEC_PER_SEC)
 
 /*
  * ktime_t definitions when using the 64-bit scalar representation:
@@ -73,6 +74,10 @@ typedef union {
  */
 static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
 {
+#if (BITS_PER_LONG == 64)
+	if (unlikely(secs >= KTIME_SEC_MAX))
+		return (ktime_t){ .tv64 = KTIME_MAX };
+#endif
 	return (ktime_t) { .tv64 = (s64)secs * NSEC_PER_SEC + (s64)nsecs };
 }
 


