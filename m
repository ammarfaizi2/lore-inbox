Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWESSIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWESSIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWESSIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:08:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:45594 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751373AbWESSIh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:08:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DJFD3WckOngYB0/vxJRpdrei7Rdu2PHMFsstJh6FCnRe1igwLvdSQEQtIC6Tb/0q4Uh9bVICLikhgjfVNEsasyYUPMOiWNnDoSwrhSarBWuyCzYEtFnwt/S4KfYSbXKVK54fdNj9MsIrgdCFfmv4BEMZOj8lEjkDQlCWaSoQmCo=
Message-ID: <e9c3a7c20605191101l7a4488b5ge185ff921e91b401@mail.gmail.com>
Date: Fri, 19 May 2006 11:01:38 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: [RFC][PATCH] MD RAID Acceleration: Move stripe operations outside the spin lock
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       daniel.j.thompson@intel.com,
       "Chris Leech" <christopher.leech@intel.com>
In-Reply-To: <17517.11618.885744.164970@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147818171.18360.14.camel@dwillia2-linux.ch.intel.com>
	 <17517.11618.885744.164970@cse.unsw.edu.au>
X-Google-Sender-Auth: 97eff627dc21d05c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi.
>
> This certainly looks like it is heading in the right direction - thanks.
>
> I have a couple of questions, which will probably lead to more.
>
> You obviously need some state-machine functionality to oversee the
> progression like  xor - drain - xor (for RMW) or clear - copy - xor
> (for RCW).
> You have encoded the different states on a per block basis (storing it
> in sh->dev[x].flags) rather than on a per-strip basis (and so encoding
> it in sh->state).
> What was the reason for this choice?
>
> The only reason I can think of is to allow more parallelism :
> different blocks within a strip can be in different states.  I cannot
> see any value in this as the 'xor' operation will work across all
> (active) blocks in the strip and so you will have to synchronise all
> the blocks on that operation.
>
> I feel the code would be simpler if the state was in the strip rather
> than the block.
I agree, I started out down this path but then I had trouble
determining which blocks were part of the operation without the
overhead of taking the sh->lock.  So, the original decision was based
on the design goal of minimizing the locking required in the
workqueue.  But your questions sparked a realization about how to
rework this, although I think it requires the wait_for_block_op queue,
 see below...

> The wait_for_block_op queue and it's usage seems odd to me.
> handle_stripe should never have to wait for anything.
> when a block_op is started, the sh->count should be incremented, and
> the decremented when the block-ops have finished.  Only when will
> handle_stripe get to look at the stripe_head again.  So waiting
> shouldn't be needed.
The case I was concerned about was when two threads are at the top of
handle_stripe, one gets in and kicks off a block op while the other
spins.  handle_write_operations makes the assumption that it can
blindly advance the state without worrying about whether the workqueue
has had a chance to dequeue the request.  Without the wait, the
workqueue races with the 2nd thread coming out of the spin lock.  I.e.
the thread in handle stripe may advance the state before the request
is dequeued in the workqueue.  The other purpose is that it allows the
workqueue to read the state bits without taking a lock.  At run time
it appears that it does not take the wait path very often, it takes it
once at the beginning of a set of operations but after the first strip
is recycled on to the handle list there are enough strips queued up
such that it does not need to wait.

As I wrote "The other purpose is that it allows the workqueue to read
the state bits without taking a lock" I realized that I can rewrite
the code to have the state information solely in sh->state.

> Your GFP_KERNEL kmalloc is a definite no-no which can lead to
> deadlocks (it might block while trying to write data out thought the
> same raid array).  At least it should be GFP_NOIO.
Ahh, I did not consider the case of I/O out the same md device.  A
hypothetical question though, would we keep recursing (threads
sleeping waiting for I/O) to a point where kmalloc would eventually
return 0 (i.e. to a point where we can take the allocation failure
path), or would we deadlock at some point?

> However a better solution would be to create and use a mempool - they
> are designed for exactly this sort of usage.
> However I'm not sure if even that is needed.  Can a stripe_head have
> move than one active block_ops task happening?  If not, the
> 'stripe_work' should be embedded in the 'stripe_head'.
The 'more than one active blocks_ops' case I am considering is a read
(bio fill) that is issued in between the bio drain and xor operation
for a write.  However, another realization, with the wait_for_block_op
queue it should be ok to have the stripe_work embedded in the
stripe_head since the next operation will not be issued until the
first is dequeued.

> There will probably be more questions once these are answered, but as
> the code is definitely a good start.

Thanks for being patient with my attempts.

>
> (*) Since reading the DDF documentation again, I've realised that
> using the word 'stripe' both for a chunk-wide stripe and a block-wide
> stripe is very confusing.  So I've started using 'strip' for a
> block-wide stripe.  Thus a 'stripe_head' should really be a
> 'strip_head'.
>
> I hope this doesn't end up being even more confusing :-)
>
I actually think this will make things less confusing.

A question, is it inefficient to discuss this with the 2.6.17-rc state
of the code, should I move over to the latest -mm?

Thanks again for your help,

Dan
