Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287577AbRLaSRD>; Mon, 31 Dec 2001 13:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287584AbRLaSQy>; Mon, 31 Dec 2001 13:16:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22291 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287591AbRLaSQt>; Mon, 31 Dec 2001 13:16:49 -0500
Date: Mon, 31 Dec 2001 10:16:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: <linux-kernel@vger.kernel.org>, Alexander Viro <viro@math.psu.edu>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] [WIP] Unbork fs.h, 3 of 3
In-Reply-To: <E16Kv7J-0003CW-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0112311004580.1404-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Dec 2001, Daniel Phillips wrote:
>
> This is the third patch of a series that will eventually remove the
> filesystem-specific includes, the struct inode union and the struct
> super_block union from linux/fs.h.  See part 1 of this series for a
> description of the approach.

I really don't like this:

> -static DECLARE_FSTYPE_DEV(ext2_fs_type, "ext2", ext2_read_super);
> +static FILESYSTEM(ext2_fs_type, "ext2", ext2_read_super,
> +	sizeof (struct ext2_sb_info),
> +	sizeof (struct ext2_inode_info));

for two reasons:
 - horrible layout
 - bad type information

The first would be easy to fix (just put everything on a line of it's
own), but the second is harder: I don't like having two integers that can
easily be mixed up, and where order matters.

How about using a descriptor structure instead of the macro, and making
the filesystem declaration syntax look more like

	static struct file_system_type ext2_descriptor = {
		owner:		THIS_MODULE,
		fs_flags:	FS_REQUIRES_DEV,
		name:		"ext2",
		read_super:	ext2_read_super,
		sb_size:	sizeof(ext2_sb_info),
		inode_size:	sizeof(struct ext2_inode_info)
	};

which is more readable, and inherently documents _what_ those things are.

In short, I think the whole DECLARE_FSTYPE thing was a mistake, just to
avoid having people do the owner/flags thing. Doing the initialization
explicitly ends up being more readable, I think.

(If you _want_ to use a macro, you can do something like

	#define DECLARE_FS(var,type, a...) \
		struct file_system_type var = { \
			owner:          THIS_MODULE, \
			fs_flags:       FS_REQUIRES_DEV \
			name:		type,
			,##a };

and then you do

	DECLARE_FS(ext2_descriptor, "ext2",
		read_super:	ext2_read_super,
		sb_size:        sizeof(ext2_sb_info),
		inode_size:     sizeof(struct ext2_inode_info)
	);

which is kind of half-way between the two formats.

What do you think?

		Linus

