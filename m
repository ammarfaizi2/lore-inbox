Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282367AbRKXGJR>; Sat, 24 Nov 2001 01:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282368AbRKXGI5>; Sat, 24 Nov 2001 01:08:57 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37527 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282367AbRKXGIw>;
	Sat, 24 Nov 2001 01:08:52 -0500
Date: Sat, 24 Nov 2001 01:08:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <Pine.LNX.4.33.0111232154320.1821-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111240105100.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Nov 2001, Linus Torvalds wrote:

> > -			if (!list_empty(&inode->i_hash) && sb && sb->s_root) {
> > +			if (!list_empty(&inode->i_hash)) {
> >  				if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
> >  					list_del(&inode->i_list);
> >  					list_add(&inode->i_list, &inode_unused);
> 
> I have to say that I like this patch better myself - the added tests are
> not sensible, and just removing them seems to be the right thing.

Test for ->s_root is bogus and had been removed - check the patch I've sent.

However, that variant suffers from the following problem: if ->read_super()
fails after it had done _any_ iget() (root inode, journal, whatever) -
we are screwed.  Sure, we do iput().  And then we have inode stuck in icache,
with ->i_sb pointing nowhere.  When it finally gets evicted we call
inode->i_sb->s_op->clear_inode().  Oops...

