Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUGLLce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUGLLce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 07:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266803AbUGLLce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 07:32:34 -0400
Received: from holomorphy.com ([207.189.100.168]:50317 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266808AbUGLLbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 07:31:23 -0400
Date: Mon, 12 Jul 2004 04:31:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Instrumenting high latency
Message-ID: <20040712113114.GA21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
	linux-kernel@vger.kernel.org
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <20040712003418.02997a12.akpm@osdl.org> <20040712080259.GV21066@holomorphy.com> <20040712083820.GW21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712083820.GW21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 01:02:59AM -0700, William Lee Irwin III wrote:
>> I suspect it's better to drop in hooks to trap those e.g. in
>> cond_resched() and cond_resched_lock().

On Mon, Jul 12, 2004 at 01:38:20AM -0700, William Lee Irwin III wrote:
> Something like this should do, modulo everything outside kernel/ and mm/.

Okay, finally, it should be possible to genericize this all, since
sched_clock() is an arch-independent interface for high-precision
timings in units of nanoseconds.

Some cleanups and fixing a minor oversight in touch_preempt_timing(),
which was that in principle things can break out of preempt_count() > 1
after checking need_resched(). Cleaner, smaller, yes. How crippled it
just got with the various potentially false negatives introduced by
using need_resched() as a hook for touch_preempt_timing() is unclear.

Also, the major oversight of nopping out inc_preempt_count() and
dec_preempt_count(), which will take out boxen, is corrected here.
Happily, some underscore-itis is also removed.

I couldn't think of a better place to put the config option for generic
use than under CONFIG_EMBEDDED, otherwise I'd have to drop it in
alongside CONFIG_PREEMPT on all arches, as it's basically more generic
than CONFIG_PREEMPT in and of itself.

I guess the other things are:
(a) do people want this sysctl-configurable instead of boot-time?
	I chose boot-time because sysctls seem to introduce more risk
	of people shooting themselves in the foot.
(b) the damn thing finally boots on my craptop, where else did it break?
(c) everything else and the kitchen sink


-- wli

Index: timing-2.6.7/include/linux/preempt.h
===================================================================
--- timing-2.6.7.orig/include/linux/preempt.h	2004-06-15 22:19:02.000000000 -0700
+++ timing-2.6.7/include/linux/preempt.h	2004-07-12 03:18:19.000000000 -0700
@@ -9,17 +9,17 @@
 #include <linux/config.h>
 #include <linux/linkage.h>
 
-#define preempt_count()	(current_thread_info()->preempt_count)
-
-#define inc_preempt_count() \
-do { \
-	preempt_count()++; \
-} while (0)
+#ifdef CONFIG_PREEMPT_TIMING
+void inc_preempt_count(void);
+void dec_preempt_count(void);
+void touch_preempt_timing(void);
+#else
+#define touch_preempt_timing()	do { } while (0)
+#define inc_preempt_count()	do { preempt_count()++; } while (0)
+#define dec_preempt_count()	do { preempt_count()--; } while (0)
+#endif
 
-#define dec_preempt_count() \
-do { \
-	preempt_count()--; \
-} while (0)
+#define preempt_count()	(current_thread_info()->preempt_count)
 
 #ifdef CONFIG_PREEMPT
 
@@ -51,9 +51,15 @@
 
 #else
 
+#ifdef CONFIG_PREEMPT_TIMING
+#define preempt_disable()		inc_preempt_count()
+#define preempt_enable_no_resched()	dec_preempt_count()
+#define preempt_enable()		dec_preempt_count()
+#else
 #define preempt_disable()		do { } while (0)
 #define preempt_enable_no_resched()	do { } while (0)
 #define preempt_enable()		do { } while (0)
+#endif
 #define preempt_check_resched()		do { } while (0)
 
 #endif
Index: timing-2.6.7/include/linux/sched.h
===================================================================
--- timing-2.6.7.orig/include/linux/sched.h	2004-06-15 22:18:57.000000000 -0700
+++ timing-2.6.7/include/linux/sched.h	2004-07-12 01:45:08.000000000 -0700
@@ -1000,7 +1000,8 @@
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }
   
-static inline int need_resched(void)
+#define need_resched()	({ touch_preempt_timing(); __need_resched(); })
+static inline int __need_resched(void)
 {
 	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
 }
Index: timing-2.6.7/init/Kconfig
===================================================================
--- timing-2.6.7.orig/init/Kconfig	2004-06-15 22:19:52.000000000 -0700
+++ timing-2.6.7/init/Kconfig	2004-07-12 03:55:15.000000000 -0700
@@ -261,6 +261,14 @@
 	  Disabling this option will cause the kernel to be built without
 	  support for epoll family of system calls.
 
+config PREEMPT_TIMING
+	bool "Non-preemptible critical section timing"
+	default n
+	help
+	  This option measures the time spent in non-preemptible critical
+	  sections and reports warnings when a boot-time configurable
+	  latency threshold is exceeded.
+
 source "drivers/block/Kconfig.iosched"
 
 config CC_OPTIMIZE_FOR_SIZE
Index: timing-2.6.7/kernel/sched.c
===================================================================
--- timing-2.6.7.orig/kernel/sched.c	2004-06-15 22:19:51.000000000 -0700
+++ timing-2.6.7/kernel/sched.c	2004-07-12 03:14:41.000000000 -0700
@@ -4029,3 +4029,74 @@
 
 EXPORT_SYMBOL(__preempt_write_lock);
 #endif /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) */
+
+#ifdef CONFIG_PREEMPT_TIMING
+#include <linux/kallsyms.h>
+
+static int preempt_thresh;
+static DEFINE_PER_CPU(u64, preempt_timings);
+static DEFINE_PER_CPU(unsigned long, preempt_entry);
+
+static int setup_preempt_thresh(char *s)
+{
+	int thresh;
+
+	get_option(&s, &thresh);
+	if (thresh > 0) {
+		preempt_thresh = thresh;
+		printk("Preemption threshold = %dms\n", preempt_thresh);
+	}
+	return 1;
+}
+__setup("preempt_thresh=", setup_preempt_thresh);
+
+static void __touch_preempt_timing(void *addr)
+{
+	__get_cpu_var(preempt_timings) = sched_clock();
+	__get_cpu_var(preempt_entry) = (unsigned long)addr;
+}
+
+void touch_preempt_timing(void)
+{
+	if (preempt_count() > 0 && system_state == SYSTEM_RUNNING &&
+						__get_cpu_var(preempt_entry))
+		__touch_preempt_timing(__builtin_return_address(0));
+}
+EXPORT_SYMBOL(touch_preempt_timing);
+
+void inc_preempt_count(void)
+{
+	preempt_count()++;
+	if (preempt_count() == 1 && system_state == SYSTEM_RUNNING)
+		__touch_preempt_timing(__builtin_return_address(0));
+}
+EXPORT_SYMBOL(inc_preempt_count);
+
+void dec_preempt_count(void)
+{
+	if (preempt_count() == 1 && system_state == SYSTEM_RUNNING &&
+					__get_cpu_var(preempt_entry)) {
+		u64 hold;
+		unsigned long preempt_exit
+				= (unsigned long)__builtin_return_address(0);
+		hold = sched_clock() - __get_cpu_var(preempt_timings) + 999999;
+		do_div(hold, 1000000);
+		if (preempt_thresh && hold > preempt_thresh &&
+							printk_ratelimit()) {
+			printk("%lums non-preemptible critical section "
+				"violated %d ms preempt threshold "
+				"starting at ",
+				(unsigned long)hold,
+				preempt_thresh);
+			print_symbol("%s", __get_cpu_var(preempt_entry));
+			printk(" and ending at ");
+			print_symbol("%s", preempt_exit);
+			printk("\n");
+			dump_stack();
+		}
+		__get_cpu_var(preempt_entry) = 0;
+	}
+	preempt_count()--;
+}
+EXPORT_SYMBOL(dec_preempt_count);
+#endif
