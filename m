Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318856AbSICRZh>; Tue, 3 Sep 2002 13:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318858AbSICRZh>; Tue, 3 Sep 2002 13:25:37 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:58806 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S318856AbSICRZc>; Tue, 3 Sep 2002 13:25:32 -0400
Date: Tue, 3 Sep 2002 13:29:57 -0400
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] mount flag "direct"
Message-ID: <20020903172956.GA12391@ravel.coda.cs.cmu.edu>
Mail-Followup-To: "Peter T. Breuer" <ptb@it.uc3m.es>,
	linux-kernel@vger.kernel.org
References: <20020903162302.GD2344@marowsky-bree.de> <200209031641.g83GfnD10219@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209031641.g83GfnD10219@oboe.it.uc3m.es>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 06:41:49PM +0200, Peter T. Breuer wrote:
> "A month of sundays ago Lars Marowsky-Bree wrote:"
> > Your approach is not feasible.
> 
> But you have to be specific about why not. I've responded to the
> particular objections so far.
> 
> > Distributed filesystems have a lot of subtle pitfalls - locking, cache
> 
> Yes, thanks, I know.
> 
> > coherency, journal replay to name a few - which you can hardly solve at the
> 
> My simple suggestion is not to cache. I am of the opinion that in
> principle that solves all coherency problems, since there would be no
> stored state that needs to "cohere". The question is how to identify
> and remove the state that is currently cached.

That is a very simple suggestion, but not feasable because there always
be 'cached copies' floating around. Even if you remove the dcache
(directory lookups) and icache (inode cache) in the kernel, both
filesystems will still need to look at the data in order to modify it.
Looking at the data involves creating an in-memory representation of the
object. If there is no locking, if one filesystem modifies the object,
the other filesystem is looking at (and possibly modifying) stale data
which causes consistency problems.

> > Good reading would be any sort of entry literature on clustering, I would
> 
> Please don't condescend! I am honestly not in need of education :-).

I'm afraid that all of this has been very well documented, another
example would be Tanenbaum's "Distributed Systems", especially the
chapter on various consistency models is a nice read.

> We already know that we can have a perfectly fine and arbitrary
> shared file system, shared only at the block level if we 
> 
>   1) permit no new dirs or files to be made (disable O_CREAT or something
>      like)
>   2) do all r/w on files with O_DIRECT
>   3) do file extensions via a new generic VFS "reserve" operation
>   4) have shared mutexes on all vfs op, implemented by passing
>      down a special "tag" request to the block layer.
>   5) maintain read+write order at the shared resource.

Can I quote your 'puhleese' here? Inodes are sharing the same on-disk
blocks, so when one inode is changed (setattr, truncate) and written
back to disk, it affects all other inodes stored in the same block. So
the shared mutexes on the VFS level don't cover the necessary locking.

Each time you add another point to work around the latest argument,
someone will surely give you another argument until you end up with a
system that is no longer practical. And then probably even slower
because you absolutely cannot allow the FS to trust _any_ data without a
locked read or write off the disk (or across the network). And because
you seem to like cpu consistency that much this even involves the data
that happens to be 'cached' in the CPU.

> I have already implemented 2,4,5.
> 
> The question is how to extend the range of useful operations. For the
> moment I would be happy simply to go ahead and implement 1) and 3),
> while taking serious strong advice on what to do about directories.

Perhaps the fact that directories (and journalled filesystems) aren't
already solved is an indication that the proposed 'solution' is flawed?

Filesystems were designed to trust the disk as 'stable storage', i.e.
anything that was read or recently written will be the same. NFS already
weakens this model slightly. AFS and Coda go even further, we only
guarantee that changes are propagated when a file is closed. There is
a callback mechanism to invalidate cached copies. But even when we open
a file, it could still have been changed within the past 1/2 RTT. This
is a window we intentionally live with because it avoids the full RTT
hit we would have if we had to go to the server on every file open.

It is the latency that kills you when you can't cache.

Jan

