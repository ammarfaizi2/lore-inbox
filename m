Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUIDSGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUIDSGK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 14:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUIDSGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 14:06:09 -0400
Received: from ozlabs.org ([203.10.76.45]:36547 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265230AbUIDSDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 14:03:23 -0400
Date: Sun, 5 Sep 2004 03:57:37 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: levon@movementarian.org, phil.el@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: [PATCH] Speed up oprofile buffer drain code
Message-ID: <20040904175737.GE7716@krispykreme>
References: <20040904174403.GC7716@krispykreme> <20040904174642.GD7716@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904174642.GD7716@krispykreme>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I noticed a large machine was doing about 400,000 context switches per
second when oprofile was enabled. Upon closer inspection it looks like
we were rearming the buffer sync timer without modifying the expire
time.

Now that we have schedule_delayed_work_on I believe we can remove the
timer completely. Each cpu should be offset by 1 jiffy so they dont
all fire at the same time. I bumped DEFAULT_TIMER_EXPIRE from 2 to 10 
times a second to be sure we reap cpu buffers.

With the following patch the same large machine gets about 4000 context
switches per second.

John does this look OK to you? The bump of DEFAULT_TIMER_EXPIRE was
pretty arbitrary, I was seeing dropped samples before but that could be
due to the timer storm before I converted it to delayed work.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN drivers/oprofile/cpu_buffer.c~oprofile_optimise drivers/oprofile/cpu_buffer.c
--- gr_work/drivers/oprofile/cpu_buffer.c~oprofile_optimise	2004-09-04 12:10:18.658740785 -0500
+++ gr_work-anton/drivers/oprofile/cpu_buffer.c	2004-09-04 12:10:18.673738407 -0500
@@ -28,8 +28,8 @@
 struct oprofile_cpu_buffer cpu_buffer[NR_CPUS] __cacheline_aligned;
 
 static void wq_sync_buffer(void *);
-static void timer_ping(unsigned long data);
-#define DEFAULT_TIMER_EXPIRE (HZ / 2)
+
+#define DEFAULT_TIMER_EXPIRE (HZ / 10)
 int timers_enabled;
 
 static void __free_cpu_buffers(int num)
@@ -64,10 +64,6 @@ int alloc_cpu_buffers(void)
 		b->sample_received = 0;
 		b->sample_lost_overflow = 0;
 		b->cpu = i;
-		init_timer(&b->timer);
-		b->timer.function = timer_ping;
-		b->timer.data = i;
-		b->timer.expires = jiffies + DEFAULT_TIMER_EXPIRE;
 		INIT_WORK(&b->work, wq_sync_buffer, b);
 	}
 	return 0;
@@ -93,7 +89,11 @@ void start_cpu_timers(void)
 	for_each_online_cpu(i) {
 		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
 
-		add_timer_on(&b->timer, i);
+		/*
+		 * Spread the work by 1 jiffy per cpu so they dont all 
+		 * fire at once.
+		 */
+		schedule_delayed_work_on(i, &b->work, DEFAULT_TIMER_EXPIRE + i);
 	}
 }
 
@@ -107,7 +107,7 @@ void end_cpu_timers(void)
 	for_each_online_cpu(i) {
 		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
 
-		del_timer_sync(&b->timer);
+		cancel_delayed_work(&b->work);
 	}
 
 	flush_scheduled_work();
@@ -203,7 +203,13 @@ void cpu_buffer_reset(struct oprofile_cp
 }
 
 
-/* FIXME: not guaranteed to be on our CPU */
+/*
+ * This serves to avoid cpu buffer overflow, and makes sure
+ * the task mortuary progresses
+ *
+ * By using schedule_delayed_work_on and then schedule_delayed_work
+ * we guarantee this will stay on the correct cpu
+ */
 static void wq_sync_buffer(void * data)
 {
 	struct oprofile_cpu_buffer * b = (struct oprofile_cpu_buffer *)data;
@@ -213,24 +219,7 @@ static void wq_sync_buffer(void * data)
 	}
 	sync_buffer(b->cpu);
 
-	/* don't re-add the timer if we're shutting down */
-	if (timers_enabled) {
-		del_timer_sync(&b->timer);
-		add_timer_on(&b->timer, b->cpu);
-	}
-}
-
-
-/* This serves to avoid cpu buffer overflow, and makes sure
- * the task mortuary progresses
- */
-static void timer_ping(unsigned long data)
-{
-	struct oprofile_cpu_buffer * b = &cpu_buffer[data];
-	if (b->cpu != smp_processor_id()) {
-		printk("Timer on CPU%d, prefer CPU%d\n",
-		       smp_processor_id(), b->cpu);
-	}
-	schedule_work(&b->work);
-	/* work will re-enable our timer */
+	/* don't re-add the work if we're shutting down */
+	if (timers_enabled)
+		schedule_delayed_work(&b->work, DEFAULT_TIMER_EXPIRE);
 }
diff -puN drivers/oprofile/cpu_buffer.h~oprofile_optimise drivers/oprofile/cpu_buffer.h
--- gr_work/drivers/oprofile/cpu_buffer.h~oprofile_optimise	2004-09-04 12:10:18.662740151 -0500
+++ gr_work-anton/drivers/oprofile/cpu_buffer.h	2004-09-04 12:10:18.674738249 -0500
@@ -12,7 +12,6 @@
 
 #include <linux/types.h>
 #include <linux/spinlock.h>
-#include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/cache.h>
  
@@ -42,7 +41,6 @@ struct oprofile_cpu_buffer {
 	unsigned long sample_received;
 	unsigned long sample_lost_overflow;
 	int cpu;
-	struct timer_list timer;
 	struct work_struct work;
 } ____cacheline_aligned;
 
_
