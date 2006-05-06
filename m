Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWEFXK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWEFXK4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 19:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWEFXK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 19:10:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37851 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750940AbWEFXKz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 19:10:55 -0400
Date: Sun, 7 May 2006 00:10:54 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: minixfs bitmaps and associated lossage
Message-ID: <20060506231054.GR27946@ftp.linux.org.uk>
References: <44560796.8010700@gmail.com> <20060506162956.GO27946@ftp.linux.org.uk> <20060506163737.GP27946@ftp.linux.org.uk> <20060506220451.GQ27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605061524420.16343@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605061524420.16343@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 03:26:21PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 6 May 2006, Al Viro wrote:
> >
> > 	Warning: text below is a mild example of software coproarchaeology,
> > so if you are easily squicked by tangled mess of bugs and dumb lossage,
> > well... you've been warned.
> 
> LOL.
> 
> Maybe the right thing to do is to just disable minixfs for anything 
> big-endian except for m68k.
> 
> It's not like it likely matters, and while we could save your description 
> of the problem as an amusing "how to really f*ck up" episode, I doubt 
> anybody really _cares_ in this case.

Well...  There's a minixfs v3 patch floating around, so somebody apparently
cares ;-)

FWIW, the only way to really deal with such structure would be to treat
on-disk values as "fs-endian" and make the conversion to and from
host-endian check the superblock.  That would _really_ consolidate
minix_..._bit() (turning them into __test_bit(nr ^ sbi->mangle, p), etc.)
and would give support of big- and little-endian images for free.
That's what we do e.g. in fs/sysv and it's neither harder nor seriously
bigger than existing code.

Whether we care to do that is a separate question, of course, and I certainly
agree that not a lot of people care about the damn thing these days, no
matter which architecture it is.

If somebody wants to play with that code, they could just merge fs/minix
into fs/sysv - that might very well turn out to be the right thing and
a fun exercise.  Codebases are very close - minixfs is a derivative of
v7 filesystem, after all, and our fs/minix and fs/sysv had been kept
mostly in sync.  Might merge minix v3 into that while we are at it...
If there are any takers for that kind of work, go ahead and if you run
into problems - feel free to ask on fsdevel or l-k.  I promise to review
and comment, but I'm not signing up for doing the entire thing myself.

If nobody picks that up, marking it broken on affected platforms is
probably the best solution.  The only problem here is that we don't
have a uniform way to say "it's little-endian" in Kconfig, but that's
something we ought to do anyway - too many places have things like
(BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
in Kconfig dependencies.
