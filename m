Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282366AbRKXGFH>; Sat, 24 Nov 2001 01:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282368AbRKXGE5>; Sat, 24 Nov 2001 01:04:57 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46225 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282367AbRKXGEy>;
	Sat, 24 Nov 2001 01:04:54 -0500
Date: Sat, 24 Nov 2001 01:04:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <20011124064739.J1324@athlon.random>
Message-ID: <Pine.GSO.4.21.0111240054080.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Andrea Arcangeli wrote:

> On Fri, Nov 23, 2001 at 04:22:17PM -0500, Alexander Viro wrote:
> > 	Sigh...  Supposed fix to problems with stale inodes was completely
> > broken.
> > 
> > 	What we need is "if we are doing last iput() on fs that is getting
> > shut, sync it and don't leave it in cache".  And yes, we have a similar
> 
> What's this "stale inode" problem? invalidate_inodes in kill_super will
> obviously get rid of all of them or we would be getting the

First of all, there is ->read_super() side of the things.  If it fails
after iget() on root, we have nothing to kick inode out of cache.  And
no, we can't call invalidate_inodes() here - too late for calling any
methods.

What's more, for stuff like inodes held by superblock (e.g. fs keeping
block bitmaps in a file - in that case the earliest point that _can_
do iput() on that sucker is ->put_super(); ditto for $BIGNUM similar
cases - journal, other fs structures of that kind - ACLs, etc., etc.)
we get final iput() _after_ invalidate_inodes().  And doing anything
after ->put_super() is again too late.

IOW, we can kick inode out of icache only between successful ->read_super()
and ->put_super().  Any iput() done outside of that range must go immediately
and yes, such cases are not only possible but actually exist.

