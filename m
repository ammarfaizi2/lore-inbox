Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136196AbRD0TkW>; Fri, 27 Apr 2001 15:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136197AbRD0TkM>; Fri, 27 Apr 2001 15:40:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61110 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136196AbRD0TkG>;
	Fri, 27 Apr 2001 15:40:06 -0400
Date: Fri, 27 Apr 2001 15:40:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Atrocious icache/dcache in 2.4.2
In-Reply-To: <20010427150114.A23960@devserv.devel.redhat.com>
Message-ID: <Pine.GSO.4.21.0104271528500.18661-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Apr 2001, Pete Zaitcev wrote:

> Hello:
> 
> My box here slows down dramatically after a while, and starts
> behaving as if it has very little memory, e.g. programs page
> each other out. It turns out that out of 40MB total, about
> 35MB is used for dcache and icache, and system basically
> runs in 5MB of RAM.
> 
> When I tried to discuss it with riel, viro, and others,
> I got an immediate and very strong knee jerk reaction "we fixed
> it in 2.4.4-pre4!" "we gotta call prune_dcache more!".
> That just does not sound persuasive to me.
 
[snip]
> written to disk if was changed), drop it into kmem_cache_free(),
> but retain on hash (forget about poisoning for a momemt).

What for?

I'm with you until now. But why bother keeping them resurrectable?
They are not refered by dentries. They have no IO happening on
them. Why retain them in cache for long?

Notice that icache is behind the dcache, so you are looking at the
second-order effects here. With the data you've shown on #kernel
it looks like half of your icache is just sitting there for no
ggod reason and slows down hash lookups.

It makes sense to retain them for a while, but inode sitting there
unreferenced by anything for minutes is a dead weight and nothing
else.

Notice that actually percent of the needlessly held inodes is higher -
2.4.2 _really_ keeps stale stuff in dcache and that means stale
stuff in icache. I.e. the only reference is from dentry that hadn't
been touched by anything for a _long_ time.

IOW, we just need to make sure that unreferenced inodes get freed
once they are not dirty / not locked. Fast. No need to keep them
on hash - just free them for real. Moreover, that will get
fragmentation down.

