Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWJFL5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWJFL5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422636AbWJFL5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:57:49 -0400
Received: from brick.kernel.dk ([62.242.22.158]:12117 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1422642AbWJFL5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:57:48 -0400
Date: Fri, 6 Oct 2006 13:57:31 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc][patch 2.6.18-rc7] block: explicit plugging
Message-ID: <20061006115731.GK5170@kernel.dk>
References: <20060916115607.GA16971@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916115607.GA16971@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16 2006, Nick Piggin wrote:
> Hi,
> 
> I've been tinkering with this idea for a while, and I'd be interested
> in seeing what people think about it. The patch isn't in a great state
> of commenting or splitting ;) but I'd be interested feelings about the
> general approach, and whether I'm going to hit any bad problems (eg.
> with SCSI or IDE).
> 
> Nick
> 
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
> 
> - Explicit plugging keeps a process-private queue of requests being held.
>   This offers some advantages over immediately sending requests to the
>   block device: firstly, merging can be attempted on requests in this list
>   (currently only attempted on the head of the list) without taking any
>   locks; secondly, when unplugging occurs, the requests can be delivered
>   to the block device queue in a batch, thus the lock aquisitions can be
>   batched up.
>   
> On a parallel tiobench benchmark, of the 800 000 calls to __make_request
> performed, this patch avoids 490 000 (62%) of queue_lock aquisitions by
> early merging on the private plugged list.

Nick, this looks pretty good in general from the vm side, and the
concept is nice for reduced lock bouncing. I've merged this for more
testing in a 'plug' branch in the block repo.

> Testing and development is in early stages yet. In particular, the lack of
> a timer based unplug kick probably breaks some block device drivers in
> funny ways (though works here for me with SCSI and UML so far). Also needs
> much wider testing.

Your SCSI changes are pretty broken, I've fixed them up. We need some
way of asking the block layer to back off and rerun is sometime soon,
which is what the plugging does in that case. I've introduced a new
mechanism for that.

Changes:

    - Don't invoke ->request_fn() in blk_queue_invalidate_tags

    - Fixup all filesystems for block_sync_page()

    - Add blk_delay_queue() to handle the old plugging-on-shortage
      usage.

    - Unconditionally run replug_current_nested() in ioschedule()

    - Merge to current git tree.

I'll try to do some serious testing on this soon. It would also be nice
to retain the plugging information for blktrace, even if it isn't per
queue anymore. Hmmm.

-- 
Jens Axboe

