Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSEXP5e>; Fri, 24 May 2002 11:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317158AbSEXPz2>; Fri, 24 May 2002 11:55:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:59694 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317177AbSEXPy5>; Fri, 24 May 2002 11:54:57 -0400
Date: Fri, 24 May 2002 17:54:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: negative dentries wasting ram
Message-ID: <20020524155417.GP21164@dualathlon.random>
In-Reply-To: <20020524071657.GI21164@dualathlon.random> <Pine.LNX.4.44.0205240737400.26171-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 07:43:32AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 24 May 2002, Andrea Arcangeli wrote:
> >
> > Negative dentries should be only temporary entities, for example between
> > the allocation of the dentry and the create of the inode, they shouldn't
> > be left around waiting the vm to collect them.
> 
> Wrong. Negative dentries are very useful for caching negative lookups:
> look at the average startup sequence of any program linked with glibc, and

yep I know it is a flood of enoent.

> depending on your setup you will notice how it tries to open a _lot_ of a
> files that do not exist (the "depending on your setup" comes from the fact
> that it depends on things like how quickly it finds your "locale" setup
> from its locale path - you may have one of the setups that puts it in the
> first location glibc searches etc).
> 
> If you don't cache those negative lookups, you will do a low-level
> filesystem lookup for each of those failures, which is _expensive_.

I see now the point, so they cache the information that there's no entry :).

> However, you're right that it probably doesn't help to do this after
> "unlink()" - it's probably only worth doing when actually doing a

Agreed, they should be dropped after unlink, and also if creat fails, so
I think my patch fits perfectly into the vfs caching scheme, the
negative dentries still will be generated for the costantly failed
lookups, but not on after unlink and creat-failures.

> "lookup()" that fails.
> 
> 		Linus
> 


Andrea
