Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUGMFfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUGMFfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 01:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbUGMFfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 01:35:24 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:34755 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264265AbUGMFe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 01:34:56 -0400
References: <200407121943.25196.devenyga@mcmaster.ca> <20040713024051.GQ21066@holomorphy.com> <200407122248.50377.devenyga@mcmaster.ca> <20040713025502.GR21066@holomorphy.com> <20040712210701.46e2cd40.akpm@osdl.org>
Message-ID: <cone.1089696847.507419.12958.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, ck@vds.kolivas.org,
       devenyga@mcmaster.ca, linux-kernel@vger.kernel.org
Subject: Re: Preempt Threshold Measurements
Date: Tue, 13 Jul 2004 15:34:07 +1000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_pc.kolivas.org-1089696847-0000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_pc.kolivas.org-1089696847-0000
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Andrew Morton writes:

> William Lee Irwin III <wli@holomorphy.com> wrote:
>>
>> On Mon, Jul 12, 2004 at 10:48:50PM -0400, Gabriel Devenyi wrote:
>>  > Well I'm not particularly educated in kernel internals yet, here's some 
>>  > reports from the system when its running.
>>  > 6ms non-preemptible critical section violated 4 ms preempt threshold starting 
>>  > at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140
>>  >  [<c014007b>] do_munmap+0xeb/0x140
>>  >  [<c01163b0>] dec_preempt_count+0x110/0x120
>>  >  [<c014007b>] do_munmap+0xeb/0x140
>>  >  [<c014010f>] sys_munmap+0x3f/0x60
>>  >  [<c0103ee1>] sysenter_past_esp+0x52/0x71
>> 
>>  Looks like ZAP_BLOCK_SIZE may be too large for you. Lowering that some
>>  may "help" this. It's probably harmless, but try lowering that to half
>>  of whatever it is now, or maybe 64*PAGE_SIZE. It may be worthwhile
>>  to restructure how the preemption points are done in unmap_vmas() so
>>  we don't end up in some kind of tuning nightmare.
> 
> Does that instrumentation patch have the cond_resched_lock() fixups?  If
> not, this is a false positive.
> 
> The current setting of ZAP_BLOCK_SIZE is good for sub-500usec latencies on
> a recentish CPU.

Here's what the full patch against 2.6.8-rc1 currently looks like 
(equivalent is in the snapshot used by Gabriel).

Cheers,
Con


--=_pc.kolivas.org-1089696847-0000
Content-Description: wli_preempttest2.1
Content-Disposition: inline;
  FILENAME="2.6.8-rc1_wli_preempttest2.1"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.8-rc1/include/linux/preempt.h
===================================================================
--- linux-2.6.8-rc1.orig/include/linux/preempt.h	2004-07-13 15:29:53.619112346 +1000
+++ linux-2.6.8-rc1/include/linux/preempt.h	2004-07-13 15:30:21.398811516 +1000
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
Index: linux-2.6.8-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.8-rc1.orig/include/linux/sched.h	2004-07-12 16:11:50.000000000 +1000
+++ linux-2.6.8-rc1/include/linux/sched.h	2004-07-13 15:31:00.547749905 +1000
@@ -1021,6 +1021,7 @@
 extern void __cond_resched(void);
 static inline void cond_resched(void)
 {
+	touch_preempt_timing();
 	if (need_resched())
 		__cond_resched();
 }
Index: linux-2.6.8-rc1/init/Kconfig
===================================================================
--- linux-2.6.8-rc1.orig/init/Kconfig	2004-07-12 16:11:50.000000000 +1000
+++ linux-2.6.8-rc1/init/Kconfig	2004-07-13 15:30:21.423807646 +1000
@@ -279,6 +279,14 @@
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
Index: linux-2.6.8-rc1/kernel/printk.c
===================================================================
--- linux-2.6.8-rc1.orig/kernel/printk.c	2004-07-12 16:11:50.000000000 +1000
+++ linux-2.6.8-rc1/kernel/printk.c	2004-07-13 15:31:00.549749595 +1000
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
 
Index: linux-2.6.8-rc1/kernel/sched.c
===================================================================
--- linux-2.6.8-rc1.orig/kernel/sched.c	2004-07-12 16:11:50.000000000 +1000
+++ linux-2.6.8-rc1/kernel/sched.c	2004-07-13 15:30:21.456802538 +1000
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
Index: linux-2.6.8-rc1/mm/memory.c
===================================================================
--- linux-2.6.8-rc1.orig/mm/memory.c	2004-07-12 16:11:50.000000000 +1000
+++ linux-2.6.8-rc1/mm/memory.c	2004-07-13 15:31:00.550749440 +1000
@@ -567,14 +567,17 @@
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

--=_pc.kolivas.org-1089696847-0000--
