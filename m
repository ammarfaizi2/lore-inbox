Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317216AbSEXR4M>; Fri, 24 May 2002 13:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317228AbSEXR4J>; Fri, 24 May 2002 13:56:09 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12864 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317215AbSEXR4A>; Fri, 24 May 2002 13:56:00 -0400
Date: Fri, 24 May 2002 19:55:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
Message-ID: <20020524175522.GD15703@dualathlon.random>
In-Reply-To: <20020524163942.GB15703@dualathlon.random> <Pine.GSO.4.21.0205241300480.9792-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 01:04:33PM -0400, Alexander Viro wrote:
> 
> 
> On Fri, 24 May 2002, Andrea Arcangeli wrote:
> 
> > > Note that this will have to touch the FS anyway, since the O_CREAT thing
> > > forces a call down to the FS to actually create the file.
> > 
> > yep. the only case where it could provide some in-core "caching"
> > positive effect is:
> > 
> > 	unlink
> > 	open(w/o creat)
> > 
> > but I don't see it as a common case.
> 
> 	Guys, how about tracing the damn thing and checking what actually
> happens?  Or, at least, checking the prototypes and noticing that ->create()
> takes (hashed) dentry as an argument, so if unlinked on had been freed we _must_
> call ->lookup().

so why don't you also left a negative directory floating around, so you
know if you creat a file with such name you don't need to ->loopup the
lowlevel fs but you only need to destroy the negative directory and all
its leafs in-core-dcache? If you did the negative effect would become
more obvious, the d_unhash hides it except for the spooling workloads.

Avoiding a lowlevel lookup operation for an unlink/open cycle, looks a
minor optimization compared to a massive dcache ""leak"" under certain
common spooling workloads IMHO.

Anyways in 2.5 we could still take advantage of the negative dentries as
much as possible (also after unlink) by moving the negative dentries
into a separate list and by putting the shrinkage of this list in front
of kmem_cache_reap, so we are as efficient as possible, but we don't
risk throwing away very useful cache, for more dubious caching effects
after an unlink/create-failure that currently have the side effect of
throwing away tons of worthwhile positive pagecache (and even triggering
swap false positives) in some workloads.

Andrea
