Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVKODbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVKODbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVKODbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:31:13 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:26293 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932350AbVKODaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:30:55 -0500
Message-ID: <4379659E.90905@watson.ibm.com>
Date: Mon, 14 Nov 2005 23:35:42 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 2/4] Delay accounting: Block I/O delays
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-blkio.patch

Record time spent by a task waiting to queue and complete block I/O.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/delayacct.h |   16 +++++++++++++++-
 include/linux/sched.h     |    2 ++
 kernel/sched.c            |    7 +++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

Index: linux-2.6.14/include/linux/delayacct.h
===================================================================
--- linux-2.6.14.orig/include/linux/delayacct.h
+++ linux-2.6.14/include/linux/delayacct.h
@@ -43,6 +43,19 @@ static inline void delayacct_timestamp(u
 #define test_ts_integrity(start_ts, end_ts)  (1)
 #endif

+static inline void delayacct_blkio(unsigned long long ts)
+{
+	unsigned long long now = sched_clock();
+
+	if (!test_ts_integrity(ts, now))
+		return;
+
+	spin_lock(&current->delays.lock);
+	current->delays.blkio_delay += now - ts;
+	current->delays.blkio_count++;
+	spin_unlock(&current->delays.lock);
+}
+
 #else

 static inline void delayacct_init(struct task_struct *tsk)
@@ -50,7 +63,8 @@ static inline void delayacct_init(struct
 #define delayacct_def_var(ts)
 static inline void delayacct_timestamp(unsigned long long *ts)
 {}
-
+static inline void delayacct_blkio(unsigned long long ts)
+{}
 #endif /* CONFIG_DELAY_ACCT */


Index: linux-2.6.14/include/linux/sched.h
===================================================================
--- linux-2.6.14.orig/include/linux/sched.h
+++ linux-2.6.14/include/linux/sched.h
@@ -502,6 +502,8 @@ struct task_delay_info {
 	spinlock_t	lock;

 	/* Add stats in pairs: uint64_t delay, uint32_t count */
+	uint64_t blkio_delay;	/* wait for block io completion */
+	uint32_t blkio_count;
 };
 #endif

Index: linux-2.6.14/kernel/sched.c
===================================================================
--- linux-2.6.14.orig/kernel/sched.c
+++ linux-2.6.14/kernel/sched.c
@@ -47,6 +47,7 @@
 #include <linux/syscalls.h>
 #include <linux/times.h>
 #include <linux/acct.h>
+#include <linux/delayacct.h>
 #include <asm/tlb.h>

 #include <asm/unistd.h>
@@ -4083,10 +4084,13 @@ EXPORT_SYMBOL(yield);
 void __sched io_schedule(void)
 {
 	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
+	delayacct_def_var(ts);

+	delayacct_timestamp(&ts);
 	atomic_inc(&rq->nr_iowait);
 	schedule();
 	atomic_dec(&rq->nr_iowait);
+	delayacct_blkio(ts);
 }

 EXPORT_SYMBOL(io_schedule);
@@ -4095,10 +4099,13 @@ long __sched io_schedule_timeout(long ti
 {
 	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
 	long ret;
+	delayacct_def_var(ts);

+	delayacct_timestamp(&ts);
 	atomic_inc(&rq->nr_iowait);
 	ret = schedule_timeout(timeout);
 	atomic_dec(&rq->nr_iowait);
+	delayacct_blkio(ts);
 	return ret;
 }

