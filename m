Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbSJVSX0>; Tue, 22 Oct 2002 14:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264926AbSJVSX0>; Tue, 22 Oct 2002 14:23:26 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:30736 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264925AbSJVSXZ>;
	Tue, 22 Oct 2002 14:23:25 -0400
Message-ID: <3DB59923.9050002@mvista.com>
Date: Tue, 22 Oct 2002 13:29:55 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@gamebox.net
CC: linux-kernel@vger.kernel.org, levon@movementarian.org
Subject: Re: [PATCH] NMI request/release
References: <3DB4AABF.9020400@mvista.com> <20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com> <20021022025346.GC41678@compsoc.man.ac.uk> <3DB54C53.9010603@mvista.com> <20021022232345.A25716@dikhow> <3DB59385.6050003@mvista.com> <20021022233853.B25716@dikhow>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

>On Tue, Oct 22, 2002 at 01:05:57PM -0500, Corey Minyard wrote:
>  
>
>>>You need to walk the list in call_nmi_handlers from nmi interrupt handler where
>>>preemption is not an issue anyway. Using RCU you can possibly do a safe
>>>walking of the nmi handlers. To do this, your update side code
>>>(request/release nmi) will still have to be serialized (spinlock), but
>>>you should not need to wait for completion of any other CPU executing
>>>the nmi handler, instead provide wrappers for nmi_handler
>>>allocation/free and there free the nmi_handler using an RCU callback
>>>(call_rcu()). The nmi_handler will not be freed until all the CPUs
>>>have done a contex switch or executed user-level or been idle.
>>>This will gurantee that *this* nmi_handler is not in execution
>>>and can safely be freed.
>>>
>>>This of course is a very simplistic view of the things, there could
>>>be complications that I may have overlooked. But I would be happy
>>>to help out on this if you want.
>>>
>>>      
>>>
>>This doesn't sound any simpler than what I am doing right now.  In fact, 
>>it sounds more complex.  Am I correct?  What I am doing is pretty simple 
>>and correct.  Maybe more complexity would be required if you couldn't 
>>atomically update a pointer, but I think simplicity should win here.
>>    
>>
>
>I would vote for simplicity and would normally agree with you here. But
>it seems to me that using RCU, you can avoid atmic operations
>and cache line bouncing of calling_nmi_handlers in the fast path
>(nmi interrupt handler). One could argue whether it is really
>a fast path or not, but if you are using it for profiling, I would
>say it is. No ?
>
I would vote against using it for profiling; profiling has it's own 
special fast-path, anyway.  The NMI watchdog only gets hit once every 
minute or so, it seems, so that seems suitable for this.

I've looked at the RCU code a little more, and I think I understand it 
better.  I think your scenario will work, if it's true that it won't be 
called until all CPUs have done what you say.  I'll look at it a little 
more.

-Corey

