Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWHDD2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWHDD2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWHDD1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:27:38 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:25801 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1030319AbWHDD1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:27:36 -0400
Message-Id: <20060804032522.163918000@mvista.com>
References: <20060804032414.304636000@mvista.com>
User-Agent: quilt/0.45-1
Date: Thu, 03 Aug 2006 20:24:20 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 06/10] -mm  clocksource: add block notifier
Content-Disposition: inline; filename=clocksource_add_block_notify_on_new_clock.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a call back interface for register/rating change
events.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 include/linux/clocksource.h |    9 +++++++++
 kernel/time/clocksource.c   |   19 ++++++++++++++++++-
 kernel/timer.c              |   12 ++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

Index: linux-2.6.17/include/linux/clocksource.h
===================================================================
--- linux-2.6.17.orig/include/linux/clocksource.h
+++ linux-2.6.17/include/linux/clocksource.h
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
@@ -206,6 +213,8 @@ static inline void clocksource_calculate
 
 /* used to install a new clocksource */
 extern int clocksource_register(struct clocksource*);
+extern int clocksource_notifier_register(struct notifier_block*);
+extern int clocksource_notifier_unregister(struct notifier_block*);
 extern int clocksource_sysfs_register(struct sysdev_attribute*);
 extern void clocksource_sysfs_unregister(struct sysdev_attribute*);
 extern void clocksource_rating_change(struct clocksource*);
Index: linux-2.6.17/kernel/time/clocksource.c
===================================================================
--- linux-2.6.17.orig/kernel/time/clocksource.c
+++ linux-2.6.17/kernel/time/clocksource.c
@@ -44,6 +44,18 @@
 static struct plist_head clocksource_list =
 	PLIST_HEAD_INIT(clocksource_list, clocksource_lock);
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
@@ -135,6 +147,9 @@ int clocksource_register(struct clocksou
  		plist_add(&c->list, &clocksource_list);
 	}
 	spin_unlock_irqrestore(&clocksource_lock, flags);
+
+	atomic_notifier_call_chain(&clocksource_list_notifier,
+				   CLOCKSOURCE_NOTIFY_REGISTER, c);
 	return ret;
 }
 EXPORT_SYMBOL(clocksource_register);
@@ -162,7 +177,9 @@ void clocksource_rating_change(struct cl
 	plist_node_init(&c->list, CLOCKSOURCE_RATING(c->rating));
 	plist_add(&c->list, &clocksource_list);
 
-	/* XXX: Add block notifier to signal new rating */
+	atomic_notifier_call_chain(&clocksource_list_notifier,
+				   CLOCKSOURCE_NOTIFY_RATING, c);
+
 	spin_unlock_irqrestore(&clocksource_lock, flags);
 }
 EXPORT_SYMBOL(clocksource_rating_change);
Index: linux-2.6.17/kernel/timer.c
===================================================================
--- linux-2.6.17.orig/kernel/timer.c
+++ linux-2.6.17/kernel/timer.c
@@ -1030,6 +1030,17 @@ static int __init boot_override_clocksou
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
 #define change_clocksource(x)	do { 0; } while(0)
 #endif
@@ -1120,6 +1131,7 @@ static int __init timekeeping_init_devic
 
 #ifdef CONFIG_GENERIC_TIME
 	atomic_inc(&clock_check);
+	clocksource_notifier_register(&clocksource_nb);
 	clocksource_sysfs_register(&attr_timeofday_clocksource);
 #endif
 	return error;

--
