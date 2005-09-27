Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVI0T5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVI0T5v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 15:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVI0T5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 15:57:51 -0400
Received: from fmr16.intel.com ([192.55.52.70]:42132 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750837AbVI0T5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 15:57:51 -0400
Subject: Re: 2.6.14-rc2-mm1
From: Rohit Seth <rohit.seth@intel.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org
In-Reply-To: <922980000.1127847470@flay>
References: <922980000.1127847470@flay>
Content-Type: text/plain
Organization: Intel 
Date: Tue, 27 Sep 2005 13:05:02 -0700
Message-Id: <1127851502.6144.10.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 19:57:39.0521 (UTC) FILETIME=[B6DDFB10:01C5C39D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 11:57 -0700, Martin J. Bligh wrote:
> > Seems like from the log messages that quite a few pages are hanging
> in the cpu's cold pcp list even with the low memory conditions.  Below
> is the patch to reduce the higher bound in cold pcp list (...this got
> increased with my previous change).  
> 
> >  
> > I think we should also drain the CPU's hot and cold pcps for the
> GFP_KERNEL page requests (in the event the higher order request is not
> able to get serviced otherwise).  This will still only drains the
> current CPUs pcps in an MP environment (leaving the other CPUs with
> their lists intact).  I will send this patch later today.
> 
> >  
> >       [PATCH]: Reduce the high mark in cpu's cold pcp list. 
> >  
> >       Signed-off-by: Rohit Seth <rohit.seth@intel.com> 
> >  
> >  
> > --- linux-2.6.13.old/mm/page_alloc.c  2005-09-26 10:57:07.000000000
> -0700 
> > +++ linux-2.6.13.work/mm/page_alloc.c 2005-09-26 10:47:57.000000000
> -0700 
> > @@ -1749,7 +1749,7 @@ 
> >       pcp = &p->pcp[1];               /* cold*/ 
> >       pcp->count = 0; 
> >       pcp->low = 0; 
> > -     pcp->high = 2 * batch; 
> > +     pcp->high = batch / 2; 
> >       pcp->batch = max(1UL, batch/2); 
> >       INIT_LIST_HEAD(&pcp->list); 
> >  } 
> > -
> 
> I don't understand. How can you set the high watermark at half the
> batch size? Makes no sense to me.
> 

The batch size for the cold pcp list is getting initialized to batch/2
in the code snip above.  So, this change is setting the high water mark
for cold list to same as pcp's batch number.

> And can you give a stricter definiton of what you mean by "low memory 
> conditions"? I agree we ought to empty the lists before going OOM or 
> anything, but not at the slightest feather of pressure ... answer lies
> somewhere inbetween ... but where?
> 

In the specific case of dump information that Mattia sent earlier, there
is only 4M of free mem available at the time the order 1 request is
failing.  

In general, I think if a specific higher order ( > 0) request fails that
has GFP_KERNEL set then at least we should drain the pcps.

-rohit


