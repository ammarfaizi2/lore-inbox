Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUGLIi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUGLIi3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 04:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266761AbUGLIi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 04:38:29 -0400
Received: from holomorphy.com ([207.189.100.168]:8589 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266756AbUGLIiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 04:38:25 -0400
Date: Mon, 12 Jul 2004 01:38:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Instrumenting high latency
Message-ID: <20040712083820.GW21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
	linux-kernel@vger.kernel.org
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <20040712003418.02997a12.akpm@osdl.org> <20040712080259.GV21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712080259.GV21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 01:02:59AM -0700, William Lee Irwin III wrote:
> I suspect it's better to drop in hooks to trap those e.g. in
> cond_resched() and cond_resched_lock().

Something like this should do, modulo everything outside kernel/ and mm/.


Index: timing-2.6.7/include/linux/sched.h
===================================================================
--- timing-2.6.7.orig/include/linux/sched.h	2004-06-15 22:18:57.000000000 -0700
+++ timing-2.6.7/include/linux/sched.h	2004-07-12 01:17:32.000000000 -0700
@@ -1008,6 +1008,7 @@
 extern void __cond_resched(void);
 static inline void cond_resched(void)
 {
+	touch_preempt_timing();
 	if (need_resched())
 		__cond_resched();
 }
@@ -1022,6 +1023,7 @@
  */
 static inline void cond_resched_lock(spinlock_t * lock)
 {
+	touch_preempt_timing();
 	if (need_resched()) {
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
Index: timing-2.6.7/include/linux/preempt.h
===================================================================
--- timing-2.6.7.orig/include/linux/preempt.h	2004-07-11 04:33:55.000000000 -0700
+++ timing-2.6.7/include/linux/preempt.h	2004-07-12 01:18:17.000000000 -0700
@@ -12,7 +12,9 @@
 #ifdef CONFIG_PREEMPT_TIMING
 void __inc_preempt_count(void);
 void __dec_preempt_count(void);
+void touch_preempt_timing(void);
 #else
+#define touch_preempt_timing()	do { } while (0)
 #ifdef CONFIG_PREEMPT
 #define __inc_preempt_count()	do { preempt_count()++; } while (0)
 #define __dec_preempt_count()	do { preempt_count()--; } while (0)
Index: timing-2.6.7/arch/i386/kernel/traps.c
===================================================================
--- timing-2.6.7.orig/arch/i386/kernel/traps.c	2004-07-12 00:10:27.000000000 -0700
+++ timing-2.6.7/arch/i386/kernel/traps.c	2004-07-12 01:34:58.000000000 -0700
@@ -969,14 +969,24 @@
 }
 __setup("preempt_thresh=", setup_preempt_thresh);
 
+static void __touch_preempt_timing(void *addr)
+{
+	rdtscll(__get_cpu_var(preempt_timings));
+	__get_cpu_var(preempt_entry) = (unsigned long)addr;
+}
+
+void touch_preempt_timing(void)
+{
+	if (preempt_count() == 1 && system_state == SYSTEM_RUNNING)
+		__touch_preempt_timing(__builtin_return_address(0));
+}
+EXPORT_SYMBOL(touch_preempt_timing);
+
 void __inc_preempt_count(void)
 {
 	preempt_count()++;
-	if (preempt_count() == 1 && system_state == SYSTEM_RUNNING) {
-		rdtscll(__get_cpu_var(preempt_timings));
-		__get_cpu_var(preempt_entry)
-				= (unsigned long)__builtin_return_address(0);
-	}
+	if (preempt_count() == 1 && system_state == SYSTEM_RUNNING)
+		__touch_preempt_timing(__builtin_return_address(0));
 }
 EXPORT_SYMBOL(__inc_preempt_count);
 
Index: timing-2.6.7/mm/memory.c
===================================================================
--- timing-2.6.7.orig/mm/memory.c	2004-06-15 22:19:22.000000000 -0700
+++ timing-2.6.7/mm/memory.c	2004-07-12 01:27:32.000000000 -0700
@@ -558,6 +558,8 @@
 			zap_bytes -= block;
 			if ((long)zap_bytes > 0)
 				continue;
+			if (!atomic)
+				touch_preempt_timing();
 			if (!atomic && need_resched()) {
 				int fullmm = tlb_is_full_mm(*tlbp);
 				tlb_finish_mmu(*tlbp, tlb_start, start);
Index: timing-2.6.7/kernel/printk.c
===================================================================
--- timing-2.6.7.orig/kernel/printk.c	2004-06-15 22:20:26.000000000 -0700
+++ timing-2.6.7/kernel/printk.c	2004-07-12 01:28:04.000000000 -0700
@@ -650,6 +650,8 @@
  */
 void console_conditional_schedule(void)
 {
+	if (console_may_schedule)
+		touch_preempt_timing();
 	if (console_may_schedule && need_resched()) {
 		set_current_state(TASK_RUNNING);
 		schedule();
