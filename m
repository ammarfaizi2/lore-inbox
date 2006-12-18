Return-Path: <linux-kernel-owner+w=401wt.eu-S1753923AbWLRM0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbWLRM0z (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 07:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbWLRM0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 07:26:55 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:65504 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923AbWLRM0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 07:26:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m9o5N9YWgr4tNSR+muH5VY6iciQdF4c3yyadE7E6/hZ2x2jWQclqjOIj9douA1lxqiy1N0epGLzBTCguViH5/kUC5FNqj3UvNaCiRw9Qdt3wGp5YaLPO24KFQa82NO44ZHbLsPuadqhgs/DzST1xYBziDiO70/nfU6i8u+vXaKQ=
Message-ID: <b0943d9e0612180426m3f320a3ah86631d1852a6b15@mail.gmail.com>
Date: Mon, 18 Dec 2006 12:26:53 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061218112120.GA7599@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <20061216165738.GA5165@elte.hu>
	 <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
	 <20061217085859.GB2938@elte.hu>
	 <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com>
	 <20061218072932.GA5624@elte.hu>
	 <b0943d9e0612180228w142a7375obf33a0f42d1982ae@mail.gmail.com>
	 <20061218112120.GA7599@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Catalin Marinas <catalin.marinas@gmail.com> wrote:
>
> > >> [...] It could be so simple that it would never need to free any
> > >> pages, just grow the size as required and reuse the freed memleak
> > >> objects from a list.
> > >
> > >sounds good to me. Please make it a per-CPU pool.
> >
> > Isn't there a risk for the pools to become imbalanced? A lot of
> > allocations would initially happen on the first CPU.
>
> hm, what's the problem with imbalance? These are trees and imbalance
> isnt a big issue.

It could just be more available (freed) memleak_objects on one CPU
than on the others and use more memory. Not a big problem though.

> > > We'll have to fix the locking too, to be per-CPU - memleak_lock is
> > > quite a scalability problem right now.
> >
> > The memleak_lock is indeed too coarse (but it was easier to track the
> > locking dependencies). With a new allocator, however, I could do a
> > finer grain locking. It probably still needs a (rw)lock for the hash
> > table. Having per-CPU hash tables is inefficient as we would have to
> > look up all the tables at every freeing or scanning for the
> > corresponding memleak_object.
>
> at freeing we only have to look up the tree belonging to object->cpu.

At freeing, kmemleak only gets a pointer value which has to be looked
up in the hash table for the corresponding memleak_object. Only after
that, we can know memleak_object->cpu. That's why I think we only need
to have a global hash table. The hash table look-up can be RCU.

It would work with per-CPU hash tables but we still need to look-up
the other hash tables in case the freeing happened on a different CPU
(i.e. look-up the current hash table and, if it fails, look-up the
other per-CPU hashes). Freeing would need to remove the entry from the
hash table and acquire a lock but this would be per-CPU. I'm not sure
how often you get this scenario (allocation and freeing on different
CPUs) but it might introduce an overhead to the memory freeing.

Do you have a better solution here?

> > There is a global object_list as well covered by memleak_lock (only
> > for insertions/deletions as traversing is RCU). [...]
>
> yeah, that would have to become per-CPU too.

That's not that difficult but, as above, we need the hash table
look-up before we find which list it is on.

> > [...] List insertion/deletion is very small compared to the hash-table
> > look-up and it wouldn't introduce a scalability problem.
>
> it's a common misconception to think that 'small' critical sections are
> fine. That's not the issue. The pure fact of having globally modified
> resource is the problem, the lock cacheline would ping-pong, etc.

You are right but I didn't mean that small critical sections are
better, just that in case we need a critical section for the global
hash table look-up, extending this critical region with list
addition/deletion wouldn't make things any worse (than they are,
regarding scalability).

-- 
Catalin
