Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282391AbRKXHak>; Sat, 24 Nov 2001 02:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282388AbRKXHaa>; Sat, 24 Nov 2001 02:30:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:25738 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282391AbRKXHaS>;
	Sat, 24 Nov 2001 02:30:18 -0500
Date: Sat, 24 Nov 2001 02:30:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <20011124081217.A1419@athlon.random>
Message-ID: <Pine.GSO.4.21.0111240213450.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Andrea Arcangeli wrote:

> if the method or the s_op isn't defined it will do nothing, if it is
> defined it'd better do something not wrong because the fs just did an
> iget within read_super. I don't see obvious troubles and the above looks
> better than making iput more complex (and nitpicking slower 8).

2.4.15-pre8:

	if (!list_empty(&inode->i_hash)) {
		FOO
		return;
	} else {
		BAR
	}

2.4.15+patch:
	
	if (!list_empty(&inode->i_hash)) {
		FOO
		if (!sb || sb->s_flags & MS_ACTIVE)
			return;
		write_inode_now(inode, 1);
		spin_lock(&inode_lock);
		inodes_stat.nr_unused--;
		list_del_init(&inode->i_hash);
	}
	BAR

Notice that it fixes _all_ problems with stale inodes, with only one rule
for fs code - "don't call iput() when ->clear_inode() doesn't work".  Your
variant requires funnier things - "if at some point ->clear_inode()
may stop working make sure to call invalidate_inodes()" in addition to
the rule above.

Frankly, I'd prefer fix that provides less possibilities for fsckup
in fs code and requires less analysis.

