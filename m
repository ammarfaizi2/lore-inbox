Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265626AbSJXXwD>; Thu, 24 Oct 2002 19:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265631AbSJXXwC>; Thu, 24 Oct 2002 19:52:02 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:64625 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S265626AbSJXXwA>; Thu, 24 Oct 2002 19:52:00 -0400
Date: Fri, 25 Oct 2002 00:59:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: cmm@us.ibm.com, <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>,
       <dipankar@in.ibm.com>, <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH]updated ipc lock patch
In-Reply-To: <3DB88298.735FD044@digeo.com>
Message-ID: <Pine.LNX.4.44.0210250038330.1240-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, Andrew Morton wrote:
> Hugh Dickins wrote:
> > 
> > ...
> > Manfred and I have both reviewed the patch (or the 2.5.44 version)
> > and we both recommend it highly (well, let Manfred speak for himself).
> 
> OK, thanks.
> 
> So I took a look.  Wish I hadn't :(  The locking rules in there
> are outrageously uncommented.  You must be brave people.

Ah, we all like to criticize the lack of comments in others' code.

> What about this code?
> 
> void ipc_rcu_free(void* ptr, int size)
> {
>         struct rcu_ipc_free* arg;
> 
>         arg = (struct rcu_ipc_free *) kmalloc(sizeof(*arg), GFP_KERNEL);
>         if (arg == NULL)
>                 return;
>         arg->ptr = ptr;
>         arg->size = size;
>         call_rcu(&arg->rcu_head, ipc_free_callback, arg);
> }
> 
> Are we sure that it's never called under locks?

Yes.

> And it seems that if the kmalloc fails, we decide to leak some
> memory, yes?

Yes, but why would it fail?
and what do you think should be the alternative?

> If so it would be better to use GFP_ATOMIC there.  Avoids any
> locking problems and also increases the chance of the allocation
> succeeding.  (With an explanatory comment, naturally :)).

There are no locking doubts here.
GFP_ATOMIC would _reduce_ the chance of the allocation succeeding:
GFP_KERNEL does include the __GFP_WAIT flag, GFP_ATOMIC does not.

> Even better: is it possible to embed the rcu_ipc_free inside the
> object-to-be-freed?  Perhaps not?

It would certainly be possible (I did suggest it as a maybe),
but it's unclear whether it's worthwhile wasting the extra memory
longterm like that.  Mingming chose not to embed, I see no reason
to overrule.

> Stylistically, it is best to not typecast the return value
> from kmalloc, btw.  You should never typecast the return
> value of anything which returns a void *, because it weakens
> your compile-time checking.  Example:
> 
> 	foo *bar = (foo *)zot();
> 
> The compiler will swallow that, regardless of what zot() returns.
> Someone could go and change zot() to return a reiserfs_inode *
> and you would never know about it.  Whereas:
> 
> 	foo *bar = zot();
> 
> Says to the compiler "zot() must return a bar * or a void *",
> which is much tighter checking, yes?

You have too much time on your hands, Andrew :-)

> There is an insane amount of inlining in the ipc code.  I
> couldn't keep my paws off it.

I agree tempting: I thought you might like that in a subsequent patch,
yes?  Mingming was splitting locks, not doing a cleanup of inlines.

Hugh

