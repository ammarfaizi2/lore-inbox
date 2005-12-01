Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVLAAEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVLAAEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVLAADz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:03:55 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:6307
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751286AbVK3X6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:25 -0500
Subject: [patch 28/43] Convert ktimeout.h and create wrappers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:56 +0100
Message-Id: <1133395436.32542.471.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-new-apis.patch)
- convert ktimeout.h to use the ktimeout naming
- introduce compatibility wrapper defines in the timer.h code

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |   80 +++++++++++++++++++++++------------------------
 include/linux/timer.h    |   27 +++++++++++++++
 2 files changed, 66 insertions(+), 41 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -6,7 +6,7 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 
-struct timer_base_s;
+struct ktimeout_base_s;
 
 struct ktimeout {
 	struct list_head entry;
@@ -15,86 +15,86 @@ struct ktimeout {
 	void (*function)(unsigned long);
 	unsigned long data;
 
-	struct timer_base_s *base;
+	struct ktimeout_base_s *base;
 };
 
-extern struct timer_base_s __init_timer_base;
+extern struct ktimeout_base_s __init_ktimeout_base;
 
-#define TIMER_INITIALIZER(_function, _expires, _data) {		\
+#define KTIMEOUT_INITIALIZER(_function, _expires, _data) {	\
 		.function = (_function),			\
 		.expires = (_expires),				\
 		.data = (_data),				\
-		.base = &__init_timer_base,			\
+		.base = &__init_ktimeout_base,			\
 	}
 
-#define DEFINE_TIMER(_name, _function, _expires, _data)		\
-	struct ktimeout _name =				\
-		TIMER_INITIALIZER(_function, _expires, _data)
+#define DEFINE_KTIMEOUT(_name, _function, _expires, _data)	\
+	struct ktimeout _name =					\
+		KTIMEOUT_INITIALIZER(_function, _expires, _data)
 
-void fastcall init_timer(struct ktimeout * timer);
+void fastcall init_ktimeout(struct ktimeout * ktimeout);
 
-static inline void setup_timer(struct ktimeout * timer,
+static inline void setup_ktimeout(struct ktimeout * ktimeout,
 				void (*function)(unsigned long),
 				unsigned long data)
 {
-	timer->function = function;
-	timer->data = data;
-	init_timer(timer);
+	ktimeout->function = function;
+	ktimeout->data = data;
+	init_ktimeout(ktimeout);
 }
 
 /***
- * timer_pending - is a timer pending?
- * @timer: the timer in question
+ * ktimeout_pending - is a ktimeout pending?
+ * @ktimeout: the ktimeout in question
  *
- * timer_pending will tell whether a given timer is currently pending,
+ * ktimeout_pending will tell whether a given ktimeout is currently pending,
  * or not. Callers must ensure serialization wrt. other operations done
- * to this timer, eg. interrupt contexts, or other CPUs on SMP.
+ * to this ktimeout, eg. interrupt contexts, or other CPUs on SMP.
  *
- * return value: 1 if the timer is pending, 0 if not.
+ * return value: 1 if the ktimeout is pending, 0 if not.
  */
-static inline int timer_pending(const struct ktimeout * timer)
+static inline int ktimeout_pending(const struct ktimeout * ktimeout)
 {
-	return timer->entry.next != NULL;
+	return ktimeout->entry.next != NULL;
 }
 
-extern void add_timer_on(struct ktimeout *timer, int cpu);
-extern int del_timer(struct ktimeout * timer);
-extern int __mod_timer(struct ktimeout *timer, unsigned long expires);
-extern int mod_timer(struct ktimeout *timer, unsigned long expires);
+extern void add_ktimeout_on(struct ktimeout *ktimeout, int cpu);
+extern int del_ktimeout(struct ktimeout * ktimeout);
+extern int __mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires);
+extern int mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires);
 
-extern unsigned long next_timer_interrupt(void);
+extern unsigned long next_ktimeout_interrupt(void);
 
 /***
- * add_timer - start a timer
- * @timer: the timer to be added
+ * add_ktimeout - start a ktimeout
+ * @ktimeout: the ktimeout to be added
  *
  * The kernel will do a ->function(->data) callback from the
- * timer interrupt at the ->expired point in the future. The
+ * ktimeout interrupt at the ->expired point in the future. The
  * current time is 'jiffies'.
  *
- * The timer's ->expired, ->function (and if the handler uses it, ->data)
+ * The ktimeout's ->expired, ->function (and if the handler uses it, ->data)
  * fields must be set prior calling this function.
  *
  * Timers with an ->expired field in the past will be executed in the next
- * timer tick.
+ * ktimeout tick.
  */
-static inline void add_timer(struct ktimeout *timer)
+static inline void add_ktimeout(struct ktimeout *ktimeout)
 {
-	BUG_ON(timer_pending(timer));
-	__mod_timer(timer, timer->expires);
+	BUG_ON(ktimeout_pending(ktimeout));
+	__mod_ktimeout(ktimeout, ktimeout->expires);
 }
 
 #ifdef CONFIG_SMP
-  extern int try_to_del_timer_sync(struct ktimeout *timer);
-  extern int del_timer_sync(struct ktimeout *timer);
+  extern int try_to_del_ktimeout_sync(struct ktimeout *ktimeout);
+  extern int del_ktimeout_sync(struct ktimeout *ktimeout);
 #else
-# define try_to_del_timer_sync(t)	del_timer(t)
-# define del_timer_sync(t)		del_timer(t)
+# define try_to_del_ktimeout_sync(t)	del_ktimeout(t)
+# define del_ktimeout_sync(t)		del_ktimeout(t)
 #endif
 
-#define del_singleshot_timer_sync(t) del_timer_sync(t)
+#define del_singleshot_ktimeout_sync(t) del_ktimeout_sync(t)
 
-extern void init_timers(void);
-extern void run_local_timers(void);
+extern void init_ktimeouts(void);
+extern void run_local_ktimeouts(void);
 
 #endif
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -7,8 +7,33 @@
 /*
  * Compatibility define to turn 'struct timer_list' into 'struct ktimeout':
  */
-#define timer_list ktimeout
+#define timer_list			ktimeout
 
+#define timer_base_s			ktimeout_base_s
+#define __init_timer_base		__init_ktimeout_base
+/*
+ * Compatibility defines for the old timer APIs:
+ */
+#define TIMER_INITIALIZER		KTIMEOUT_INITIALIZER 
+#define DEFINE_TIMER			DEFINE_KTIMEOUT
+#define init_timer			init_ktimeout
+#define setup_timer			setup_ktimeout
+#define timer_pending			ktimeout_pending
+#define add_timer_on			add_ktimeout_on
+#define del_timer			del_ktimeout
+#define __mod_timer			__mod_ktimeout
+#define mod_timer			mod_ktimeout
+#define next_timer_interrupt		next_ktimeout_interrupt
+#define add_timer			add_ktimeout
+#define try_to_del_timer_sync		try_to_del_ktimeout_sync
+#define del_timer_sync			del_ktimeout_sync
+#define del_singleshot_timer_sync	del_singleshot_ktimeout_sync
+#define init_timers			init_ktimeouts
+#define run_local_timers		run_local_ktimeouts
+
+/*
+ * Pick up the timeout APIs:
+ */
 #include <linux/ktimeout.h>
 
 extern int it_real_fn(void *);

--

