Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282392AbRKXHpJ>; Sat, 24 Nov 2001 02:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282396AbRKXHpC>; Sat, 24 Nov 2001 02:45:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:40244 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282392AbRKXHoq>; Sat, 24 Nov 2001 02:44:46 -0500
Date: Sat, 24 Nov 2001 08:44:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011124084455.B1419@athlon.random>
In-Reply-To: <20011124081217.A1419@athlon.random> <Pine.GSO.4.21.0111240213450.4000-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0111240213450.4000-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 24, 2001 at 02:30:15AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 02:30:15AM -0500, Alexander Viro wrote:
> 
> 
> On Sat, 24 Nov 2001, Andrea Arcangeli wrote:
> 
> > if the method or the s_op isn't defined it will do nothing, if it is
> > defined it'd better do something not wrong because the fs just did an
> > iget within read_super. I don't see obvious troubles and the above looks
> > better than making iput more complex (and nitpicking slower 8).
> 
> 2.4.15-pre8:
> 
> 	if (!list_empty(&inode->i_hash)) {
> 		FOO
> 		return;
> 	} else {
> 		BAR
> 	}
> 
> 2.4.15+patch:
> 	
> 	if (!list_empty(&inode->i_hash)) {
> 		FOO
> 		if (!sb || sb->s_flags & MS_ACTIVE)
> 			return;
> 		write_inode_now(inode, 1);
> 		spin_lock(&inode_lock);
> 		inodes_stat.nr_unused--;
> 		list_del_init(&inode->i_hash);
> 	}
> 	BAR
> 
> Notice that it fixes _all_ problems with stale inodes, with only one rule
> for fs code - "don't call iput() when ->clear_inode() doesn't work".  Your
> variant requires funnier things - "if at some point ->clear_inode()
> may stop working make sure to call invalidate_inodes()" in addition to
> the rule above.

the rule I add is "if ->clear_inode is really needed, just don't clear
s_op before returning null from read_super" and that requirement looks
fine.

> 
> Frankly, I'd prefer fix that provides less possibilities for fsckup
> in fs code and requires less analysis.

I think right fix is invalidate_inodes() in read_super fail path so I
think it worth the short analysis, and that fail path was just buggy, so
it shouldn't get worse at least :).

Andrea
