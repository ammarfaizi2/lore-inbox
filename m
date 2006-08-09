Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWHIWGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWHIWGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWHIWGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:06:05 -0400
Received: from mx02.stofanet.dk ([212.10.10.12]:11984 "EHLO mx02.stofanet.dk")
	by vger.kernel.org with ESMTP id S1751395AbWHIWGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:06:03 -0400
Date: Thu, 10 Aug 2006 00:05:57 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@gogglemail.com>
X-X-Sender: simlo@frodo.shire
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Steven Rostedt <rostedt@goodmis.org>, Robert Crocombe <rcrocomb@gmail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re:
 Problems with 2.6.17-rt8
In-Reply-To: <20060808030524.GA20530@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.64.0608090050500.23474@frodo.shire>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
 <1154541079.25723.8.camel@localhost.localdomain>
 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
 <1154615261.32264.6.camel@localhost.localdomain> <20060808025615.GA20364@gnuppy.monkey.org>
 <20060808030524.GA20530@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Aug 2006, Bill Huey wrote:

> On Mon, Aug 07, 2006 at 07:56:15PM -0700, Bill Huey wrote:
>> On Thu, Aug 03, 2006 at 10:27:41AM -0400, Steven Rostedt wrote:
>>
>> ...(output and commentary a log deleted)...
>>
>>> This could also have a side effect that messes things up.
>>>
>>> Unfortunately, right now I'm assigned to other tasks and I cant spend
>>> much more time on this at the moment.  So hopefully, Ingo, Thomas or
>>> Bill, or someone else can help you find the reason for this problem.
>>
>> Steve and company,
>>
>> Speaking of which, after talking to Steve about this and confirming this
>> with a revert of changes. put_task_struct() can't deallocated memory from
>> either the zone or SLAB cache without taking a sleeping lock. It can't
>> be called directly from finish_task_switch to reap the thread because of
>> that (violation in atomic).
>>
>> It is for this reason the RCU call back to delay processing was put into
>> place to reap threads and was, seemingly by accident, missing from
>> patch-2.6.17-rt7 to -rt8. That is what broke it in the first place.
>>
>> I tested it with a "make -j4" which triggers the warning and it they all
>> go away now.
>>
>> Reverse patch attached:
>
> Resend with instrumentation code removed:
>
> bill
>
>

I had a long discussion with Paul McKenney about this. I opposed the patch 
from a latency point of view: Suddenly a high-priority RT task could be 
made into releasing a task_struct. It would be better for latencies to 
defer it to a low priority task.

The conclusion we ended up with was that it is not a job for the RCU 
system, but it ought to be deferred to some other low priority task to 
free the task_struct.

Esben

