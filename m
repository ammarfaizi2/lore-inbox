Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbVI0VSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVI0VSS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVI0VSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:18:18 -0400
Received: from dvhart.com ([64.146.134.43]:23693 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965149AbVI0VSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:18:17 -0400
Date: Tue, 27 Sep 2005 14:18:14 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Rohit Seth <rohit.seth@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <970900000.1127855894@flay>
In-Reply-To: <1127851502.6144.10.camel@akash.sc.intel.com>
References: <922980000.1127847470@flay> <1127851502.6144.10.camel@akash.sc.intel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > --- linux-2.6.13.old/mm/page_alloc.c  2005-09-26 10:57:07.000000000
>> -0700 
>> > +++ linux-2.6.13.work/mm/page_alloc.c 2005-09-26 10:47:57.000000000
>> -0700 
>> > @@ -1749,7 +1749,7 @@ 
>> >       pcp = &p->pcp[1];               /* cold*/ 
>> >       pcp->count = 0; 
>> >       pcp->low = 0; 
>> > -     pcp->high = 2 * batch; 
>> > +     pcp->high = batch / 2; 
>> >       pcp->batch = max(1UL, batch/2); 
>> >       INIT_LIST_HEAD(&pcp->list); 
>> >  } 
>> > -
>> 
>> I don't understand. How can you set the high watermark at half the
>> batch size? Makes no sense to me.
>> 
> 
> The batch size for the cold pcp list is getting initialized to batch/2
> in the code snip above.  So, this change is setting the high water mark
> for cold list to same as pcp's batch number.

I must be being particularly dense today ... but:

 pcp->high = batch / 2; 

Looks like half the batch size to me, not the same? 

>> And can you give a stricter definiton of what you mean by "low memory 
>> conditions"? I agree we ought to empty the lists before going OOM or 
>> anything, but not at the slightest feather of pressure ... answer lies
>> somewhere inbetween ... but where?
>> 
> 
> In the specific case of dump information that Mattia sent earlier, there
> is only 4M of free mem available at the time the order 1 request is
> failing.  
> 
> In general, I think if a specific higher order ( > 0) request fails that
> has GFP_KERNEL set then at least we should drain the pcps.

Mmmm. so every time we fork a process with 8K stacks, or allocate a frame
for jumbo ethernet, or NFS, you want to drain the lists? that seems to
wholly defeat the purpose.

Could you elaborate on what the benefits were from this change in the
first place? Some page colouring thing on ia64? It seems to have way more
downside than upside to me.

M.

