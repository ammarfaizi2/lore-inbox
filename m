Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVE0IHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVE0IHq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 04:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVE0IHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 04:07:46 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:34695 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261970AbVE0IH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:07:28 -0400
Message-ID: <4296D53B.2000507@yahoo.com.au>
Date: Fri, 27 May 2005 18:07:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       dwalker@mvista.com, bhuey@lnxw.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527071800.GA1624@elte.hu>
In-Reply-To: <20050527071800.GA1624@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

Thanks Ingo,

> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Presumably your RT tasks are going to want to do some kind of *real* 
>>work somewhere along the line - so how is that work provided 
>>guarantees?
> 
> 
> there are several layers to this. The primary guarantee we can offer is
> to execute userspace code within N usecs. Most code that needs hard
> guarantees is quite simple and uses orthogonal mechanisms.
> 

Well yes, but *somewhere* along the line they'll need to interact
with something else in a timely (in the RT sense) manner?

[...]

> 
>>So in that sense, if you do hard RT in the Linux kernel, it surely is 
>>always going to be some subset of operations, dependant on exact 
>>locking implementation, other tasks running and resource usage, right?
> 
> 
> yes. The goal is that latencies will fundamentally depend on what 
> facilities (and sharing) the RT task makes use of - instead of depending 
> on what _other_ tasks do in the system.
> 

OK.

> 
>>Tasklist lock might be a good example off the top of my head - so you 
>>may be able to send a signal to another process with deterministic 
>>latency, however that latency might look something like: x + nrproc*y
> 
> 
> yes, signals are not O(1).
> 
> Fundamentally, the Linux kernel constantly moves towards separation of 
> unrelated functionality, for scalability reasons. So the moment there's 
> some unexpected sharing, we try to get to rid of it not primarily due to 
> latencies, but due to performance. (and vice versa - one reason why it's 
> not hard to get latency patches into the kernel) E.g. the tasklist lock 
> might be convered to RCU one day. The idea is that a 'perfectly
> scalable' Linux kernel also has perfect latencies - the two goals meet.
> 

I'd have to think about that one ;)
But yeah I agree they seem to broadly move in the same direction,
but let's not split hairs.

> 
>>It appears to me (uneducated bystander, remember) that a nanokernel 
>>running a small hard-rt kernel and Linux together might be "better" 
>>for people that want real realtime.
> 
> 
> If your application model can tolerate a total separation of OSs then 
> that's sure a viable way. If you want to do everything under one 
> instance of Linux, and want to separate out some well-controlled RT 
> functionality, then PREEMPT_RT is good for you.
> 
> Note that if you can tolerate separation of OSs (i.e. no sharing or 
> well-controlled sharing) then you can do that under PREEMPT_RT too, here 
> and today: e.g. run all the non-RT tasks in an UML or QEMU instance.
> (separation of UML needs more work but it's fundamentally ok.) Or you
> can use PREEMPT_RT as the nanokernel [although this sure is overkill]
> and put all the RT functionality into a virtual machine. So instead of a
> hard choice forced upon you, virtualization becomes an option. Soft-RT
> applications can morph towards hard-RT conditions and vice versa.
> 

OK. I what sort of applications can't tolerate the nanokernel type
separation? I guess the hosts would be seperated by some network like
device, shared memory, etc. devices that use functionality provided
by the nanokernel?

> So whether it's good enough will have to be seen - maybe nanokernels
> will win in the end. As long as PREEMPT_RT does not impose any undue
> design burden on the stock kernel (and i believe it does not) it's a
> win-win situation: latency improvements will drive scalability,
> scalability improvements will drive latencies, and the code can be
> easily removed if it becomes unused.

Well yeah, from what I gather, the PREEMPT_RT work needn't be excluded
on the basis that it can't provide hard-RT - for a real world example
all the sound guys seem to love it ;) so it obviously is worth something.

And if the complexity can be nicely hidden away and configured out,
then I personally don't have any problem with it whatsoever :) But
I don't like to comment further on actual code until I see the actual
proposed patch when you're happy with it.

Nick
Send instant messages to your online friends http://au.messenger.yahoo.com 
