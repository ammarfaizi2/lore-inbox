Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751895AbWB1BaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbWB1BaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbWB1BaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:30:19 -0500
Received: from ns1.suse.de ([195.135.220.2]:36256 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751895AbWB1BaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:30:18 -0500
From: Neil Brown <neilb@suse.de>
To: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Date: Tue, 28 Feb 2006 12:29:33 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17411.42877.14972.748051@cse.unsw.edu.au>
Subject: Bug in fs/reiserfs/file.c
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In fs/reiserfs/file.c, in reiserfs_file_write, at line 1400 in
2.6.16-rc2-mm1 we have

		size_t blocks_to_allocate;	/* how much blocks we need to allocate for this iteration */

size_t is an unsigned type.

Later (line 1467) we have code like:

		blocks_to_allocate =
		    reiserfs_prepare_file_region_for_write(inode, pos,
							   num_pages,
							   write_bytes,
							   prepared_pages);
		if (blocks_to_allocate < 0) {
			res = blocks_to_allocate;
			reiserfs_release_claimed_blocks(inode->i_sb,
							num_pages <<
							(PAGE_CACHE_SHIFT -
							 inode->i_blkbits));
			break;
		}


Spot the bug.... reiserfs_prepare_file_region_for_write can return a
negative error status, but blocks_to_allocate won't store it, and
things go wrong.

The actual result if reiserfs_prepare_file_region_for_write returns
negative is that a subsequent call to 
			    reiserfs_allocate_blocks_for_region(&th, inode, pos,
								num_pages,
								write_bytes,
								prepared_pages,
								blocks_to_allocate);
trys to kmalloc an enormous amount of memory
	allocated_blocks = kmalloc((blocks_to_allocate + will_prealloc) *
				   sizeof(b_blocknr_t), GFP_NOFS);

and fails so
		if (res) {
			reiserfs_unprepare_pages(prepared_pages, num_pages);
			break;
		}

which tries to unlock the pages in prepared_pages. But
reiserfs_prepare_file_region_for_write didn't leave any locked pages
in their (due to it's failure) and try_to_free_buffers BUGs out.

The "obvious" fix it to change the 'size_t' to 'ssize_t', but I'll
leave to to reiserfs-dev to create and submit a patch....


As an aside, 
  info gcc
tells me that '-W' will cause a warning when

        * An unsigned value is compared against zero with `<' or `<='.

It doesn't :-(

NeilBrown
