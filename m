Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265157AbRF0AIs>; Tue, 26 Jun 2001 20:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265158AbRF0AIh>; Tue, 26 Jun 2001 20:08:37 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40445 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265157AbRF0AIZ>;
	Tue, 26 Jun 2001 20:08:25 -0400
Date: Tue, 26 Jun 2001 20:08:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Theodore Tso <tytso@valinux.com>
cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [RFC] Checks in ext2_new_block()
In-Reply-To: <20010626194919.J537@think.thunk.org>
Message-ID: <Pine.GSO.4.21.0106261952100.18037-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Ted, could you comment on sanity checks in ext2_new_block()?
a)
        if (tmp == le32_to_cpu(gdp->bg_block_bitmap) ||
            tmp == le32_to_cpu(gdp->bg_inode_bitmap) ||
            in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
                      sb->u.ext2_sb.s_itb_per_group))
                ext2_error (sb, "ext2_new_block",
                            "Allocating block in system zone - "
                            "block = %u", tmp);

will go ahead and return the block. Looks like we can do better than that
if we mark it in use (we do that anyway), decremnt relevant free blocks
counters (global and cylinder group one) and goto repeat;

b) we don't do similar checks for blocks we grab in preallocation loop.
And ext2_alloc_block() doesn't do such checks either.

c)
        if (ext2_set_bit (j, bh->b_data)) {
                ext2_warning (sb, "ext2_new_block",
                              "bit already set for block %d", j);
                DQUOT_FREE_BLOCK(sb, inode, 1);
                goto repeat;
        }
is of the "if memory got corrupted during the last dozens of cycles" variety -
we had seen that bit 0 several lines before and we couldn't even block during
that interval (not that it mattered much, since all modifications of these
bitmaps are under lock_super() anyway).

d)
        if (j >= le32_to_cpu(es->s_blocks_count)) {
                ext2_error (sb, "ext2_new_block",
                            "block(%d) >= blocks count(%d) - "
                            "block_group = %d, es == %p ",j,
                        le32_to_cpu(es->s_blocks_count), i, es);
                goto out;
        }
is a bit too late _and_ we don't do anything similar for preallocated blocks.

The question being: which of these checks deserve to stay ((c) doesn't, IMO)
and which deserve to be extended to preallocation? If we do them for
main path, we ought to be at least consistent...

