Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422902AbWBOHIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422902AbWBOHIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbWBOHIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:08:22 -0500
Received: from fmr23.intel.com ([143.183.121.15]:37016 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1422902AbWBOHIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:08:21 -0500
Date: Tue, 14 Feb 2006 23:07:45 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, kernel@kolivas.org, npiggin@suse.de,
       mingo@elte.hu, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
Message-ID: <20060214230745.A1677@unix-os.sc.intel.com>
References: <43ED3D6A.8010300@bigpond.net.au> <20060214010712.B20191@unix-os.sc.intel.com> <43F25C60.4080603@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43F25C60.4080603@bigpond.net.au>; from pwil3058@bigpond.net.au on Wed, Feb 15, 2006 at 09:40:32AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 09:40:32AM +1100, Peter Williams wrote:
> Siddha, Suresh B wrote:
> > On a 4P(8-way with HT), if you run a -20 task(a simple infinite loop)
> > it hops from one processor to another processor... you can observe it
> > using top.
> 
> How do you get top to display which CPU tasks are running on?

In the interactive mode, you can select the "last used cpu" field to display.
or you can use /proc/pid/stat

> > 
> > find_busiest_group() thinks there is an imbalance and ultimately the
> > idle cpu kicks active load balance on busy cpu, resulting in the hopping.
> 
> I'm still having trouble getting my head around this.  A task shouldn't 
> be moved unless there's at least one other task on its current CPU, it 

Because of the highest priority task, weighted load of that cpu
will be > SCHED_LOAD_SCALE. Because of this, an idle cpu in 
find_busiest_group() thinks that there is an imbalance.. This is due to
the code near the comment "however we may be able to increase 
total CPU power used by ...". That piece of code assumes that a unit load
is represented by SCHED_LOAD_SCALE (which is no longer true with smpnice)
and finally results in "pwr_move > pwr_now".. This will make the idle cpu
try to pull that process from busiest cpu and the process will ultimately move
with the help of active load balance...

> > I agree with you.. But lets take a DP system with HT, now if there are
> > only two low priority tasks running, ideally we should be running them
> > on two different packages. With this patch, we may end up running on the
> > same logical processor.. leave alone running on the same package..
> > As these are low priority tasks, it might be ok.. But...
> 
> Yes, this is an issue but it's not restricted to HT systems (except for 

Agreed.

> the same package part).  The latest patch that I've posted addresses 
> (part of) this problem by replacing SCHED_LOAD_SCALE with the average 
> load per runnable task in the code at the end of find_busiest_group() 
> which handles the case where imbalance is small.  This should enable 
> load balancing to occur even if all runnable tasks are low priority.

Yes. We need to fix the code I mentioned above too.... And please make sure
it doesn't break HT optimizations as this piece of code is mainly used
for implementing HT optimizations..

thanks,
suresh
