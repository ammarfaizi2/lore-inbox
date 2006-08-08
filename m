Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWHHQIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWHHQIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWHHQIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:08:37 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:25513 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S932442AbWHHQIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:08:37 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC] NUMA futex hashing
Date: Tue, 8 Aug 2006 18:08:34 +0200
User-Agent: KMail/1.9.1
Cc: Ulrich Drepper <drepper@gmail.com>, Andi Kleen <ak@suse.de>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
References: <20060808070708.GA3931@localhost.localdomain> <a36005b50608080739w2ea03ea8i8ef2f81c7bd55b5d@mail.gmail.com> <44D8A9BE.3050607@yahoo.com.au>
In-Reply-To: <44D8A9BE.3050607@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081808.34708.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 17:11, Nick Piggin wrote:
> Ulrich Drepper wrote:
> > On 8/8/06, Eric Dumazet <dada1@cosmosbay.com> wrote:
> >> The validity of the virtual address is still tested by normal get_user()
> >> call.. If the memory was freed by a thread, then a normal EFAULT error
> >> will
> >> be reported... eventually.
> >
> > This is indeed what should be done.  Private futexes are the by far
> > more frequent case and I bet you'd see improvements when avoiding the
> > mm mutex even for normal machines since futexes really are everywhere.
> > For shared mutexes you end up doing two lookups and that's fine IMO
> > as long as the first lookup is fast.
>
> The private futex's namespace is its virtual address, so I don't see
> how you can decouple that from the management of virtual addresses.
>
> Let me get this straight: to insert a contended futex into your rbtree,
> you need to hold the mmap sem to ensure that address remains valid,
> then you need to take a lock which protects your rbtree. Then to wake
> up a process and remove the futex, you need to take the rbtree lock. Or
> to unmap any memory you also need to take the rbtree lock and ensure
> there are no futexes there.
>
> So you just add another lock for no reason, or have I got a few screws
> loose myself? I don't see how you can significantly reduce lock
> cacheline bouncing in a futex heavy workload if you're just going to
> add another shared data structure. But if you can, sweet ;)

We certainly can. But if you insist of using mmap sem at all, then we have a 
problem.

rbtree would not reduce cacheline bouncing, so :

We could use a hashtable (allocated on demand) of size N, N depending on 
NR_CPUS for example. each chain protected by a private spinlock. If N is well 
chosen, we might reduce lock cacheline bouncing. (different threads fighting 
on different private futexes would have a good chance to get different 
cachelines in this hashtable)

As soon a process enters 'private futex' code, the futex code allocates this 
hashtable if the process has a NULL hash table (set to NULL at exec() time, 
or maybe re-allocated because we want to be sure futex syscall always suceed 
(no ENOMEM))

So we really can... but for 'private futexes' which are the vast majority of 
futexes needed by typical program (using POSIX pshared thread mutex attribute 
PTHREAD_PROCESS_PRIVATE, currently not used by NPTL glibc)

Of course we would need a new syscall, and to change glibc to be able to 
actually use this new private_futex syscall.

Probably a lot of work, still, but could help heavy threaded programs not 
touching mmap_sem.

We might have a refcounting problem on this 'hashtable' since several threads 
share this structure, but only at thread creation/destruction, not in futex 
call (ie no cacheline bouncing on the refcount)

Eric
