Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129791AbRBVGX3>; Thu, 22 Feb 2001 01:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbRBVGXT>; Thu, 22 Feb 2001 01:23:19 -0500
Received: from mail.valinux.com ([198.186.202.175]:14860 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129791AbRBVGXN>;
	Thu, 22 Feb 2001 01:23:13 -0500
To: phillips@innominate.de
CC: Linux-kernel@vger.kernel.org, adilger@turbolinux.com, hch@ns.caldera.de,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <01022020011905.18944@gimli> (message from Daniel Phillips on
	Tue, 20 Feb 2001 16:04:50 +0100)
Subject: Re: [Ext2-devel] [rfc] Near-constant time directory index for Ext2
From: tytso@valinux.com
Phone: (781) 391-3464
In-Reply-To: <01022020011905.18944@gimli>
Message-Id: <E14Vp9h-0001IB-00@beefcake.hdqt.valinux.com>
Date: Wed, 21 Feb 2001 22:23:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

Nice work!

A couple of comments.  If you make the beginning of each index block
look like a an empty directory block (i.e, the first 8 blocks look like
this):

	32 bits: ino == 0
	16 bits: rec_len == blocksize
	16 bits: name_len = 0

... then you will have full backwards compatibility, both for reading
*and* writing.  When reading, old kernels will simply ignore the index
blocks, since it looks like it has an unpopulated directory entry.  And
if the kernel attempts to write into the directory, it will clear the
BTREE_FL flag, in which case new kernels won't treat the directory as a
tree anymore.  (Running a smart e2fsck which knows about directory trees
will be able to restore the tree structure).

Is it worth it?  Well, it means you lose an index entry from each
directory block, thus reducing your fanout at each node of the tree by a
worse case of 0.7% in the worst case (1k blocksize) and 0.2% if you're
using 4k blocksizes.

						- Ted

