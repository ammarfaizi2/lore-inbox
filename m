Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbUJ1Q3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbUJ1Q3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUJ1Q3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:29:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18659 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261740AbUJ1Q2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:28:01 -0400
Message-ID: <41811F7C.40003@sgi.com>
Date: Thu, 28 Oct 2004 11:34:04 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: Christoph Lameter <clameter@sgi.com>, Jesse Barnes <jbarnes@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com> <20041026022322.GD17038@holomorphy.com> <200410251940.30574.jbarnes@sgi.com> <20041026143513.GC28391@lnx-holt.americas.sgi.com> <Pine.LNX.4.58.0410271103500.18165@schroedinger.engr.sgi.com> <418028B8.5060206@sgi.com> <20041028115144.GA21926@lnx-holt.americas.sgi.com>
In-Reply-To: <20041028115144.GA21926@lnx-holt.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt wrote:
> On Wed, Oct 27, 2004 at 06:01:12PM -0500, Ray Bryant wrote:
> 
>>Christoph Lameter wrote:
>>
>>>On Tue, 26 Oct 2004, Robin Holt wrote:
>>>
>>>
>>>
>>>>Sorry for being a stickler here, but the BTE is really part of the
>>>>I/O Interface portion of the shub.  That portion has a seperate clock
>>>>frequency from the memory controller (unfortunately slower).  The BTE
>>>>can zero at a slightly slower speed than the processor.  It does, as
>>>>you pointed out, not trash the CPU cache.
>>>>
>>>>One other feature of the BTE is it can operate asynchronously from
>>>>the cpu.  This could be used to, during a clock interrupt, schedule
>>>>additional huge page zero filling on multiple nodes at the same time.
>>>>This could result in a huge speed boost on machines that have multiple
>>>>memory only nodes.  That has not been tested thoroughly.  We have done
>>>>considerable testing of the page zero functionality as well as the
>>>>error handling.
>>>
>>>
>>>If the huge patch would support some way of redirecting the clearing of a
>>>huge page then we could:
>>>
>>>1. set the huge pte to not present so that we get a fault on access
>>>2. run the bte clearer.
>>>3. On receiving a huge fault we could check for the bte being finished.
>>>
>>>This would parallelize the clearing of huge pages. But is that really more
>>>efficient? There may be complexity involved in allowing the clearing of
>>>multiple pages and tracking of the clear in progress is additional
>>>overhead.
>>>
>>>
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>>I'm personally of the opinion that using the BTE to "speculatively" clear
>>hugetlb pages in advance of when the hugetlb pages are requested is not a 
>>good
>>thing [tm].  One never knows if those pages will ever be requested.  And in
>>the meantime, tasks that need the BTE will be delayed by speculative use.
>>But that is a personal bias  :-), with no data to back it up.
> 
> 
> I was thinking the bte would be best used in an async mode where the pages
> would be pre-zeroed and available for use if the application needs them.
> If the pre-zeroed list is empty, then use the cpu to zero the page.
> 
> 
>>AFAIK, it is faster to clear the page with the processor anyway, since the
> 
> 
> The processor is slightly faster.  I believe the FSB is 200Mhz and the
> II is 100Mhz (150Mhz with no attached IX brick).  Future versions of the
> BTE will possibly have faster access to on node memory than the processor.
> 
> 
>>processor has a faster clock cycle.  Yes, it destroys the processor cache,
>>but the application has clearly indicated that it wants the page NOW, 
>>please,
>>(because it has faulted on it), and delivering the page to the application
>>as quickly as possible sounds like a good thing.  I'm not sure reloading
> 
> 
> I am not either.  I just would like to see any design take into consideration
> the possible uses and not design them out.  Nothing more.
> 
> 
>>the processor cache at this point is a cost we care about, given that the
>>application is likely just starting up anyway.  I figure hugetlb pages are
>>allocated once, stay around a long long time, so I'm not sure optimizing to
>>minimize cache damage is the correct way to go here.
>>
>>The only obvious win is for memory only nodes, that have a BTE and no CPU.
>>It is probably faster to use the local BTE than a remote CPU to clear the 
>>page.
> 
> 
> Plus, a single CPU could schedule the clearing of pages on multiple
> nodes at the same time.  Imagine a system that has 256 compute nodes
> and 756 memory nodes.  That configuration is theoretically possible with
> todays hardware, but we have never built or sold one.  Looking at that
> configuration gives you an one possible indication of how a pre-zeroing
> mechanism might improve things.
> 
> I am not saying that the BTE is the best option, or even a good one.  It
> just looks interesting.  It does bring up some interesting problems with
> repeatability.  Consider the application startup following termination
> of another which used all the huge pages.  The pre-zeroed list will
> be nearly if not completely empty.  The first fault will find the list
> empty and have to zero the page itself.  Hopefully, the second fault will
> find one on the zeroed list and return immediately.  This would cause
> application startup time to feel like it doubled from the previous run.
> Ouch.  That would be very upsetting for our typical customers.
>

Yep.

> The more memory nodes you have per cpu, the better this number will
> appear.
> 
> Sorry for being spineless, but I don't feel very strongly that it will
> be beneficial enough to be desirable.  I am just not sure.  I would
> just hope that it is taken into consideration during the design and,
> as long as it has no negative impact on the design, be left as a
> possibility.
> 
> Thanks,
> Robin Holt
> 

As always, Robin, you are being very reasonable.  I think the option
should be kept open as you suggest, since it may help and I agree it
is an interesting approach that might yield big speedups.

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
