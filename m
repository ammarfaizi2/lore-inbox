Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282370AbRKXG0j>; Sat, 24 Nov 2001 01:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282371AbRKXG0b>; Sat, 24 Nov 2001 01:26:31 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23333 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282370AbRKXG0V>; Sat, 24 Nov 2001 01:26:21 -0500
Date: Sat, 24 Nov 2001 07:26:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011124072636.B2398@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0111232154320.1821-100000@penguin.transmeta.com> <Pine.GSO.4.21.0111240105100.4000-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0111240105100.4000-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 24, 2001 at 01:08:49AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 01:08:49AM -0500, Alexander Viro wrote:
> 
> 
> On Fri, 23 Nov 2001, Linus Torvalds wrote:
> 
> > > -			if (!list_empty(&inode->i_hash) && sb && sb->s_root) {
> > > +			if (!list_empty(&inode->i_hash)) {
> > >  				if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
> > >  					list_del(&inode->i_list);
> > >  					list_add(&inode->i_list, &inode_unused);
> > 
> > I have to say that I like this patch better myself - the added tests are
> > not sensible, and just removing them seems to be the right thing.
> 
> Test for ->s_root is bogus and had been removed - check the patch I've sent.
> 
> However, that variant suffers from the following problem: if ->read_super()
> fails after it had done _any_ iget() (root inode, journal, whatever) -
> we are screwed.  Sure, we do iput().  And then we have inode stuck in icache,

you are screwed because you were running a broken filesystem: it is its
own business to drop the inodes if it fails, all it needs to do is to
call invalidate_inodes(s) internally before returning from the read_super
in the failure case.

> with ->i_sb pointing nowhere.  When it finally gets evicted we call
> inode->i_sb->s_op->clear_inode().  Oops...


Andrea
