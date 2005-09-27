Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbVI0Vos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbVI0Vos (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbVI0Vos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:44:48 -0400
Received: from fmr16.intel.com ([192.55.52.70]:14512 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S965160AbVI0Vor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:44:47 -0400
Subject: Re: 2.6.14-rc2-mm1
From: Rohit Seth <rohit.seth@intel.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org
In-Reply-To: <970900000.1127855894@flay>
References: <922980000.1127847470@flay>
	 <1127851502.6144.10.camel@akash.sc.intel.com>  <970900000.1127855894@flay>
Content-Type: text/plain
Organization: Intel 
Date: Tue, 27 Sep 2005 14:51:59 -0700
Message-Id: <1127857919.7258.13.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 21:44:35.0454 (UTC) FILETIME=[A70FA9E0:01C5C3AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 14:18 -0700, Martin J. Bligh wrote:
> >> > --- linux-2.6.13.old/mm/page_alloc.c  2005-09-26 10:57:07.000000000
> >> -0700 
> >> > +++ linux-2.6.13.work/mm/page_alloc.c 2005-09-26 10:47:57.000000000
> >> -0700 
> >> > @@ -1749,7 +1749,7 @@ 
> >> >       pcp = &p->pcp[1];               /* cold*/ 
> >> >       pcp->count = 0; 
> >> >       pcp->low = 0; 
> >> > -     pcp->high = 2 * batch; 
> >> > +     pcp->high = batch / 2; 
> >> >       pcp->batch = max(1UL, batch/2); 
> >> >       INIT_LIST_HEAD(&pcp->list); 
> >> >  } 
> >> > -
> >> 
> >> I don't understand. How can you set the high watermark at half the
> >> batch size? Makes no sense to me.
> >> 
> > 
> > The batch size for the cold pcp list is getting initialized to batch/2
> > in the code snip above.  So, this change is setting the high water mark
> > for cold list to same as pcp's batch number.
> 
> I must be being particularly dense today ... but:
> 
>  pcp->high = batch / 2; 
> 
> Looks like half the batch size to me, not the same? 

pcp->batch = max(1UL, batch/2); is the line of code that is setting the
batch value for the cold pcp list.  batch is just a number that we
counted based on some parameters earlier.


> 
> >> And can you give a stricter definiton of what you mean by "low memory 
> >> conditions"? I agree we ought to empty the lists before going OOM or 
> >> anything, but not at the slightest feather of pressure ... answer lies
> >> somewhere inbetween ... but where?
> >> 
> > 
> > In the specific case of dump information that Mattia sent earlier, there
> > is only 4M of free mem available at the time the order 1 request is
> > failing.  
> > 
> > In general, I think if a specific higher order ( > 0) request fails that
> > has GFP_KERNEL set then at least we should drain the pcps.
> 
> Mmmm. so every time we fork a process with 8K stacks, or allocate a frame
> for jumbo ethernet, or NFS, you want to drain the lists? that seems to
> wholly defeat the purpose.
> 

Not every time there is a request for higher order pages.  That surely
will defeat the purpose of pcps.  But my suggestion is only to drain
when the the global pool is not able to service the request.  In the
pathological case where the higher order and zero order requests are
alternating you could have thrashing in terms of pages moving to pcp for
them to move back to global list.

> Could you elaborate on what the benefits were from this change in the
> first place? Some page colouring thing on ia64? It seems to have way more
> downside than upside to me.

The original change was to try to allocate a higher order page to
service a batch size bulk request.  This was with the hope that better
physical contiguity will spread the data better across big caches.

-rohit

