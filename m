Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVJaUsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVJaUsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVJaUsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:48:13 -0500
Received: from fmr22.intel.com ([143.183.121.14]:19423 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751210AbVJaUsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:48:12 -0500
Subject: Re: [PATCH]: Clean up of __alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <4362DF80.3060802@yahoo.com.au>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	 <4362DF80.3060802@yahoo.com.au>
Content-Type: text/plain
Organization: Intel 
Date: Mon, 31 Oct 2005 12:55:07 -0800
Message-Id: <1130792107.4853.24.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2005 20:47:56.0985 (UTC) FILETIME=[5F75F290:01C5DE5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-29 at 12:33 +1000, Nick Piggin wrote:

> Rohit, Seth wrote:
> > the only changes in this clean up are:
> > 
> 
> Looking good. I imagine it must be good for icache.
> Man, the page allocator somehow turned unreadable since I last
> looked at it! We will want this patch.
> 

Thanks for your comments.

> > 	1- remove the initial direct reclaim logic
> > 	2- GFP_HIGH pages are allowed to go little below low watermark sooner
> 
> I don't think #2 is any good. The reason we don't check GFP_HIGH on
> the first time round is because we simply want to kick kswapd at its
> normal watermark - ie. it doesn't matter what kind of allocation this
> is, kswapd should start at the same time no matter what.
> 
> If you don't do this, then a GFP_HIGH allocator can allocate right
> down to its limit before it kicks kswapd, then it either will fail or
> will have to do direct reclaim.
> 

You are right if there are only GFP_HIGH requests coming in then the
allocation will go down to (min - min/2) before kicking in kswapd.
Though if the requester is not ready to wait, there is another good shot
at allocation succeed before we get into direct reclaim (and this is
happening based on can_try_harder flag).

> >
> >  got_pg:
> > -	zone_statistics(zonelist, z);
> > +	zone_statistics(zonelist, page_zone(page));
> >  	return page;
> 
> How about moving the zone_statistics up into the 'if (page)'
> test of get_page_from_freelist? This way we don't have to
> evaluate page_zone().
> 

Let us keep this as is for now.  Will revisit once after the
pcp_prefer_allocation patches get in place. 

Thanks,
-rohit

