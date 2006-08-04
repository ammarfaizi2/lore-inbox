Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWHDD0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWHDD0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWHDD0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:26:22 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:11465 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1030309AbWHDDZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:25:40 -0400
Message-Id: <20060804032521.814001000@mvista.com>
References: <20060804032414.304636000@mvista.com>
User-Agent: quilt/0.45-1
Date: Thu, 03 Aug 2006 20:24:19 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 05/10] -mm  clocksource: convert generic timeofday
Content-Disposition: inline; filename=clocksource_more_generic.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch shifts some of the code around so that the time 
of day override happens inside kernel/timer.c.

The biggest timeofday changes are in update_wall_time() and
change_clocksource(). I removed the unconditional call to 
change_clocksource(), and replaced it with a single atomic
check. The atomic is asserted only when a clock change is
needed. update_callback is no longer driven from 
update_wall_time().

The fast path is now a single atomic check.


Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 include/linux/clocksource.h |    2 
 kernel/time/clocksource.c   |  183 +++++---------------------------------------
 kernel/timer.c              |  162 +++++++++++++++++++++++++++++++++-----
 3 files changed, 164 insertions(+), 183 deletions(-)

Index: linux-2.6.17/include/linux/clocksource.h
===================================================================
--- linux-2.6.17.orig/include/linux/clocksource.h
+++ linux-2.6.17/include/linux/clocksource.h
@@ -206,6 +206,8 @@ static inline void clocksource_calculate
 
 /* used to install a new clocksource */
 extern int clocksource_register(struct clocksource*);
+extern int clocksource_sysfs_register(struct sysdev_attribute*);
+extern void clocksource_sysfs_unregister(struct sysdev_attribute*);
 extern void clocksource_rating_change(struct clocksource*);
 extern struct clocksource * clocksource_get_clock(char*);
 
Index: linux-2.6.17/kernel/time/clocksource.c
===================================================================
--- linux-2.6.17.orig/kernel/time/clocksource.c
+++ linux-2.6.17/kernel/time/clocksource.c
@@ -5,6 +5,8 @@
  *
  * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
  *
+ * Copyright (C) 2006 MontaVista Daniel Walker (dwalker@mvista.com)
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -21,7 +23,6 @@
  *
  * TODO WishList:
  *   o Allow clocksource drivers to be unregistered
- *   o get rid of clocksource_jiffies extern
  */
 
 #include <linux/clocksource.h>
@@ -29,51 +30,20 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
-/* XXX - Would like a better way for initializing curr_clocksource */
-extern struct clocksource clocksource_jiffies;
-
 /*
  * Internally used to invert the rating, so lower is better.
  */
 #define CLOCKSOURCE_RATING(x)	(INT_MAX-x)
 
 /*[Clocksource internal variables]---------
- * curr_clocksource:
- *	currently selected clocksource. Initialized to clocksource_jiffies.
- * next_clocksource:
- *	pending next selected clocksource.
  * clocksource_list:
  *	priority list with the registered clocksources
  * clocksource_lock:
- *	protects manipulations to curr_clocksource and next_clocksource
- *	and the clocksource_list
- * override_name:
- *	Name of the user-specified clocksource.
+ * 	protects manipulations to the clocksource_list
  */
-static struct clocksource *curr_clocksource = &clocksource_jiffies;
-static struct clocksource *next_clocksource;
 static struct plist_head clocksource_list =
 	PLIST_HEAD_INIT(clocksource_list, clocksource_lock);
 static DEFINE_SPINLOCK(clocksource_lock);
-static char override_name[32];
-
-/**
- * clocksource_get_next - Returns the selected clocksource
- *
- */
-struct clocksource *clocksource_get_next(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&clocksource_lock, flags);
-	if (next_clocksource) {
-		curr_clocksource = next_clocksource;
-		next_clocksource = NULL;
-	}
-	spin_unlock_irqrestore(&clocksource_lock, flags);
-
-	return curr_clocksource;
-}
 
 /**
  * __is_registered - Returns a clocksource if it's registered
@@ -139,24 +109,6 @@ struct clocksource * clocksource_get_clo
 	return ret;
 }
 
-
-/**
- * select_clocksource - Finds the best registered clocksource.
- *
- * Private function. Must hold clocksource_lock when called.
- *
- * Looks through the list of registered clocksources, returning
- * the one with the highest rating value. If there is a clocksource
- * name that matches the override string, it returns that clocksource.
- */
-static struct clocksource *select_clocksource(void)
-{
-	if (!*override_name)
-		return plist_first_entry(&clocksource_list, struct clocksource,
-					 list);
-	return get_clock(override_name);
-}
-
 /**
  * clocksource_register - Used to install new clocksources
  * @t:		clocksource to be registered
@@ -181,8 +133,6 @@ int clocksource_register(struct clocksou
 	} else {
 		plist_node_init(&c->list, CLOCKSOURCE_RATING(c->rating));
  		plist_add(&c->list, &clocksource_list);
-		/* scan the registered clocksources, and pick the best one */
-		next_clocksource = select_clocksource();
 	}
 	spin_unlock_irqrestore(&clocksource_lock, flags);
 	return ret;
@@ -212,70 +162,12 @@ void clocksource_rating_change(struct cl
 	plist_node_init(&c->list, CLOCKSOURCE_RATING(c->rating));
 	plist_add(&c->list, &clocksource_list);
 
-	next_clocksource = select_clocksource();
+	/* XXX: Add block notifier to signal new rating */
 	spin_unlock_irqrestore(&clocksource_lock, flags);
 }
 EXPORT_SYMBOL(clocksource_rating_change);
 
 /**
- * sysfs_show_current_clocksources - sysfs interface for current clocksource
- * @dev:	unused
- * @buf:	char buffer to be filled with clocksource list
- *
- * Provides sysfs interface for listing current clocksource.
- */
-static ssize_t
-sysfs_show_current_clocksources(struct sys_device *dev, char *buf)
-{
-	char *curr = buf;
-
-	spin_lock_irq(&clocksource_lock);
-	curr += sprintf(curr, "%s ", curr_clocksource->name);
-	spin_unlock_irq(&clocksource_lock);
-
-	curr += sprintf(curr, "\n");
-
-	return curr - buf;
-}
-
-/**
- * sysfs_override_clocksource - interface for manually overriding clocksource
- * @dev:	unused
- * @buf:	name of override clocksource
- * @count:	length of buffer
- *
- * Takes input from sysfs interface for manually overriding the default
- * clocksource selction.
- */
-static ssize_t sysfs_override_clocksource(struct sys_device *dev,
-					  const char *buf, size_t count)
-{
-	size_t ret = count;
-	/* strings from sysfs write are not 0 terminated! */
-	if (count >= sizeof(override_name))
-		return -EINVAL;
-
-	/* strip of \n: */
-	if (buf[count-1] == '\n')
-		count--;
-	if (count < 1)
-		return -EINVAL;
-
-	spin_lock_irq(&clocksource_lock);
-
-	/* copy the name given: */
-	memcpy(override_name, buf, count);
-	override_name[count] = 0;
-
-	/* try to select it: */
-	next_clocksource = select_clocksource();
-
-	spin_unlock_irq(&clocksource_lock);
-
-	return ret;
-}
-
-/**
  * sysfs_show_available_clocksources - sysfs interface for listing clocksource
  * @dev:	unused
  * @buf:	char buffer to be filled with clocksource list
@@ -304,11 +196,8 @@ sysfs_show_available_clocksources(struct
 }
 
 /*
- * Sysfs setup bits:
+ * Generic sysfs setup bits:
  */
-static SYSDEV_ATTR(current_clocksource, 0600, sysfs_show_current_clocksources,
-		   sysfs_override_clocksource);
-
 static SYSDEV_ATTR(available_clocksource, 0600,
 		   sysfs_show_available_clocksources, NULL);
 
@@ -321,6 +210,21 @@ static struct sys_device device_clocksou
 	.cls	= &clocksource_sysclass,
 };
 
+/**
+ * clocksource_sysfs_register - interface to register a sysfs
+ *				hook under the clocksource sys_device.
+ * @attr:	sysdev_attribute created with the SYSDEV_ATTR macro.
+ *
+ * This functions should be used to create a sysfs file under
+ * the clocksource directory which will be used to show the current
+ * clock used by the code calling clocksource_sysfs_register(), and
+ * set a specific overide when written to.
+ */
+int clocksource_sysfs_register(struct sysdev_attribute * attr)
+{
+	return sysdev_create_file(&device_clocksource, attr);
+}
+
 static int __init init_clocksource_sysfs(void)
 {
 	int error = sysdev_class_register(&clocksource_sysclass);
@@ -330,52 +234,7 @@ static int __init init_clocksource_sysfs
 	if (!error)
 		error = sysdev_create_file(
 				&device_clocksource,
-				&attr_current_clocksource);
-	if (!error)
-		error = sysdev_create_file(
-				&device_clocksource,
 				&attr_available_clocksource);
 	return error;
 }
-
-device_initcall(init_clocksource_sysfs);
-
-/**
- * boot_override_clocksource - boot clock override
- * @str:	override name
- *
- * Takes a clocksource= boot argument and uses it
- * as the clocksource override name.
- */
-static int __init boot_override_clocksource(char* str)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&clocksource_lock, flags);
-	if (str)
-		strlcpy(override_name, str, sizeof(override_name));
-	spin_unlock_irqrestore(&clocksource_lock, flags);
-	return 1;
-}
-
-__setup("clocksource=", boot_override_clocksource);
-
-/**
- * boot_override_clock - Compatibility layer for deprecated boot option
- * @str:	override name
- *
- * DEPRECATED! Takes a clock= boot argument and uses it
- * as the clocksource override name
- */
-static int __init boot_override_clock(char* str)
-{
-	if (!strcmp(str, "pmtmr")) {
-		printk("Warning: clock=pmtmr is deprecated. "
-			"Use clocksource=acpi_pm.\n");
-		return boot_override_clocksource("acpi_pm");
-	}
-	printk("Warning! clock= boot option is deprecated. "
-		"Use clocksource=xyz\n");
-	return boot_override_clocksource(str);
-}
-
-__setup("clock=", boot_override_clock);
+postcore_initcall(init_clocksource_sysfs);
Index: linux-2.6.17/kernel/timer.c
===================================================================
--- linux-2.6.17.orig/kernel/timer.c
+++ linux-2.6.17/kernel/timer.c
@@ -17,6 +17,8 @@
  *  2000-10-05  Implemented scalable SMP per-CPU timer handling.
  *                              Copyright (C) 2000, 2001, 2002  Ingo Molnar
  *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
+ *  2006-08-03  Added usage of the generic clocksource API
+ *				Copyright (C) 2006 MontaVista, Daniel Walker
  */
 
 #include <linux/kernel_stat.h>
@@ -788,9 +790,15 @@ u64 current_tick_length(void)
 
 /* XXX - all of this timekeeping code should be later moved to time.c */
 #include <linux/clocksource.h>
-static struct clocksource *clock; /* pointer to current clocksource */
+/* pointer to current clocksource */
+static struct clocksource *clock = &clocksource_jiffies;
+static char clock_override_name[32];
+
+/* Interrupt update singaling variables */
+static atomic_t clock_check = ATOMIC_INIT(0);
 
 #ifdef CONFIG_GENERIC_TIME
+
 /**
  * __get_nsec_offset - Returns nanoseconds since last call to periodic_hook
  *
@@ -910,29 +918,120 @@ EXPORT_SYMBOL(do_settimeofday);
  *
  * Accumulates current time interval and initializes new clocksource
  */
-static int change_clocksource(void)
+static int change_clocksource(char * override)
 {
-	struct clocksource *new;
-	cycle_t now;
 	u64 nsec;
-	new = clocksource_get_next();
-	if (clock != new) {
-		now = clocksource_read(new);
-		nsec =  __get_nsec_offset();
-		timespec_add_ns(&xtime, nsec);
-
-		clock = new;
-		clock->cycle_last = now;
-		printk(KERN_INFO "Time: %s clocksource has been installed.\n",
-		       clock->name);
-		return 1;
-	} else if (clock->update_callback) {
-		return clock->update_callback();
+	cycle_t now;
+	struct clocksource *new = clocksource_get_clock(override);
+
+	now = clocksource_read(new);
+	nsec =  __get_nsec_offset();
+	timespec_add_ns(&xtime, nsec);
+
+	clock = new;
+	clock->cycle_last = now;
+	printk(KERN_INFO "Time: %s clocksource has been installed.\n",
+	       clock->name);
+
+	return 1;
+}
+
+/**
+ * sysfs_show_current_clocksources - sysfs interface for current clocksource
+ * @dev:	unused
+ * @buf:	char buffer to be filled with clocksource list
+ *
+ * Provides sysfs interface for listing the current clocksource.
+ * Locking handled inside sysfs.
+ */
+static ssize_t
+sysfs_show_current_clocksources(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "%s \n", clock->name);
+}
+
+/**
+ * sysfs_override_clocksource - interface for manually overriding clocksource
+ * @dev:	unused
+ * @buf:	name of override clocksource
+ * @count:	length of buffer
+ *
+ * Takes input from sysfs interface for manually overriding the default
+ * clocksource selction. Locking handled inside sysfs
+ */
+static ssize_t sysfs_override_clocksource(struct sys_device *dev,
+					  const char *buf, size_t count)
+{
+	size_t ret = count;
+
+	/*
+	 * If there's already an update in progress then
+	 * we can't proceed.
+	 */
+	if (atomic_read(&clock_check))
+		return -EINVAL;
+
+	/* strings from sysfs write are not 0 terminated! */
+	if (count >= sizeof(clock_override_name))
+		return -EINVAL;
+
+	/* strip of \n: */
+	if (buf[count-1] == '\n')
+		count--;
+	if (count < 1)
+		return -EINVAL;
+
+	/* copy the name given: */
+	memcpy(clock_override_name, buf, count);
+	clock_override_name[count] = 0;
+
+	if (!clocksource_get_clock(clock_override_name)) {
+		clock_override_name[0] = 0;
+		return  -EINVAL;
 	}
-	return 0;
+
+	atomic_inc(&clock_check);
+
+	return ret;
 }
+
+/*
+ * Sysfs atrribure structure.
+ */
+static SYSDEV_ATTR(timeofday_clocksource, 0600, sysfs_show_current_clocksources,
+		   sysfs_override_clocksource);
+
+/**
+ * boot_override_clocksource - boot clock override
+ * @str:	override name
+ *
+ * Takes a clocksource= boot argument and uses it
+ * as the clocksource override name.
+ */
+static int __init boot_override_clocksource(char* str)
+{
+	if (str) {
+		/*
+		 * Make sure the clock exists.
+		 */
+		if (clocksource_get_clock(str))
+			strlcpy(clock_override_name, str,
+				sizeof(clock_override_name));
+		else {
+			printk("Time: requested clock \"%s\" doesn't exist\n",
+			       str);
+			return 0;
+		}
+	}
+	/* Signal the interrupt to update. */
+	atomic_inc(&clock_check);
+
+	return 1;
+}
+__setup("timeofday_clocksource=", boot_override_clocksource);
+
 #else
-#define change_clocksource()	do { 0; } while(0)
+#define change_clocksource(x)	do { 0; } while(0)
 #endif
 
 /**
@@ -961,7 +1060,7 @@ void __init timekeeping_init(void)
 	unsigned long flags;
 
 	write_seqlock_irqsave(&xtime_lock, flags);
-	clock = clocksource_get_next();
+	clock = clocksource_get_best_clock();
 	clocksource_calculate_interval(clock, tick_nsec);
 	clock->cycle_last = clocksource_read(clock);
 	ntp_clear();
@@ -1018,6 +1117,11 @@ static int __init timekeeping_init_devic
 	int error = sysdev_class_register(&timekeeping_sysclass);
 	if (!error)
 		error = sysdev_register(&device_timer);
+
+#ifdef CONFIG_GENERIC_TIME
+	atomic_inc(&clock_check);
+	clocksource_sysfs_register(&attr_timeofday_clocksource);
+#endif
 	return error;
 }
 
@@ -1161,10 +1265,26 @@ static void update_wall_time(void)
 	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
 
 	/* check to see if there is a new clocksource to use */
-	if (change_clocksource()) {
+	if (unlikely(atomic_read(&clock_check))) {
+
+		/*
+		 * Switch to the new override clock, or the highest
+		 * rated clock.
+		 */
+		if (*clock_override_name)
+			change_clocksource(clock_override_name);
+		else
+			change_clocksource(NULL);
+
 		clock->error = 0;
 		clock->xtime_nsec = 0;
 		clocksource_calculate_interval(clock, tick_nsec);
+
+		/*
+		 * Remove the change signal
+		 */
+		atomic_dec(&clock_check);
+
 	}
 }
 

--
