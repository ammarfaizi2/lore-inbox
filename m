Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279822AbRKSUjL>; Mon, 19 Nov 2001 15:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278522AbRKSUjB>; Mon, 19 Nov 2001 15:39:01 -0500
Received: from mons.uio.no ([129.240.130.14]:53223 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S278046AbRKSUir>;
	Mon, 19 Nov 2001 15:38:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15353.28112.350734.11894@charged.uio.no>
Date: Mon, 19 Nov 2001 21:38:40 +0100
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
In-Reply-To: <200111191952.WAA21731@ms2.inr.ac.ru>
In-Reply-To: <15353.23941.858943.218040@charged.uio.no>
	<200111191952.WAA21731@ms2.inr.ac.ru>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == kuznet  <kuznet@ms2.inr.ac.ru> writes:

    >> The problem is that when EAGAIN is returned by sendmsg,

     > BTW this is already problem. UDP should not hit EAGAIN case, if
     > the predicate is right.

You are saying that the it is impossible for sock_alloc_send_skb() to
fail when using non-blocking writes? It was certainly occuring in
2.2.x.
Don't forget that we can be trying to fire off 16 * 32k 'simultaneous'
requests down the same socket when NFS is doing asynchronous block
writes. (Note: by 'simultaneous' I mean that we don't wait for the
server to reply before firing off the next request)

    >> then the current UDP code should be correct and race-free.

     > BTW recently I was reported it deadlocks on some spinlock...

Ulrich Weigand reported the following problem on the S/390:

A QDIO networking driver bottom half was grabbing a private spinlock,
then calling dev_kfree_skb_any() which again calls write_space() (via
kfree_skb()) and so tries to take xprt->sock_lock.

At the same time, a QDIO hard interrupt could be trying to take the
same private spinlock on another processor. Since the RPC layer only
protects against bottom halves, and since the interrupted process
could already be holding the RPC lock that kfree_skb() tries to take,
the hard interrupt could deadlock.

I haven't done anything about this because IMHO it makes more sense to
have the QDIO driver drop their special spinlock when calling external
functions such as dev_kfree_skb_any() rather than to force the RPC
layer to use the spin_lock_irqsave().

Cheers,
  Trond
