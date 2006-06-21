Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWFUBz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWFUBz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWFUBz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:55:56 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:41080 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750755AbWFUBzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:55:55 -0400
Message-ID: <4498A728.207@bigpond.net.au>
Date: Wed, 21 Jun 2006 11:55:52 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Matt Helsley <matthltc@us.ibm.com>, nagar@watson.ibm.com,
       sekharan@us.ibm.com, jtk@us.ibm.com, balbir@in.ibm.com, jes@sgi.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH 09/11] Task watchers: Add support for per-task
 watchers
References: <20060613235122.130021000@localhost.localdomain>	<1150242901.21787.149.camel@stark>	<44978793.8070109@bigpond.net.au>	<1150844177.21787.774.camel@stark>	<20060620161524.7c132eea.akpm@osdl.org>	<1150852848.21787.828.camel@stark> <20060620184617.7dbefed8.akpm@osdl.org>
In-Reply-To: <20060620184617.7dbefed8.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 21 Jun 2006 01:55:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 20 Jun 2006 18:20:48 -0700
> Matt Helsley <matthltc@us.ibm.com> wrote:
> 
>>>>>> +static inline int notify_per_task_watchers(unsigned int val,
>>>>>> +					   struct task_struct *task)
>>>>>> +{
>>>>>> +	if (get_watch_event(val) != WATCH_TASK_INIT)
>>>>>> +		return raw_notifier_call_chain(&task->notify, val, task);
>>>>>> +	RAW_INIT_NOTIFIER_HEAD(&task->notify);
>>>>>> +	if (task->real_parent)
>>>>>> +		return raw_notifier_call_chain(&task->real_parent->notify,
>>>>>> +		   			       val, task);
>>>>>> +}
>>>>> It's possible for this task to exit without returning a result.
>>>> Assuming you meant s/task/function/:
>>>>
>>>> 	In the common case this will return a result because most tasks have a
>>>> real parent. The only exception should be the init task. However, the
>>>> init task does not "fork" from another task so this function will never
>>>> get called with WATCH_TASK_INIT and the init task.
>>>>
>>>> 	This means that if one wants to use per-task watchers to associate data
>>>> and a function call with *every* task, special care will need to be
>>>> taken to register with the init task.
>>> no......
>> 	I've been looking through the source and, from what I can see, the end
>> of the function is not reachable. I think I need to add:
>>
>> notify_watchers(WATCH_TASK_INIT, &init_task);
>>
>> to make this into an applicable warning.
> 
> If the end of the function isn't reachable then the
> `if (task->real_parent)' can simply be removed.

Perhaps with a comment to say that it's safe (and why) to dereference 
task->real_parent to help code reviewers?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
