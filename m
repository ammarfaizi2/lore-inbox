Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVFKNNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVFKNNk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 09:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVFKNNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 09:13:40 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:29870 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261696AbVFKNNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 09:13:37 -0400
Date: Sat, 11 Jun 2005 15:13:20 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <1118449247.27756.47.camel@dhcp153.mvista.com>
Message-Id: <Pine.OSF.4.05.10506111455240.2917-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2005, Daniel Walker wrote:

> On Sat, 2005-06-11 at 01:37 +0200, Esben Nielsen wrote:
> [...]
> > As far as I can see the only solution is to replace them with a per-cpu
> > mutex. Such a mutex can be the rt_mutex for now, but someone may want to
> > make a more optimized per-cpu version where a raw_spin_lock isn't used.
> > That would make it nearly as cheap as cli()/sti() when there is no
> > congestion. One doesn't need PI for this region either as the RT
> > subsystems will not hit it anyway.
> 
> I don't like this solution mainly because it's so expensive. cli/sti may
> take a few cycles at most, what your suggesting may take 50 times that,
> which would similar in speed to put linux under adeos.. 

We are only talking about the local_irq_disable()/enable() in drivers, not
the core system, right? Therefore making it into a mutex will not be that
expensive overall.

> Plus take into
> account that the average interrupt disable section is very small .. I
> also think it's possible to extend my version to allow those section to
> be preemptible but keep the cost equally low.
> 

The more I think about it the more dangerous I think it is. What does
local_irq_disable() protect against? All local threads as well as
irq-handlers. If these sections keeped mutual exclusive but preemtible we
will not have protected against a irq-handler.

I will start to play around with the following:
1) Make local_irq_disable() stop compiling to see how many we are really
talking about.
2) Make local_cpu_lock, which on PREEMPT_RT is a rt_mutex and on
!PREEMPT_RT turns into local_irq_disable()/enable() pairs. To introduce
this will demand some code-analyzing for each case but I am afraid there
is no general one-size solution to all the places.

> Daniel
> 
> 

Esben


