Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267781AbUGWQAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267781AbUGWQAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 12:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUGWP6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:58:22 -0400
Received: from fmr06.intel.com ([134.134.136.7]:28803 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267808AbUGWPlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:41:17 -0400
Date: Fri, 23 Jul 2004 08:49:36 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 10/11: Modifications to the core: struct timeout
Message-ID: <0407230849.IbGdeaVc4cHb1asaZc5cubdcLdZaaaCb17066@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0407230849.XbjdYbRaAasd1aIaAbkbWb3asaLdbaLb17066@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define a generic way to specifcy timeouts, either relative or
absolute, in jiffies or 'struct timespec'. As well, define a
variant of schedule_timeout() that takes this new struct.

This allows userspace to follow POSIX more effectively. Most
POSIX timeouts are absolute, so it is pointless to go to the
kernel, ask for the time, compute a relative sleep and go to
the kernel to block.

aio defines an 'struct timeout' -- as it is specific to it,
inside it's .c file, renamed it to aio_timeout to avoid
conflict with the wider 'struct timeout' we introduce.


 fs/aio.c             |   12 +++---
 include/linux/time.h |   47 +++++++++++++++++++++++++-
 kernel/timer.c       |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 142 insertions(+), 8 deletions(-)

--- include/linux/time.h:1.1.1.4 Tue Apr 6 00:23:00 2004
+++ include/linux/time.h Thu Jun 10 20:40:42 2004
@@ -22,11 +22,38 @@
 	int	tz_dsttime;	/* type of dst correction */
 };
 
+/** Flags for 'struct timeout' */
+enum {
+	/** Time is specified in jiffies, as a timespec otherwise. */
+	TIMEOUT_USE_JIFFIES = 0x1,
+	/** Timeout is relative to the current clock source time. */
+	TIMEOUT_RELATIVE = 0x2,
+};
+
+/**
+ * Generic timeout specification
+ *
+ * FIXME: this is kind of ugly to export to user space, as the jiffies
+ *        should not be in there...however, we want a single
+ *        interface. Reusing ts->tv_sec as jiffies is an option, but
+ *        it is ugly--unions are for that.
+ */
+struct timeout
+{
+	int flags;
+	clockid_t clock_id; /* Currently unused */
+	union {
+		struct timespec ts;
+		unsigned long jiffies;
+	};
+};
+
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
 #include <linux/timex.h>
+#include <linux/kernel.h>
 #include <asm/div64.h>
 #ifndef div_long_long_rem
 
@@ -189,7 +216,7 @@
  * value to a scaled second value.
  */
 static __inline__ unsigned long
-timespec_to_jiffies(struct timespec *value)
+timespec_to_jiffies(const struct timespec *value)
 {
 	unsigned long sec = value->tv_sec;
 	long nsec = value->tv_nsec + TICK_NSEC - 1;
@@ -259,6 +286,24 @@
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
 } 
 
+/** Adds @t1 and @t2 into @result, maintaining timespec semantics.
+ *
+ * Should work if any of the tv_sec is negative. Will crap if the
+ * added tv_nsec is negative.
+ */
+static inline
+void timespec_add (struct timespec *result,
+		   const struct timespec *t1, const struct timespec *t2) 
+{
+	result->tv_nsec = t1->tv_nsec + t2->tv_nsec;
+	result->tv_sec = t1->tv_sec + t2->tv_sec;
+	/* Assuming tv_nsec is always > 0 */
+	if (result->tv_nsec >= NSEC_PER_SEC) {
+		result->tv_sec += result->tv_nsec / NSEC_PER_SEC;
+		result->tv_nsec = result->tv_nsec % NSEC_PER_SEC;
+	}
+}
+
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
  * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
--- kernel/timer.c:1.1.1.13 Tue Apr 6 01:51:37 2004
+++ kernel/timer.c Wed Jul 7 18:30:29 2004
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
+#include <linux/fuqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/div64.h>
@@ -967,7 +968,9 @@
 
 static void process_timeout(unsigned long __data)
 {
-	wake_up_process((task_t *)__data);
+	struct task_struct *task = (task_t *) __data;
+	fuqueue_waiter_cancel(task, -ETIMEDOUT);
+	wake_up_process(task);
 }
 
 /**
@@ -1050,6 +1053,92 @@
 
 EXPORT_SYMBOL(schedule_timeout);
 
+/** @returns the absolute jiffies for a given absolute @timeout. */
+static inline
+unsigned long timeout_to_jiffies_abs (const struct timeout *timeout)
+{
+        unsigned long jiffies_abs, seq;
+        struct timespec oc, now;
+
+        if (timeout->flags & TIMEOUT_USE_JIFFIES)
+                jiffies_abs = timeout->jiffies;
+        else {
+                 do {
+                         seq = read_seqbegin(&xtime_lock);
+                         now = current_kernel_time();
+                         jiffies_abs = get_jiffies_64();
+                 } while (read_seqretry(&xtime_lock, seq));
+                oc = timeout->ts;
+                set_normalized_timespec(&oc, oc.tv_sec - now.tv_sec,
+                                        oc.tv_nsec - now.tv_nsec);
+                if (oc.tv_sec < 0)
+                        oc.tv_sec = oc.tv_nsec = 0;
+                jiffies_abs += timespec_to_jiffies(&oc)
+                        + (oc.tv_sec || oc.tv_nsec);
+        }
+        return jiffies_abs;
+}
+
+/** @returns the relative jiffies for a given relative @timeout. */
+static inline
+unsigned long timeout_to_jiffies_rel (const struct timeout *timeout)
+{
+	return timeout->flags & TIMEOUT_USE_JIFFIES?
+		timeout->jiffies : timespec_to_jiffies (&timeout->ts);
+}
+
+/**
+ * Wait for an amount of time, absolute or relative.
+ *
+ * @timeout: Pointer to an struct that describes the timeout. If it
+ *           equals '(struct timeout *) ~0', then it waits for ever. 
+ *
+ * timeout->flags &
+ *
+ *   TIMEOUT_RELATIVE means the timeout is relative to the current
+ *                    time. Otherwise is absolute.
+ *   TIMEOUT_USE_JIFFIES
+ *                    The timeout is specified as jiffies instead of a
+ *                    'struct timespec'.
+ *
+ * All times are currently based on CLOCK_REALTIME and the whole thing
+ * is not too precise, I am afraid. It doesn't take into account
+ * changes to CLOCK_REALTIME.
+ * 
+ * TODO:
+ *  - Lacks support for recalc of how much did we sleep if we were
+ *    interrupted (only needed for relative mode).
+ *  - Add support for other clock sources.
+ *
+ * Thanks to George Anzinger for coming out with the way to do it and
+ * to Boris Hu for fixing timespec_to_jiffies_abs() for accurate timings.
+ */ 
+void schedule_timeout_ext (const struct timeout *timeout)
+{
+	unsigned long jiffies_abs;
+	struct timer_list timer;
+	
+	if (timeout == (const struct timeout *) ~0) { /* Wait for ever */
+		schedule();
+		goto out;
+	}
+	jiffies_abs = timeout->flags & TIMEOUT_RELATIVE?
+		jiffies + timeout_to_jiffies_rel (timeout) 
+		: timeout_to_jiffies_abs (timeout);
+
+	init_timer (&timer);
+	timer.expires = jiffies_abs;
+	timer.data = (unsigned long) current;
+	timer.function = process_timeout;
+	add_timer (&timer);
+	schedule();
+	del_timer_sync (&timer);
+out:
+	return;
+}
+
+EXPORT_SYMBOL_GPL (schedule_timeout_ext);
+
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
--- fs/aio.c:1.1.1.7 Tue Apr 6 00:22:44 2004
+++ fs/aio.c Fri Jun 4 01:34:19 2004
@@ -750,7 +750,7 @@
 	return ret;
 }
 
-struct timeout {
+struct aio_timeout {
 	struct timer_list	timer;
 	int			timed_out;
 	struct task_struct	*p;
@@ -758,13 +758,13 @@
 
 static void timeout_func(unsigned long data)
 {
-	struct timeout *to = (struct timeout *)data;
+	struct aio_timeout *to = (struct aio_timeout *)data;
 
 	to->timed_out = 1;
 	wake_up_process(to->p);
 }
 
-static inline void init_timeout(struct timeout *to)
+static inline void init_timeout(struct aio_timeout *to)
 {
 	init_timer(&to->timer);
 	to->timer.data = (unsigned long)to;
@@ -773,7 +773,7 @@
 	to->p = current;
 }
 
-static inline void set_timeout(long start_jiffies, struct timeout *to,
+static inline void set_timeout(long start_jiffies, struct aio_timeout *to,
 			       const struct timespec *ts)
 {
 	unsigned long how_long;
@@ -791,7 +791,7 @@
 	add_timer(&to->timer);
 }
 
-static inline void clear_timeout(struct timeout *to)
+static inline void clear_timeout(struct aio_timeout *to)
 {
 	del_timer_sync(&to->timer);
 }
@@ -807,7 +807,7 @@
 	int			ret;
 	int			i = 0;
 	struct io_event		ent;
-	struct timeout		to;
+	struct aio_timeout	to;
 
 	/* needed to zero any padding within an entry (there shouldn't be 
 	 * any, but C is fun!
