Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266761AbUGUWi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266761AbUGUWi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266766AbUGUWi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:38:28 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:22945 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266761AbUGUWiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:38:23 -0400
Date: Wed, 21 Jul 2004 18:37:49 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721223749.GA2863@yoda.timesys>
References: <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721211826.GB30871@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 11:18:26PM +0200, Ingo Molnar wrote:
> * Scott Wood <scott@timesys.com> wrote:
> 
> > It appears, though, that recent kernel versions do preempt_disable()
> > in ksoftirqd, apparently to support CPU hotplugging[1].  When I
> > originally made the patch (against 2.6.0), this wasn't the case. 
> > Since it was done so recently, hopefully there are no cases since then
> > that have started depending on this behavior.
> 
> do_softirq() always did a local_bh_disable() which stops preemption, so
> softirq processing was always non-preemptible.

Hmm... I'm not sure how I missed that (probably by misreading the
local_irq_enable() that comes after it as a local_bh_enable()).

> believe me, as someone who took part in the discussions that designed
> softirqs years ago and cleaned up some of it later on, i can tell you
> that this property of softirqs was and is fully intentional. It's not
> just some side-effect that got relied on by random code - it was used
> from day one on. E.g. it enables exclusion against softirq contexts
> without having to use cli/sti.

It'd be nice to use locks that only exclude the specific regions in
the softirqs that are needed, but that's a lot to change at this
point...

> trying to make softirqs preemptible surely wont fly for 2.6 and it will
> also overly complicate the softirq model. What's so terminally wrong
> about adding preemption checks to the softirq paths? It should solve the
> preemption problem for good. The unbound softirq paths are well-known
> (mostly in the networking code) and already have preemption-alike
> checks.

If every such loop in every softirq is taken care of, that would work
(though only until someone adds a new softirq that forgets to check
for preemption).  I don't see any such checks in either the transmit
or receive network softirqs in vanilla 2.6.7, though (are they in a
patch, or am I overlooking them?), much less in each individual
driver.  There are checks for excessive work (where "excessive" is
not well defined in terms of actual time), but none for need_resched()
except in a few isolated places.

-Scott
