Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVAUHH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVAUHH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVAUHFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:05:35 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:28072 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262297AbVAUHEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:04:32 -0500
Subject: Re: OOM fixes 2/5
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20050120224645.3351d22c.akpm@osdl.org>
References: <20050121054840.GA12647@dualathlon.random>
	 <20050121054916.GB12647@dualathlon.random>
	 <20050120222056.61b8b1c3.akpm@osdl.org>
	 <1106289375.5171.7.camel@npiggin-nld.site>
	 <20050120224645.3351d22c.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 18:04:25 +1100
Message-Id: <1106291065.5171.23.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 22:46 -0800, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > It does turn on lowmem protection by default. We never reached
> > an agreement about doing this though, but Andrea has shown that
> > it fixes trivial OOM cases.
> > 
> > I think it should be turned on by default. I can't recall what
> > your reservations were...?
> > 
> 
> Just that it throws away a bunch of potentially usable memory.  In three
> years I've seen zero reports of any problems which would have been solved
> by increasing the protection ratio.
> 
> Thus empirically, it appears that the number of machines which need a
> non-zero protection ratio is exceedingly small.  Why change the setting on
> all machines for the benefit of the tiny few?  Seems weird.  Especially
> when this problem could be solved with a few-line initscript.  Ho hum.


That is true, but it should not reserve a great deal of memory on
small memory machines. ZONE_NORMAL reservation may not even be too
noticeable as you'll usually have ZONE_NORMAL allocations during
the course of normal running.

Although it is true that there haven't been many problems attributed
to this, one example I can remember is when we fixed the __alloc_pages
watermark code, we fixed a bug that was reserving much more ZONE_DMA
than it was supposed to. This cased all those page allocation failure
problems. So we raised the atomic reserve, but that didn't bring
ZONE_DMA reservation back to its previous levels.

"So the buffer between GFP_KERNEL and GFP_ATOMIC allocations is:

2.6.8      | 465 dma, 117 norm, 582 tot = 2328K
2.6.10-rc  |   2 dma, 146 norm, 148 tot =  592K
patch      |  12 dma, 500 norm, 512 tot = 2048K"

So we were still seeing GFP_DMA allocation failures in the sound code.
You recently had to make that NOWARN to shut it up.

OK this is a fairly lame example... but the current code is more or
less just lucky that ZONE_DMA doesn't usually fill up with pinned mem
on machines that need explicit ZONE_DMA allocations.



Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
