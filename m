Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRKXKZ6>; Sat, 24 Nov 2001 05:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRKXKZj>; Sat, 24 Nov 2001 05:25:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29259 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274752AbRKXKZ3>; Sat, 24 Nov 2001 05:25:29 -0500
Date: Sat, 24 Nov 2001 11:25:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011124112536.K1419@athlon.random>
In-Reply-To: <20011124103854.I1419@athlon.random> <Pine.GSO.4.21.0111240445520.4000-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0111240445520.4000-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 24, 2001 at 04:56:41AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 04:56:41AM -0500, Alexander Viro wrote:
> 
> 
> On Sat, 24 Nov 2001, Andrea Arcangeli wrote:
> 
> > I think long term (2.5) the right way is to replace all the iput in the
> > slow fail paths with a iput_not_mounted, that will avoid both the iput
> > clobbering and the MS_ACTIVE tracking. The differentiation should be
> 
> Egads...  Andrea, think for a bloody minute.  What's the point of adding
> a new helper that would share a lot of code with the iput() _and_ would
> bring additional calling rules?  We get
> 	* more code in inode.c
> 	* more code duplications
> 	* a lot of opportunities to fsck up in fs code

red herring, you can solve all by simply implementing it sanely, for
example make it inline with a parameter (int sync), code duplication is
not the issue, icache waste obviously isn't either since the
_not_mounted version would never be called during prodution.

> 	* redundant invalidate_inodes() calls in fs/super.c existing just
> to catch these fsckups.

that would obviously go away if we take your way.

> 	* some filesystems getting out with only iput(), some needing new
> helper.

I don't follow this one, what's the point of "needing new helper"? The
iput_not_mounted would work like yours, but without the need of the
MS_ACTIVE tracking and without slowing down iput, and most important it
would make self documenting the synchronous behaviour and the need of
->clean_inode working.

> 	* cut'n'paste programming getting one more source of bugs to
> introduce.

See above.

> And it's not even the case when filesystems could use that distinction in
> any sane way...

This could be a valid point against that split of functions, I thought
all iputs were localized and not share with the production code indeed.

Or we could also stick with document that if somebody has the per-sb
things, he has to run invalidate_inodes() before freeing them, that
would be the "lesser code to maintain" and simpler solution (the one I
prefer for 2.4 incidentally). Another cons about this one is that gets
rid of the dirty inodes as well, so the read_super/put_super should also
take care to flush to disk by hand in the put_super/read_super if they
really ever needs. I tend to like to have structures in place only for
the production code, and to be able to share them for the special cases
too with minimal effort, but ok, this way the semantics gets a bit more
complicated for the very unlikely case. But in practice nobody will ever
need the flush or/and the explicit invalidate_inodes into the
put_user/read_super and 2.4.15aa1 should be just unbrekeable.

In short I'm fine either ways.

Andrea
