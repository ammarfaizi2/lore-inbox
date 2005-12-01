Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVLAADy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVLAADy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbVK3X6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:21 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:48290
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751286AbVK3X5e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:34 -0500
Subject: [patch 13/43] Introduce nsec_t type and conversion functions
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:15 +0100
Message-Id: <1133395395.32542.456.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (nsec-t.patch)
- introduce the nsec_t type
- basic nsec conversion routines: timespec_to_ns(), timeval_to_ns(),
  ns_to_timespec(), ns_to_timeval().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/time.h |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/time.c        |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

Index: linux-2.6.15-rc2-rework/include/linux/time.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/time.h
+++ linux-2.6.15-rc2-rework/include/linux/time.h
@@ -50,6 +50,12 @@ extern void set_normalized_timespec(stru
 #define timespec_valid(ts) \
 	(((ts)->tv_sec >= 0) && (((unsigned) (ts)->tv_nsec) < NSEC_PER_SEC))
 
+/*
+ * 64-bit nanosec type. Large enough to span 292+ years in nanosecond
+ * resolution. Ought to be enough for a while.
+ */
+typedef s64 nsec_t;
+
 extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
 extern seqlock_t xtime_lock;
@@ -78,6 +84,47 @@ extern void getnstimeofday(struct timesp
 
 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);
 
+/**
+ * timespec_to_ns - Convert timespec to nanoseconds
+ * @ts:		pointer to the timespec variable to be converted
+ *
+ * Returns the scalar nanosecond representation of the timespec
+ * parameter.
+ */
+static inline nsec_t timespec_to_ns(const struct timespec *ts)
+{
+	return ((nsec_t) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
+}
+
+/**
+ * timeval_to_ns - Convert timeval to nanoseconds
+ * @ts:		pointer to the timeval variable to be converted
+ *
+ * Returns the scalar nanosecond representation of the timeval
+ * parameter.
+ */
+static inline nsec_t timeval_to_ns(const struct timeval *tv)
+{
+	return ((nsec_t) tv->tv_sec * NSEC_PER_SEC) +
+		tv->tv_usec * NSEC_PER_USEC;
+}
+
+/**
+ * ns_to_timespec - Convert nanoseconds to timespec
+ * @nsec:	the nanoseconds value to be converted
+ *
+ * Returns the timespec representation of the nsec parameter.
+ */
+extern struct timespec ns_to_timespec(const nsec_t nsec);
+
+/**
+ * ns_to_timeval - Convert nanoseconds to timeval
+ * @nsec:	the nanoseconds value to be converted
+ *
+ * Returns the timeval representation of the nsec parameter.
+ */
+extern struct timeval ns_to_timeval(const nsec_t nsec);
+
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS
Index: linux-2.6.15-rc2-rework/kernel/time.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/time.c
+++ linux-2.6.15-rc2-rework/kernel/time.c
@@ -630,6 +630,42 @@ void set_normalized_timespec(struct time
 	ts->tv_nsec = nsec;
 }
 
+/**
+ * ns_to_timespec - Convert nanoseconds to timespec
+ * @nsec:       the nanoseconds value to be converted
+ *
+ * Returns the timespec representation of the nsec parameter.
+ */
+inline struct timespec ns_to_timespec(const nsec_t nsec)
+{
+	struct timespec ts;
+
+	if (nsec)
+		ts.tv_sec = div_long_long_rem_signed(nsec, NSEC_PER_SEC,
+						     &ts.tv_nsec);
+	else
+		ts.tv_sec = ts.tv_nsec = 0;
+
+	return ts;
+}
+
+/**
+ * ns_to_timeval - Convert nanoseconds to timeval
+ * @nsec:       the nanoseconds value to be converted
+ *
+ * Returns the timeval representation of the nsec parameter.
+ */
+struct timeval ns_to_timeval(const nsec_t nsec)
+{
+	struct timespec ts = ns_to_timespec(nsec);
+	struct timeval tv;
+
+	tv.tv_sec = ts.tv_sec;
+	tv.tv_usec = (suseconds_t) ts.tv_nsec / 1000;
+
+	return tv;
+}
+
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {

--

