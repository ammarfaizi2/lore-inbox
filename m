Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSJ1WVX>; Mon, 28 Oct 2002 17:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSJ1WVW>; Mon, 28 Oct 2002 17:21:22 -0500
Received: from dp.samba.org ([66.70.73.150]:50857 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261572AbSJ1WVQ>;
	Mon, 28 Oct 2002 17:21:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: mingming cao <cmm@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]updated ipc lock patch 
In-reply-to: Your message of "Mon, 28 Oct 2002 14:21:47 -0000."
             <Pine.LNX.4.44.0210281311001.10156-100000@localhost.localdomain> 
Date: Tue, 29 Oct 2002 08:47:31 +1100
Message-Id: <20021028222738.201E02C4D6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0210281311001.10156-100000@localhost.localdomain> you
 write:
> (Since you're bringing our discussion to linux-kernel,
> I've restored the full paragraph of my side of the argument above.)

Hi Hugh,

	Thanks for your complete reply.  I thought it was my fault
that it fell off lkml, and "corrected" it.  Sorry about that.

> > Two oom kills.  Three oom kills.  Four oom kills.  Where's the bound
> > here?
> 
> No bound to the number of possible OOM kills, but what problem is that?

Sorry, I'm obviously not making myself clear, since I've said this
three times now.

1) The memory is required for one whole RCU period (whether from
   kmalloc or the mempool).  This can be an almost arbitrarily long
   time (I've seen it take a good fraction of a second).

2) This is a problem, because other tasks could be OOM killed during
   that period, and could also try to use this mempool.

3) So, the size of the mempool which guarantees there will be enough?
   It's equal to the number of things you might free, which means
   you might as well allocate them together.

This is the correctness problem with the mempool IPC implementation.

> > Our allocator behavior for GFP_KERNEL has changed several times.  Are
> > you sure that it won't *ever* fail under other circomstances?
> 
> Well, I'll be surprised if we change kmalloc(GFP_KERNEL) to fail for
> reasons other than memory shortage ("insufficient privilege"? hmm,
> we'd change the names before that); though how hard it tries to decide
> if there's really a memory shortage certainly changes from one kernel
> to another.  But so long as it doesn't fail very often in normal
> circumstances, it's okay: the reserved mempool buffers back it up.

Once again, if ever returns NULL other than for tasks being OOM
killed, the problem gets wider.

It would be reasonable for the page allocator one day to say "hmm, at
the rate kswapd is going, it's going to take > 1 minute to fill this
allocation.  Let's fail it immediately instead".

This is the fragility problem with the mempool IPC implementation: you
are relying on the kmalloc implementation details which you are
explicitly not allowed to do (see previous "should kmalloc fail?"
threads).

> Your_patch shows that it need not be ugly, and reduces the normal
> waste to 16 bytes per msq, sema, shmseg.  These are not struct pages,
> that amount will often be wasted by cacheline alignment too, so I'm
> not going to get into a fight over it.

It could be reduced to 12 bytes by cutting out the "arg", and 8 bytes
by making it a single linked list.  I've posted this separately.

> I think your patch looks quite nice - apart from the subtle hacky
> fragile tasteless void *data[0]; but if something like that is
> necessary, I'm sure someone can come up with a better there.

Yes, it's tasteless, but not fragile.  Skipping it would be fragile
(it's unneccessary since struct rcu_head has a pointer in it).

I'm not sure that the alternative is nicer, either, though 8(

> But I wish you'd introduced your patch as "Here, I think this is
> a nicer way of doing it, and doesn't waste as much as you thought:
> you don't have to bother with a mempool this way" instead of getting
> so mysteriously upset about it, implying some idiot failure in the
> mempool method which you've not yet revealed to us.

You're right.  This took far more time than simply producing the patch
myself would have taken.

But despite that, I prefer to take the un-Viro-like approach of
believing that my fellow programmers cleverer than I am, and hence
require only a few subtle pointers when I manage to spot errors.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
