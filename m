Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWB1SxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWB1SxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWB1SxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:53:16 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:7129 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S932411AbWB1SxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:53:16 -0500
Message-ID: <44049C19.40509@namesys.com>
Date: Tue, 28 Feb 2006 10:53:13 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>, vs <vs@thebsh.namesys.com>
CC: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Bug in fs/reiserfs/file.c
References: <17411.42877.14972.748051@cse.unsw.edu.au>
In-Reply-To: <17411.42877.14972.748051@cse.unsw.edu.au>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Neil, I'll have vs evaluate and fix this.

Hans

Neil Brown wrote:

>In fs/reiserfs/file.c, in reiserfs_file_write, at line 1400 in
>2.6.16-rc2-mm1 we have
>
>		size_t blocks_to_allocate;	/* how much blocks we need to allocate for this iteration */
>
>size_t is an unsigned type.
>
>Later (line 1467) we have code like:
>
>		blocks_to_allocate =
>		    reiserfs_prepare_file_region_for_write(inode, pos,
>							   num_pages,
>							   write_bytes,
>							   prepared_pages);
>		if (blocks_to_allocate < 0) {
>			res = blocks_to_allocate;
>			reiserfs_release_claimed_blocks(inode->i_sb,
>							num_pages <<
>							(PAGE_CACHE_SHIFT -
>							 inode->i_blkbits));
>			break;
>		}
>
>
>Spot the bug.... reiserfs_prepare_file_region_for_write can return a
>negative error status, but blocks_to_allocate won't store it, and
>things go wrong.
>
>The actual result if reiserfs_prepare_file_region_for_write returns
>negative is that a subsequent call to 
>			    reiserfs_allocate_blocks_for_region(&th, inode, pos,
>								num_pages,
>								write_bytes,
>								prepared_pages,
>								blocks_to_allocate);
>trys to kmalloc an enormous amount of memory
>	allocated_blocks = kmalloc((blocks_to_allocate + will_prealloc) *
>				   sizeof(b_blocknr_t), GFP_NOFS);
>
>and fails so
>		if (res) {
>			reiserfs_unprepare_pages(prepared_pages, num_pages);
>			break;
>		}
>
>which tries to unlock the pages in prepared_pages. But
>reiserfs_prepare_file_region_for_write didn't leave any locked pages
>in their (due to it's failure) and try_to_free_buffers BUGs out.
>
>The "obvious" fix it to change the 'size_t' to 'ssize_t', but I'll
>leave to to reiserfs-dev to create and submit a patch....
>
>
>As an aside, 
>  info gcc
>tells me that '-W' will cause a warning when
>
>        * An unsigned value is compared against zero with `<' or `<='.
>
>It doesn't :-(
>
>NeilBrown
>
>
>  
>

