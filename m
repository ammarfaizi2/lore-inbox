Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbULRJnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbULRJnu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 04:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbULRJnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 04:43:50 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:49642 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262861AbULRJnn
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 18 Dec 2004 04:43:43 -0500
Message-ID: <41C3FBCA.1020707@cyberone.com.au>
Date: Sat, 18 Dec 2004 20:43:38 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Loic Domaigne <loicWorks@gmx.net>
CC: nptl@bullopensource.org,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: OSDL Bug 3770
References: <1102071900.14792.81.camel@decugiss.frec.bull.fr>	 <41B6368F.9060704@cyberone.com.au>	 <1102495648.3613.39.camel@decugiss.frec.bull.fr>	 <41B6C2D4.5040705@cyberone.com.au>	 <1102497754.3644.1.camel@decugiss.frec.bull.fr>	 <41B6D544.1010106@cyberone.com.au>	 <1102501896.3644.5.camel@decugiss.frec.bull.fr>	 <41B6D824.80804@cyberone.com.au>  <41B6DA44.4020100@cyberone.com.au>	 <1102502987.3644.7.camel@decugiss.frec.bull.fr>	 <41B6DEC1.9050506@cyberone.com.au>	 <1102523077.3644.42.camel@decugiss.frec.bull.fr>	 <41B8115C.30509@cyberone.com.au>  <41B82435.7020802@cyberone.com.au> <1102590314.3644.107.camel@decugiss.frec.bull.fr> <41C3F4BB.2050102@gmx.net>
In-Reply-To: <41C3F4BB.2050102@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Loic Domaigne wrote:

> Hello Nick!
> Hello NPTL Mailing List!
>

Hello Loic! Thanks for the interesting mail.

I'm CCing lkml and Ingo with this, because I wouldn't feel comfortable 
to veto
this myself.

lkml: We're discussing the fact that on SMP machines, our realtime 
scheduling
policies are per-CPU only. This caused a problem where a high priority 
task on
one CPU caused all lower priority tasks on that CPU to be starved, while 
tasks
on another CPU with the same low priority were able to run.

>>> Ah, the problem is that when the driver thread has a higher
>>> priority than the worker threads, so when the driver goes into an
>>> infinite loop  waiting, the able to schedule, however.
>>
>
> Although POSIX legally permits such implementation for realtime policy 
> on SMP machines, this implementation is clearly *NOT* REASONABLE.
>

Well I haven't done much in the realtime area... but nobody has 
complained till now.

> The reason is extremely simple: the application *CANNOT* necessarily 
> known that it gets stuck behind a higher-priority thread (though it 
> could had run on another CPU if the scheduler had decided otherwise). 
> That's *NOT* doable to program in a deterministic fashion in such 
> "realtime"-environement
>

You could use CPU binding. I'd argue that this may be nearly a 
requirement for
any realtime system of significant complexity on an SMP system.

*But*, notice that the program in question did not run on UP and 
randomly fail
on SMP, rather it would not work on single processor AT ALL.

> [
> "Realtime" put into quote. I am speaking here of soft realtime, that 
> is an environment whose tasks scheduling follow a specific 
> deterministic order. I am not speaking about hard-realtime that have 
> additional timing constraints. Following that definition, we can say 
> that Linux offers (soft) "Realtime".
> ]
>
>
>> > The driver really needs to sleep, use a mutex, use a lower priority,
>>
>>> or  something in order for it to work.
>>
>
> NO! It is not the responsability of the application to fix that 
> behavior! We can in our case because 'we know', but some applications 
> don't!!!
>

That's a bit hand-wavy ;) but I don't dismiss it out of hand because as 
I said,
I'm not so familiar with this area. I would be interested in an example 
of some
application where this matters, and which absolutely can't use any 
synchronisation
primitives.

>
> The mistake done here is interesting. When you have a pool of servers, 
> you can proceed in two ways to serve the clients:
>
>     (1) make a FIFO queue for each server. When a client arrives, it
>         chooses the queue that is the shortest.
>
>     (2) make an unique FIFO queue for all servers. All clients are
>         queued, and when a server is done it takes the first client
>         waiting on that big queue.
>
> Queuing theory proves that (2) is better. Exactly due to the reason we 
> have here. With (1), the guys in the queue might get stuck if the 
> corresponding server is blocked by a client. With (2), when a server 
> is blocked by a client, it doesn't prevent the other clients to be 
> served by other servers.
>

But that model is flawed for SMP scheduling. If it were that easy, we 
might have a
single queue for _all_ tasks.

The main problem is the cost of synchronisation and cacheline sharing. A 
secondary
problem is that of CPU affinities - moving a task to another CPU nearly 
always has
some non zero cost in terms of cache (and in case of NUMA, memory) 
efficiency.

Our global queue scheduler was basically crap for more than 4 CPUs. We 
could give
RT tasks a global queue with little impact to non-RT workloads (in fact, 
I think
early iterations of the 2.6 scheduler trialed this)... but let's not 
cripple the
RT apps that do the right thing (and need scalablility).

Another problem is that scheduling may not be O(1) anymore, if you have 
CPU affinity
bindings in place.

To summaries, I believe that if per-CPU RT queues is allowed within 
POSIX, then we
want to go with the sanest possible implementation, and force any broken 
apps to
fix themselves.... let's not cave in now :)

Nick

> [
> An historical note. USA had implemented (2) in offices, supermarkets 
> and such long before Europa. Because in Europe, customers were 
> convinced that model (2) took more time, because the queue was longer.
> ]
>
>

