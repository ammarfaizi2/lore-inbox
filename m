Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbULHUex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbULHUex (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbULHUew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:34:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34992 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261353AbULHUei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:34:38 -0500
Date: Wed, 8 Dec 2004 14:34:26 -0600
From: Dean Nelson <dcn@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: chrisw@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <20041208203426.GA6370@sgi.com>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com> <20041115105801.T14339@build.pdx.osdl.net> <20041115203343.GA32173@sgi.com> <20041116104821.GA31395@elte.hu> <20041116201841.GA29687@sgi.com> <20041116223608.GA27550@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116223608.GA27550@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 11:36:08PM +0100, Ingo Molnar wrote:
> 
> * Dean Nelson <dcn@sgi.com> wrote:
> 
> > > could you make sched_setscheduler() also include a parameter for the
> > > nice value, so that ->static_prio could be set at the same time too
> > > (which would have relevance if SCHED_OTHER is used)? This would make it
> > > a generic kernel-internal API to change all the priority parameters.
> > > Looks good otherwise.
> > 
> > Yeah, I can do that. I'll probably be getting back to you with a
> > question or two, if what you're after isn't obvious once I start
> > making the changes for the nice parameter.
> 
> another potential API would be to use the linear priority range that the
> scheduler has internally, from 0 (RT prio 99) to 140 (nice +19). I'm not
> sure which solution is the better one. Using the linear priority has the
> advantage of not having to pass any policy value - priorities between 0
> and 99 implicitly mean SCHED_FIFO, priorities above that would mean
> SCHED_NORMAL, a pretty natural and compact interface.

I realize that I don't know where you are ultimately headed with your
ideas for scheduling changes, but as things are it doesn't make sense
to me to drop the SCHED_RR scheduling policy. There may be existing
users who depend on the preemptive nature of this policy. It seems too
much of a risk to eliminate this policy at this time.

Regarding the nice argument itself, it strikes me that it needs to be an
optional argument in the sense that the caller should be able to indicate
that they're not passing a nice value. To simply pass the task's current
nice value has a window of vulnerability in that after fetching the current
nice value via TASK_NICE(p) but before doing anything with it, another
thread could change the task's nice value to something else, then we
end up setting it back to what it was. Would it be better to have callers
pass the nice value as NICE_TO_PRIO(nice), with sched_setscheduler()
treating zero as no nice value arg was passed, and ensuring if non-zero
that '-20 <= PRIO_TO_NICE(nice_prio) <= 19' was true? Or do you simply
want to ignore the window and always pass?

If the nice value arg was passed, would we want to call
security_task_setnice() as sys_nice() does? Also, set_user_nice()
allows the realtime tasks to set the nice value (p->static_prio =
NICE_TO_PRIO(nice)) but it doesn't take effect until the policy is
changed to SCHED_NORMAL. I'm assuming we wouldn't support this in
sched_setscheduler() since you want to tie the nice value arg to
the SCHED_NORMAL policy only.

I'm assuming that we need to allow for the struct sched_param pointer
to be NULL, if the caller of sched_scheduler() only wanted to set the
nice value?

Having asked all of these questions, I must say that I'm not clear on
the value of adding the nice argument to sched_setscheduler().
Who do you envision calling sched_setscheduler() with it set? Will it
be replacing set_user_nice() at some point?

I'm still willing to add a nice argument if you feel it's appropriate
(and I can get answers to my many questions :-)). But Would it be
acceptable to you to separate this work into two parts? The first
part would be along the lines of breaking up setscheduler() into
do_sched_setscheduler() and sched_setscheduler(), and exporting
sched_setscheduler() like in my proposed patch. And the second part
would be to add your nice argument to sched_setscheduler(). I'm
thinking it may take some fiddling to arrive at a proper nice arg
patch, and I really need to get the exporting of sched_setscheduler()
patch accepted in a timely fashion.

Thanks,
Dean
