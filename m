Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932784AbWFVE05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWFVE05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932786AbWFVE05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:26:57 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:14523 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932784AbWFVE04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:26:56 -0400
Message-ID: <449A1C0D.7030906@bigpond.net.au>
Date: Thu, 22 Jun 2006 14:26:53 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [PATCH 00/11] Task watchers:  Introduction
References: <1150242721.21787.138.camel@stark>	 <4498DC23.2010400@bigpond.net.au> <1150876292.21787.911.camel@stark>	 <44992EAA.6060805@bigpond.net.au>  <44993079.40300@bigpond.net.au>	 <1150925387.21787.1056.camel@stark>  <4499D097.5030604@bigpond.net.au>	 <1150936337.21787.1114.camel@stark>  <4499EE29.9020703@bigpond.net.au> <1150947965.21787.1228.camel@stark>
In-Reply-To: <1150947965.21787.1228.camel@stark>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 22 Jun 2006 04:26:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> On Thu, 2006-06-22 at 11:11 +1000, Peter Williams wrote:
>> Matt Helsley wrote:
>>> On Thu, 2006-06-22 at 09:04 +1000, Peter Williams wrote:
>>>> Matt Helsley wrote:
>>>>> On Wed, 2006-06-21 at 21:41 +1000, Peter Williams wrote:
>>>>>> Peter Williams wrote:
>>>>>>> Matt Helsley wrote:
>>>>>>>> On Wed, 2006-06-21 at 15:41 +1000, Peter Williams wrote:
>>>>>>>>> On a related note, I can't see where the new task's notify field gets 
>>>>>>>>> initialized during fork.
>>>>>>>> It's initialized in kernel/sys.c:notify_per_task_watchers(), which calls
>>>>>>>> RAW_INIT_NOTIFIER_HEAD(&task->notify) in response to WATCH_TASK_INIT.
>>>>>>> I think that's too late.  It needs to be done at the start of 
>>>>>>> notify_watchers() before any other watchers are called for the new task.
>>>>> 	I don't see why you think it's too late. It needs to be initialized
>>>>> before it's used. Waiting until notify_per_task_watchers() is called
>>>>> with WATCH_TASK_INIT does this.
>>>> I probably didn't understand the code well enough.  I'm still learning 
>>>> how it all hangs together :-).
>>>>
>>>>>> On second thoughts, it would simpler just before the WATCH_TASK_INIT 
>>>>>> call in copy_process() in fork.c.  It can be done unconditionally there.
>>>>>>
>>>>>> Peter
>>>>> 	That would work. It would not simplify the control flow of the code.
>>>>> The branch for WATCH_TASK_INIT in notify_per_task_watchers() is
>>>>> unavoidable; we need to call the parent task's chain in that case since
>>>>> we know the child task's is empty.
>>>>>
>>>>> 	It is also counter to one goal of the patches -- reducing the "clutter"
>>>>> in these paths. Arguably task watchers is the same kind of clutter that
>>>>> existed before. However, it is a means of factoring such clutter into
>>>>> fewer instances (ideally one) of the pattern.
>>>> Maybe a few comments in the code to help reviewers such as me learn how 
>>>> it works more quickly would be worthwhile.
>>> Good point. I'll keep this in mind as I consider the multi-chain
>>> approach suggested by Andrew -- I suspect improvments in my commenting
>>> will be even more critical there.
>>>
>>>> BTW as a former user of PAGG, I think there are ideas in the PAGG 
>>>> implementation that you should look at.  In particular:
>>>>
>>>> 1. The use of an array of function pointers (one for each hook) can cut 
>>>> down on the overhead.  The notifier_block only needs to contain a 
>>>> pointer to the array so there's no increase in the size of that 
>>>> structure.  Within the array a null pointer would mean "don't bother 
>>>> calling".  Only one real array needs to exist even for per task as 
>>>> they're all using the same functions (just separate data).  It removes 
>>>> the need for a switch statement in the client's function as well as 
>>>> saving on unnecessary function calls.
>>> 	I don't think having an explicit array of function pointers is likely
>>> to be as fast as a switch statement (or a simple branch) generated by
>>> the compiler.
>> With the array there's no need for any switch or branching.  You know 
>> exactly which function in the array to use in each hook.
> 
> 	I don't forsee enough of a difference to make this worth arguing about.
> You're welcome to benchmark and compare arrays vs. switches/branches on
> a variety of archs, SMP boxen, NUMA boxen, etc. and post the results.
> I'm going to focus on other issues for now.
> 
>>> 	It doesn't save unecessary function calls unless I modify the core
>>> notifier block structure. Otherwise I still need to stuff a generic
>>> function into .notifier_call and from there get the pointer to the array
>>> to make the next call. So it adds more pointer indirection but does not
>>> reduce the number of intermediate function calls.
>> There comes a point when trying to reuse existing code is less cost 
>> effective than starting over.
> 
> Write my own notifier chains just to avoid a function call? I don't
> think that's sufficient justification for implementing my own.

Can't help thinking why the easier option of adding setuid and setgid 
hooks to PAGG and then including PAGG wasn't adopted.

> 
>>> 	As far as the multi-chain approach is concerned, I'm still leaning
>>> towards registering a single function with a mask describing what it
>>> wants to be notified of.
>> I think that will be less efficient than the function array.
> 
> Well if I don't register with the mask there are other approaches that
> wouldn't require the switch or the array.
> 
>>>> 2. A helper mechanism to allow a client that's being loaded as a module 
>>>> to visit all existing tasks and do whatever initialization it needs to 
>>>> do.  Without this every client would have to implement such a mechanism 
>>>> themselves (and it's not pretty).
>>> 	Interesting idea. It should resemble existing macros. Something like:
>>> 	register_task_watcher(&my_nb, &unnoticed);
>>> 	for_each_unnoticed_task(unnoticed)
>>> 		...
>> Something like that.  It involved some tricky locking issues and was
>> reasonably complex (which made providing it a good option when compared 
>> to each client implementing its own version).  Rather than trying to do 
>> this from scratch I'd advise getting a copy of the most recent PAGG
>> patches and using that as a model as a fair bit of effort was spent 
>> ironing out all the problems involved.  It's not as easy as it sounds.
> 
> 	Yes, it does sound quite hairy.
> 
> 	My feeling is that such code should be largely independent of task
> watchers and I'd like to stay focused. So I have no plans to work on
> something like "for_each_unnoticed_task()" for now.

Yes, this won't be an issue until there's a client in a loadable module.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
