Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137155AbREKO45>; Fri, 11 May 2001 10:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136938AbREKO4i>; Fri, 11 May 2001 10:56:38 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:23054 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S137150AbREKO4f>; Fri, 11 May 2001 10:56:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Pavel Machek <pavel@suse.cz>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Date: Fri, 11 May 2001 16:54:44 +0200
X-Mailer: KMail [version 1.2]
Cc: Chris Wedgwood <cw@f00f.org>, Andrea Arcangeli <andrea@suse.de>,
        Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010506153218.A11911@tapu.f00f.org> <Pine.GSO.4.21.0105052338580.26799-100000@weyl.math.psu.edu> <20010507184224.A32@(none)>
In-Reply-To: <20010507184224.A32@(none)>
MIME-Version: 1.0
Message-Id: <01051116544400.01990@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 May 2001 20:42, Pavel Machek wrote:
> > >     It's not exactly "kernel-based fsck". What I've been talking
> > > about is secondary filesystem providing coherent access to
> > > primary fs metadata.  I.e. mount -t ext2meta -o master=/usr none
> > > /mnt and then access through /mnt/super, /mnt/block_bitmap, etc.
> > >
> > > Call me stupid --- but what exactly does the above actually
> > > achieve? Why would you do this?
> >
> > Coherent access to metadata? Well, for one thing, it allows stuff
> > like tunefs and friends on mounted fs. What's more useful, it
> > allows to do things like access to boot code, which is _not_ safe
> > to do through device access - usually you have superblock in
> > vicinity and no warranties about the things that will be
> > overwritten on umount. Same for debugging stuff, IO stats, etc. -
> > access through secondary tree is much saner than inventing tons of
> > ioctls for dealing with that. Moreover, it allows fsck and friends
> > to get rid of code duplication - while the repair logics, etc.
> > stays in userland (where it belongs) layout information is already
> > handled in the kernel. No need to duplicate it in userland...
>
> OTOH with current way if you make mistake in kernel, fsck will not
> automatically inherit it; therefore fsck is likely to work even if
> kernel ext2 is b0rken [and that's fairly important]

Al's idea ncely dances around a big problem with the page cache: there 
is no efficient way to know which address_space a given physical block 
belongs to.   It *might* be nice to have such capability in a 
fs-independent way.  We could do that now, very inefficiently, by 
searching all the address_spaces (i.e., inodes) for the physical block. 
We'd have to prevent further page cache operations while we did that, 
and when we add fs-private address_spaces some more mechanism would be 
required..  So: slow, intrusive and fragile.

The only reasonable way I can think of getting a block-coherent view 
underneath a mounted fs is to have a reverse map, and update it each 
time we map block into the page cache or unmap it.  The reverse map 
would tell us if a given physical block is currently in the page 
cache,and if so, which address_space it belongs to.  A blocks not 
currently mapped into any address_space could be mapped into an 
'anonymous' space covering the entire partition and moved automatically 
to the correct address_space when the fs tries to map it.

The big problem with this mechanism is it slows down the common case, 
which works perfectly well without any reverse map.  Not to mention 
adding bloat.  So the next question I thought about was, is there a way 
to switch on a page cache reverse map just when needed and do that in a 
generic way.  I convinced myself it wouldn't be too hard,  but then 
there's another question: how badly do we need this?

Al's idea does let us get at some of the specific parts of the fs 
metadata but it has its problems too.  We'd need to exhaustively 
enumerate every kind of filesystem metadata that could reasonably be 
accessed underneath the filesystem, and special-case it, not so nice.

But I couldn't come up with any killer examples where we'd really need 
a generalized, coherent view underneath a mounted filesystem, so I put 
these thoughts on hold.   Your borked-fs example sounds interesting, 
have you got more of those?

One more example I can suggest is: right now we have to way of 
detecting an error condition where the same fs block is mapped into 
more than one address_space.  A page cache reverse map could detect 
this easily and would be a really useful debugging tool.

--
Daniel
