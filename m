Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277317AbRJJQ7O>; Wed, 10 Oct 2001 12:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277319AbRJJQ7F>; Wed, 10 Oct 2001 12:59:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31540 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277317AbRJJQ6v>; Wed, 10 Oct 2001 12:58:51 -0400
Date: Wed, 10 Oct 2001 18:58:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: Peter Rival <frival@zk3.dec.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Richard Henderson <rth@twiddle.net>, cardoza@zk3.dec.com,
        woodward@zk3.dec.com
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010185848.D726@athlon.random>
In-Reply-To: <OF206EE8AA.7A83A16B-ON88256AE1.005467E3@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF206EE8AA.7A83A16B-ON88256AE1.005467E3@boulder.ibm.com>; from Paul.McKenney@us.ibm.com on Wed, Oct 10, 2001 at 08:24:11AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 08:24:11AM -0700, Paul McKenney wrote:
> which states:
> 
>      For instance, your producer must issue a "memory barrier" instruction
>      after writing the data to shared memory and before inserting it on
>      the queue; likewise, your consumer must issue a memory barrier
>      instruction after removing an item from the queue and before reading
>      from its memory.  Otherwise, you risk seeing stale data, since,
>      while the Alpha processor does provide coherent memory, it does
>      not provide implicit ordering of reads and writes.  (That is, the
>      write of the producer's data might reach memory after the write of
>      the queue, such that the consumer might read the new item from the
>      queue but get the previous values from the item's memory.
> 
> Note that they require a memory barrier (rmb()) between the time the
> item is removed from the queue and the time that the data in the item
> is referenced, despite the fact that there is a data dependency between
> the dequeueing and the dereferencing.  So, again, data dependency does
> -not- substitute for an MB on Alpha.

This is very explicit indeed.

In short I guess what happens is that the reader may have old data in
its cache, and the rmb() makes sure the cache used after the rmb() is
not older than the cache used before the rmb().

However the more I think about it the more I suspect we'd better use
rmb() in all readers in the common code, rather than defining rmbdd with
IPI on alpha, maybe alpha after all isn't the only one that needs the
rmb() but it's the only one defining the behaviour in detail? I can very
well imagine other archs also not invalidating all caches of all other
cpus after a write followed by wmb, the synchronization can be delayed
safely if the other cpus are readers, and they didn't issued an explicit
rmb. So what alpha is doing can really be seen as a "feature" that
allows to delay synchronization of caches after writes and wmb, unless
an explicit order is requested by the reader via rmb (or better mb on alpha).

The fact is that if there's old data in cache, a data dependency isn't
different than non data dependency if the cpu caches aren't synchronized
or invalidated during wmb run by the producer.

Andrea
