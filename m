Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVDSRWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVDSRWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 13:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVDSRWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 13:22:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:40327 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261265AbVDSRWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 13:22:34 -0400
Date: Tue, 19 Apr 2005 12:22:31 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH [PPC64]: dead processes never reaped
Message-ID: <20050419172231.GY15596@austin.ibm.com>
References: <20050418193833.GW15596@austin.ibm.com> <1113872821.5516.330.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113872821.5516.330.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 11:07:01AM +1000, Benjamin Herrenschmidt was heard to remark:
> On Mon, 2005-04-18 at 14:38 -0500, Linas Vepstas wrote:
> > 
> > Hi,
> > 
> > The patch below appears to fix a problem where a number of dead processes
> > linger on the system.  On a highly loaded system, dozens of processes 
> > were found stuck in do_exit(), calling thier very last schedule(), and
> > then being lost forever.  
> > 
> > Processes that are PF_DEAD are cleaned up *after* the context switch, 
> > in a routine called finish_task_switch(task_t *prev). The "prev" gets 
> > the  value returned by _switch() in entry.S, but this value comes from 
> >   
> > __switch_to (struct task_struct *prev, 
> >             struct task_struct *new) 
> > { 
> >    old_thread = &current->thread; ///XXX shouldn't this be prev, not current? 
> >    last = _switch(old_thread, new_thread); 
> >    return last; 
> > } 
> >  
> > The way I see it, "prev" and "current" are almost always going to be  
> > pointing at the same thing; however, if a "need resched" happens,  
> > or there's a pre-emept or some-such, then prev and current won't be  
> > the same; in which case, finish_task_switch() will end up cleaning  
> > up the old current, instead of prev.  This will result in dead processes 
> > hanging around, which will never be scheduled again, and will never  
> > get a chance to have put_task_struct() called on them.  
> 
> Ok, thinking moer about this ... that will need maybe some help from
> Ingo so I fully understand where schedule's are allowed ... We are
> basically in the middle of the scheduler here, so I wonder how much of
> the scheduler itself can be preempted or so ...
> 
> Basically, under which circumstances can prev and current be different ?

I remember finding a path through void __sched schedule(void) that
took a branch through the goto need_resched; that would result in this.
I takes a bit of mental gymnastics to see how this might happen.

FWIW, I can send you a debug session showing all cpu's idle and 44 dead 
processes sitting in do_exit().  All but two of these were Java threads,
so this seems to be some sort of thread-scheduling subtlty.  (the two
that weren't java threads were a find|grep pair that must have gotten 
tangled in.)

Given that the patch seems to fix the problem, I didn't dig much deeper.

--linas

