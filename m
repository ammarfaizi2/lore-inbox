Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136175AbRD0TOT>; Fri, 27 Apr 2001 15:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136194AbRD0TOQ>; Fri, 27 Apr 2001 15:14:16 -0400
Received: from ns.caldera.de ([212.34.180.1]:32675 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S136175AbRD0TNx>;
	Fri, 27 Apr 2001 15:13:53 -0400
Date: Fri, 27 Apr 2001 21:13:37 +0200
Message-Id: <200104271913.f3RJDbc19786@ns.caldera.de>
From: hch@caldera.de (Christoph Hellwig)
To: zaitcev@redhat.com (Pete Zaitcev)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Atrocious icache/dcache in 2.4.2
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010427150114.A23960@devserv.devel.redhat.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

In article <20010427150114.A23960@devserv.devel.redhat.com> you wrote:
> After a little thinking it seems apparent to me that it
> may be a good thing to have VM taking pages from dentry and
> inode pools directly. This sounds almost what slab does,
> so let me speculate about it (it is a bad idea, but it is
> interesting _why_).
>
> Suppose that we do this: when inode gets clean (e.g. unlocked,
> written to disk if was changed), drop it into kmem_cache_free(),
> but retain on hash (forget about poisoning for a momemt).
> Then, if memory is needed, VM may ask slab, slab calls our
> destructors, and destructors take inode off hash. The idea
> solves the problem, but has two marks agains it. First, when
> we look up an inode, we either hit dirty or "clean", which
> is free. Then we have to do kmem_cache_alloc() and that will
> return wrong inode, which we have to drop from hash, then do
> memcpy from old "really free one", etc. It still saves disk
> I/O, but messy. Another thing is a fragmentation: suppose we
> have bunch of slabs, every one has a single dirty inode in it
> (tar xf -). Memory pressure will be powerless to do anything
> about them.

It looks like you want the SLAB cache ->reclaim method we seem
to have forgotten when cloning the Solaris SLAB interface nearly
1:1...

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
