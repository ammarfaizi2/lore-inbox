Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262900AbREVXwL>; Tue, 22 May 2001 19:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262899AbREVXvw>; Tue, 22 May 2001 19:51:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60923 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262898AbREVXvm>;
	Tue, 22 May 2001 19:51:42 -0400
Date: Tue, 22 May 2001 19:51:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <Pine.LNX.4.21.0105221521330.4332-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105221909001.17373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 May 2001, Linus Torvalds wrote:
 
> I would much prefer a union of pointers over a pointer to a union.
> 
> So I'd much rather have the inode have a
> 
> 	union {
> 		struct block_device *block;
> 		struct char_device *char;
		struct pipe_inode_info *pipe;
and possibly
		struct socket *socket;
> 	} dev;

> 	struct block_dev *bdget(struct inode *);
> 	struct char_dev *cdget(struct inode *);
> 
>    which populate the "inode->dev" union pointer, which in turn is _only_
>    a cache of the lookup. Right now we do this purely based on "dev_t",
>    and I think that is bogus. We should never pass a "dev_t" around
>    without an inode, I think.

I doubt it. First of all, then we'd better make i_rdev dev_t. Right now
we have it kdev_t and it makes absolutely no sense that way. If we
only use it for stat() (when we convert it to dev_t) and for keeping the
information between mknod/read_inode and open() - why bother converting it
to anything? Currently it's used by drivers to identify the device.
->dev.{block,char} is perfectly fine for that and gives more information
without extra lookups, etc. And that's it - nothing else cares for
->i_rdev. What you suggest is reusing it so that we had a way to get
the right ->dev.{block,char} when we open. Fine, but there's no reason
to tie it to kdev_t (or to have kdev_t, for that matter).

The real thing is inode->dev. Notice that for devfs (and per-device
filesystems) we can set it upon inode creation, since they _know_ it
from the very beginning and there is absolutely no reason to do any
hash lookups. Moreover, in these cases we may have no meaningful device
number at all.

>    And we should not depend on the "inode->dev.xxxx" pointer being valid all
>    the time, as there is absolutely zero point in initializing the pointer
>    every time the inode is read just because somebody does a "ls -l /dev".
>    Thus the "cache" part above.

OK, but see comments above.

>  - NO reason to try to make "struct block_dev" and "struct char_dev" look
>    similar. They will have some commonality for lookup purposes (that
>    issue is similar, as Andries points out), and maybe that commonality
>    can be separated out into a sub-structure or something. But apart from
>    that, they have absolutely nothing to do with each other, and I'd
>    rather not have them have even a _superficial_ connection.

Aye.

>    Block devices will have the "request queue" pointer, and the size and
>    partitioning information. Character devices currently would not have

Do we really want a separate queue for each partition? I'd rather have
disk_struct created when driver sees the disk and list of partitions
(possibly represented by struct block_device) anchored in disk_struct
and populated by grok_partitions().

Then disk_struct would keep the queue _and_ ll_rw_block could do all
remapping, so that driver itself wouldn't know anything about the
partitioning.

I have a half-baked patch for that (circa last Spring) and Ben LaHaise got
suckere^W^Whad kindly volunteered to try porting it to current tree...

								Al


