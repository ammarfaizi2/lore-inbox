Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282402AbRKXIVx>; Sat, 24 Nov 2001 03:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282403AbRKXIVo>; Sat, 24 Nov 2001 03:21:44 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:55610 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282402AbRKXIV2>; Sat, 24 Nov 2001 03:21:28 -0500
Date: Sat, 24 Nov 2001 09:21:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011124092126.D1419@athlon.random>
In-Reply-To: <20011124084455.B1419@athlon.random> <Pine.GSO.4.21.0111240247300.4000-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0111240247300.4000-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 24, 2001 at 03:05:02AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 03:05:02AM -0500, Alexander Viro wrote:
> 
> 
> On Sat, 24 Nov 2001, Andrea Arcangeli wrote:
> 
> > > Notice that it fixes _all_ problems with stale inodes, with only one rule
> > > for fs code - "don't call iput() when ->clear_inode() doesn't work".  Your
> > > variant requires funnier things - "if at some point ->clear_inode()
> > > may stop working make sure to call invalidate_inodes()" in addition to
> > > the rule above.
> > 
> > the rule I add is "if ->clear_inode is really needed, just don't clear
> > s_op before returning null from read_super" and that requirement looks
> > fine.
> 
> It's not that simple.  You may need the per-superblock data structures for
> ->clear_inode() to work.
> 
> In any case, it _is_ additional rule for no good reason.  "inode may stay
> in icache after iput() only when fs is up and running" is a warranty that
> is trivial to provide and that removes a source of hard-to-debug screwups
> in fs code.

I don't think it's harder to debug, you need the per-superblock data
structures for ->clear_inode() also if you try to ->clear_inode in iput,
and I cannot see any valid reason for which the fs would be allowed to
screwup the superblock before returning from read_inode. As soon as you
call iget the superblock must be sane and there's no point in screwing
it up afterwards.

Andrea
