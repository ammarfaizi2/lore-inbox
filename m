Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbVLGWNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbVLGWNJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbVLGWNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:13:09 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56013 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030382AbVLGWNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:13:07 -0500
Message-ID: <43975E6D.9000301@watson.ibm.com>
Date: Wed, 07 Dec 2005 22:13:01 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
Subject: [RFC][Patch 1/5] nanosecond timestamps and diffs
References: <43975D45.3080801@watson.ibm.com>
In-Reply-To: <43975D45.3080801@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel utility functions for
- nanosecond resolution timestamps, adjusted for lost ticks
- interval (diff) between two such timestamps, in nanoseconds, adjusting
  for overflow

The timestamp part of this patch is identical to the one proposed by
Matt Helsley (as part of adding timestamps to process event connectors)
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0512.0/1373.html

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/time.h |   16 ++++++++++++++++
 kernel/time.c        |   22 ++++++++++++++++++++++
 2 files changed, 38 insertions(+)

Index: linux-2.6.15-rc5/include/linux/time.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/time.h
+++ linux-2.6.15-rc5/include/linux/time.h
@@ -95,6 +95,7 @@ struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue);
 extern int do_getitimer(int which, struct itimerval *value);
 extern void getnstimeofday (struct timespec *tv);
+extern void getnstimestamp(struct timespec *ts);

 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);

@@ -113,6 +114,21 @@ set_normalized_timespec (struct timespec
 	ts->tv_nsec = nsec;
 }

+/*
+ * timespec_nsdiff - Return difference of two timestamps in nanoseconds
+ * In the rare case of @end being earlier than @start, return zero
+ */
+static inline unsigned long long
+timespec_nsdiff(struct timespec *start, struct timespec *end)
+{
+	long long ret;
+
+	ret = end->tv_sec*(1000000000) + end->tv_nsec;
+	ret -= start->tv_sec*(1000000000) + start->tv_nsec;
+	if (ret < 0)
+		return 0;
+	return ret;
+}
 #endif /* __KERNEL__ */

 #define NFDBITS			__NFDBITS
Index: linux-2.6.15-rc5/kernel/time.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/time.c
+++ linux-2.6.15-rc5/kernel/time.c
@@ -561,6 +561,28 @@ void getnstimeofday(struct timespec *tv)
 EXPORT_SYMBOL_GPL(getnstimeofday);
 #endif

+void getnstimestamp(struct timespec *ts)
+{
+	unsigned int seq;
+	struct timespec wall2mono;
+
+	/* synchronize with settimeofday() changes */
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		getnstimeofday(ts);
+		wall2mono = wall_to_monotonic;
+	} while(unlikely(read_seqretry(&xtime_lock, seq)));
+
+	/* adjust to monotonicaly-increasing values */
+	ts->tv_sec += wall2mono.tv_sec;
+	ts->tv_nsec += wall2mono.tv_nsec;
+	while (unlikely(ts->tv_nsec >= NSEC_PER_SEC)) {
+		ts->tv_nsec -= NSEC_PER_SEC;
+		ts->tv_sec++;
+	}
+}
+EXPORT_SYMBOL_GPL(getnstimestamp);
+
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {
