Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVLAAHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVLAAHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVLAAGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:06:32 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:1443
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751312AbVK3X6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:20 -0500
Subject: [patch 25/43] Create ktimeout.h and move timer.h code into it
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:48 +0100
Message-Id: <1133395428.32542.468.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-h.patch)
- introduce ktimeout.h and move the timeout implementation into it, as-is.
- keep timer.h for compatibility

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |  100 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/timer.h    |   96 +--------------------------------------------
 2 files changed, 103 insertions(+), 93 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- /dev/null
+++ linux/include/linux/ktimeout.h
@@ -0,0 +1,100 @@
+#ifndef _LINUX_KTIMEOUT_H
+#define _LINUX_KTIMEOUT_H
+
+#include <linux/config.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/stddef.h>
+
+struct timer_base_s;
+
+struct timer_list {
+	struct list_head entry;
+	unsigned long expires;
+
+	void (*function)(unsigned long);
+	unsigned long data;
+
+	struct timer_base_s *base;
+};
+
+extern struct timer_base_s __init_timer_base;
+
+#define TIMER_INITIALIZER(_function, _expires, _data) {		\
+		.function = (_function),			\
+		.expires = (_expires),				\
+		.data = (_data),				\
+		.base = &__init_timer_base,			\
+	}
+
+#define DEFINE_TIMER(_name, _function, _expires, _data)		\
+	struct timer_list _name =				\
+		TIMER_INITIALIZER(_function, _expires, _data)
+
+void fastcall init_timer(struct timer_list * timer);
+
+static inline void setup_timer(struct timer_list * timer,
+				void (*function)(unsigned long),
+				unsigned long data)
+{
+	timer->function = function;
+	timer->data = data;
+	init_timer(timer);
+}
+
+/***
+ * timer_pending - is a timer pending?
+ * @timer: the timer in question
+ *
+ * timer_pending will tell whether a given timer is currently pending,
+ * or not. Callers must ensure serialization wrt. other operations done
+ * to this timer, eg. interrupt contexts, or other CPUs on SMP.
+ *
+ * return value: 1 if the timer is pending, 0 if not.
+ */
+static inline int timer_pending(const struct timer_list * timer)
+{
+	return timer->entry.next != NULL;
+}
+
+extern void add_timer_on(struct timer_list *timer, int cpu);
+extern int del_timer(struct timer_list * timer);
+extern int __mod_timer(struct timer_list *timer, unsigned long expires);
+extern int mod_timer(struct timer_list *timer, unsigned long expires);
+
+extern unsigned long next_timer_interrupt(void);
+
+/***
+ * add_timer - start a timer
+ * @timer: the timer to be added
+ *
+ * The kernel will do a ->function(->data) callback from the
+ * timer interrupt at the ->expired point in the future. The
+ * current time is 'jiffies'.
+ *
+ * The timer's ->expired, ->function (and if the handler uses it, ->data)
+ * fields must be set prior calling this function.
+ *
+ * Timers with an ->expired field in the past will be executed in the next
+ * timer tick.
+ */
+static inline void add_timer(struct timer_list *timer)
+{
+	BUG_ON(timer_pending(timer));
+	__mod_timer(timer, timer->expires);
+}
+
+#ifdef CONFIG_SMP
+  extern int try_to_del_timer_sync(struct timer_list *timer);
+  extern int del_timer_sync(struct timer_list *timer);
+#else
+# define try_to_del_timer_sync(t)	del_timer(t)
+# define del_timer_sync(t)		del_timer(t)
+#endif
+
+#define del_singleshot_timer_sync(t) del_timer_sync(t)
+
+extern void init_timers(void);
+extern void run_local_timers(void);
+
+#endif
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -1,101 +1,11 @@
 #ifndef _LINUX_TIMER_H
 #define _LINUX_TIMER_H
 
-#include <linux/config.h>
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <linux/stddef.h>
-
-struct timer_base_s;
-
-struct timer_list {
-	struct list_head entry;
-	unsigned long expires;
-
-	void (*function)(unsigned long);
-	unsigned long data;
-
-	struct timer_base_s *base;
-};
-
-extern struct timer_base_s __init_timer_base;
-
-#define TIMER_INITIALIZER(_function, _expires, _data) {		\
-		.function = (_function),			\
-		.expires = (_expires),				\
-		.data = (_data),				\
-		.base = &__init_timer_base,			\
-	}
-
-#define DEFINE_TIMER(_name, _function, _expires, _data)		\
-	struct timer_list _name =				\
-		TIMER_INITIALIZER(_function, _expires, _data)
-
-void fastcall init_timer(struct timer_list * timer);
-
-static inline void setup_timer(struct timer_list * timer,
-				void (*function)(unsigned long),
-				unsigned long data)
-{
-	timer->function = function;
-	timer->data = data;
-	init_timer(timer);
-}
-
-/***
- * timer_pending - is a timer pending?
- * @timer: the timer in question
- *
- * timer_pending will tell whether a given timer is currently pending,
- * or not. Callers must ensure serialization wrt. other operations done
- * to this timer, eg. interrupt contexts, or other CPUs on SMP.
- *
- * return value: 1 if the timer is pending, 0 if not.
- */
-static inline int timer_pending(const struct timer_list * timer)
-{
-	return timer->entry.next != NULL;
-}
-
-extern void add_timer_on(struct timer_list *timer, int cpu);
-extern int del_timer(struct timer_list * timer);
-extern int __mod_timer(struct timer_list *timer, unsigned long expires);
-extern int mod_timer(struct timer_list *timer, unsigned long expires);
-
-extern unsigned long next_timer_interrupt(void);
-
-/***
- * add_timer - start a timer
- * @timer: the timer to be added
- *
- * The kernel will do a ->function(->data) callback from the
- * timer interrupt at the ->expired point in the future. The
- * current time is 'jiffies'.
- *
- * The timer's ->expired, ->function (and if the handler uses it, ->data)
- * fields must be set prior calling this function.
- *
- * Timers with an ->expired field in the past will be executed in the next
- * timer tick.
+/*
+ * This file is a compatibility placeholder - it will go away.
  */
-static inline void add_timer(struct timer_list *timer)
-{
-	BUG_ON(timer_pending(timer));
-	__mod_timer(timer, timer->expires);
-}
-
-#ifdef CONFIG_SMP
-  extern int try_to_del_timer_sync(struct timer_list *timer);
-  extern int del_timer_sync(struct timer_list *timer);
-#else
-# define try_to_del_timer_sync(t)	del_timer(t)
-# define del_timer_sync(t)		del_timer(t)
-#endif
-
-#define del_singleshot_timer_sync(t) del_timer_sync(t)
+#include <linux/ktimeout.h>
 
-extern void init_timers(void);
-extern void run_local_timers(void);
 extern int it_real_fn(void *);
 
 #endif

--

