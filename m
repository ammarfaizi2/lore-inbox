Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266494AbUGULdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUGULdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 07:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266496AbUGULdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 07:33:03 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:31868 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266494AbUGULcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 07:32:55 -0400
Message-ID: <40FE545E.3050300@yahoo.com.au>
Date: Wed, 21 Jul 2004 21:32:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption
 Patch
References: <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu>
In-Reply-To: <20040721085246.GA19393@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------040601070308030607090000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040601070308030607090000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
>>below i've also attached a softirq.c patch against 2.6.8-rc2 that does
>>unconditional deferring. (this patch is of course not intended to be
>>merged upstream as-is, since normally we want to process softirqs
>>right after the irq context.)
> 
> 
> i've got a more complete patch against vanilla 2.6.8-rc2:
> 
>  http://redhat.com/~mingo/voluntary-preempt/defer-softirqs-2.6.8-rc2-A2
> 
> which introduces the following tunable:
> 
>     /proc/sys/kernel/defer_softirqs  (default: 0)
> 
> this, if enabled, causes all softirqs to be processed within ksoftirqd,
> and it also breaks out of the softirq loop if preemption of ksoftirqd
> has been triggered by a higher-prio task.
> 
> I've also added this additional break-out to the -H6 patch of
> voluntary-preempt:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-H6
> 
> it's enabled by default.
> 

What do you think about deferring softirqs just while in critical
sections?

I'm not sure how well this works, and it is CONFIG_PREEMPT only
but in theory it should prevent unbounded softirqs while under
locks without taking the performance hit of doing the context
switch.

--------------040601070308030607090000
Content-Type: text/x-patch;
 name="lat-softirq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lat-softirq.patch"




---

 linux-2.6-npiggin/include/asm-i386/hardirq.h |    8 ++++++--
 linux-2.6-npiggin/include/linux/preempt.h    |    6 +-----
 linux-2.6-npiggin/kernel/sched.c             |   13 +++++++++++--
 linux-2.6-npiggin/kernel/softirq.c           |    4 ++--
 4 files changed, 20 insertions(+), 11 deletions(-)

diff -puN kernel/softirq.c~lat-softirq kernel/softirq.c
--- linux-2.6/kernel/softirq.c~lat-softirq	2004-07-17 00:32:52.000000000 +1000
+++ linux-2.6-npiggin/kernel/softirq.c	2004-07-17 00:32:52.000000000 +1000
@@ -68,7 +68,7 @@ static inline void wakeup_softirqd(void)
  * we want to handle softirqs as soon as possible, but they
  * should not be able to lock up the box.
  */
-#define MAX_SOFTIRQ_RESTART 10
+#define MAX_SOFTIRQ_RESTART 4
 
 asmlinkage void __do_softirq(void)
 {
@@ -322,7 +322,7 @@ void __init softirq_init(void)
 
 static int ksoftirqd(void * __bind_cpu)
 {
-	set_user_nice(current, 19);
+	set_user_nice(current, 10);
 	current->flags |= PF_NOFREEZE;
 
 	set_current_state(TASK_INTERRUPTIBLE);
diff -puN include/asm-i386/hardirq.h~lat-softirq include/asm-i386/hardirq.h
--- linux-2.6/include/asm-i386/hardirq.h~lat-softirq	2004-07-17 00:32:52.000000000 +1000
+++ linux-2.6-npiggin/include/asm-i386/hardirq.h	2004-07-17 00:32:52.000000000 +1000
@@ -80,17 +80,21 @@ typedef struct {
 # include <linux/smp_lock.h>
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
+#define irq_exit()							\
+do {									\
+		preempt_count() -= IRQ_EXIT_OFFSET;			\
+		preempt_enable_no_resched(); /* This will catch the softirq */ \
+} while (0)
 #else
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
 		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
 			do_softirq();					\
-		preempt_enable_no_resched();				\
 } while (0)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
diff -puN include/linux/preempt.h~lat-softirq include/linux/preempt.h
--- linux-2.6/include/linux/preempt.h~lat-softirq	2004-07-17 00:32:52.000000000 +1000
+++ linux-2.6-npiggin/include/linux/preempt.h	2004-07-17 00:32:52.000000000 +1000
@@ -16,12 +16,8 @@ do { \
 	preempt_count()++; \
 } while (0)
 
-#define dec_preempt_count() \
-do { \
-	preempt_count()--; \
-} while (0)
-
 #ifdef CONFIG_PREEMPT
+void dec_preempt_count(void);
 
 asmlinkage void preempt_schedule(void);
 
diff -puN kernel/sched.c~lat-softirq kernel/sched.c
--- linux-2.6/kernel/sched.c~lat-softirq	2004-07-17 00:32:52.000000000 +1000
+++ linux-2.6-npiggin/kernel/sched.c	2004-07-17 00:32:52.000000000 +1000
@@ -3968,8 +3968,16 @@ void __might_sleep(char *file, int line)
 EXPORT_SYMBOL(__might_sleep);
 #endif
 
+#ifdef CONFIG_PREEMPT
+void dec_preempt_count(void)
+{
+	if (unlikely(preempt_count() == 1 &&
+				softirq_pending(smp_processor_id())))
+		do_softirq();
+	preempt_count()--;
+}
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+#ifdef CONFIG_SMP
 /*
  * This could be a long-held lock.  If another CPU holds it for a long time,
  * and that CPU is not asked to reschedule then *this* CPU will spin on the
@@ -4012,4 +4020,5 @@ void __sched __preempt_write_lock(rwlock
 }
 
 EXPORT_SYMBOL(__preempt_write_lock);
-#endif /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) */
+#endif /* CONFIG_SMP */
+#endif /* CONFIG_PREEMPT */

_

--------------040601070308030607090000--
