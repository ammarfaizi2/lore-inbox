Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbUCOV4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUCOV4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:56:04 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34310
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262822AbUCOVyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:54:53 -0500
Date: Mon, 15 Mar 2004 22:55:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: piggin@cyberone.com.au, riel@redhat.com, marcelo.tosatti@cyclades.com,
       j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-ID: <20040315215532.GJ30940@dualathlon.random>
References: <Pine.LNX.4.44.0403150822040.12895-100000@chimarrao.boston.redhat.com> <4055BF90.5030806@cyberone.com.au> <20040315145020.GC30940@dualathlon.random> <20040315103510.25c955a3.akpm@osdl.org> <20040315185147.GH30940@dualathlon.random> <20040315110240.24ae4bad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315110240.24ae4bad.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 11:02:40AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > The effect is that you can do stuff like 'cvs up' and you will end up
> >  caching just 1G instead of 2G. Or do I miss something? If I would own a
> >  2G box I would hate to be able to cache just 1 G (yeah, the cache is 2G
> >  but half of that cache is pinned and it sits there with years old data,
> >  so effectively you lose 50% of the ram in the box in terms of cache
> >  utilization).
> 
> Nope, we fill all zones with pagecache and once they've all reached
> pages_low we scan all zones in proportion to their size.  So the
> probability of a page being scanned is independent of its zone.
> 
> It took a bit of diddling, but it seems to work OK now.  Here are the
> relevant bits of /proc/vmstat from a 1G machine, running 2.6.4-rc1-mm1 with
> 13 days uptime:
> 
> pgalloc_high 65658111
> pgalloc_normal 384294820
> pgalloc_dma 617780
> 
> pgrefill_high 5980273
> pgrefill_normal 11873490
> pgrefill_dma 69861
> 
> pgsteal_high 2377905
> pgsteal_normal 10504356
> pgsteal_dma 4756
> 
> pgscan_kswapd_high 3621882
> pgscan_kswapd_normal 15652593
> pgscan_kswapd_dma 99
> 
> pgscan_direct_high 54120
> pgscan_direct_normal 162353
> pgscan_direct_dma 69377
> 
> These are approximately balanced wrt the zone sizes, with a bias towards
> ZONE_NORMAL because of non-highmem allocations.  It's not perfect, but we
> did fix a few things up after 2.6.4-rc1-mm1.

as far as you don't always start from the highmem zone (so you need a
per-classzone variable to keep track of the last zone scanned and to
start shrinking from zone-normal and zone-dma if needed), the above
should avoid the problem I mentioned for the 2G setup.
