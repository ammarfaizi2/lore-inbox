Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422849AbWJFS6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422849AbWJFS6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422851AbWJFS6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:58:37 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:29987 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1422847AbWJFS6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:58:02 -0400
Message-Id: <20061006185456.995993000@mvista.com>
References: <20061006185439.667702000@mvista.com>
User-Agent: quilt/0.45-1
Date: Fri, 06 Oct 2006 11:54:45 -0700
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 06/10] -mm: clocksource: add block notifier
Content-Disposition: inline; filename=clocksource_add_block_notify_on_new_clock.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a call back interface for register/rating change
events.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 include/linux/clocksource.h |    8 ++++++++
 kernel/time/clocksource.c   |   19 ++++++++++++++++++-
 kernel/timer.c              |   12 ++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

Index: linux-2.6.18/include/linux/clocksource.h
===================================================================
--- linux-2.6.18.orig/include/linux/clocksource.h
+++ linux-2.6.18/include/linux/clocksource.h
@@ -14,6 +14,7 @@
 #include <linux/list.h>
 #include <linux/plist.h>
 #include <linux/sysdev.h>
+#include <linux/notifier.h>
 #include <asm/div64.h>
 #include <asm/io.h>
 
@@ -26,6 +27,12 @@ typedef u64 cycle_t;
  */
 extern struct clocksource clocksource_jiffies;
 
+/*
+ * Block notifier flags.
+ */
+#define CLOCKSOURCE_NOTIFY_REGISTER	1
+#define CLOCKSOURCE_NOTIFY_RATING	2
+
 /**
  * struct clocksource - hardware abstraction for a free running counter
  *	Provides mostly state-free accessors to the underlying hardware.
@@ -205,6 +212,7 @@ static inline void clocksource_calculate
 
 
 /* used to install a new clocksource */
+extern int clocksource_notifier_register(struct notifier_block*);
 extern int clocksource_sysfs_register(struct sysdev_attribute*);
 extern void clocksource_sysfs_unregister(struct sysdev_attribute*);
 extern int clocksource_register(struct clocksource*);
Index: linux-2.6.18/kernel/time/clocksource.c
===================================================================
--- linux-2.6.18.orig/kernel/time/clocksource.c
+++ linux-2.6.18/kernel/time/clocksource.c
@@ -39,6 +39,18 @@
 static __read_mostly
 struct list_head clocksource_list = LIST_HEAD_INIT(clocksource_list);
 static DEFINE_SPINLOCK(clocksource_lock);
+static ATOMIC_NOTIFIER_HEAD(clocksource_list_notifier);
+
+/**
+ * clocksource_notifier_register - Registers a list change notifier
+ * @nb:		pointer to a notifier block
+ *
+ * Returns zero always.
+ */
+int clocksource_notifier_register(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&clocksource_list_notifier, nb);
+}
 
 /**
  * __is_registered - Returns a clocksource if it's registered
@@ -139,6 +151,9 @@ int clocksource_register(struct clocksou
  		__sorted_list_add(c);
 	}
 	spin_unlock_irqrestore(&clocksource_lock, flags);
+
+	atomic_notifier_call_chain(&clocksource_list_notifier,
+ 				   CLOCKSOURCE_NOTIFY_REGISTER, c);
 	return ret;
 }
 EXPORT_SYMBOL(clocksource_register);
@@ -165,7 +180,9 @@ void clocksource_rating_change(struct cl
 	list_del_init(&c->list);
 	__sorted_list_add(c);
 
-	/* XXX: Add block notifier to signal new rating */
+	atomic_notifier_call_chain(&clocksource_list_notifier,
+				   CLOCKSOURCE_NOTIFY_RATING, c);
+
 	spin_unlock_irqrestore(&clocksource_lock, flags);
 }
 EXPORT_SYMBOL(clocksource_rating_change);
Index: linux-2.6.18/kernel/timer.c
===================================================================
--- linux-2.6.18.orig/kernel/timer.c
+++ linux-2.6.18/kernel/timer.c
@@ -819,6 +819,17 @@ static int __init boot_override_clocksou
 }
 __setup("timeofday_clocksource=", boot_override_clocksource);
 
+static int
+clocksource_callback(struct notifier_block *nb, unsigned long op, void *c)
+{
+	atomic_inc(&clock_check);
+	return 0;
+}
+
+static struct notifier_block clocksource_nb = {
+	.notifier_call = clocksource_callback,
+};
+
 #else
 #define change_clocksource(x)	do { } while(0)
 #endif
@@ -912,6 +923,7 @@ static int __init timekeeping_init_devic
 
 #ifdef CONFIG_GENERIC_TIME
 	clocksource_sysfs_register(&attr_timeofday_clocksource);
+	clocksource_notifier_register(&clocksource_nb);
 
 	/*
 	 * All the clocks should be registered at this point,

--

