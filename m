Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVK3X5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVK3X5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVK3X5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:57:35 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:41890
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751291AbVK3X51
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:27 -0500
Subject: [patch 10/43] Coding style and white space cleanup posix-timer.h
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:08 +0100
Message-Id: <1133395388.32542.453.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (posix-timer-h-cleanup.patch)
- style/whitespace/macro cleanups of posix-timers.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/posix-timers.h |   78 +++++++++++++++++++++++--------------------
 1 files changed, 43 insertions(+), 35 deletions(-)

Index: linux-2.6.15-rc2-rework/include/linux/posix-timers.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/posix-timers.h
+++ linux-2.6.15-rc2-rework/include/linux/posix-timers.h
@@ -42,7 +42,7 @@ struct k_itimer {
 	timer_t it_id;			/* timer id */
 	int it_overrun;			/* overrun on pending signal  */
 	int it_overrun_last;		/* overrun on last delivered signal */
-	int it_requeue_pending;         /* waiting to requeue this timer */
+	int it_requeue_pending;		/* waiting to requeue this timer */
 #define REQUEUE_PENDING 1
 	int it_sigev_notify;		/* notify word of sigevent struct */
 	int it_sigev_signo;		/* signo word of sigevent struct */
@@ -52,8 +52,10 @@ struct k_itimer {
 	union {
 		struct {
 			struct timer_list timer;
-			struct list_head abs_timer_entry; /* clock abs_timer_list */
-			struct timespec wall_to_prev;   /* wall_to_monotonic used when set */
+			/* clock abs_timer_list: */
+			struct list_head abs_timer_entry;
+			/* wall_to_monotonic used when set: */
+			struct timespec wall_to_prev;
 			unsigned long incr; /* interval in jiffies */
 		} real;
 		struct cpu_timer_list cpu;
@@ -70,14 +72,16 @@ struct k_clock_abs {
 	struct list_head list;
 	spinlock_t lock;
 };
+
 struct k_clock {
-	int res;		/* in nano seconds */
+	int res;		/* in nanoseconds */
 	int (*clock_getres) (const clockid_t which_clock, struct timespec *tp);
 	struct k_clock_abs *abs_struct;
 	int (*clock_set) (const clockid_t which_clock, struct timespec * tp);
 	int (*clock_get) (const clockid_t which_clock, struct timespec * tp);
 	int (*timer_create) (struct k_itimer *timer);
-	int (*nsleep) (const clockid_t which_clock, int flags, struct timespec *);
+	int (*nsleep) (const clockid_t which_clock, int flags,
+		       struct timespec *);
 	int (*timer_set) (struct k_itimer * timr, int flags,
 			  struct itimerspec * new_setting,
 			  struct itimerspec * old_setting);
@@ -89,7 +93,7 @@ struct k_clock {
 
 void register_posix_clock(const clockid_t clock_id, struct k_clock *new_clock);
 
-/* Error handlers for timer_create, nanosleep and settime */
+/* error handlers for timer_create, nanosleep and settime */
 int do_posix_clock_notimer_create(struct k_itimer *timer);
 int do_posix_clock_nonanosleep(const clockid_t, int flags, struct timespec *);
 int do_posix_clock_nosettime(const clockid_t, struct timespec *tp);
@@ -101,39 +105,43 @@ struct now_struct {
 	unsigned long jiffies;
 };
 
-#define posix_get_now(now) (now)->jiffies = jiffies;
+#define posix_get_now(now) \
+	do { (now)->jiffies = jiffies; } while (0)
+
 #define posix_time_before(timer, now) \
                       time_before((timer)->expires, (now)->jiffies)
 
 #define posix_bump_timer(timr, now)					\
-         do {								\
-              long delta, orun;						\
-	      delta = now.jiffies - (timr)->it.real.timer.expires;	\
-              if (delta >= 0) {						\
-	           orun = 1 + (delta / (timr)->it.real.incr);		\
-	          (timr)->it.real.timer.expires +=			\
-			 orun * (timr)->it.real.incr;			\
-                  (timr)->it_overrun += orun;				\
-              }								\
-            }while (0)
-
-int posix_cpu_clock_getres(const clockid_t which_clock, struct timespec *);
-int posix_cpu_clock_get(const clockid_t which_clock, struct timespec *);
-int posix_cpu_clock_set(const clockid_t which_clock, const struct timespec *tp);
-int posix_cpu_timer_create(struct k_itimer *);
-int posix_cpu_nsleep(const clockid_t, int, struct timespec *);
-int posix_cpu_timer_set(struct k_itimer *, int,
-			struct itimerspec *, struct itimerspec *);
-int posix_cpu_timer_del(struct k_itimer *);
-void posix_cpu_timer_get(struct k_itimer *, struct itimerspec *);
-
-void posix_cpu_timer_schedule(struct k_itimer *);
-
-void run_posix_cpu_timers(struct task_struct *);
-void posix_cpu_timers_exit(struct task_struct *);
-void posix_cpu_timers_exit_group(struct task_struct *);
+	do {								\
+		long delta, orun;					\
+									\
+		delta = (now).jiffies - (timr)->it.real.timer.expires;	\
+		if (delta >= 0) {					\
+			orun = 1 + (delta / (timr)->it.real.incr);	\
+			(timr)->it.real.timer.expires +=		\
+				orun * (timr)->it.real.incr;		\
+			(timr)->it_overrun += orun;			\
+		}							\
+	} while (0)
+
+int posix_cpu_clock_getres(const clockid_t which_clock, struct timespec *ts);
+int posix_cpu_clock_get(const clockid_t which_clock, struct timespec *ts);
+int posix_cpu_clock_set(const clockid_t which_clock, const struct timespec *ts);
+int posix_cpu_timer_create(struct k_itimer *timer);
+int posix_cpu_nsleep(const clockid_t which_clock, int flags,
+		     struct timespec *ts);
+int posix_cpu_timer_set(struct k_itimer *timer, int flags,
+			struct itimerspec *new, struct itimerspec *old);
+int posix_cpu_timer_del(struct k_itimer *timer);
+void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec *itp);
+
+void posix_cpu_timer_schedule(struct k_itimer *timer);
+
+void run_posix_cpu_timers(struct task_struct *task);
+void posix_cpu_timers_exit(struct task_struct *task);
+void posix_cpu_timers_exit_group(struct task_struct *task);
 
-void set_process_cpu_timer(struct task_struct *, unsigned int,
-			   cputime_t *, cputime_t *);
+void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
+			   cputime_t *newval, cputime_t *oldval);
 
 #endif

--

