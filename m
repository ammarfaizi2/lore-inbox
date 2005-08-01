Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVHAU4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVHAU4C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVHAUxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:53:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18600 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261170AbVHAUvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:51:47 -0400
Date: Mon, 1 Aug 2005 22:52:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Message-ID: <20050801205208.GA20731@elte.hu>
References: <20050730160345.GA3584@elte.hu> <1122920564.6759.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122920564.6759.15.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> What's with the "BUG: possible soft lockup detected on CPU..."? I'm 
> getting a bunch of them from the IDE interrupt.  It's not locking up, 
> but it does things that probably do take some time.  Is this really 
> necessary? Here's an example dump:

doh - it's Daniel not Cc:-ing lkml when sending me patches, so people 
dont know what's going on ...

here's the patch below. Could you try to revert it?

	Ingo

On Sun, 2005-07-31 at 20:27 +0200, Ingo Molnar wrote:
> looks good, but i'd suggest to use printk_ratelimit(). (and the use of 
> u16 can be a performance hit on x86 due to potential 16-bit prefixes - 
> the best thing to use is an 'int' on pretty much every arch. with 
> printk_ratelimit() this flag go away anyway.)


Ok, here's with your suggestions.


Index: linux-2.6.12/kernel/softlockup.c
===================================================================
--- linux-2.6.12.orig/kernel/softlockup.c	2005-07-31 15:31:09.000000000 +0000
+++ linux-2.6.12/kernel/softlockup.c	2005-07-31 18:43:35.000000000 +0000
@@ -9,6 +9,7 @@
 
 #include <linux/mm.h>
 #include <linux/cpu.h>
+#include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
@@ -19,6 +20,7 @@ static DEFINE_RAW_SPINLOCK(print_lock);
 static DEFINE_PER_CPU(unsigned long, timeout) = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, timestamp) = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, print_timestamp) = INITIAL_JIFFIES;
+static DEFINE_PER_CPU(struct task_struct *, prev_task);
 static DEFINE_PER_CPU(struct task_struct *, watchdog_task);
 
 static int did_panic = 0;
@@ -56,6 +58,23 @@ void softlockup_tick(void)
 		if (!per_cpu(watchdog_task, this_cpu))
 			return;
 
+		if (per_cpu(prev_task, this_cpu) != current || 
+			!rt_task(current)) {
+			per_cpu(prev_task, this_cpu) = current;
+		}
+		else if (printk_ratelimit()) {
+
+			spin_lock(&print_lock);
+			printk(KERN_ERR "BUG: possible soft lockup detected on CPU#%u! %lu-%lu(%lu)\n",
+				this_cpu, jiffies, timestamp, timeout);
+			dump_stack();
+#if defined(__i386__) && defined(CONFIG_SMP)
+			nmi_show_all_regs();
+#endif
+			spin_unlock(&print_lock);
+
+		}
+
 		wake_up_process(per_cpu(watchdog_task, this_cpu));
 		per_cpu(timeout, this_cpu) = jiffies + msecs_to_jiffies(1000);
 	}
@@ -71,7 +90,7 @@ void softlockup_tick(void)
 		per_cpu(print_timestamp, this_cpu) = timestamp;
 
 		spin_lock(&print_lock);
-		printk(KERN_ERR "BUG: soft lockup detected on CPU#%d! %ld-%ld(%ld)\n",
+		printk(KERN_ERR "BUG: soft lockup detected on CPU#%u! %lu-%lu(%lu)\n",
 			this_cpu, jiffies, timestamp, timeout);
 		dump_stack();
 #if defined(__i386__) && defined(CONFIG_SMP)

