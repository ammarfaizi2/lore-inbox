Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266849AbUGLOcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266849AbUGLOcq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266851AbUGLOcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:32:46 -0400
Received: from holomorphy.com ([207.189.100.168]:46222 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266849AbUGLOcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:32:42 -0400
Date: Mon, 12 Jul 2004 07:32:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Instrumenting high latency
Message-ID: <20040712143234.GD21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
	linux-kernel@vger.kernel.org
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <20040712003418.02997a12.akpm@osdl.org> <20040712080259.GV21066@holomorphy.com> <20040712083820.GW21066@holomorphy.com> <20040712113114.GA21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712113114.GA21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 04:31:14AM -0700, William Lee Irwin III wrote:
> Some cleanups and fixing a minor oversight in touch_preempt_timing(),
> which was that in principle things can break out of preempt_count() > 1
> after checking need_resched(). Cleaner, smaller, yes. How crippled it
> just got with the various potentially false negatives introduced by
> using need_resched() as a hook for touch_preempt_timing() is unclear.

Something's gone wrong with using need_resched() as a hook for that.
The following, incremental atop the cleaned up patch, backs that out
and restores the apparent accuracy of reporting, though there isn't
any rigorous correlation of this with other scheduling latency stuff
(it should report lower worst-case latencies since it's measuring what
are tighter sections of code and ignores waiting time on runqueues).

vs. 2.6.7 (and the prior patch too). I'll probably repost a full patch
vs. -mm7 (or whatever's current when I do) in a dedicated thread.


-- wli

Index: timing-2.6.7/include/linux/sched.h
===================================================================
--- timing-2.6.7.orig/include/linux/sched.h	2004-07-12 01:45:08.000000000 -0700
+++ timing-2.6.7/include/linux/sched.h	2004-07-12 05:28:50.000000000 -0700
@@ -1000,8 +1000,7 @@
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }
   
-#define need_resched()	({ touch_preempt_timing(); __need_resched(); })
-static inline int __need_resched(void)
+static inline int need_resched(void)
 {
 	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
 }
@@ -1009,6 +1008,7 @@
 extern void __cond_resched(void);
 static inline void cond_resched(void)
 {
+	touch_preempt_timing();
 	if (need_resched())
 		__cond_resched();
 }
Index: timing-2.6.7/kernel/printk.c
===================================================================
--- timing-2.6.7.orig/kernel/printk.c	2004-06-15 22:20:26.000000000 -0700
+++ timing-2.6.7/kernel/printk.c	2004-07-12 05:30:14.000000000 -0700
@@ -650,10 +650,8 @@
  */
 void console_conditional_schedule(void)
 {
-	if (console_may_schedule && need_resched()) {
-		set_current_state(TASK_RUNNING);
-		schedule();
-	}
+	if (console_may_schedule)
+		cond_resched();
 }
 EXPORT_SYMBOL(console_conditional_schedule);
 
Index: timing-2.6.7/mm/memory.c
===================================================================
--- timing-2.6.7.orig/mm/memory.c	2004-06-15 22:19:22.000000000 -0700
+++ timing-2.6.7/mm/memory.c	2004-07-12 05:33:17.000000000 -0700
@@ -558,14 +558,17 @@
 			zap_bytes -= block;
 			if ((long)zap_bytes > 0)
 				continue;
-			if (!atomic && need_resched()) {
+			zap_bytes = ZAP_BLOCK_SIZE;
+			if (!atomic)
+				continue;
+			touch_preempt_timing();
+			if (need_resched()) {
 				int fullmm = tlb_is_full_mm(*tlbp);
 				tlb_finish_mmu(*tlbp, tlb_start, start);
 				cond_resched_lock(&mm->page_table_lock);
 				*tlbp = tlb_gather_mmu(mm, fullmm);
 				tlb_start_valid = 0;
 			}
-			zap_bytes = ZAP_BLOCK_SIZE;
 		}
 	}
 	return ret;
