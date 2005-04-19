Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVDSRjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVDSRjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 13:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVDSRjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 13:39:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57262 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261446AbVDSRjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 13:39:33 -0400
Date: Tue, 19 Apr 2005 12:39:30 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH [PPC64]: dead processes never reaped
Message-ID: <20050419173930.GZ15596@austin.ibm.com>
References: <20050418193833.GW15596@austin.ibm.com> <1113872485.5516.326.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113872485.5516.326.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 11:01:25AM +1000, Benjamin Herrenschmidt was heard to remark:
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
> I wonder why we bother doing all that at all... we could just return
> "prev" from __switch_to() no ? Like x86 does...

Probably.  I assume this funny two-step is left-over from a 2.4 kernel
design point.  Naively, we could rturn "prev", this would save a few
cycles. Cut the "addi  r3,r3,-THREAD" from entry.S as well.  I was being 
conservative with the patch, making the smallest change possible.  
Do you want this larger patch?


--linas

