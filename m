Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWHRWly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWHRWly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWHRWly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:41:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751156AbWHRWlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:41:52 -0400
Date: Fri, 18 Aug 2006 15:34:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@google.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Message-Id: <20060818153455.2a3f2bcb.akpm@osdl.org>
In-Reply-To: <44E62F7F.7010901@google.com>
References: <20060808211731.GR14627@postel.suug.ch>
	<44DBED4C.6040604@redhat.com>
	<44DFA225.1020508@google.com>
	<20060813.165540.56347790.davem@davemloft.net>
	<44DFD262.5060106@google.com>
	<20060813185309.928472f9.akpm@osdl.org>
	<1155530453.5696.98.camel@twins>
	<20060813215853.0ed0e973.akpm@osdl.org>
	<44E3E964.8010602@google.com>
	<20060816225726.3622cab1.akpm@osdl.org>
	<44E5015D.80606@google.com>
	<20060817230556.7d16498e.akpm@osdl.org>
	<44E62F7F.7010901@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 14:22:07 -0700
Daniel Phillips <phillips@google.com> wrote:

> Andrew Morton wrote:
> >Daniel Phillips wrote:
> >>Andrew Morton wrote:
> >
> > ...it's runtime configurable.
> 
> So we default to "less than the best" because we are too lazy to fix the
> network starvation issue properly?  Maybe we don't really need a mempool for
> struct bio either, isn't that one rather like the reserve pool we propose
> for sk_buffs?  (And for that matter, isn't a bio rather more like an sk_buff
> than one would think from the code we have written?)
> 
> >>unavailable for write caching just to get around the network receive
> >> starvation issue?
> > 
> > No, it's mainly to avoid latency: to prevent tasks which want to allocate
> > pages from getting stuck behind writeback.
> 
> This seems like a great help for some common loads, but a regression for
> other not-so-rare loads.  Regardless of whether or not marking 60% of memory
> as unusable for write caching is a great idea, it is not a compelling reason
> to fall for the hammer/nail trap.
> 
> >>What happens if some in kernel user grabs 68% of kernel memory to do some
> >>very important thing, does this starvation avoidance scheme still work?
> > 
> > Well something has to give way.  The process might get swapped out a bit,
> > or it might stall in the page allocator because of all the dirty memory.
> 
> It is that "something has to give way" that makes me doubt the efficacy of
> our global write throttling scheme as a solution for network receive memory
> starvation.  As it is, the thing that gives way may well be the network
> stack.  Avoiding this hazard via a little bit of simple code is the whole
> point of our patch set.
> 
> Yes, we did waltz off into some not-so-simple code at one point, but after
> discussing it, Peter and I agree that the simple approach actually works
> well enough, so we just need to trim down the patch set accordingly and
> thus prove that our approach really is nice, light and tight.
> 
> Specifically, we do not actually need any fancy sk_buff sub-allocator
> (either ours or the one proposed by davem).  We already got rid of the per
> device reserve accounting in order to finesse away the sk_buff->dev oddity
> and shorten the patch.  So the next rev will be rather lighter than the
> original.
> 

Sigh.  Daniel, in my earlier emails I asked a number of questions regarding
whether existing facilities, queued patches or further slight kernel
changes could provide a sufficient solution to these problems.  The answer
may well be "no".  But diligence requires that we be able to prove that,
and handwaving doesn't provide that proof, does it?
