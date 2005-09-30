Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbVI3BY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbVI3BY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVI3BY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:24:59 -0400
Received: from fmr16.intel.com ([192.55.52.70]:30080 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751401AbVI3BY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:24:58 -0400
Subject: Re: [PATCH] earlier allocation of order 0 pages from pcp in
	__alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <719460000.1128034108@[10.10.2.4]>
References: <20050929150155.A15646@unix-os.sc.intel.com>
	 <719460000.1128034108@[10.10.2.4]>
Content-Type: text/plain
Organization: Intel 
Date: Thu, 29 Sep 2005 18:32:13 -0700
Message-Id: <1128043933.3735.26.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 01:24:42.0055 (UTC) FILETIME=[BBA28D70:01C5C55D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 15:48 -0700, Martin J. Bligh wrote:
> >         Try to service a order 0 page request from pcp list.  This will allow us to not check and possibly start the reclaim activity when there are free pages present on the pcp.  This early allocation does not try to replenish an empty pcp.
> > 
> >         Signed-off-by: Rohit Seth <rohit.seth@intel.com>
> 
> It seems a bit odd to copy more code to do this, which I think we already
> have in buffered_rmqueue? Can we clean up the flow a bit here ... it 
> is already looking messy in __alloc_pages with various gotos and crud
> there. I'm not saying what you're trying to do is bad, but the flow
> in there is getting more and move convoluted, and we perhaps need to
> straighten it. 
> 

I will update/streamline __alloc_pages code and send the patch.

> It looks like we're now dropping into direct reclaim as the first thing
> in __alloc_pages before even trying to kick off kswapd. When the hell
> did that start? Or is that only meant to trigger if we're already below
> the low watermark level?
> 

As Andrew said in the other mail that do_reclaim is never true so the
first reclaim never happens.  That also means that we don't look at pcp
for the scenarios when zone has run below the low water mark before
waking kswapd.

> What do we want to do at a higher level?
> 
> 	if (order 0) and (have stuff in the local lists)
> 		take from local lists
> 	else if (we're under a little pressure)
> 		do kswapd reclaim
> 	else if (we're under a lot of pressure)
> 		do direct reclaim?
> 
> That whole code area seems to have been turned into spagetti, without
> any clear comments.

Agreed. 

