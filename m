Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265890AbUEUO2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265890AbUEUO2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 10:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265892AbUEUO2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 10:28:54 -0400
Received: from portal.beam.ltd.uk ([62.49.82.227]:33921 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id S265890AbUEUO2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 10:28:48 -0400
Message-ID: <40AE1208.4020505@beam.ltd.uk>
Date: Fri, 21 May 2004 15:28:24 +0100
From: Terry Barnaby <terry@beam.ltd.uk>
Organization: Beam Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Elladan <elladan@eskimo.com>
CC: Terry Barnaby <terry1@beam.ltd.uk>, davids@webmaster.com,
       Mike Black <mblack@csi-inc.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with mlockall() and Threads: memory usage
References: <MDEHLPKNGKAHNMBLJOLKEEIJMBAA.davids@webmaster.com> <40AB1EA7.8080104@beam.ltd.uk> <20040520002317.GB6501@eskimo.com>
In-Reply-To: <20040520002317.GB6501@eskimo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elladan,

Thanks for the responce, I don't think we have a really special-purpose
situation here. The application is relatively complex it that it
uses CORBA as well as many other libraries. We cannot hope to
calculate the necessary total stack usage, just make an educated guess
based on observed stack usage during running. It is very likely
that the stack usage will be small, and we can safely set the stack size
small, however we cannot garantee this. Normally VM allows programmers
flexibility with memory size limitations.
It seems inconsistant that when using mlockall() newly malloced memory will
be paged in as required but stacks are fixed into memory. Both of these
mechanisems involve dynamically extending the processes memory. I would have
thought it better that stacks followed the malloc() model in that memory
pages are only allocated as required. A system that needed to guarantee
no page faults could preallocate the stack easily as it would have to
with the heap. I do understand that this could be dificult to achieve
however.

Anyway cheers for the response and pointers.

Cheers

Terry

Some info gained for those reading this thread:
1. If you have a threaded application and you use
	mlockall(MCL_CURRENT | MCL_FUTURE) then the full amount
	of each threads	preallocated stack will be mapped into
	physical memory.
2. If you use pthread_create(&t, NULL, func, 0) then RedHat 9
	will allocate 8MBytes of stack per thread. (Possibly
	the amount set by the processes stack ulimit ?)
3. If you use pthread_create(&t, &a, func, 0) and set up the
	attributes with pthread_attr_init(&a) then RedHat 9
	will allocate 2MBytes to each thread. The pthreads manual
	states that using pthread_create() with attibutes set
	using pthread_attr_init() is the same as using NULL to
	pthread_create() this is WRONG. Also using pthread_attr_init()
	will sets the threads scheduler to SCHED_OTHER rather
	than "inherit" the parents scheduler config as passing
	NULL to pthread_create() does.

Elladan wrote:
> On Wed, May 19, 2004 at 09:45:27AM +0100, Terry Barnaby wrote:
> 
>>Hi David,
>>
>>We do want improved latency, but with reasonable memory usage. This is
>>a soft real-time system. At the moment the memory usage is far too
>>high in our application.
>>
>>With 20 threads runing the system will lock 160MBytes of memory just
>>for stack space (8 MBytes each), although the application probably
>>only needs 2MByte in total.  We can reduce the maximum stack size per
>>thread, but then if a thread increases its stack size beyond this the
>>application will crash with a segment fault, not good ...
>>
>>For our use, mapping in physical memory as required for a growing
>>stack would be a good compromise between latency and memory usage.
>>Once the system has run the worker threads for a short time all of the
>>needed stack memory will be locked in and latency will be controlled.
>>If a thread needs more memory for stack in a particular instance,
>>there will be a latency hit but this would be acceptable and much
>>better than a crash.
> 
> 
> It sounds to me like you have a really special-purpose situation here.
> You want to minimize the amount of memory used, but you may have deep
> stacks of unknown depth and you can't grow them safely without incurring
> latency.
> 
> It seems to me that you really should just figure out how much stack
> your app really needs and set your limits appropriately.  If your
> program requires indeterminate stack depth, you should fix it so it
> doesn't.
> 
> If you really, really want random memory allocations and memory locking
> at the same time, you could implement your own mlockall solution with
> your own stack manager.  You could do an mlockall(MCL_CURRENT) with
> small stack reserves, and then manually go and remap your stack space
> the way you want it.  Of course, you'd need your own memory allocator if
> you ever allocate more non-stack memory, but you'll need that anyway.
> 
> -J
> 
> 
>>David Schwartz wrote:
>>
>>>>Thanks for that.
>>>>I have done some more investigating, and on my system (Standard RedHat 9)
>>>>the stack ulimit is set to 8192 KBytes. So it appears that the thread
>>>>library/kernel threads pre-allocates, and writes to, 8129 KBytes
>>>>of stack per
>>>>thread and so then mlockall() locks all of this in memory.
>>>>
>>>>Should'nt the Thread library grow the stack rather than
>>>>preallocate it all even
>>>>with mlockall() like malloc ?
>>>
>>>
>>>	I thought you wanted improved latency. Surely having to find a page 
>>>	for you
>>>when your stack grows will add unpredictable latency. So, no, the thread
>>>library should reserve the stack when 'mlockall(MCL_FUTURE)' is specified.
>>>
>>>	I do agree that having an 'initial stack size' in additional to a 
>>>	'maximum
>>>stack size' would be a good idea. The former good for application that are
>>>concerned about physical memory usage and the latter for applications
>>>concerned about virtual memory usage.
>>>
>>>	DS
>>>
>>>
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>>-- 
>>Dr Terry Barnaby                     BEAM Ltd
>>Phone: +44 1454 324512               Northavon Business Center, Dean Rd
>>Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
>>Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
>>BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
>>                      "Tandems are twice the fun !"
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Dr Terry Barnaby                     BEAM Ltd
Phone: +44 1454 324512               Northavon Business Center, Dean Rd
Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
                       "Tandems are twice the fun !"
