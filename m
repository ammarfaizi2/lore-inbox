Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbTBUJgp>; Fri, 21 Feb 2003 04:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbTBUJgp>; Fri, 21 Feb 2003 04:36:45 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:40325 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267212AbTBUJgo>;
	Fri, 21 Feb 2003 04:36:44 -0500
Date: Fri, 21 Feb 2003 10:46:27 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing system to a crawl]
Message-ID: <20030221094627.GI31480@x30.school.suse.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <200302191742.02275.m.c.p@wolk-project.de> <20030219174940.GJ14633@x30.suse.de> <200302201629.51374.m.c.p@wolk-project.de> <20030220103543.7c2d250c.akpm@digeo.com> <20030220215457.GV31480@x30.school.suse.de> <20030220161536.F1723@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220161536.F1723@schatzie.adilger.int>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 04:15:36PM -0700, Andreas Dilger wrote:
> On Feb 20, 2003  22:54 +0100, Andrea Arcangeli wrote:
> > Explanation is very simple: you _can't_ kmap two times in the context of
> > a single task (especially if more than one task can run the same code at
> > the same time). I don't yet have the confirmation that this fixes the
> > deadlock though (it takes days to reproduce so it will take weeks to
> > confirm), but I can't see anything else wrong at the moment, and this
> > remains a genuine highmem deadlock that has to be fixed.  The fix is
> > optimal, no change unless you run out of kmaps and in turn you can
> > deadlock, i.e. all the light workloads won't be affected at all.
> 
> We had a similar problem in Lustre, where we have to kmap multiple pages
> at once and hold them over a network RPC (which is doing zero-copy DMA
> into multiple pages at once), and there is possibly a very heavy load
> of kmaps because the client and the server can be on the same system.
> 
> What we did was set up a "kmap reservation", which used an atomic_dec()
> + wait_event() to reschedule the task until it could get enough kmaps
> to satisfy the request without deadlocking (i.e. exceeding the kmap cap
> which we conservitavely set at 3/4 of all kmap space).

Your approch was fragile (every arch is free to give you just 1 kmap in
the pool and you still must not deadlock) and it's not capable of using
the whole kmap pool at the same time. the only robust and efficient way
to fix it is the kmap_nonblock IMHO

> A single "server" task could exceed the kmap cap by enough to satisfy the
> maximum possible request size, so that a single system with both clients
> and servers can always make forward progress even in the face of clients
> trying to kmap more than the total amount of kmap space.
> 
> This works for us because we are the only consumer of huge amounts of kmaps
> on our systems, but it would be nice to have a generic interface to do that
> so that multiple apps don't deadlock against each other (e.g. NFS + Lustre).

This isn't the problem, if NFS wouldn't be broken it couldn't deadlock
against Lustre even with your design (assuming you don't fall in the two
problems mentioned above). But still your design is more fragile and
less scalable, especially for a generic implementation where you don't
know how many pages you'll reserve in mean, and you don't know how many
kmaps entries the architecture can provide to you. But of course with
kmap_nonblock you'll have to fallback submitting single pages if it
fails, it's a bit more difficult but it's more robust and optimized IMHO.

Andrea
