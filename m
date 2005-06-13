Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVFMIG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVFMIG1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 04:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVFMIG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 04:06:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30706 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261369AbVFMIGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 04:06:24 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.05.10506130946010.10063-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506130946010.10063-100000@da410.phys.au.dk>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 01:05:05 -0700
Message-Id: <1118649905.5729.76.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 09:53 +0200, Esben Nielsen wrote:
> On Mon, 13 Jun 2005, Sven-Thorsten Dietrich wrote:
> > > 
> > 
> > Hi Esben,
> > 
> > I just wondered if you are talking about the scenario where an interrupt
> > is executing on one processor, and gets preempted. Then some code runs
> > on the same CPU, which does local_irq_disable (now preempt_disable), to
> > keep that IRQ from running, but the IRQ thread is already started?
> > 
> > In the community kernel, this could never happen, because IRQs can't be
> > preempted. But in RT, its possible an IRQ could be preempted, and under
> > some circumstance, this sequence could occur.
> > 
> > Is that is what you are talking about? If not, it might be over my head,
> > and I am sorry. If so, I think that scenario is covered under SMP.
> > 
> > Sven
> > 
> No, Sven it is not. I am not so worried about that scenario.
> I am worried about some coder somewhere still using local_irq_disable() -
> there is a lot of code out there doing that. We have not confirmed that
> all of it really locks small enough regions to preserver RT preemption.
> I for one is doubtfull about the cmos_lock thingy. (Sorry, can't connect
> to my machine at home to check where it is, right now.) A very weird setup
> with a kind of homebrewn spinlock.
> All these cases needs to be reviewed to see if it is valid to use a
> global lock type like local_irq_disable() or a local mutex must be used.
> The former is only "allowed" if the time being within the locked is
> deterministicly only in the order of the time for scheduling.
> I wanted to add a extra name to the namespace stating "this usage of
> local_irq_disable() have been reviwed wrt. RT_PREEMPT".

I am sure there are some issues like you describe out there.

I suppose we could examine each local_irq_disable, but I wonder if there
is not a better way.

I wrote earlier, that we could just keep specific IRQ threads from
runnning, rather than disabling preemption overall.

This is somewhat orthogonal, but would serve as a filter to break things
down into local_irq_disable to keep a specific IRQ from running, and
local_irq_disable to suppress all IRQ activity.

If we're going to walk trough all these local_irq_disables, we might as
well check-off that item as well.

What do you think?

Sven



