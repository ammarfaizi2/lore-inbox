Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751903AbWIRUKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbWIRUKU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbWIRUKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:10:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:26063 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751903AbWIRUKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:10:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FIXVf7QXFrgIFJ9TE4r/yXrW0MdRTLNOjjsWJP0ik5D89DAifpC1NG0gyfzu7vyLes77TizOR74kAxoH6bFRT5cNgvbxr+e6+ayRPvlaRy5p3yrRUPSzZwsKsYaLW40kpXu595KiybTfATXH4dopIt4srtRG4hhQPukA0OLS8/s=
Message-ID: <5c49b0ed0609181310n409a64c2i172e07044802751a@mail.gmail.com>
Date: Mon, 18 Sep 2006 13:10:13 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Nick Piggin" <npiggin@suse.de>
Subject: Re: [rfc][patch 2.6.18-rc7] block: explicit plugging
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Jens Axboe" <axboe@kernel.dk>
In-Reply-To: <20060916115607.GA16971@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060916115607.GA16971@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/06, Nick Piggin <npiggin@suse.de> wrote:
> Hi,
>
> I've been tinkering with this idea for a while, and I'd be interested
> in seeing what people think about it. The patch isn't in a great state
> of commenting or splitting ;) but I'd be interested feelings about the
> general approach, and whether I'm going to hit any bad problems (eg.
> with SCSI or IDE).

I *really* like this idea, and I would like to help get it merged.  I
can even run some benchmarks for you once I get my test rig running
again.

>
> This is a patch to perform block device plugging explicitly in the submitting
> process context rather than implicitly by the block device.
>
> There are several advantages to plugging in process context over plugging
> by the block device:
>
> - Implicit plugging is only active when the queue empties, so any
>   advantages are lost if there is parallel IO occuring. Not so with
>   explicit plugging.
>
> - Implicit plugging relies on a timer and watermarks and a kind-of-explicit
>   directive in lock_page which directs plugging. These are heuristics and
>   can cost performance due to holding a block device idle longer than it
>   should be. Explicit plugging avoids most of these issues by only holding
>   the device idle when it is known more requests will be submitted.
>
> - This lock_page directive uses a roundabout way to attempt to minimise
>   intrusiveness of plugging on the VM. In doing so, it gets needlessly
>   complex: the VM really is in a good position to direct the block layer
>   as to the nature of its requests, so there is no need to try to hide
>   the fact.

I had a related idea that I have not been able to work on yet.  I
called it "kernel anticipation", and it explicitly instructs the
scheduler when a function is submitting I/O that subsequent I/O is
dependent on.  In other words, when we are composing a bio and get the
"BH_Boundary" flag in a buffer head, mark the bio for mandatory
anticipation, since we know we'll have a hit.  This would enable the
anticipation code to act in some cases even for processes with very
high thinktimes.

> On a parallel tiobench benchmark, of the 800 000 calls to __make_request
> performed, this patch avoids 490 000 (62%) of queue_lock aquisitions by
> early merging on the private plugged list.

Have you run any FS performance benchmorks to check for regressions in
performance?  Who knows, you might even see be able to show a visible
increase :)

> @@ -2865,68 +2762,48 @@ static int __make_request(request_queue_
>          */
>         blk_queue_bounce(q, &bio);
>
> -       spin_lock_prefetch(q->queue_lock);
> -
>         barrier = bio_barrier(bio);
>         if (unlikely(barrier) && (q->next_ordered == QUEUE_ORDERED_NONE)) {
>                 err = -EOPNOTSUPP;
>                 goto end_io;
>         }
>
> +       /* Attempt merging with the plugged list before taking locks */
> +       ioc = current->io_context;
> +       if (ioc && ioc->plugged && !list_empty(&ioc->plugged_list)) {
> +               struct request *rq;
> +               rq = list_entry_rq(ioc->plugged_list.prev);
> +
> +               el_ret = elv_try_merge(rq, bio);
> +               if (el_ret == ELEVATOR_BACK_MERGE) {
> +                       if (bio_attempt_back_merge(q, rq, nr_sectors, bio))
> +                               goto out;
> +               } else if (el_ret == ELEVATOR_FRONT_MERGE) {
> +                       if (bio_attempt_front_merge(q, rq, nr_sectors, bio))
> +                               goto out;
> +               }
> +       }
> +
>         spin_lock_irq(q->queue_lock);
>
> -       if (unlikely(barrier) || elv_queue_empty(q))
> +       if (elv_queue_empty(q))
>                 goto get_rq;
>
>         el_ret = elv_merge(q, &req, bio);
> -       switch (el_ret) {

Have you considered skipping the queue merge entirely, if there is not
a hit in the plugged_list?  I would be interested to see a "hit rate"
of how many queue merge attempts are successful here.  I bet it's
pretty low.  The difference froim just skipping these entirely might
not even be visible in a benchmark.  It'd be pretty cool to be able to
eliminate the queue merging interface altogether.

Thanks for doing this work, it looks really promising.

NATE
