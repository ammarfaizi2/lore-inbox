Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbUJ0EoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbUJ0EoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbUJ0EoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:44:05 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:23273 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261626AbUJ0Ent (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:43:49 -0400
Date: Wed, 27 Oct 2004 06:44:45 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041027044445.GV14325@dualathlon.random>
References: <417DCFDD.50606@yahoo.com.au> <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com> <20041027005425.GO14325@dualathlon.random> <417F025F.5080001@yahoo.com.au> <20041027022920.GS14325@dualathlon.random> <417F0FA2.4090800@yahoo.com.au> <20041027032338.GU14325@dualathlon.random> <417F1746.2080607@yahoo.com.au> <20041026204308.73ee438b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026204308.73ee438b.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 08:43:08PM -0700, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > It actually can overscan lower zones a little bit, because
> >  whenever any higher zone in the pgdat is low on memory, then
> >  it and all zones below it get scanned too.
> 
> Because we know that all of the eligible zones are below pages_low.  kswapd
> will then work to bring all the relevant zones back to pages_high.

entering the loop is easy and shrinking all zones is easy.

is how much to free from each zone in kswapd that won't work as 2.4 did
with only pages_high.

what we'll happen is that we'll blindly free a few pages from each zone,
but then we'll be allowed to allocate the highmem pages, and not the
normal/dma pages. So after allocating the highmem pages we invoke kswapd
again and it frees again some highmem/normal/dma pages but we keep only
using the highmem ones.  So for a while we may be rolling over only the
highmem lru and ignoring all freed pages from the normal/dma zones.

2.4 would have freed all pages from the lower zones first (without
this additional rolling over the highmem zone). Though it's a bit hard
to compare since 2.4 had a global lru.

The bigger the highmem zone, the less it will matter the stuff that can
be cached in the low zones. And the smaller the highemm zone the less
imbalancing will be generated since the reservation will be minuscle on
the lower zones. So perhaps it already works fine, but this is not 2.4
was working (I'm sure to make it work like 2.4 you'd need to add the
lowmem_reserve in the when-to-stop-kswapd math). But maybe it works even
better this way?
