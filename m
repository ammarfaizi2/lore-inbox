Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWFZRdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWFZRdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWFZRdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:33:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15560 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751160AbWFZRdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:33:16 -0400
Message-ID: <44A01A50.1050403@sgi.com>
Date: Mon, 26 Jun 2006 10:33:04 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com>	<20060609042129.ae97018c.akpm@osdl.org>	<4489EE7C.3080007@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>	<44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com> <20060623213912.96056b02.akpm@osdl.org> <449CD4B3.8020300@watson.ibm.com>
In-Reply-To: <449CD4B3.8020300@watson.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Andrew Morton wrote:
> 
>> On Fri, 23 Jun 2006 22:59:04 -0400
>> Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>
>>  
>>
>>>>> It was due to a loop in fill_tgid() when per-TG stats
>>>>> data are assembled for netlink:
>>>>>       do {
>>>>>               rc = delayacct_add_tsk(stats, tsk);
>>>>>               if (rc)
>>>>>                       break;
>>>>>
>>>>>       } while_each_thread(first, tsk);
>>>>>
>>>>> and it is executed inside a lock.
>>>>> Fortunately single threaded appls do not hit this code.
>>>>>  
>>>>>       
>>>>
>>>> Am I reading this right?  We do that loop when each thread within the
>>>> thread group exits?
>>>>
>>>>     
>>>
>>> Yes.
>>>
>>>   
>>>
>>>> How come?
>>>>
>>>>
>>>>     
>>>
>>> To get the sum of all per-tid data for threads that are currently alive.
>>> This is returned to userspace with each thread exit.
>>>   
>>
>>
>> I realise that.  How about we stop doing it?
>>
>> When a thread exits it only makes sense to send up the stats for that
>> thread. 
> 
> 
>> Why does the kernel assume that userspace is also interested in
>> the accumulated stats of its siblings?  And if userspace _is_ 
>> interested in
>> that info, it's still present in-kernel and can be queried for.
>>  
>>
> The reason for sending out sum of siblings's stats was as follows:
> I didn't maintain a per-tgid data structure in-kernel where the exiting 
> threads taskstats could be accumalated
> , erroneously thinking that this would require such a structure to be 
> *additionally* updated each  time a statististic
> was being collected and that would be way too much overhead. Also to 
> save on space. Thus if userspace wants to get the per-tgid stats for the 
> thread group when the last thread exits, then it cannot
> do so by querying since such a query only returns the sum of currently 
> live threads (data from exited threads is lost).
> 
> So, the current design chooses to return the sum of all siblings + self 
> when each thread exits. Using this userspace
> can maintain the per-tgid data for all currently living threads of the 
> group + previously exited threads.
> 
> But as pointed out in an earlier mail, it looks like this is 
> unnecessarily elaborate way of trying to avoid maintaining
> a separate per-tgid data structure in the kernel (in addition to the 
> per-tid ones we already have).
> 
> What can be done is to create a taskstats structure for a thread group 
> the moment the *second* thread gets created.
> Then each exiting thread can accumalate its stats to this struct. If 
> userspace queries for per-tgid data, the sum of all
> live threads + value in this struct can be returned. And when the last 
> thread of the thread group exits, the struct's
> value can be output.
> 
> While this will mean an extra taskstats structure hanging around for the 
> lifetime of a multithreaded app (not single threaded
> ones), it should cut down on the overhead of running through all threads 
> that we see in the current design.
> More importantly, it will reduce the frequency of per-tgid data send to 
> once for each thread group exit  instead of once
> per thread exit.
> 
> Will that work for everyone ?

As long as the per-pid delayacct struct has a pointer to the per-tgid
data struct and deoes not need to go through the loop on every exit.

> 
>>>> Is there some better lock we can use in there?  It only has to be
>>>> threadgroup-wide rather than kernel-wide.
>>>>
>>>>
>>>>     
>>>
>>> The lock we're holding is the tasklist_lock. To go through all the 
>>> threads of a thread group
>>> thats the only lock that can protect integrity of while_each_thread 
>>> afaics.
>>>   
>>
>>
>> At present, yes.  That's persumably not impossible to fix.
>>  
>>
> In the above design, if a userspace query for per-tgid data arrives, 
> then I'll still need to run through
> all the threads of a thread group (to return their sum + that of already 
> exited threads accumalated in the
> extra per-tgid taskstats struct).

But, this query-reply logic can be separated from that executed at
exit.

Thanks,
  - jay


> 
> So that could still benefit from such a thread group specific lock. 
> Scope of change is a bit more of course
> so will need to take a closer look.
> 
> --Shailabh

