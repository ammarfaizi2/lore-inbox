Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281065AbRKDR7K>; Sun, 4 Nov 2001 12:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281057AbRKDR7C>; Sun, 4 Nov 2001 12:59:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1029 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281056AbRKDR6n>; Sun, 4 Nov 2001 12:58:43 -0500
Date: Sun, 4 Nov 2001 09:55:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] ramfs/tmpfs readdir()
In-Reply-To: <Pine.GSO.4.21.0111041046040.21449-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111040943160.6919-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 4 Nov 2001, Alexander Viro wrote:
>
> Please, help with review and testing.  Linus, if you have problems with
> that approach - please, tell.

The approach looks solid, although the fact that telldir/seekdir will
still be random is a bummer. And means that it _still_ won't be POSIX-
compatible..

(POSIX specifies that you can seek to any previously reported telldir
location - but not any random location).

This is better than what we have, though, so I wouldn't object to the
patch. I wonder why you export the internal dcache functions, though? The
only thing that _should_ need exporting is "dcache_dir_ops", no? We don't
want other filesystems mucking with the internals of this, as far as I can
tell.

As to telldir/seekdir - the approach will never fix them. The only thing
that will fix those would be to add a "d_offset" to the "struct dentry"
itself, and have the start of "filldir()" walk the chain until it finds
the first offset larger than the current one.

Then, dcache file creation would be something like

	new_dentry->d_offset = 0;
	if (!list_entry(parent->d_child))
		new_dentry->d_offset = list_dentry(parent->d_child.prev)->d_offset + 1;

(or something similar), and we'd have to make sure that "d_add()" always
adds to the end - which it doesn't seem to do right now. Lots of small
details, and not as clean as your patch, but I don't see any better ways
to _really_ fix this.

Note that other filesystems would already enjoy having a d_offset in the
dentry: it allows for various other optimizations (ie making "unlink()" a
O(1) operation, by not having to search the directory).

So quite frankly I'd prefer the d_offset approach, and fix the directory
behaviour once and for all, not just the "linear traversal" case.

Admittedly linear traversal is the _common_ case, and arguably the much
more important of the two. However, right is right, and a true quality
implementation gets seekdir/telldir right too.

Have you looked at how nasty the d_offset thing would be?

		Linus

