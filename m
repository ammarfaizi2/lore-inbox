Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUGMM2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUGMM2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 08:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUGMM2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 08:28:20 -0400
Received: from holomorphy.com ([207.189.100.168]:56212 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264917AbUGMM2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 08:28:06 -0400
Date: Tue, 13 Jul 2004 05:28:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: preempt-timing-2.6.8-rc1
Message-ID: <20040713122805.GZ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the preemption counter increments and decrements to time
non-preemptible critical sections.

This is an instrumentation patch intended to help determine the causes of
scheduling latency related to long non-preemptible critical sections.

Changes from 2.6.7-based patch:
(1) fix unmap_vmas() check correctly this time
(2) add touch_preempt_timing() to cond_resched_lock()
(3) depend on preempt until it's worked out wtf goes wrong without it


-- wli

Index: timing-2.6.8-rc1/include/linux/preempt.h
===================================================================
--- timing-2.6.8-rc1.orig/include/linux/preempt.h	2004-07-11 10:34:18.000000000 -0700
+++ timing-2.6.8-rc1/include/linux/preempt.h	2004-07-13 03:56:37.887605624 -0700
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
Index: timing-2.6.8-rc1/include/linux/sched.h
===================================================================
--- timing-2.6.8-rc1.orig/include/linux/sched.h	2004-07-11 10:33:55.000000000 -0700
+++ timing-2.6.8-rc1/include/linux/sched.h	2004-07-13 03:56:37.895604408 -0700
@@ -1021,6 +1021,7 @@
 extern void __cond_resched(void);
 static inline void cond_resched(void)
 {
+	touch_preempt_timing();
 	if (need_resched())
 		__cond_resched();
 }
@@ -1040,7 +1041,8 @@
 		preempt_enable_no_resched();
 		__cond_resched();
 		spin_lock(lock);
-	}
+	} else
+		touch_preempt_timing();
 }
 
 /* Reevaluate whether the task has signals pending delivery.
Index: timing-2.6.8-rc1/init/Kconfig
===================================================================
--- timing-2.6.8-rc1.orig/init/Kconfig	2004-07-11 10:35:08.000000000 -0700
+++ timing-2.6.8-rc1/init/Kconfig	2004-07-13 03:56:37.898603952 -0700
@@ -279,6 +279,15 @@
 	  Disabling this option will cause the kernel to be built without
 	  support for epoll family of system calls.
 
+config PREEMPT_TIMING
+	bool "Non-preemptible critical section timing"
+	default n
+	depends on PREEMPT
+	help
+	  This option measures the time spent in non-preemptible critical
+	  sections and reports warnings when a boot-time configurable
+	  latency threshold is exceeded.
+
 source "drivers/block/Kconfig.iosched"
 
 config CC_OPTIMIZE_FOR_SIZE
Index: timing-2.6.8-rc1/kernel/printk.c
===================================================================
--- timing-2.6.8-rc1.orig/kernel/printk.c	2004-07-11 10:35:31.000000000 -0700
+++ timing-2.6.8-rc1/kernel/printk.c	2004-07-13 03:56:37.901603496 -0700
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
 
Index: timing-2.6.8-rc1/kernel/sched.c
===================================================================
--- timing-2.6.8-rc1.orig/kernel/sched.c	2004-07-11 10:35:08.000000000 -0700
+++ timing-2.6.8-rc1/kernel/sched.c	2004-07-13 03:56:37.914601520 -0700
@@ -4040,3 +4040,74 @@
 
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
Index: timing-2.6.8-rc1/mm/memory.c
===================================================================
--- timing-2.6.8-rc1.orig/mm/memory.c	2004-07-11 10:34:37.000000000 -0700
+++ timing-2.6.8-rc1/mm/memory.c	2004-07-13 03:56:37.920600608 -0700
@@ -567,14 +567,17 @@
 			zap_bytes -= block;
 			if ((long)zap_bytes > 0)
 				continue;
-			if (!atomic && need_resched()) {
+			zap_bytes = ZAP_BLOCK_SIZE;
+			if (atomic)
+				continue;
+			if (need_resched()) {
 				int fullmm = tlb_is_full_mm(*tlbp);
 				tlb_finish_mmu(*tlbp, tlb_start, start);
 				cond_resched_lock(&mm->page_table_lock);
 				*tlbp = tlb_gather_mmu(mm, fullmm);
 				tlb_start_valid = 0;
-			}
-			zap_bytes = ZAP_BLOCK_SIZE;
+			} else
+				touch_preempt_timing();
 		}
 	}
 	return ret;
