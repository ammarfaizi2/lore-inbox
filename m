Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129252AbRBVIeU>; Thu, 22 Feb 2001 03:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129336AbRBVIeL>; Thu, 22 Feb 2001 03:34:11 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:55286 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129252AbRBVIdv>; Thu, 22 Feb 2001 03:33:51 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102220831.f1M8VHS21717@webber.adilger.net>
Subject: Re: [rfc] [LONG] Near-constant time directory index for Ext2
In-Reply-To: From "(env:" "adilger)" at "Feb 22, 2001 01:06:17 am"
To: Ext2 development mailing list <ext2-devel@lists.sourceforge.net>
Date: Thu, 22 Feb 2001 01:31:16 -0700 (MST)
CC: Daniel Phillips <phillips@innominate.de>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@ns.caldera.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just wrote:
> I just had a clever idea - on a single-level index you put the header
> and index data in block 0, and put the directory data in the first
> indirect block (11 sparse blocks, instead of 511).

To clarify (with wonderful ASCII art), an un-indexed directory would have
data blocks like:

<d0> <d1> <d2> <d3> (wherever we decide the cutoff is for indexing)

When we start with a single level index, it looks like:

<index header > 0 0 0 0 0 0 0 0 0 0 0 <indirect0>
                                      /  |  |   \
                                  <d0> <d1> ... <dN>

> If you need to go to a second-level index, you can simply shift the
> indirect data block to be a double-indirect block, and start the level-2
> index in the first indirect block.

So it would look like:

<index header > 0 0 0 0 0 0 0 0 0 0 0 <index_indirect> <dindirect0>
                                      /    |            /        \
                               <index0><index1>     <indirect0>   <indirect1>
                                                    /  |  |   \
                                                <d0> <d1> ... <dN>

> If we ever need a third-level index, you basically do the same thing -
> move the double-indirect blocks to triple-indirect, and put the level-3
> index in the double-indirect block.  The index blocks will always fit,
> because the index branching level is 1/2 of the indirect block
> branching because the index has the extra 4-byte hash values.

The benefit is that you don't need to do any copying of directory
block pointers (or contents) when you need to go to the next-level
index.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
