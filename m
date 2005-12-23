Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030551AbVLWSdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030551AbVLWSdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 13:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030598AbVLWSdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 13:33:22 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24201 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030551AbVLWSdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 13:33:21 -0500
Subject: Re: 2.6.15-rc5-rt4: BUG: swapper:0 task might have lost
	a	preemption check!
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, John Rigg <lk@sound-man.co.uk>
In-Reply-To: <43AC2607.1050707@cybsft.com>
References: <1135306534.4473.1.camel@mindpipe> <43AB6B89.8020409@cybsft.com>
	 <1135352277.6652.2.camel@localhost.localdomain>
	 <43AC2607.1050707@cybsft.com>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 13:37:47 -0500
Message-Id: <1135363068.22177.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 10:29 -0600, K.R. Foley wrote:
> Steven Rostedt wrote:
> > On Thu, 2005-12-22 at 21:14 -0600, K.R. Foley wrote:
> >> Lee Revell wrote:
> >>> Got this on boot.  Same .config as the last one I sent you.
> >>>
> >>> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
> >>>     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
> >>> Probing IDE interface ide1...
> >>> BUG: swapper:0 task might have lost a preemption check!
> >>>  [<c010440c>] dump_stack+0x1c/0x20 (20)
> >>>  [<c01166aa>] preempt_enable_no_resched+0x5a/0x60 (20)
> >>>  [<c0100dd9>] cpu_idle+0x79/0xb0 (12)
> >>>  [<c0100280>] _stext+0x40/0x50 (28)
> >>>  [<c03078e6>] start_kernel+0x176/0x1d0 (20)
> >>>  [<c0100199>] 0xc0100199 (1086889999)
> >>> ---------------------------
> >>> | preempt count: 00000000 ]
> >>> | 0-level deep critical section nesting:
> >>> ----------------------------------------
> >>>
> >>>
> > 
> > 
> > OK, I just found an SMP bug, and here's the patch.  Maybe this will help
> > you kr.  I'm currently running x86_64 SMP with 2.6.15-rc5-rt4 with this
> > and my softirq-no-hrtimers patch I sent earlier.
> > 
> > -- Steve
> > 
> > Index: linux-2.6.15-rc5-rt4/kernel/workqueue.c
> > ===================================================================
> > --- linux-2.6.15-rc5-rt4.orig/kernel/workqueue.c	2005-12-23 10:23:25.000000000 -0500
> > +++ linux-2.6.15-rc5-rt4/kernel/workqueue.c	2005-12-23 10:25:21.000000000 -0500
> > @@ -370,10 +370,17 @@
> >  void set_workqueue_thread_prio(struct workqueue_struct *wq, int cpu,
> >  				int policy, int rt_priority, int nice)
> >  {
> > -	struct task_struct *p = wq->cpu_wq[cpu].thread;
> > +	struct cpu_workqueue_struct *cwq;
> > +	struct task_struct *p;
> >  	struct sched_param param = { .sched_priority = rt_priority };
> > +	unsigned long flags;
> >  	int ret;
> >  
> > +	cwq = per_cpu_ptr(wq->cpu_wq, cpu);
> > +	spin_lock_irqsave(&cwq->lock, flags);
> > +	p = cwq->thread;
> > +	spin_unlock_irqrestore(&cwq->lock, flags);
> > +
> >  	set_user_nice(p, nice);
> >  	ret = sys_sched_setscheduler(p->pid, policy, &param);
> >  	if (ret)
> > 
> > 
> > 
> 
> OK. The BUG still exists (output below) but it does boot now with the
> above patch applied (THANKS Steven!), which would seem to imply the two
> weren't related. ARGH! :)
> 
> Dec 23 10:16:27 porky kernel: Event source lapic installed with caps set: 06
> Dec 23 10:16:27 porky kernel: BUG: swapper:0 task might have lost a
> preemption check!
> Dec 23 10:16:27 porky kernel: Brought up 2 CPUs
> Dec 23 10:16:27 porky kernel: checking if image is initramfs... it is
> Dec 23 10:16:27 porky kernel:  [<c010424e>] dump_stack+0x1e/0x20 (20)
> Dec 23 10:16:27 porky kernel:  [<c011c9cf>]
> preempt_enable_no_resched+0x5f/0x70 (20)
> Dec 23 10:16:27 porky kernel:  [<c0100ff2>] cpu_idle+0xb2/0x100 (40)
> Dec 23 10:16:27 porky kernel:  [<c0111446>]
> start_secondary+0x296/0x340<6>Freeing initrd memory: 452k freed
> 
> 

FWIW this BUG is harmless on my system, I can boot fine, so it does seem
to be a different problem.

Lee

