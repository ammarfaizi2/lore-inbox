Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSEXS6v>; Fri, 24 May 2002 14:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317151AbSEXS6u>; Fri, 24 May 2002 14:58:50 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8772 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314829AbSEXS6t>; Fri, 24 May 2002 14:58:49 -0400
Date: Fri, 24 May 2002 20:58:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
Message-ID: <20020524185811.GF15703@dualathlon.random>
In-Reply-To: <20020524175522.GD15703@dualathlon.random> <Pine.GSO.4.21.0205241356590.9792-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 02:00:36PM -0400, Alexander Viro wrote:
> 
> 
> On Fri, 24 May 2002, Andrea Arcangeli wrote:
> 
> > so why don't you also left a negative directory floating around, so you
> > know if you creat a file with such name you don't need to ->loopup the
> > lowlevel fs but you only need to destroy the negative directory and all
> > its leafs in-core-dcache? If you did the negative effect would become
> > more obvious, the d_unhash hides it except for the spooling workloads.
>  
> -ENOPARSE

instead of dropping the dentry for a directory after an rmdir you could
left it there as a negative entry, it would avoid you to ->lookup if
somebody creat() using the name of such ex-directory.

> 
> > of kmem_cache_reap, so we are as efficient as possible, but we don't
> > risk throwing away very useful cache, for more dubious caching effects
> > after an unlink/create-failure that currently have the side effect of
> > throwing away tons of worthwhile positive pagecache (and even triggering
> > swap false positives) in some workloads.
> 
> I might buy that argument if we didn't also leave around _unreferenced_
> inodes for minutes in the icache.  And _that_ is much stronger source of

I don't see it, at the last iput of an inode with i_nlink == 0 the inode
is freed immediatly, not like the dcache that is left floating around as
a negative one with no useful caching effects for most workloads.

> memory pressure, so if you want to balance the thing you need to start
> there.


Andrea
