Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265144AbSJPQK3>; Wed, 16 Oct 2002 12:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265150AbSJPQK2>; Wed, 16 Oct 2002 12:10:28 -0400
Received: from thunk.org ([140.239.227.29]:30672 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S265144AbSJPQK2>;
	Wed, 16 Oct 2002 12:10:28 -0400
Date: Wed, 16 Oct 2002 12:16:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Add extended attributes to ext2/3
Message-ID: <20021016161620.GC8210@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
References: <E181a3S-0006Nq-00@snap.thunk.org> <aojc1q$l37$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aojc1q$l37$1@forge.intermeta.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 09:38:02AM +0000, Henning P. Schmiedehausen wrote:
> tytso@mit.edu writes:
> 
> >+	int ea_blocks = EXT3_I(inode)->i_file_acl ?
> >+		(inode->i_sb->s_blocksize >> 9) : 0;
> 
> Sometimes I wonder if we shouldn't have the block size (512) and the
> bit shift (9) as defines somewhere and gradually shift away from hard
> coded values...
> 
> If we ever decide to change the block size of ext2/ext3, we're in for
> a "looking for nines"... :-)

We already have different block sizes for ext2/3; we support 1k, 2k,
and 4k block sizes.  The bit shift is only there because the
superblock stores the blocksize shifted by 9 for "historical reasons".
(i.e., I probably wouldn't have bothered with it, but Remy Card did it
that way, and it doesn't hurt, so make everyone suffer with an
incompatible format change?)

We do have one place where the 512 byte sector count is used, and
that's in inode->i_blocks, which is stored as 512 byte sectors,
regardless of the blocksize.  *That's* due to st_blocks in the stat
structure being returned in 512 byte sectors, and for no other good
reason.  As a result of this particular bit of history, ext2
filesystems are limited to 2TB, even when using a 4k blocksize.
Without this bit of "design history", we'd be able to support 16TB
filesystems with 2.6's CONFIG_LBD support, without needing to going to
a 64-bit block numbers.  Making this change is actually pretty easy,
and I may try to get that change to Linus before 2.6 closes.

						- Ted
