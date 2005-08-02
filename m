Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVHBAxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVHBAxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVHBAxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:53:48 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:8871 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261337AbVHBAxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:53:47 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1122931238.4623.17.camel@dhcp153.mvista.com>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <1122931238.4623.17.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 01 Aug 2005 20:53:30 -0400
Message-Id: <1122944010.6759.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 14:20 -0700, Daniel Walker wrote:
> On Mon, 2005-08-01 at 14:22 -0400, Steven Rostedt wrote:
> > Ingo,
> > 
> > What's with the "BUG: possible soft lockup detected on CPU..."? I'm
> > getting a bunch of them from the IDE interrupt.  It's not locking up,
> > but it does things that probably do take some time.  Is this really
> > necessary? Here's an example dump:
> > 
> > -- Steve
> > 
> > Note: I added the curr=%s:%d,current->comm,current->pid just to see who
> > was at fault. 
> 
> It means that IRQ 14 is running for a long time as an RT task .. btw,
> the curr=%s:%d information duplicates some in the "show all held locks"
> section .

yeah I know that was redundant (after putting it in), but I wanted to
make sure what current was. The locks held wasn't as straight forward as
to what was current (I wasn't looking at what produced that, I just
noticed the output).

> 
> I could base it off current_sched_time() to only trigger if the task has
> actually been running for 10 seconds, instead of just assuming that it
> has..

I thought about changing that too. But I'm assuming that you are looking
for bugs (like the kjournald as RT) where a task may be in a loop, but
higher priority tasks can still preempt it.  Putting the check elsewhere
will still be screwed up by preempting higher prio tasks.

In my custom kernel, I have a wchan field of the task that records where
the task calls something that might schedule. This way I can see where
things locked up if I don't have a back trace of the task.  This field
is always zero when it switches to usermode.  Something like this can
also be used to check how long the process is in kernel mode.  If a task
is in the kernel for more than 10 seconds without sleeping, that would
definitely be a good indication of something wrong.  I probably could
write something to check for this if people are interested.  I wont
waste my time if nobody would want it.

-- Steve


