Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVJRNPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVJRNPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 09:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVJRNPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 09:15:34 -0400
Received: from petasus.ims.intel.com ([62.118.80.130]:53918 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S1750739AbVJRNPe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 09:15:34 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH 1/1] indirect function calls elimination in IO scheduler
Date: Tue, 18 Oct 2005 17:15:23 +0400
Message-ID: <6694B22B6436BC43B429958787E454988F6171@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] indirect function calls elimination in IO scheduler
thread-index: AcXTRFoj9r9DdGFgQi+UhR1vAtjnkAAeoCCA
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Oct 2005 13:15:15.0735 (UTC) FILETIME=[FAB95A70:01C5D3E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes 
> But with the patch proposed, the function call is still indirect.
> That matches your asm, you eliminate one mov there.

Yes I've eliminated one only of two additional mov's and it is enough
for
increasing SysBench fileio throughput by 2% and more on Itanium. Other
indirect step deleting had no any influence on SysBench fileio
throughput.

Kernel object code for Itanium is reduced by 856 bytes after patching.

> I'm guessing you are testing this with your NULL driver.
NULL driver was used for profiling of elevator function only.
It is not considered as grounding for patching.

> this patch is a no-go from the beginning since
> you cannot ref count a statically embedded structure. It has to be
> dynamically allocated.

There was no any 'ref count' elevator structure in 2.6.9. There was not
added any 'ref count' while modular and online switching was enabled.

> So if you are really interested in this and have a valid reason
The SysBench fileio test results shows noop degradation after 2.6.9.

> That's a seperate point, but it means that embedding the elevator
inside
> the queue wastes memory (104 bytes per queue on this box I'm typing
on)
> for dm/md devices.

845 bytes in kernel code are deleted but 104 bites per disk
(except first disk) are wasted. For summery 9 disks he have a balance.
But kernel run time and performance is better.

> The reference count does exist outside of the queue getting
gotten/put,
> the switching being one of them. Tejun has patches for improving the
> switching, so it would be possible to keep two schedulers alive for
the
> queue for the duration of the switch.

Now it is not possible function two schedulers simultaneously while
schedulers are switching. But ioscheduler switcher will return still to
previous ioscheduler if new ioscheduler fail to attach. 

Leonid
-----Original Message-----
From: Jens Axboe [mailto:axboe@suse.de] 
Sent: Monday, October 17, 2005 9:59 PM
To: Ananiev, Leonid I
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] indirect function calls elimination in IO
scheduler

On Mon, Oct 17 2005, Ananiev, Leonid I wrote:
> Jens Axboe writes
> 
> > I don't really see the patch doing what you describe - the indirect
> > function calls are the same.
> 
> For example on Pentium4 in the function elv_next_request() the line
>             struct request *rq =
> q->elevator->ops->elevator_next_req_fn(q);
> before patch had required 11% of function running time as oprofile
> reports
>            %
>     26  0.0457 :c0270ecb:       mov    0xc(%edi),%eax
>   3455  6.0670 :c0270ece:       mov    (%eax),%eax
>   2848  5.0011 :c0270ed0:       mov    %edi,(%esp)
>   1538  2.7008 :c0270ed3:       call   *0xc(%eax)
> 
> 	A patch which would delete all indirect calls was tryed
>         struct request *rq =
q->elevator_cp.ops.elevator_next_req_fn(q);
>      9  0.0224 :c0270eea:       mov    %edi,(%esp)
>   3814  9.4793 :c0270eed:       call   *0x18(%edi)
> 
> But additional memory would be needed for 'ops' in each queue. The
> intermediate (proposed) patch has the same timing effect but saves
some
> memory:
> 	struct request *rq =
> q->elevator_cp.ops->elevator_next_req_fn(q);
> drivers/block/elevator.c:351
> ffffffff802a8b97:       49 8b 44 24 18          mov    0x18(%r12),%rax
> ffffffff802a8b9c:       4c 89 e7                mov    %r12,%rdi
> ffffffff802a8b9f:       ff 50 18                callq  *0x18(%rax)

But with the patch proposed, the function call is still indirect. You
are only moving eliminating a dereference of elevator-> since that is
now inlined in the queue. That matches your asm, you eliminate one mov
there.

I'm guessing you are testing this with your NULL driver, which is why
the difference is so 'huge' in profiling. And you are probably using
noop, correct? I don't see a lot of real world relevance to this
testing to be honest, the io path isn't completely lean with the regular
io schedulers either and I bet this would be noise on real world
testing. Micro benchmarks are all fine, but they only say so much. And
as I originally stated, this patch is a no-go from the beginning since
you cannot ref count a statically embedded structure. It has to be
dynamically allocated.

So if you are really interested in this and have a valid reason to
pursue it, please think more about other ways to solve this.

-- 
Jens Axboe

