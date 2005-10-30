Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVJ3Q7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVJ3Q7U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 11:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVJ3Q7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 11:59:20 -0500
Received: from gold.veritas.com ([143.127.12.110]:32855 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932181AbVJ3Q7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 11:59:19 -0500
Date: Sun, 30 Oct 2005 16:58:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: munmap extremely slow even with untouched mapping.
In-Reply-To: <43644C22.8050501@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0510301631360.2848@goblin.wat.veritas.com>
References: <20051028013738.GA19727@attica.americas.sgi.com>
 <43620138.6060707@yahoo.com.au> <Pine.LNX.4.61.0510281557440.3229@goblin.wat.veritas.com>
 <43644C22.8050501@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Oct 2005 16:59:15.0071 (UTC) FILETIME=[422648F0:01C5DD73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Oct 2005, Nick Piggin wrote:
> Hugh Dickins wrote:
> > 
> > I prefer your patch too.  But I'm not very interested in temporary
> > speedups relative to 2.6.14.  Attacking this is a job I'd put off
> > until after the page fault scalability changes, which make it much
> > easier to do a proper job.
> 
> Yeah definitely.
> 
> I wonder if we should go with Robin's fix (+/- my variation)
> as a temporary measure for 2.6.15?

You're right, I was too dismissive.  I've now spent a day looking into
the larger rework, and it's a bigger job than I'd thought - partly the
architecture variations, partly the fast/slow paths and other "tlb" cruft,
partly the truncation case's i_mmap_lock (and danger of making no progress
whenever we drop it).  I'll have to set all that aside for now.

I've taken another look at the two patches.  The main reason I preferred
yours was that I misread Robin's!  But yes, yours takes it a bit further,
and I think that is worthwhile.

But a built and tested version would be better.  Aren't you trying to
return addr from each level (that's what I liked, and what I'll want to
do in the end)?  But some levels are returning nothing, and unmap_vmas
does start +=, and the huge case leaves start unchanged, and zap_work
should be a long so it doesn't need casting almost everywhere, and...
given all that, I bet there's more!

As to whether p??_none should count for 1 where !pte_none counts for
PAGE_SIZE, well, they say a picture is worth a thousand words, and I'm
sure that's entered your calculation ;-)  I'd probably make the p??_none
count for a little more.  Perhaps we should get everyone involved in a
great profiling effort across the architectures to determine it.
Config option.  Sys tunable.  I'll shut up.

Hugh
