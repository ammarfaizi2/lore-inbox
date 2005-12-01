Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVK3X6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVK3X6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVK3X5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:57:40 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49826
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751291AbVK3X5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:38 -0500
Subject: [patch 14/43] Introduce ktime_t time format
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:18 +0100
Message-Id: <1133395398.32542.457.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktime-t.patch)
- introduce ktime_t: nanosecond-resolution time format.

- eliminate the plain s64 scalar type, and always use the union.
  This simplifies the arithmetics. Idea from Roman Zippel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktime.h |  310 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 310 insertions(+)

Index: linux-2.6.15-rc2-rework/include/linux/ktime.h
===================================================================
--- /dev/null
+++ linux-2.6.15-rc2-rework/include/linux/ktime.h
@@ -0,0 +1,310 @@
+/*
+ *  include/linux/ktime.h
+ *
+ *  ktime_t - nanosecond-resolution time format.
+ *
+ *   Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
+ *   Copyright(C) 2005, Red Hat, Inc., Ingo Molnar
+ *
+ *  data type definitions, declarations, prototypes and macros.
+ *
+ *  Started by: Thomas Gleixner and Ingo Molnar
+ *
+ *  For licencing details see kernel-base/COPYING
+ */
+#ifndef _LINUX_KTIME_H
+#define _LINUX_KTIME_H
+
+#include <linux/time.h>
+#include <linux/jiffies.h>
+
+/*
+ * ktime_t:
+ *
+ * On 64-bit CPUs a single 64-bit variable is used to store the ktimers
+ * internal representation of time values in scalar nanoseconds. The
+ * design plays out best on 64-bit CPUs, where most conversions are
+ * NOPs and most arithmetic ktime_t operations are plain arithmetic
+ * operations.
+ *
+ * On 32-bit CPUs an optimized representation of the timespec structure
+ * is used to avoid expensive conversions from and to timespecs. The
+ * endian-aware order of the tv struct members is choosen to allow
+ * mathematical operations on the tv64 member of the union too, which
+ * for certain operations produces better code.
+ *
+ * For architectures with efficient support for 64/32-bit conversions the
+ * plain scalar nanosecond based representation can be selected by the
+ * config switch CONFIG_KTIME_SCALAR.
+ */
+typedef union {
+	s64	tv64;
+#if BITS_PER_LONG != 64 && !defined(CONFIG_KTIME_SCALAR)
+	struct {
+# ifdef __BIG_ENDIAN
+	s32	sec, nsec;
+# else
+	s32	nsec, sec;
+# endif
+	} tv;
+#endif
+} ktime_t;
+
+#define KTIME_MAX			(~((u64)1 << 63))
+
+/*
+ * ktime_t definitions when using the 64-bit scalar representation:
+ */
+
+#if (BITS_PER_LONG == 64) || defined(CONFIG_KTIME_SCALAR)
+
+/* Define a ktime_t variable and initialize it to zero: */
+#define DEFINE_KTIME(kt)		ktime_t kt = { .tv64 = 0 }
+
+/**
+ * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
+ *
+ * @secs:	seconds to set
+ * @nsecs:	nanoseconds to set
+ *
+ * Return the ktime_t representation of the value
+ */
+static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
+{
+	return (ktime_t) { .tv64 = (s64)secs * NSEC_PER_SEC + (s64)nsecs };
+}
+
+/*
+ * The following 3 macros are used for the nanosleep restart handling
+ * to store the "low" and "high" part of a 64-bit ktime variable.
+ * (on 32-bit CPUs the restart block has 32-bit fields, so we have to
+ *  split the 64-bit value up into two pieces)
+ *
+ * In the scalar representation we have to split up the 64-bit scalar:
+ */
+
+/* Set the "low" and "high" part of a ktime_t variable: */
+static inline ktime_t
+ktime_set_low_high(const unsigned long low, const unsigned long high)
+{
+	return (ktime_t) { .tv64 = (s64)low | ((s64)high << 32) };
+}
+
+/* Get the "low" part of a ktime_t variable: */
+#define ktime_get_low(kt)		((kt).tv64 & 0xFFFFFFFF)
+
+/* Get the "high" part of a ktime_t variable: */
+#define ktime_get_high(kt)		((kt).tv64 >> 32)
+
+/* Subtract two ktime_t variables. rem = lhs -rhs: */
+#define ktime_sub(lhs, rhs) \
+		({ (ktime_t){ .tv64 = (lhs).tv64 - (rhs).tv64 }; })
+
+/* Add two ktime_t variables. res = lhs + rhs: */
+#define ktime_add(lhs, rhs) \
+		({ (ktime_t){ .tv64 = (lhs).tv64 + (rhs).tv64 }; })
+
+/*
+ * Add a ktime_t variable and a scalar nanosecond value.
+ * res = kt + nsval:
+ */
+#define ktime_add_ns(kt, nsval) \
+		({ (ktime_t){ .tv64 = (kt).tv64 + (nsval) }; })
+
+/* convert a timespec to ktime_t format: */
+#define timespec_to_ktime(ts)		ktime_set((ts).tv_sec, (ts).tv_nsec)
+
+/* convert a timeval to ktime_t format: */
+#define timeval_to_ktime(tv)		ktime_set((tv).tv_sec, (tv).tv_usec * 1000)
+
+/* Map the ktime_t to timespec conversion to ns_to_timespec function */
+#define ktime_to_timespec(kt)		ns_to_timespec((kt).tv64)
+
+/* Map the ktime_t to timeval conversion to ns_to_timeval function */
+#define ktime_to_timeval(kt)		ns_to_timeval((kt).tv64)
+
+/* Map the ktime_t to clock_t conversion to the inline in jiffies.h: */
+#define ktime_to_clock_t(kt)		nsec_to_clock_t((kt).tv64)
+
+/* Convert ktime_t to nanoseconds - NOP in the scalar storage format: */
+#define ktime_to_ns(kt)			((kt).tv64)
+
+#else
+
+/*
+ * Helper macros/inlines to get the ktime_t math right in the timespec
+ * representation. The macros are sometimes ugly - their actual use is
+ * pretty okay-ish, given the circumstances. We do all this for
+ * performance reasons. The pure scalar nsec_t based code was nice and
+ * simple, but created too many 64-bit / 32-bit conversions and divisions.
+ *
+ * Be especially aware that negative values are represented in a way
+ * that the tv.sec field is negative and the tv.nsec field is greater
+ * or equal to zero but less than nanoseconds per second. This is the
+ * same representation which is used by timespecs.
+ *
+ *   tv.sec < 0 and 0 >= tv.nsec < NSEC_PER_SEC
+ */
+
+/* Define a ktime_t variable and initialize it to zero: */
+#define DEFINE_KTIME(kt)		ktime_t kt = { .tv64 = 0 }
+
+/* Set a ktime_t variable to a value in sec/nsec representation: */
+static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
+{
+	return (ktime_t) { .tv = { .sec = secs, .nsec = nsecs } };
+}
+
+/*
+ * The following 3 macros are used for the nanosleep restart handling
+ * to store the "low" and "high" part of a 64-bit ktime variable.
+ * (on 32-bit CPUs the restart block has 32-bit fields, so we have to
+ *  split the 64-bit value up into two pieces)
+ *
+ * In the union type representation this is just storing and restoring
+ * the sec and nsec members of the tv structure:
+ */
+
+/* Set the "low" and "high" part of a ktime_t variable: */
+#define ktime_set_low_high(l, h)	ktime_set(h, l)
+
+/* Get the "low" part of a ktime_t variable: */
+#define ktime_get_low(kt)		(kt).tv.nsec
+
+/* Get the "high" part of a ktime_t variable: */
+#define ktime_get_high(kt)		(kt).tv.sec
+
+/**
+ * ktime_sub - subtract two ktime_t variables
+ *
+ * @lhs:	minuend
+ * @rhs:	subtrahend
+ *
+ * Returns the remainder of the substraction
+ */
+static inline ktime_t ktime_sub(const ktime_t lhs, const ktime_t rhs)
+{
+	ktime_t res;
+
+	res.tv64 = lhs.tv64 - rhs.tv64;
+	if (res.tv.nsec < 0)
+		res.tv.nsec += NSEC_PER_SEC;
+
+	return res;
+}
+
+/**
+ * ktime_add - add two ktime_t variables
+ *
+ * @add1:	addend1
+ * @add2:	addend2
+ *
+ * Returns the sum of addend1 and addend2
+ */
+static inline ktime_t ktime_add(const ktime_t add1, const ktime_t add2)
+{
+	ktime_t res;
+
+	res.tv64 = add1.tv64 + add2.tv64;
+	/*
+	 * performance trick: the (u32) -NSEC gives 0x00000000Fxxxxxxx
+	 * so we subtract NSEC_PER_SEC and add 1 to the upper 32 bit.
+	 *
+	 * it's equivalent to:
+	 *   tv.nsec -= NSEC_PER_SEC
+	 *   tv.sec ++;
+	 */
+	if (res.tv.nsec >= NSEC_PER_SEC)
+		res.tv64 += (u32)-NSEC_PER_SEC;
+
+	return res;
+}
+
+/**
+ * ktime_add_ns - Add a scalar nanoseconds value to a ktime_t variable
+ *
+ * @kt:		addend
+ * @nsec:	the scalar nsec value to add
+ *
+ * Returns the sum of kt and nsec in ktime_t format
+ */
+extern ktime_t ktime_add_ns(const ktime_t kt, u64 nsec);
+
+/**
+ * timespec_to_ktime - convert a timespec to ktime_t format
+ *
+ * @ts:		the timespec variable to convert
+ *
+ * Returns a ktime_t variable with the converted timespec value
+ */
+static inline ktime_t timespec_to_ktime(const struct timespec ts)
+{
+	return (ktime_t) { .tv = { .sec = (s32)ts.tv_sec,
+			   	   .nsec = (s32)ts.tv_nsec } };
+}
+
+/**
+ * timeval_to_ktime - convert a timeval to ktime_t format
+ *
+ * @tv:		the timeval variable to convert
+ *
+ * Returns a ktime_t variable with the converted timeval value
+ */
+static inline ktime_t timeval_to_ktime(const struct timeval tv)
+{
+	return (ktime_t) { .tv = { .sec = (s32)tv.tv_sec,
+				   .nsec = (s32)tv.tv_usec * 1000 } };
+}
+
+/**
+ * ktime_to_timespec - convert a ktime_t variable to timespec format
+ *
+ * @kt:		the ktime_t variable to convert
+ *
+ * Returns the timespec representation of the ktime value
+ */
+static inline struct timespec ktime_to_timespec(const ktime_t kt)
+{
+	return (struct timespec) { .tv_sec = (time_t) kt.tv.sec,
+				   .tv_nsec = (long) kt.tv.nsec };
+}
+
+/**
+ * ktime_to_timeval - convert a ktime_t variable to timeval format
+ *
+ * @kt:		the ktime_t variable to convert
+ *
+ * Returns the timeval representation of the ktime value
+ */
+static inline struct timeval ktime_to_timeval(const ktime_t kt)
+{
+	return (struct timeval) {
+		.tv_sec = (time_t) kt.tv.sec,
+		.tv_usec = (suseconds_t) (kt.tv.nsec / NSEC_PER_USEC) };
+}
+
+/**
+ * ktime_to_clock_t - convert a ktime_t variable to clock_t format
+ * @kt:		the ktime_t variable to convert
+ *
+ * Returns a clock_t variable with the converted value
+ */
+static inline clock_t ktime_to_clock_t(const ktime_t kt)
+{
+	return nsec_to_clock_t( (u64) kt.tv.sec * NSEC_PER_SEC + kt.tv.nsec);
+}
+
+/**
+ * ktime_to_ns - convert a ktime_t variable to scalar nanoseconds
+ * @kt:		the ktime_t variable to convert
+ *
+ * Returns the scalar nanoseconds representation of kt
+ */
+static inline u64 ktime_to_ns(const ktime_t kt)
+{
+	return (u64) kt.tv.sec * NSEC_PER_SEC + kt.tv.nsec;
+}
+
+#endif
+
+#endif

--

