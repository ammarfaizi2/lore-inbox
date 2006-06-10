Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWFJNFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWFJNFF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 09:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWFJNFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 09:05:04 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:37174 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751512AbWFJNFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 09:05:03 -0400
Date: Sat, 10 Jun 2006 09:05:03 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
In-reply-to: <448A089C.6020408@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, jlan@sgi.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org
Message-id: <448AC37F.8040807@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <44892610.6040001@watson.ibm.com>
 <20060609010057.e454a14f.akpm@osdl.org> <448952C2.1060708@in.ibm.com>
 <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com>
 <4489F93E.6070509@engr.sgi.com> <20060609162232.2f2479c5.akpm@osdl.org>
 <448A089C.6020408@engr.sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

>Andrew Morton wrote:
>  
>
>>Jay Lan <jlan@engr.sgi.com> wrote:
>> 
>>    
>>
>>>If you can show me how to not sending per-tgid with current patchset,
>>>i would be very happy to drop this request.
>>>   
>>>      
>>>
>>pleeeze, not a global sysctl.  It should be some per-client subscription thing.
>> 
>>    
>>
>
>Per-client subscription is not possible since it is the push (multicast)
>model we
>talk about and delayacct needs tgid.
>  
>
One way to do per-client subscription that Balbir brought up
is to have separate multicast groups for the clients wanting to receive 
per-pid stats and per-tgid stats.

However, this does change the current API since a separate connect to 
the per-tgid multicast group is needed.
So its not a option that can be tagged on later but needs to be done now.

>How about sending tgid stats when the last process in the group exist?
>But do not send it if not the last in the thread?
>
>  
>
This is doable if we have a place where the per-tgid data can be 
accumalated.
One choice that was explored and discarded was to have a struct 
taskstats allocated as part of mm struct,
and keep accumalating per-pid stats into that struct (ie. while filling 
the per-pid stat struct, accumalate into the
per-tgid struct too) which obviously doubles the collection overhead. 
Instead we chose to collect the per-tgid
stats dynamically.

However, we can consider allocating a per-tgid struct as part of the 
exit routine (when we notice a thread exiting
that is part of a thread group) and accumalate stats from each exiting 
thread of that group into the per-tgid stat and
output it alongwith the last exiting thread.

This would also save on the cost of collecting the entire per-tgid data 
each time a thread exits (as is being done now).

This solution is also a bit of an API change since the kind of data 
being received on the common multicast channel
will be different from what it is now. Also looks a little involved.


So we have solutions for the problem going forward, but not without 
changing the API.
Question is: does this really need to be done even in future ? If so, 
then we should perhaps do the change rightaway.

One more point to consider here - if a third or fourth subsystem were to 
come along to use the taskstats
interface and did not want to use the taskstats structure (since they 
have no field in common)...their clients
would still need to be able to accept getting data they don't care about 
(whether they have one or two multicast
groups). So the model for dealing with unwanted data will still need to 
be "don't process the netlink attributes
you don't care about". But thats farther into the future...


--Shailabh

