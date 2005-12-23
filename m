Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030555AbVLWPiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbVLWPiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 10:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030560AbVLWPiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 10:38:10 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:37251 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030555AbVLWPiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 10:38:08 -0500
Subject: Re: 2.6.15-rc5-rt4: BUG: swapper:0 task might have lost a
	preemption check!
From: Steven Rostedt <rostedt@goodmis.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, John Rigg <lk@sound-man.co.uk>
In-Reply-To: <43AB6B89.8020409@cybsft.com>
References: <1135306534.4473.1.camel@mindpipe> <43AB6B89.8020409@cybsft.com>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 10:37:57 -0500
Message-Id: <1135352277.6652.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 21:14 -0600, K.R. Foley wrote:
> Lee Revell wrote:
> > Got this on boot.  Same .config as the last one I sent you.
> > 
> > VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
> >     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
> > Probing IDE interface ide1...
> > BUG: swapper:0 task might have lost a preemption check!
> >  [<c010440c>] dump_stack+0x1c/0x20 (20)
> >  [<c01166aa>] preempt_enable_no_resched+0x5a/0x60 (20)
> >  [<c0100dd9>] cpu_idle+0x79/0xb0 (12)
> >  [<c0100280>] _stext+0x40/0x50 (28)
> >  [<c03078e6>] start_kernel+0x176/0x1d0 (20)
> >  [<c0100199>] 0xc0100199 (1086889999)
> > ---------------------------
> > | preempt count: 00000000 ]
> > | 0-level deep critical section nesting:
> > ----------------------------------------
> > 
> > 


OK, I just found an SMP bug, and here's the patch.  Maybe this will help
you kr.  I'm currently running x86_64 SMP with 2.6.15-rc5-rt4 with this
and my softirq-no-hrtimers patch I sent earlier.

-- Steve

Index: linux-2.6.15-rc5-rt4/kernel/workqueue.c
===================================================================
--- linux-2.6.15-rc5-rt4.orig/kernel/workqueue.c	2005-12-23 10:23:25.000000000 -0500
+++ linux-2.6.15-rc5-rt4/kernel/workqueue.c	2005-12-23 10:25:21.000000000 -0500
@@ -370,10 +370,17 @@
 void set_workqueue_thread_prio(struct workqueue_struct *wq, int cpu,
 				int policy, int rt_priority, int nice)
 {
-	struct task_struct *p = wq->cpu_wq[cpu].thread;
+	struct cpu_workqueue_struct *cwq;
+	struct task_struct *p;
 	struct sched_param param = { .sched_priority = rt_priority };
+	unsigned long flags;
 	int ret;
 
+	cwq = per_cpu_ptr(wq->cpu_wq, cpu);
+	spin_lock_irqsave(&cwq->lock, flags);
+	p = cwq->thread;
+	spin_unlock_irqrestore(&cwq->lock, flags);
+
 	set_user_nice(p, nice);
 	ret = sys_sched_setscheduler(p->pid, policy, &param);
 	if (ret)


