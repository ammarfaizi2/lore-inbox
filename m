Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312562AbSDJLed>; Wed, 10 Apr 2002 07:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSDJLec>; Wed, 10 Apr 2002 07:34:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16098 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312562AbSDJLeb>;
	Wed, 10 Apr 2002 07:34:31 -0400
Date: Wed, 10 Apr 2002 07:34:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <3CB4203D.C3BE7298@zip.com.au>
Message-ID: <Pine.GSO.4.21.0204100725410.15110-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Apr 2002, Andrew Morton wrote:

> 
> This is a largish patch which makes some fairly deep changes.  It's
> currently at the "wow, it worked" stage.  Most of it is fairly
> mature code, but some conceptual changes were recently made.
> Hopefully it'll be in respectable state in a few days, but I'd
> like people to take a look.
> 
> The idea is: all writeback is against address_spaces.  All dirty data
> has the dirty bit set against its page.  So all dirty data is
> accessible by
> 
> 	superblock list
> 		-> superblock dirty inode list
> 			-> inode mapping's dirty page list.
> 				-> page_buffers(page) (maybe)

Wait.  You are assuming that all address_spaces happen to be ->i_mapping of
some inode.  Which is less than obvious - e.g. putting indirect blocks into
private per-inode address_space is not unreasonable.

What's more, I wonder how well does your scheme work with ->i_mapping
to a different inode's ->i_data (CODA et.al., file access to block devices).

BTW, CODA-like beasts can have several local filesystems for cache - i.e.
->i_mapping for dirty inodes from the same superblock can ultimately go
to different queues.  Again, the same goes for stuff like
dd if=foo of=/dev/floppy - you get dirty inode of /dev/floppy with ->i_mapping
pointing to bdev filesystem and queue we end up with having nothing in common
with that of root fs' device.

I'd really like to see where are you going with all that stuff - if you
expect some correspondence between superblocks and devices, you've are
walking straight into major PITA.

