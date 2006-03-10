Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751740AbWCJFzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbWCJFzD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 00:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWCJFzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 00:55:03 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:5499 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751740AbWCJFzB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 00:55:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oguxBPj/EFhGC4K8xNc7p/87igEGIMPwD8pyQxPCRaFnixSaAOl7y9fdwRXe1ryZ0O8gEDlC/EfdE+vDPqO0rlWpprUR0ULzMt89IzgsZ7ky++i+qV/+ifXDbaeS5V+jQQJdbOgLiFB68Qx0whv4tTN4HArcFm0+tc4m8azIr5k=
Message-ID: <aec7e5c30603092155u59789c87u2f21c61078587d0b@mail.gmail.com>
Date: Fri, 10 Mar 2006 14:55:00 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
Cc: "Magnus Damm" <magnus@valinux.co.jp>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <441106C9.9040502@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <441106C9.9040502@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Magnus Damm wrote:
> > Unmapped patches - Use two LRU:s per zone.
> >
> > These patches break out the per-zone LRU into two separate LRU:s - one for
> > mapped pages and one for unmapped pages. The patches also introduce guarantee
> > support, which allows the user to set how many percent of all pages per node
> > that should be kept in memory for mapped or unmapped pages. This guarantee
> > makes it possible to adjust the VM behaviour depending on the workload.
> >
> > Reasons behind the LRU separation:
> >
> > - Avoid unnecessary page scanning.
> >   The current VM implementation rotates mapped pages on the active list
> >   until the number of mapped pages are high enough to start unmap and page out.
> >   By using two LRU:s we can avoid this scanning and shrink/rotate unmapped
> >   pages only, not touching mapped pages until the threshold is reached.
> >
> > - Make it possible to adjust the VM behaviour.
> >   In some cases the user might want to guarantee that a certain amount of
> >   pages should be kept in memory, overriding the standard behaviour. Separating
> >   pages into mapped and unmapped LRU:s allows guarantee with low overhead.
> >
> > I've performed many tests on a Dual PIII machine while varying the amount of
> > RAM available. Kernel compiles on a 64MB configuration gets a small speedup,
> > but the impact on other configurations and workloads seems to be unaffected.
> >
> > Apply on top of 2.6.16-rc5.
> >
> > Comments?
> >
>
> I did something similar a while back which I called split active lists.
> I think it is a good idea in general and I did see fairly large speedups
> with heavy swapping kbuilds, but nobody else seemed to want it :P

I want it if it helps you! =)

I don't see why both mapped and unmapped pages should be kept on the
same list at all actually, especially with the reclaim_mapped
threshold used today.  The current solution is to scan through lots of
mapped pages on the active list if the threshold is not reached. I
think avoiding this scanning can improve performance.

The single LRU solution today keeps mapped pages on the active list,
but always moves unmapped pages from the active list to the inactive
list. I would say that that solution is pretty different from having
two individual LRU:s with two lists each.

> So you split the inactive list as well - that's going to be a bit of
> change in behaviour and I'm not sure whether you gain anything.

Well, other parts of the VM still use lru_cache_add_active for some
mapped pages, so anonymous pages will mostly be in the active list on
the mapped LRU. My plan with using two full LRU:s is to provide two
separate LRU instances that individually will act as two-list LRU:s.
So active mapped pages should actually end up on the active list,
while seldom used mapped pages should be on the inactive list.

Also, I think it makes sense to separate mapped from unmapped because
mapped pages needs to clear the young-bits in the pte to track usage,
but unmapped activity happens through mark_page_accessed(). So mapped
pages needs to be scanned, but unmapped pages could say be moved to
the head of a list to avoid scanning. I'm not sure that is a win
though.

> I don't think PageMapped is a very good name for the flag.

Yeah, it's a bit confusing to both have PageMapped() and page_mapped().

> I test mapped lazily. Much better way to go IMO.

I will have a look at your patch to see how you handle things.

> I had further patches that got rid of reclaim_mapped completely while
> I was there. It is based on crazy metrics that basically completely
> change meaning if there are changes in the memory configuration of
> the system, or small changes in reclaim algorithms.

It is not very NUMA aware either, right?

I think there are many interesting things that are possible to improve
in the vmscan code, but I'm trying to change as little as possible for
now.

Thanks for the comments,

/ magnus
