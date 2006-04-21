Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWDULu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWDULu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 07:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWDULu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 07:50:28 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:16574 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751286AbWDULu1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 07:50:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YM0HG4L2uxcgsCJxy+PbOiD0hJ4tGlZ4WkRqf3jqwb7cWXuZVPxMqa6wuj9lLLVqFsgquIvHwC54T1/0OPyZ0g/eM47nKOKcCHeGoIzZCHbQhQsOuKZ/P4Zq0yPIpRwodMoIP+G4BGq7tX+OQMFtdeDPY20TlF9EkSXkwI9mxqA=
Message-ID: <9fe69740604210450h798eded8nff1ef8b98c0f151@mail.gmail.com>
Date: Fri, 21 Apr 2006 20:50:26 +0900
From: "Naoaki MAEDA" <maeda.naoaki@gmail.com>
To: "MAEDA Naoaki" <maeda.naoaki@jp.fujitsu.com>
Subject: Re: [ckrm-tech] Re: [RFC][PATCH 3/9] CPU controller - Adds timeslice scaling
Cc: "Mike Galbraith" <efault@gmx.de>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <44489E27.2090108@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <20060421022742.13598.7230.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <1145607449.10016.47.camel@homer> <44489E27.2090108@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mike Galbraith wrote:
> > On Fri, 2006-04-21 at 11:27 +0900, maeda.naoaki@jp.fujitsu.com wrote:
> >> Index: linux-2.6.17-rc2/kernel/sched.c
> >> ===================================================================
> >> --- linux-2.6.17-rc2.orig/kernel/sched.c
> >> +++ linux-2.6.17-rc2/kernel/sched.c
> >> @@ -173,10 +173,17 @@
> >>
> >>  static unsigned int task_timeslice(task_t *p)
> >>  {
> >> +    unsigned int timeslice;
> >> +
> >>      if (p->static_prio < NICE_TO_PRIO(0))
> >> -            return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
> >> +            timeslice = SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
> >>      else
> >> -            return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
> >> +            timeslice = SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
> >> +
> >> +    if (!TASK_INTERACTIVE(p))
> >> +            timeslice = cpu_rc_scale_timeslice(p, timeslice);
> >> +
> >> +    return timeslice;
> >>  }
> >
> > Why does timeslice scaling become undesirable if TASK_INTERACTIVE(p)?
> > With this barrier, you will completely disable scaling for many loads.
>
> Because interactive tasks tend to spend very small timeslice at one
> time, scaling timeslice for these tasks is not effective to control
> CPU spent.

It was not good explanation. Let me restate that.
The effect of shortening timeslice is to let the task be expired soon
by shortening
its remainder timeclice, so it still works even if the task consome very small
timeslice at one time. However, expired TASK_INTERACTIVE tasks will be requeued
to the active for a while by the scheduler, so shortening timeslice
doesn't work well for
TASK_INTERACTIVE tasks.

Thanks,
MAEDA Naoaki
