Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266764AbUGLIr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266764AbUGLIr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 04:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266765AbUGLIr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 04:47:56 -0400
Received: from holomorphy.com ([207.189.100.168]:13965 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266764AbUGLIrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 04:47:52 -0400
Date: Mon, 12 Jul 2004 01:47:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Instrumenting high latency
Message-ID: <20040712084748.GY21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <20040712003418.02997a12.akpm@osdl.org> <1089620980.2806.8.camel@laptop.fenrus.com> <20040712084231.GX21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712084231.GX21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 10:29:40AM +0200, Arjan van de Ven wrote:
>> ... or reset the time(r) in need_resched() under the assumption that all
>> need_resched() callers will yield when it returns true...

On Mon, Jul 12, 2004 at 01:42:31AM -0700, William Lee Irwin III wrote:
> Might be a good enough approximation. Two examples and a counterexample...


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
 
