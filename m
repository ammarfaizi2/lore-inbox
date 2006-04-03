Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWDCT4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWDCT4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 15:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWDCT4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 15:56:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:65512 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964864AbWDCT4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 15:56:00 -0400
Date: Mon, 3 Apr 2006 21:55:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] generic clocksource updates
Message-ID: <Pine.LNX.4.64.0604032155070.4707@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A number of changes to the clocksource infrastructur:
- use xtime_lock instead of clocksource_lock, so it's easier to
  synchronize the clocksource switch for gettimeofday.
- add a few clock state variables (instead of making them global).
- clocksource_get_nsec_offset(): this should become clocksource specific
  later.
- select_clocks: immediately switch clocksource.
- cleanup naming to put the subsystem name in front

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/clocksource.h |   33 +++++++-------
 kernel/Makefile             |    1 
 kernel/time/clocksource.c   |   99 +++++++++++++++++---------------------------
 kernel/time/jiffies.c       |   16 ++++---
 4 files changed, 67 insertions(+), 82 deletions(-)

Index: linux-2.6-mm/include/linux/clocksource.h
===================================================================
--- linux-2.6-mm.orig/include/linux/clocksource.h	2006-04-02 06:53:29.000000000 +0200
+++ linux-2.6-mm/include/linux/clocksource.h	2006-04-02 16:12:28.000000000 +0200
@@ -45,9 +45,8 @@ typedef u64 cycle_t;
  * @mult:		cycle to nanosecond multiplier
  * @shift:		cycle to nanosecond divisor (power of two)
  * @update_callback:	called when safe to alter clocksource values
- * @is_continuous:	defines if clocksource is free-running.
- * @interval_cycles:	Used internally by timekeeping core, please ignore.
- * @interval_snsecs:	Used internally by timekeeping core, please ignore.
+ * @cycle_update:	Used internally by timekeeping core, please ignore.
+ * @xtime_update:	Used internally by timekeeping core, please ignore.
  */
 struct clocksource {
 	char *name;
@@ -58,11 +57,11 @@ struct clocksource {
 	u32 mult;
 	u32 shift;
 	int (*update_callback)(void);
-	int is_continuous;
 
 	/* timekeeping specific data, ignore */
-	cycle_t interval_cycles;
-	u64 interval_snsecs;
+	u64 cycles_last, cycle_update;
+	u64 xtime_nsec, xtime_update;
+	s64 ntp_error;
 };
 
 
@@ -145,7 +144,7 @@ static inline s64 cyc2ns(struct clocksou
 }
 
 /**
- * calculate_clocksource_interval - Calculates a clocksource interval struct
+ * clocksource_calculate_interval - Calculates a clocksource interval struct
  *
  * @c:		Pointer to clocksource.
  * @length_nsec: Desired interval length in nanoseconds.
@@ -155,8 +154,8 @@ static inline s64 cyc2ns(struct clocksou
  *
  * Unless you're the timekeeping code, you should not be using this!
  */
-static inline void calculate_clocksource_interval(struct clocksource *c,
-						unsigned long length_nsec)
+static inline void clocksource_calculate_interval(struct clocksource *c,
+						  unsigned long length_nsec)
 {
 	u64 tmp;
 
@@ -166,16 +165,18 @@ static inline void calculate_clocksource
 	tmp += c->mult/2;
 	do_div(tmp, c->mult);
 
-	c->interval_cycles = (cycle_t)tmp;
-	if(c->interval_cycles == 0)
-		c->interval_cycles = 1;
+	c->cycle_update = (cycle_t)tmp;
+	if (c->cycle_update == 0)
+		c->cycle_update = 1;
 
-	c->interval_snsecs = (u64)c->interval_cycles * c->mult;
+	c->xtime_update = (u64)c->cycle_update * c->mult;
 }
 
 /* used to install a new clocksource */
-int register_clocksource(struct clocksource*);
-void reselect_clocksource(void);
-struct clocksource* get_next_clocksource(void);
+int clocksource_register(struct clocksource *);
+void clocksource_reselect(void);
+unsigned long clocksource_get_nsec_offset(struct clocksource *cs);
+
+extern struct clocksource *curr_clocksource;
 
 #endif /* _LINUX_CLOCKSOURCE_H */
Index: linux-2.6-mm/kernel/Makefile
===================================================================
--- linux-2.6-mm.orig/kernel/Makefile	2006-04-02 06:52:06.000000000 +0200
+++ linux-2.6-mm/kernel/Makefile	2006-04-02 16:11:03.000000000 +0200
@@ -10,6 +10,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
 	    hrtimer.o
 
+obj-y += time/
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
 obj-$(CONFIG_FUTEX) += futex.o
 ifeq ($(CONFIG_COMPAT),y)
Index: linux-2.6-mm/kernel/time/clocksource.c
===================================================================
--- linux-2.6-mm.orig/kernel/time/clocksource.c	2006-04-02 06:53:29.000000000 +0200
+++ linux-2.6-mm/kernel/time/clocksource.c	2006-04-02 16:11:28.000000000 +0200
@@ -35,57 +35,28 @@ extern struct clocksource clocksource_ji
 /*[Clocksource internal variables]---------
  * curr_clocksource:
  *	currently selected clocksource. Initialized to clocksource_jiffies.
- * next_clocksource:
- *	pending next selected clocksource.
  * clocksource_list:
  *	linked list with the registered clocksources
- * clocksource_lock:
- *	protects manipulations to curr_clocksource and next_clocksource
- *	and the clocksource_list
  * override_name:
  *	Name of the user-specified clocksource.
  */
-static struct clocksource *curr_clocksource = &clocksource_jiffies;
-static struct clocksource *next_clocksource;
+struct clocksource *curr_clocksource = &clocksource_jiffies;
 static LIST_HEAD(clocksource_list);
-static DEFINE_SPINLOCK(clocksource_lock);
 static char override_name[32];
-static int finished_booting;
 
-/* clocksource_done_booting - Called near the end of bootup
- *
- * Hack to avoid lots of clocksource churn at boot time
- */
-static int clocksource_done_booting(void)
+unsigned long clocksource_get_nsec_offset(struct clocksource *cs)
 {
-	finished_booting = 1;
-	return 0;
-}
+	cycle_t cycle_delta;
 
-late_initcall(clocksource_done_booting);
+	cycle_delta = (cs->read() - cs->cycles_last) & cs->mask;
 
-/**
- * get_next_clocksource - Returns the selected clocksource
- *
- */
-struct clocksource *get_next_clocksource(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&clocksource_lock, flags);
-	if (next_clocksource && finished_booting) {
-		curr_clocksource = next_clocksource;
-		next_clocksource = NULL;
-	}
-	spin_unlock_irqrestore(&clocksource_lock, flags);
-
-	return curr_clocksource;
+	return (cs->xtime_nsec + cycle_delta * cs->mult) >> cs->shift;
 }
 
 /**
  * select_clocksource - Finds the best registered clocksource.
  *
- * Private function. Must hold clocksource_lock when called.
+ * Private function. Must hold xtime_lock when called.
  *
  * Looks through the list of registered clocksources, returning
  * the one with the highest rating value. If there is a clocksource
@@ -114,6 +85,17 @@ static struct clocksource *select_clocks
 		 	best = src;
 	}
 
+	if (curr_clocksource != best) {
+		printk("switching to clocksource %s\n", best->name);
+		if (curr_clocksource)
+			xtime.tv_nsec = clocksource_get_nsec_offset(curr_clocksource);
+		best->ntp_error = 0;
+		best->cycles_last = best->read();
+		best->xtime_nsec = (u64)xtime.tv_nsec << best->shift;
+		clocksource_calculate_interval(best, tick_nsec);
+		curr_clocksource = best;
+	}
+
 	return best;
 }
 
@@ -121,7 +103,7 @@ static struct clocksource *select_clocks
  * is_registered_source - Checks if clocksource is registered
  * @c:		pointer to a clocksource
  *
- * Private helper function. Must hold clocksource_lock when called.
+ * Private helper function. Must hold xtime_lock when called.
  *
  * Returns one if the clocksource is already registered, zero otherwise.
  */
@@ -142,48 +124,45 @@ static int is_registered_source(struct c
 }
 
 /**
- * register_clocksource - Used to install new clocksources
+ * clocksource_register - Used to install new clocksources
  * @t:		clocksource to be registered
  *
  * Returns -EBUSY if registration fails, zero otherwise.
  */
-int register_clocksource(struct clocksource *c)
+int clocksource_register(struct clocksource *c)
 {
 	int ret = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&clocksource_lock, flags);
+	write_seqlock_irq(&xtime_lock);
 	/* check if clocksource is already registered */
 	if (is_registered_source(c)) {
-		printk("register_clocksource: Cannot register %s. "
+		printk("clocksource_register: Cannot register %s. "
 			"Already registered!", c->name);
 		ret = -EBUSY;
 	} else {
 		/* register it */
  		list_add(&c->list, &clocksource_list);
 		/* scan the registered clocksources, and pick the best one */
-		next_clocksource = select_clocksource();
+		select_clocksource();
 	}
-	spin_unlock_irqrestore(&clocksource_lock, flags);
+	write_sequnlock_irq(&xtime_lock);
 	return ret;
 }
 
-EXPORT_SYMBOL(register_clocksource);
+EXPORT_SYMBOL(clocksource_register);
 
 /**
- * reselect_clocksource - Rescan list for next clocksource
+ * clocksource_reselect - Rescan list for next clocksource
  *
  * A quick helper function to be used if a clocksource changes its
  * rating. Forces the clocksource list to be re-scaned for the best
  * clocksource.
  */
-void reselect_clocksource(void)
+void clocksource_reselect(void)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&clocksource_lock, flags);
-	next_clocksource = select_clocksource();
-	spin_unlock_irqrestore(&clocksource_lock, flags);
+	write_seqlock_irq(&xtime_lock);
+	select_clocksource();
+	write_sequnlock_irq(&xtime_lock);
 }
 
 /**
@@ -198,9 +177,9 @@ sysfs_show_current_clocksources(struct s
 {
 	char *curr = buf;
 
-	spin_lock_irq(&clocksource_lock);
+	write_seqlock_irq(&xtime_lock);
 	curr += sprintf(curr, "%s ", curr_clocksource->name);
-	spin_unlock_irq(&clocksource_lock);
+	write_sequnlock_irq(&xtime_lock);
 
 	curr += sprintf(curr, "\n");
 
@@ -230,16 +209,16 @@ static ssize_t sysfs_override_clocksourc
 	if (count < 1)
 		return -EINVAL;
 
-	spin_lock_irq(&clocksource_lock);
+	write_seqlock_irq(&xtime_lock);
 
 	/* copy the name given: */
 	memcpy(override_name, buf, count);
 	override_name[count] = 0;
 
 	/* try to select it: */
-	next_clocksource = select_clocksource();
+	select_clocksource();
 
-	spin_unlock_irq(&clocksource_lock);
+	write_sequnlock_irq(&xtime_lock);
 
 	return ret;
 }
@@ -257,14 +236,14 @@ sysfs_show_available_clocksources(struct
 	struct list_head *tmp;
 	char *curr = buf;
 
-	spin_lock_irq(&clocksource_lock);
+	write_seqlock_irq(&xtime_lock);
 	list_for_each(tmp, &clocksource_list) {
 		struct clocksource *src;
 
 		src = list_entry(tmp, struct clocksource, list);
 		curr += sprintf(curr, "%s ", src->name);
 	}
-	spin_unlock_irq(&clocksource_lock);
+	write_sequnlock_irq(&xtime_lock);
 
 	curr += sprintf(curr, "\n");
 
@@ -318,10 +297,10 @@ device_initcall(init_clocksource_sysfs);
 static int __init boot_override_clocksource(char* str)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&clocksource_lock, flags);
+	write_seqlock_irqsave(&xtime_lock, flags);
 	if (str)
 		strlcpy(override_name, str, sizeof(override_name));
-	spin_unlock_irqrestore(&clocksource_lock, flags);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
 	return 1;
 }
 
Index: linux-2.6-mm/kernel/time/jiffies.c
===================================================================
--- linux-2.6-mm.orig/kernel/time/jiffies.c	2006-04-02 06:53:29.000000000 +0200
+++ linux-2.6-mm/kernel/time/jiffies.c	2006-04-02 06:53:29.000000000 +0200
@@ -50,10 +50,7 @@
  */
 #define JIFFIES_SHIFT	8
 
-static cycle_t jiffies_read(void)
-{
-	return (cycle_t) jiffies;
-}
+static cycle_t jiffies_read(void);
 
 struct clocksource clocksource_jiffies = {
 	.name		= "jiffies",
@@ -62,12 +59,19 @@ struct clocksource clocksource_jiffies =
 	.mask		= 0xffffffff, /*32bits*/
 	.mult		= NSEC_PER_JIFFY << JIFFIES_SHIFT, /* details above */
 	.shift		= JIFFIES_SHIFT,
-	.is_continuous	= 0, /* tick based, not free running */
+
+	.cycle_update	= 1,
+	.xtime_update	= NSEC_PER_JIFFY << JIFFIES_SHIFT,
 };
 
+static cycle_t jiffies_read(void)
+{
+	return clocksource_jiffies.cycles_last + 1;
+}
+
 static int __init init_jiffies_clocksource(void)
 {
-	return register_clocksource(&clocksource_jiffies);
+	return clocksource_register(&clocksource_jiffies);
 }
 
 module_init(init_jiffies_clocksource);
