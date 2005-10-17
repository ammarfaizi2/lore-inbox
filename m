Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVJQR6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVJQR6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVJQR6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:58:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56087 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751183AbVJQR6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:58:13 -0400
Date: Mon, 17 Oct 2005 19:58:59 +0200
From: Jens Axboe <axboe@suse.de>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] indirect function calls elimination in IO scheduler
Message-ID: <20051017175858.GY2811@suse.de>
References: <6694B22B6436BC43B429958787E454988F5B44@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6694B22B6436BC43B429958787E454988F5B44@mssmsx402nb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
>         struct request *rq = q->elevator_cp.ops.elevator_next_req_fn(q);
>      9  0.0224 :c0270eea:       mov    %edi,(%esp)
>   3814  9.4793 :c0270eed:       call   *0x18(%edi)
> 
> But additional memory would be needed for 'ops' in each queue. The
> intermediate (proposed) patch has the same timing effect but saves some
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

