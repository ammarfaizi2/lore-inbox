Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWDXJsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWDXJsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 05:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWDXJsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 05:48:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:56720 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750700AbWDXJso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 05:48:44 -0400
X-Authenticated: #14349625
Subject: Re: [ckrm-tech] Re: [RFC][PATCH 5/9] CPU controller - Documents
	how the controller works
From: Mike Galbraith <efault@gmx.de>
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
In-Reply-To: <444C6F3C.1070505@jp.fujitsu.com>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <20060421022753.13598.77686.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <1145776430.7990.58.camel@homer>  <444C6F3C.1070505@jp.fujitsu.com>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 11:49:52 +0200
Message-Id: <1145872192.19240.59.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 15:25 +0900, MAEDA Naoaki wrote:
> Mike Galbraith wrote:
> > On Fri, 2006-04-21 at 11:27 +0900, maeda.naoaki@jp.fujitsu.com wrote:
> >> +3. Timeslice scaling
> >> +
> >> + If there are hungry classes, we need to adjust timeslices to satisfy
> >> + the share.  To scale timeslices, we introduce a scaling factor
> >> + used for scaling timeslices.  The scaling factor is associated with
> >> + the class (stored in the cpu_rc structure) and adaptively adjusted
> >> + according to the class load and the share.
> > 
> > This all works fine until interactive task requeueing is considered, and
> > it must be considered.
> > 
> > One simple way to address the requeue problem is to introduce a scaled
> > class sleep_avg consumption factor.  Remove the scaling exemption for
> > TASK_INTERACTIVE(p), and if a class's cpu usage doesn't drop to what is
> > expected by group timeslice scaling, make members consume sleep_avg at a
> > higher rate such that scaling can take effect.
> 
> Interesting approach. However, I'm worrying about hurting interactive
> response by this change.

It will certainly do so if _truely_ interactive tasks are using
significant cpu.

> > A better way to achieve the desired group cpu usage IMHO would be to
> > adjust nice level of members at slice refresh time.  This way, you get
> > the timeslice scaling and priority adjustment all in one.
> > 
> > (I think I would do both actually, with nice level being preferred such
> > that dynamic priority spread within the group isn't flattened, which can
> > cause terminal starvation within the group, unless really required.)
> 
> If nice is changed, the task priority is also changed. I don't think
> changing the task priority for this purpose is a good choice, but
> only lengthen the timeslice would work and that is what I'm considering.

How would that help if the cause of starvation is "interactive" tasks
being requeued?  At present, EXPIRED_STARVING() will initiate an array
switch, but that only gives you one slice every nr_running seconds.  For
one non-interactive task (group A) to achieve parity with N interactive
tasks (group B) which are doing round-robin requeue, you'd need an N
second slice.

> Another obvious bad case is an imbalanced number of runnable tasks
> in the different groups. Since minimum timeslice is 1 tick,
> minimum share is the factor of number of runnable tasks in the group.
> If 1% share group contains 99 runnable tasks and the other 99% share
> group has just one runnable task, the load of the two groups would be
> the same. (It becomes worse in small HZ configuration.)

A group scheduler (array of arrays) would solve that as well as the
above.  You can kind of implement such a scheduler within the scheduler
via priority twiddling, but I don't think you can't get there from here
via timeslice modulation alone.

> I've tried different approach to compensate for this badness.
> Which is to requeue the starving tasks to the active as if they are
> TASK_INTERACTIVE, but it sometimes hurt system response and other
> undesirable side effect was observed.

Yeah, I'm currently requeueing based upon latency, and it does have both
promise and some interesting rough spots.  I've eliminated the massively
painful to interactive tasks array switch when busy successfully, but
requeueing starving tasks within the active array itself still needs
work. 

> Now, I'm thinking to enlarge the timeslice of starving groups.

Good luck.

	-Mike

