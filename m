Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292305AbSBUB0u>; Wed, 20 Feb 2002 20:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292306AbSBUB0b>; Wed, 20 Feb 2002 20:26:31 -0500
Received: from zero.tech9.net ([209.61.188.187]:23559 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292305AbSBUB00>;
	Wed, 20 Feb 2002 20:26:26 -0500
Subject: [PATCH] 2.5: conditional schedules with a preemptive kernel
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kpreempt-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 20:26:31 -0500
Message-Id: <1014254791.18361.172.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

With a preemptive kernel, explicit conditional schedules when
preempt_count is zero are a waste of cycles and code size.  The attached
patch, against 2.5.5, implements variants of cond_resched() and
need_resched() that optimize away when CONFIG_PREEMPT is set.

This patch also converts some uses of cond_resched() and need_resched()
to the new __cond_resched() and __need_resched() methods.  These
codepaths have been heavily tested and a lock is _never_ held across
them.  Thus we guarantee the same scheduling semantics.

	Robert Love

diff -urN linux-2.5.5/Documentation/DocBook/kernel-hacking.tmpl linux/Documentation/DocBook/kernel-hacking.tmpl
--- linux-2.5.5/Documentation/DocBook/kernel-hacking.tmpl	Tue Feb 19 21:11:03 2002
+++ linux/Documentation/DocBook/kernel-hacking.tmpl	Wed Feb 20 19:10:46 2002
@@ -371,7 +371,16 @@
   </para>
 
   <programlisting>
-cond_resched(); /* Will sleep */ 
+cond_resched(); /* Will sleep */
+  </programlisting>
+
+  <para>
+  or, if you know the lock count is zero (and thus the kernel is
+  preemptible), don't waste the cycles:
+  </para>
+
+  <programlisting>
+__cond_resched(); /* Is not called if CONFIG_PREEMPT is set */
   </programlisting>
 
   <para>
diff -urN linux-2.5.5/drivers/char/random.c linux/drivers/char/random.c
--- linux-2.5.5/drivers/char/random.c	Tue Feb 19 21:10:55 2002
+++ linux/drivers/char/random.c	Wed Feb 20 19:35:24 2002
@@ -1308,9 +1308,10 @@
 		wake_up_interruptible(&random_write_wait);
 
 	r->extract_count += nbytes;
-	
+
 	ret = 0;
 	while (nbytes) {
+#ifndef CONFIG_PREEMPT
 		/*
 		 * Check if we need to break out or reschedule....
 		 */
@@ -1322,6 +1323,7 @@
 			}
 			schedule();
 		}
+#endif
 
 		/* Hash the pool to get the output */
 		tmp[0] = 0x67452301;
diff -urN linux-2.5.5/drivers/char/tty_io.c linux/drivers/char/tty_io.c
--- linux-2.5.5/drivers/char/tty_io.c	Tue Feb 19 21:11:04 2002
+++ linux/drivers/char/tty_io.c	Wed Feb 20 19:35:37 2002
@@ -712,7 +712,7 @@
 			ret = -ERESTARTSYS;
 			if (signal_pending(current))
 				break;
-			cond_resched();
+			__cond_resched();
 		}
 	}
 	if (written) {
diff -urN linux-2.5.5/fs/namei.c linux/fs/namei.c
--- linux-2.5.5/fs/namei.c	Tue Feb 19 21:11:00 2002
+++ linux/fs/namei.c	Wed Feb 20 19:36:01 2002
@@ -342,7 +342,7 @@
 		goto loop;
 	if (current->total_link_count >= 40)
 		goto loop;
-	if (need_resched()) {
+	if (__need_resched()) {
 		current->state = TASK_RUNNING;
 		schedule();
 	}
diff -urN linux-2.5.5/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.5/include/linux/sched.h	Tue Feb 19 21:10:55 2002
+++ linux/include/linux/sched.h	Wed Feb 20 19:41:30 2002
@@ -830,7 +830,22 @@
 {
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }
-  
+
+/*
+ * With a preemptible kernel, explicit conditional schedules
+ * when preempt_count is zero are a waste of cycles.  If you
+ * know the lock count is zero, use
+ * 	__cond_resched() instead of cond_resched() and
+ * 	__need_resched() instead of need_resched()
+ */
+#ifndef CONFIG_PREEMPT
+#define __cond_resched()	cond_resched()
+#define __need_resched()	need_resched()
+#else
+#define __cond_resched()	do { } while(0)
+#define __need_resched()	0
+#endif
+
 static inline int need_resched(void)
 {
 	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
diff -urN linux-2.5.5/kernel/softirq.c linux/kernel/softirq.c
--- linux-2.5.5/kernel/softirq.c	Tue Feb 19 21:10:58 2002
+++ linux/kernel/softirq.c	Wed Feb 20 18:08:09 2002
@@ -387,7 +387,7 @@
 
 		while (softirq_pending(cpu)) {
 			do_softirq();
-			cond_resched();
+			__cond_resched();
 		}
 
 		__set_current_state(TASK_INTERRUPTIBLE);
diff -urN linux-2.5.5/mm/filemap.c linux/mm/filemap.c
--- linux-2.5.5/mm/filemap.c	Tue Feb 19 21:11:00 2002
+++ linux/mm/filemap.c	Wed Feb 20 19:38:06 2002
@@ -401,7 +401,7 @@
 		}
 
 		page_cache_release(page);
-		if (need_resched()) {
+		if (__need_resched()) {
 			__set_current_state(TASK_RUNNING);
 			schedule();
 		}
diff -urN linux-2.5.5/mm/vmscan.c linux/mm/vmscan.c
--- linux-2.5.5/mm/vmscan.c	Tue Feb 19 21:10:56 2002
+++ linux/mm/vmscan.c	Wed Feb 20 19:07:58 2002
@@ -627,7 +627,7 @@
 
 	for (i = pgdat->nr_zones-1; i >= 0; i--) {
 		zone = pgdat->node_zones + i;
-		cond_resched();
+		__cond_resched();
 		if (!zone->need_balance)
 			continue;
 		if (!try_to_free_pages(zone, GFP_KSWAPD, 0)) {


