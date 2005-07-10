Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVGJPn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVGJPn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 11:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVGJPn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 11:43:58 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:54319 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261960AbVGJPn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 11:43:58 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050710151008.GA28194@elte.hu>
References: <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
	 <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu>
	 <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org>
	 <20050707104859.GD22422@elte.hu>
	 <Pine.LNX.4.58.0507071257320.25321@echo.lysdexia.org>
	 <20050708080359.GA32001@elte.hu>
	 <Pine.LNX.4.58.0507081246340.30549@echo.lysdexia.org>
	 <1120944243.12169.3.camel@twins> <1120994288.14680.0.camel@twins>
	 <20050710151008.GA28194@elte.hu>
Content-Type: text/plain
Date: Sun, 10 Jul 2005 17:43:56 +0200
Message-Id: <1121010236.14680.6.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-10 at 17:10 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > > I can reproduce priority leakage on my SMP system; any userspace process
> > > chrt'ed up and a lot will follow. This makes the system very
> > > unresponsive when doing a make -j5. Verified on 51-{6,18,23}.
> > > 
> > 
> > The following patch seems to fix it for me, YMMV.
> > 
> > --- kernel/sched.c~     2005-07-08 10:27:59.000000000 +0200
> > +++ kernel/sched.c      2005-07-10 13:00:42.000000000 +0200
> > @@ -780,7 +780,8 @@ static void recalc_task_prio(task_t *p,
> >                 }
> >         }
> > 
> > -       p->prio = p->normal_prio = effective_prio(p);
> > +       p->prio = effective_prio(p);
> > +       p->normal_prio = unlikely(rt_prio(p->normal_prio)) ? p->prio : __effective_prio(p);
> >  }
> 
> ahh, indeed, this code did not take boosting into account. Good catch!  
> I'm wondering why this only showed up on SMP. 

I was thinking because of the agressive RT rebalance code this codepath
is more exercised on SMP systems.

> I've fixed it a bit 
> differently in my tree, by making the roles of the various priority 
> fields and functions more obvious, see the delta patch below.  

Yes, much nicer :-)

> I've also 
> released the -51-23 patch with these changes included. Does this fix 
> priority leakage on your SMP system?
> 

-51-24 right? I'll give it a spin.

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

