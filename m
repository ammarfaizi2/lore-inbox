Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319795AbSIMV0I>; Fri, 13 Sep 2002 17:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319796AbSIMV0I>; Fri, 13 Sep 2002 17:26:08 -0400
Received: from packet.digeo.com ([12.110.80.53]:30696 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319795AbSIMV0H>;
	Fri, 13 Sep 2002 17:26:07 -0400
Message-ID: <3D825907.493B4DB3@digeo.com>
Date: Fri, 13 Sep 2002 14:30:47 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
References: <20020913210042.GA25464@elf.ucw.cz> <Pine.LNX.4.44L.0209131808240.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 21:30:52.0394 (UTC) FILETIME=[D5F42CA0:01C25B6C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Fri, 13 Sep 2002, Pavel Machek wrote:
> 
> > /*
> >  * Try to free as much memory as possible, but do not OOM-kill anyone
> >  *
> >  * Notice: all userland should be stopped at this point, or livelock
> > is possible.
> >  */
> >
> > This worked before -rmap came in, but it does not free anything
> > now. What needs to be done to fix it?
> 
> Actually, it still worked when -rmap came in, but it stopped working
> when the LRU lists were made to be per-zone...

hmm, I missed that.  Yes, the zone balancing in try_to_free_pages() will
see that all zones are above ->pages_high and will just return.

> > static void free_some_memory(void)
> > {
> >         printk("Freeing memory: ");
> >         while
> > (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
> >                 printk(".");
> >         printk("|\n");
> > }
> 
> Why don't you just allocate memory ?

That would work.
 
> To prevent the OOM kill you can just check for a variable
> in the OOM slow path.  No need to rely on any particular
> behaviour of the VM.
> 

Sure.

I'm not sure why swsusp needs "half of memory to be free"?  What's
the story there?

I'd recommend that you sit in a loop, allocating pages with an
allocation mode of

	__GFP_HIGHMEM | __GFP_WAIT

This will give you all the easily-reclaimable pages in the machine,
without trashing the page reserves (no __GFP_HIGH).

String all the pages together via page->list and when you have "enough",
free them all again.
