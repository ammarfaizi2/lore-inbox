Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbUJ0XBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbUJ0XBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbUJ0W76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:59:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32965 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262757AbUJ0WzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:55:09 -0400
Message-ID: <418028B8.5060206@sgi.com>
Date: Wed, 27 Oct 2004 18:01:12 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Robin Holt <holt@sgi.com>, Jesse Barnes <jbarnes@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com> <20041026022322.GD17038@holomorphy.com> <200410251940.30574.jbarnes@sgi.com> <20041026143513.GC28391@lnx-holt.americas.sgi.com> <Pine.LNX.4.58.0410271103500.18165@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0410271103500.18165@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 26 Oct 2004, Robin Holt wrote:
> 
> 
>>Sorry for being a stickler here, but the BTE is really part of the
>>I/O Interface portion of the shub.  That portion has a seperate clock
>>frequency from the memory controller (unfortunately slower).  The BTE
>>can zero at a slightly slower speed than the processor.  It does, as
>>you pointed out, not trash the CPU cache.
>>
>>One other feature of the BTE is it can operate asynchronously from
>>the cpu.  This could be used to, during a clock interrupt, schedule
>>additional huge page zero filling on multiple nodes at the same time.
>>This could result in a huge speed boost on machines that have multiple
>>memory only nodes.  That has not been tested thoroughly.  We have done
>>considerable testing of the page zero functionality as well as the
>>error handling.
> 
> 
> If the huge patch would support some way of redirecting the clearing of a
> huge page then we could:
> 
> 1. set the huge pte to not present so that we get a fault on access
> 2. run the bte clearer.
> 3. On receiving a huge fault we could check for the bte being finished.
> 
> This would parallelize the clearing of huge pages. But is that really more
> efficient? There may be complexity involved in allowing the clearing of
> multiple pages and tracking of the clear in progress is additional
> overhead.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

I'm personally of the opinion that using the BTE to "speculatively" clear
hugetlb pages in advance of when the hugetlb pages are requested is not a good
thing [tm].  One never knows if those pages will ever be requested.  And in
the meantime, tasks that need the BTE will be delayed by speculative use.
But that is a personal bias  :-), with no data to back it up.

AFAIK, it is faster to clear the page with the processor anyway, since the
processor has a faster clock cycle.  Yes, it destroys the processor cache,
but the application has clearly indicated that it wants the page NOW, please,
(because it has faulted on it), and delivering the page to the application
as quickly as possible sounds like a good thing.  I'm not sure reloading
the processor cache at this point is a cost we care about, given that the
application is likely just starting up anyway.  I figure hugetlb pages are
allocated once, stay around a long long time, so I'm not sure optimizing to
minimize cache damage is the correct way to go here.

The only obvious win is for memory only nodes, that have a BTE and no CPU.
It is probably faster to use the local BTE than a remote CPU to clear the page.

Does that make any sense?

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
