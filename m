Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVFKQJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVFKQJt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVFKQJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:09:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26351 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261698AbVFKQJp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:09:45 -0400
Date: Sat, 11 Jun 2005 09:09:36 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <Pine.OSF.4.05.10506111455240.2917-100000@da410.phys.au.dk>
Message-ID: <Pine.LNX.4.10.10506110904100.27294-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Jun 2005, Esben Nielsen wrote:

> On Fri, 10 Jun 2005, Daniel Walker wrote:
> 
> > On Sat, 2005-06-11 at 01:37 +0200, Esben Nielsen wrote:
> > [...]
> > > As far as I can see the only solution is to replace them with a per-cpu
> > > mutex. Such a mutex can be the rt_mutex for now, but someone may want to
> > > make a more optimized per-cpu version where a raw_spin_lock isn't used.
> > > That would make it nearly as cheap as cli()/sti() when there is no
> > > congestion. One doesn't need PI for this region either as the RT
> > > subsystems will not hit it anyway.
> > 
> > I don't like this solution mainly because it's so expensive. cli/sti may
> > take a few cycles at most, what your suggesting may take 50 times that,
> > which would similar in speed to put linux under adeos.. 
> 
> We are only talking about the local_irq_disable()/enable() in drivers, not
> the core system, right? Therefore making it into a mutex will not be that
> expensive overall.

No, core system . We're talking about everything, including
raw_spinlock_t.
 
> The more I think about it the more dangerous I think it is. What does
> local_irq_disable() protect against? All local threads as well as
> irq-handlers. If these sections keeped mutual exclusive but preemtible we
> will not have protected against a irq-handler.

Which IRQ handlers are those ? There is only one interrupt context handler
that must be protected, if you enable PREEMPT_HARDIRQS .
 
> I will start to play around with the following:
> 1) Make local_irq_disable() stop compiling to see how many we are really
> talking about.

I did that in my release notes , my patch reduced the number of cli's in
my kernel to 30% of what was in PREEMPT_RT .

Daniel

