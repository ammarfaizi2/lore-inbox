Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbUCOSfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUCOSfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:35:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:59618 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262577AbUCOSf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:35:26 -0500
Date: Mon, 15 Mar 2004 10:35:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: piggin@cyberone.com.au, riel@redhat.com, marcelo.tosatti@cyclades.com,
       j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-Id: <20040315103510.25c955a3.akpm@osdl.org>
In-Reply-To: <20040315145020.GC30940@dualathlon.random>
References: <Pine.LNX.4.44.0403150822040.12895-100000@chimarrao.boston.redhat.com>
	<4055BF90.5030806@cyberone.com.au>
	<20040315145020.GC30940@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Tue, Mar 16, 2004 at 01:37:04AM +1100, Nick Piggin wrote:
> > This case I think is well worth the unfairness it causes, because it
> > means your zone's pages can be freed quickly and without freeing pages
> > from other zones.
> 
> freeing pages from other zones is perfectly fine, the classzone design
> gets it right, you have to free memory from the other zones too or you
> have no way to work on a 1G machine. you call the thing "unfair" when it
> has nothing to do with fariness, your unfariness is the slowdown I
> pointed out,

This "slowdown" is purely theoretical and has never been demonstrated.

One could just as easily point at the fact that on a 32GB machine with a
single LRU we have to send 64 highmem pages to the wrong end of the LRU for
each scanned lowmem page, thus utterly destroying any concept of it being
an LRU in the first place.  But this is also theoretical, and has never
been demonstrated and is thus uninteresting.

What _is_ interesting is the way in which the single LRU collapses when
there are a huge number amount of highmem pages on the tail and then there
is a surge in lowmem demand.  This was demonstrated, and is what prompted
the per-zone LRU.




Begin forwarded message:

Date: Sun, 04 Aug 2002 01:35:22 -0700
From: Andrew Morton <akpm@zip.com.au>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: how not to write a search algorithm


Worked out why my box is going into a 3-5 minute coma with one test.
Think what the LRUs look like when the test first hits page reclaim
on this 2.5G ia32 box:

               head                           tail
active_list:   <800M of ZONE_NORMAL> <200M of ZONE_HIGHMEM>
inactive_list:          <1.5G of ZONE_HIGHMEM>

now, somebody does a GFP_KERNEL allocation.

uh-oh.

VM calls refill_inactive.  That moves 25 ZONE_HIGHMEM pages onto
the inactive list.  It then scans 5000 pages, achieving nothing.

VM calls refill_inactive.  That moves 25 ZONE_HIGHMEM pages onto
the inactive list.  It then scans about 10000 pages, achieving nothing.

VM calls refill_inactive.  That moves 25 ZONE_HIGHMEM pages onto
the inactive list.  It then scans about 20000 pages, achieving nothing.

VM calls refill_inactive.  That moves 25 ZONE_HIGHMEM pages onto
the inactive list.  It then scans about 40000 pages, achieving nothing.

VM calls refill_inactive.  That moves 25 ZONE_HIGHMEM pages onto
the inactive list.  It then scans about 80000 pages, achieving nothing.

VM calls refill_inactive.  That moves 25 ZONE_HIGHMEM pages onto
the inactive list.  It then scans about 160000 pages, achieving nothing.

VM calls refill_inactive.  That moves 25 ZONE_HIGHMEM pages onto
the inactive list.  It then scans about 320000 pages, achieving nothing.

The page allocation fails.  So __alloc_pages tries it all again.


This all gets rather boring.


Per-zone LRUs will fix it up.  We need that anyway, because a ZONE_NORMAL
request will bogusly refile, on average, memory_size/800M pages to the
head of the inactive list, thus wrecking page aging.

Alan's kernel has a nice-looking implementation.  I'll lift that out
next week unless someone beats me to it.
--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/
