Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbRBVSVj>; Thu, 22 Feb 2001 13:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129397AbRBVSVa>; Thu, 22 Feb 2001 13:21:30 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64017 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129232AbRBVSVP>; Thu, 22 Feb 2001 13:21:15 -0500
Date: Thu, 22 Feb 2001 10:20:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <20010222123137.T724@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.10.10102221009460.8403-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Feb 2001, Ingo Oeser wrote:
> 
> On Wed, Feb 21, 2001 at 09:19:45PM -0800, Linus Torvalds wrote:
> > In article <97230a$16k$1@penguin.transmeta.com>,
> > Linus Torvalds <torvalds@transmeta.com> wrote:
> > >allocate blocks one at a time. Make the blocksize something nice and
> > >big, not just 4kB or 8kB or something.
> > 
> > Btw, this is also going to be a VM and performance issue some time in
> > the future.  Tgere are already CPU's that would _love_ to have 64kB
> > pages etc, and as such a filesystem that doesn't play with the old silly
> > "everthing is a block" rules would be much appreciated with the kind of
> > people who have multi-gigabyte files and want to read in big chunks at a
> > time. 
>  
> For this we need a block remapper layer that can map any
> blocksize n to any blocksize m with only the following constraints:

No, nothing like that at all..

What you can _trivially_ do is to basically act to the VFS and VM layer as
if you're a 1kB block filesystem (or something), and then when you get
called to do a "bmap()" (which only happens for kernel installing and
LILO, not under normal load), you just return the "offset" into a larger
block.

The VFS and MM layers do not care what the _real_ underlying blocksize of
the filesystem is. They will just do "readpage()" and "write()" calls, and
you can implement those any way you want to - never showing that you are
chunking out page-sized pieces from a bigger allocation block.

It's not all that hard. You just have to think a bit differently: don't
think of it as a block-based filesystem that has to have fixed blocks. The
VFS and MM layer don't care. They just want to access it.

> Daniel (and others) uses ext2 as as a playground, because it is
> implemented, tested and not that hard to understand and verify.

I realize that. But I get _very_ nervous when people talk about adding
stuff to ext2, because there are a lot of people who do not want to ever
even by mistake run code that is "new" on their filesystem.

Note that I had the same issue with ext3 - for the longest time, Stephen
Tweedie wanted to just extend ext2, and make it an invisible upgrade where
the filesystem would just magically become journalled when the user asked
for it. It _sounds_ appealing, but it doesn't take into account (a)
inevitable bugs and (b) the fact that Reiserfs actually got a head start
at least partly because it didn't need to worry about backwards
compatibility at all (there were other reasons too).

Basically, if there is one thing I've learnt over ten years of Linux, it's
that it is absolutely _evil_ to add more "linkages" or dependencies than
you absolutely have to. It is _much_ easier to create a new filesystem,
and slowly phase out old code that is no longer used. It's been done
several times (both with filesystems and with drivers), and every time
we've had a "new X, phase out old X" kind of situation it has been very
smooth.

In comparison, if you have "new features in X, which also handles the old
cases of X" situation, you not only bind yourself to backwards
compatibility, but you also cause yourself to be unable to ever phase out
the old code. Which means that eventually the whole system is a piece of
crap, full of old garbage that nobody needs to use, but that is part of
the new stuff that everybody _does_ use.

			Linus

