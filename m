Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbSJ1OOi>; Mon, 28 Oct 2002 09:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbSJ1OOi>; Mon, 28 Oct 2002 09:14:38 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:9939 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261223AbSJ1OOc>; Mon, 28 Oct 2002 09:14:32 -0500
Date: Mon, 28 Oct 2002 14:21:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rusty Russell <rusty@rustcorp.com.au>
cc: mingming cao <cmm@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]updated ipc lock patch 
In-Reply-To: <20021028010711.E659A2C085@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210281311001.10156-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may prefer to skip the history and goto Your_patch;

On Mon, 28 Oct 2002, Rusty Russell wrote:
> In message <Pine.LNX.4.44.0210270748560.1704-100000@localhost.localdomain> you 
> write:
> > On Sun, 27 Oct 2002, Rusty Russell wrote:
> > > 
> > > You can't do that.  It's the price you pay.  It's nonsensical to fail
> > > to destroy an shm or sem.
> > 
> > Ironic, but not nonsensical: remember, this would only happen (if we
> > abandoned the mempool method and) the task trying to free is itself
> > being OOM-killed - sometimes, OOM-killing will kill the very task
> > that might have gone on to free even more memory, just a sad fact.

(Since you're bringing our discussion to linux-kernel,
I've restored the full paragraph of my side of the argument above.)

> Yes, nonsensical.  Firstly, it's in violation of the standard to fail
> IPC_RMID under random circumstances.  Secondly, failing to clean up is
> an unhandlable error, since you're quite possible in the failure path
> of the code already.  This is a well known issue.

The task which would have failed was being OOM-killed: it's not even
going to get back to userspace.  It might have been OOM-killed just
before it tried to IPC_RMID, but it happened during, that's all.
I think OOM-killing lies, shall we say, outside the standard?

But that's all irrelevant: we (Andrew tidied patch by Mingming
following recommendation by me of solution by Andrew) added the
mempool so that it will surely succeed, as you insisted, even if
OOM-kill intervenes at the worst moment.

> > > Using a mempool is putting your head in the sand, because it's use is
> > > not bounded.  Might as well just ignore kmalloc failures and leak
> > > memory, which is *really* dumb, because if we get killed by the
> > > oom-killer because we're out of memory, and that results in IPC trying
> > > to free.
> > 
> > Bounded in what sense?  The mempool is dedicated to ipc freeing, it's
> > not being drawn on by other kinds of use.  In the OOM-kill case of
> > actually getting down to using the reserved pool, each reserved item
> > will be returned when RCU (and, in the vfree case, the additional
> > scheduled work) has done with it.  Unbounded in that we cannot say
> > how many milliseconds that will take, but so what?
> 
> Two oom kills.  Three oom kills.  Four oom kills.  Where's the bound
> here?

No bound to the number of possible OOM kills, but what problem is that?
I got excited for a few minutes when I thought you were saying that the
task being OOM-killed would exit holding on to its mempool buffer.  But
that's not so, is it?  We'd have wider, more serious resource problems
with OOM kills if that were so.

> Our allocator behavior for GFP_KERNEL has changed several times.  Are
> you sure that it won't *ever* fail under other circomstances?

Well, I'll be surprised if we change kmalloc(GFP_KERNEL) to fail for
reasons other than memory shortage ("insufficient privilege"? hmm,
we'd change the names before that); though how hard it tries to decide
if there's really a memory shortage certainly changes from one kernel
to another.  But so long as it doesn't fail very often in normal
circumstances, it's okay: the reserved mempool buffers back it up.

> > Okay (I expect, didn't review it) for just the ids arrays, but too much
> > memory waste if we have to allocate for each msq, sema, shm: if there's
> > a better solution available.  mempool looks better to us.
> 
> It's a hacky, fragile and incorrect solution.  It's completely
> tasteless.

I guess it's a step forward that you haven't called it senseless.
Hacky, tasteless?  Maybe, depends on your taste.  I'm inclined to
counter that it's _fashionable_, which holds about as much weight.
But fragile, incorrect?  You've repeatedly failed to argue that.

> In order to save 12 bytes, you've added dozens of lines of subtle,
> fragile, incorrect code.  You honestly think this is a worthwhile
> tradeoff?

I thought mempool was the best way to go, to avoid wasting 80 bytes
per msq, sema, shmseg - I thought it would get ugly (hacky, tasteless)
to avoid the struct work overhead in some cases and not others.

Your_patch shows that it need not be ugly, and reduces the normal
waste to 16 bytes per msq, sema, shmseg.  These are not struct pages,
that amount will often be wasted by cacheline alignment too, so I'm
not going to get into a fight over it.

I think your patch looks quite nice - apart from the subtle hacky
fragile tasteless void *data[0]; but if something like that is
necessary, I'm sure someone can come up with a better there.

If Andrew or Mingming likes it and wants to replace the mempool
solution by yours, I'm not going to object (but if that is done,
remove struct rcu_ipc_free from ipc/util.h, and move its includes
of rcupdate.h and workqueue.h to ipc/util.c).  If they prefer the
mempool method, that's fine with me too.

But I wish you'd introduced your patch as "Here, I think this is
a nicer way of doing it, and doesn't waste as much as you thought:
you don't have to bother with a mempool this way" instead of getting
so mysteriously upset about it, implying some idiot failure in the
mempool method which you've not yet revealed to us.

Hugh

