Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285709AbRLaAFv>; Sun, 30 Dec 2001 19:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbRLaAFk>; Sun, 30 Dec 2001 19:05:40 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21061 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285709AbRLaAF1>; Sun, 30 Dec 2001 19:05:27 -0500
Date: Mon, 31 Dec 2001 01:05:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd kern  el panic woes
Message-ID: <20011231010537.K1356@athlon.random>
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au> <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Dec 30, 2001 at 01:33:24AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 01:33:24AM -0500, Alexander Viro wrote:
> 
> 
> On Sat, 29 Dec 2001, Andrew Morton wrote:
> 
> > Would it be necessary to preallocate the holes at mmap() time?  Mad
> > hand-waving: Could we not perform the instantiation at pagefault time,
> > and give the caller SIGBUS if we cannot allocate the blocks?  Or if
> > there's an IO error, or quota exceeded.
> 
> Allocation at mmap() Is Not Going To Happen.  Consider it vetoed.
> There are applications that use mmap() on large and very sparse
> files.

it's exactly this kind of apps that will be screwed up by silent data
corruption. the point of the holes is to optimize performance and save
space, but they shouldn't introduce the possibilty of data corruption.

Note: I'm fine to introduce another way to notify the app about -ENOSPC,
-ENOSPC on mmap is the most obvious one, but we could still allow the
current "overcommit" behaviour with a kind of sigbus mentioned by
Andrew (possibly not sigbus though, since it has just well defined
semantics for MAP_SHARED, maybe they could be extended, anyways as said
this is only a matter of API). My point is only that some API should be
added because your mmap on sparse files are unreliable at the moment.

> > Question: can someone please define BH_New?  Its lifecycle seems
> > very vague.  We never actually seem to *clear* it anywhere for 
> > ext2, and it appears that the kernel will keep on treating a
> > clearly non-new buffer as "new" all the time.  ext3 explicitly
> > clears BH_New in get_block(), if it finds the block was already
> > present in the file.  I did this because we need the newness
> > info for internal purposes.
> 
> It should be reset when we submit IO.  Breakage related to failing
> allocation is indeed not new, but that's a long story.  And no,
> "allocate on mmap()" is not a fix.

it is a fix (assuming people will understand/expect this retval :), but
yes, the current overcommit behaviour has some value so I agree some
other async API ala sigbus may be more desiderable.

Andrea
