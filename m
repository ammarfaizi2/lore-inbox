Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVHAVSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVHAVSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVHAVRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:17:09 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:20732 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261278AbVHAVPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:15:50 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <20050801205208.GA20731@elte.hu>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <20050801205208.GA20731@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 01 Aug 2005 17:15:32 -0400
Message-Id: <1122930932.6759.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 22:52 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Ingo,
> > 
> > What's with the "BUG: possible soft lockup detected on CPU..."? I'm 
> > getting a bunch of them from the IDE interrupt.  It's not locking up, 
> > but it does things that probably do take some time.  Is this really 
> > necessary? Here's an example dump:
> 
> doh - it's Daniel not Cc:-ing lkml when sending me patches, so people 
> dont know what's going on ...
> 
> here's the patch below. Could you try to revert it?

Thanks Ingo.

If Daniel was trying to detect soft lock ups of lower priority tasks
(tasks that block all tasks lower than itself), I've added a counter to
Daniels patch to keep from showing this for the one time case.  This
doesn't spit anything out for me anymore.  But I guess this could detect
a higher priority task blocking lower ones, as long as higher tasks
don't run often (thus reseting the count).

-- Steve

Index: linux_realtime_ernie/kernel/softlockup.c
===================================================================
--- linux_realtime_ernie/kernel/softlockup.c	(revision 266)
+++ linux_realtime_ernie/kernel/softlockup.c	(working copy)
@@ -22,6 +22,7 @@
 static DEFINE_PER_CPU(unsigned long, print_timestamp) = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(struct task_struct *, prev_task);
 static DEFINE_PER_CPU(struct task_struct *, watchdog_task);
+static DEFINE_PER_CPU(unsigned long, task_counter);
 
 static int did_panic = 0;
 static int softlock_panic(struct notifier_block *this, unsigned long event,
@@ -61,18 +62,21 @@
 		if (per_cpu(prev_task, this_cpu) != current || 
 			!rt_task(current)) {
 			per_cpu(prev_task, this_cpu) = current;
+			per_cpu(task_counter, this_cpu) = 0;
 		}
-		else if (printk_ratelimit()) {
+		else if ((++per_cpu(task_counter, this_cpu) > 10) && printk_ratelimit()) {
 
 			spin_lock(&print_lock);
 			printk(KERN_ERR "BUG: possible soft lockup detected on CPU#%u! %lu-%lu(%lu)\n",
 				this_cpu, jiffies, timestamp, timeout);
+			printk("curr=%s:%d\n",current->comm,current->pid);
+			
 			dump_stack();
 #if defined(__i386__) && defined(CONFIG_SMP)
 			nmi_show_all_regs();
 #endif
 			spin_unlock(&print_lock);
-
+			per_cpu(task_counter, this_cpu) = 0;
 		}
 
 		wake_up_process(per_cpu(watchdog_task, this_cpu));
@@ -97,6 +101,7 @@
 		nmi_show_all_regs();
 #endif
 		spin_unlock(&print_lock);
+		per_cpu(task_counter, this_cpu) = 0;
 	}
 }
 


