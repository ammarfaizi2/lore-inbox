Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUCOW1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUCOW1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:27:01 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49670
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262825AbUCOWXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:23:37 -0500
Date: Mon, 15 Mar 2004 23:24:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-ID: <20040315222419.GM30940@dualathlon.random>
References: <Pine.LNX.4.44.0403150822040.12895-100000@chimarrao.boston.redhat.com> <4055BF90.5030806@cyberone.com.au> <20040315145020.GC30940@dualathlon.random> <405628AC.4030609@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405628AC.4030609@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 09:05:32AM +1100, Nick Piggin wrote:
> 
> What I meant by unfairness is that low zone scanning in response
> to low zone pressure will not put any pressure on higher zones.
> Thus pages in higher zones have an advantage.

Ok I see what you mean now, in this sense the unfariness is the same
with the global lru too.

> We do scan lowmem in response to highmem pressure.

As I told Andrew, you've also to make sure not to start always from the
highmemzone, and from the code this seems not the case, so my 2G
scenario still applies.

Obviously I expected that you would can the lowmem zones too, otherwise
you couldn't allocate in cache more than 100M or so in a 1G box.

shrink_caches(struct zone **zones, int priority, int *total_scanned,
		int gfp_mask, int nr_pages, struct page_state *ps)
{
	int ret = 0;
	int i;

	for (i = 0; zones[i] != NULL; i++) {
		int to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX);
		struct zone *zone = zones[i];
		int nr_mapped = 0;
		int max_scan;

you seem to start always from zones[0] (that zone ** thing is the
zonelist so it starts with highmem, the normal then dma, depending on
the classzone you're shrinking). That will generate the waste of cache
in a 2G box that I described.

I'm reading 2.4.4 mainline here.

to really fix it, you need a global information keeping track of the
last zone shrinked to keep going in round robin.

Either that or you can choose to do some overwork and to shrink from all
the zones removing this break:

		if (ret >= nr_pages)
			break;

but as far as I can tell, the 50% waste of cache in a 2G box can happen
in 2.6.4 and it won't happen in 2.4.x.
