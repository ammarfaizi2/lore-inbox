Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVE0P5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVE0P5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVE0P5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:57:55 -0400
Received: from mail4.utc.com ([192.249.46.193]:25315 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262481AbVE0P5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:57:47 -0400
Message-ID: <4297432F.90901@cybsft.com>
Date: Fri, 27 May 2005 10:56:31 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527071800.GA1624@elte.hu> <4296D53B.2000507@yahoo.com.au>
In-Reply-To: <4296D53B.2000507@yahoo.com.au>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Ingo Molnar wrote:
> 
> Thanks Ingo,
> 
>> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>
>>> Presumably your RT tasks are going to want to do some kind of *real* 
>>> work somewhere along the line - so how is that work provided guarantees?
>>
>>
>>
>> there are several layers to this. The primary guarantee we can offer is
>> to execute userspace code within N usecs. Most code that needs hard
>> guarantees is quite simple and uses orthogonal mechanisms.
>>
> 
> Well yes, but *somewhere* along the line they'll need to interact
> with something else in a timely (in the RT sense) manner?
> 
> [...]
> 
>>
>>> So in that sense, if you do hard RT in the Linux kernel, it surely is 
>>> always going to be some subset of operations, dependant on exact 
>>> locking implementation, other tasks running and resource usage, right?
>>
>>
>>
>> yes. The goal is that latencies will fundamentally depend on what 
>> facilities (and sharing) the RT task makes use of - instead of 
>> depending on what _other_ tasks do in the system.
>>
> 
> OK.
> 
>>
>>> Tasklist lock might be a good example off the top of my head - so you 
>>> may be able to send a signal to another process with deterministic 
>>> latency, however that latency might look something like: x + nrproc*y
>>
>>
>>
>> yes, signals are not O(1).
>>
>> Fundamentally, the Linux kernel constantly moves towards separation of 
>> unrelated functionality, for scalability reasons. So the moment 
>> there's some unexpected sharing, we try to get to rid of it not 
>> primarily due to latencies, but due to performance. (and vice versa - 
>> one reason why it's not hard to get latency patches into the kernel) 
>> E.g. the tasklist lock might be convered to RCU one day. The idea is 
>> that a 'perfectly
>> scalable' Linux kernel also has perfect latencies - the two goals meet.
>>
> 
> I'd have to think about that one ;)
> But yeah I agree they seem to broadly move in the same direction,
> but let's not split hairs.

I think this is an excellent point and one that is often missed by the 
opponents of lower latencies in favor of throughput. At the risk of 
over-simplification: If your task takes 20ms vs. 10ms eventually those 
extra 10ms, every time your task runs, add up to real, noticeable wall 
clock time. Unless you live in a world where you have unlimited CPU 
resources, lower latencies (or maybe more correctly determinism) have to 
be beneficial to throughput also. In a case where it cost throughput 
because of the context changes created by higher priorty tasks 
preempting lower priority tasks, change the priorities so that the tasks 
don't get preempted. I believe that in a case where all codepaths have 
been made to be as efficient and deterministic as possible, you remove 
most of the unknowns that the OS can throw at you. Doesn't this leave it 
to the application designer/developer to make his app perform at the 
best possible level?

> 
>>
>>> It appears to me (uneducated bystander, remember) that a nanokernel 
>>> running a small hard-rt kernel and Linux together might be "better" 
>>> for people that want real realtime.
>>
>>
>>
>> If your application model can tolerate a total separation of OSs then 
>> that's sure a viable way. If you want to do everything under one 
>> instance of Linux, and want to separate out some well-controlled RT 
>> functionality, then PREEMPT_RT is good for you.
>>
>> Note that if you can tolerate separation of OSs (i.e. no sharing or 
>> well-controlled sharing) then you can do that under PREEMPT_RT too, 
>> here and today: e.g. run all the non-RT tasks in an UML or QEMU instance.
>> (separation of UML needs more work but it's fundamentally ok.) Or you
>> can use PREEMPT_RT as the nanokernel [although this sure is overkill]
>> and put all the RT functionality into a virtual machine. So instead of a
>> hard choice forced upon you, virtualization becomes an option. Soft-RT
>> applications can morph towards hard-RT conditions and vice versa.
>>
> 
> OK. I what sort of applications can't tolerate the nanokernel type
> separation? I guess the hosts would be seperated by some network like
> device, shared memory, etc. devices that use functionality provided
> by the nanokernel?

I am not saying this is the case with all of these environments, so 
please noone start throwing things at me. Imagine if you will a world 
where there is no shared memory between RT tasks and non RT tasks. 
Imagine a world where such tasks must share data via a pipe. Imagine if 
you will a world where you don't just have to make your application as 
fast and efficient as possible but you also have to build your own 
facilities (such as IPC) that you take for granted in normal Linux 
environment. To my knowledge there are very few RT environments today 
where you don't have to live with these types of constraints. The ones 
that I know about where you don't are not nanokernel type environments.

> 
>> So whether it's good enough will have to be seen - maybe nanokernels
>> will win in the end. As long as PREEMPT_RT does not impose any undue
>> design burden on the stock kernel (and i believe it does not) it's a
>> win-win situation: latency improvements will drive scalability,
>> scalability improvements will drive latencies, and the code can be
>> easily removed if it becomes unused.
> 
> 
> Well yeah, from what I gather, the PREEMPT_RT work needn't be excluded
> on the basis that it can't provide hard-RT - for a real world example
> all the sound guys seem to love it ;) so it obviously is worth something.
> 
> And if the complexity can be nicely hidden away and configured out,
> then I personally don't have any problem with it whatsoever :) But
> I don't like to comment further on actual code until I see the actual
> proposed patch when you're happy with it.
> 
> Nick
> Send instant messages to your online friends 
> http://au.messenger.yahoo.com -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
    kr
