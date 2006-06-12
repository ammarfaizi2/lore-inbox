Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWFLSyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWFLSyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbWFLSyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:54:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54685 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751693AbWFLSyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:54:06 -0400
Message-ID: <448DB848.700@sgi.com>
Date: Mon, 12 Jun 2006 11:54:00 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Jay Lan <jlan@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com> <20060609010057.e454a14f.akpm@osdl.org> <448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com> <4489F93E.6070509@engr.sgi.com> <20060609162232.2f2479c5.akpm@osdl.org> <448A089C.6020408@engr.sgi.com> <448AC37F.8040807@watson.ibm.com>
In-Reply-To: <448AC37F.8040807@watson.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Jay Lan wrote:
> 
>> Andrew Morton wrote:
>>  
>>
>>> Jay Lan <jlan@engr.sgi.com> wrote:
>>>
>>>   
>>>
>>>> If you can show me how to not sending per-tgid with current patchset,
>>>> i would be very happy to drop this request.
>>>>       
>>>
>>> pleeeze, not a global sysctl.  It should be some per-client 
>>> subscription thing.
>>>
>>>   
>>
>>
>> Per-client subscription is not possible since it is the push (multicast)
>> model we
>> talk about and delayacct needs tgid.
>>  
>>
> One way to do per-client subscription that Balbir brought up
> is to have separate multicast groups for the clients wanting to receive 
> per-pid stats and per-tgid stats.
> 
> However, this does change the current API since a separate connect to 
> the per-tgid multicast group is needed.
> So its not a option that can be tagged on later but needs to be done now.
> 
>> How about sending tgid stats when the last process in the group exist?
>> But do not send it if not the last in the thread?
>>
>>  
>>
> This is doable if we have a place where the per-tgid data can be 
> accumalated.
> One choice that was explored and discarded was to have a struct 
> taskstats allocated as part of mm struct,
> and keep accumalating per-pid stats into that struct (ie. while filling 
> the per-pid stat struct, accumalate into the
> per-tgid struct too) which obviously doubles the collection overhead. 
> Instead we chose to collect the per-tgid
> stats dynamically.
> 
> However, we can consider allocating a per-tgid struct as part of the 
> exit routine (when we notice a thread exiting
> that is part of a thread group) and accumalate stats from each exiting 
> thread of that group into the per-tgid stat and
> output it alongwith the last exiting thread.

This sounds a good plan. You do allocating a per-tgid struct only once
per thread group, right?

> 
> This would also save on the cost of collecting the entire per-tgid data 
> each time a thread exits (as is being done now).
> 
> This solution is also a bit of an API change since the kind of data 
> being received on the common multicast channel
> will be different from what it is now. Also looks a little involved.

I am confused. Wouldn't it simply a change in the test of when to
process and write the tgid data? The API seems to me unchanged? Do
i miss something?

Regards,
  - jay


> 
> 
> So we have solutions for the problem going forward, but not without 
> changing the API.
> Question is: does this really need to be done even in future ? If so, 
> then we should perhaps do the change rightaway.
> 
> One more point to consider here - if a third or fourth subsystem were to 
> come along to use the taskstats
> interface and did not want to use the taskstats structure (since they 
> have no field in common)...their clients
> would still need to be able to accept getting data they don't care about 
> (whether they have one or two multicast
> groups). So the model for dealing with unwanted data will still need to 
> be "don't process the netlink attributes
> you don't care about". But thats farther into the future...
> 
> 
> --Shailabh
> 

