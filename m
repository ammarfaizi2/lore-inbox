Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265115AbSJOXyY>; Tue, 15 Oct 2002 19:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265117AbSJOXyY>; Tue, 15 Oct 2002 19:54:24 -0400
Received: from packet.digeo.com ([12.110.80.53]:42220 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265115AbSJOXyX>;
	Tue, 15 Oct 2002 19:54:23 -0400
Message-ID: <3DACAC0C.D4C497C1@digeo.com>
Date: Tue, 15 Oct 2002 17:00:12 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tytso@mit.edu, Andreas Gruenbacher <agruen@suse.de>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Add extended attributes to ext2/3
References: <E181a3N-0006No-00@snap.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 00:00:12.0502 (UTC) FILETIME=[FFD02760:01C274A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu wrote:
> 
> This is an updated submission of the extended attribute patches for
> ext2/3 (versus bk-current).  Many thanks to Cristoph, Andrea, and Andrew
> for their suggestions and cleanups.
> 
> This patch creates a meta block cache which is utilized by the ext3 and
> ext2 extended attribute patches (patches 2 and 3, respectively).  This
> cache allows directory blocks to be indexed by multiple keys.  In the
> case of the extended attribute patches, it is used to look up blocks by
> both the block number and by the hash of the extended attributes.  This
> is extremely important to allow the sharing of acl's when stored as
> extended attributes.  Otherwise every single file would require its own,
> separate, one block overhead to store then ACL, even though there might
> be a large number of files that have the same ACL.
> 

The key thing here appears to be the cache entry:

+struct mb_cache_entry {
+       struct list_head                e_lru_list;
+       struct mb_cache                 *e_cache;
+       atomic_t                        e_used;
+       dev_t                           e_dev;
+       unsigned long                   e_block;
+       struct list_head                e_block_list;
+       struct mb_cache_entry_index     e_indexes[0];
+};

This should be converted to use sector_t for >2TB support, and tested
with CONFIG_LBD=y and n.

The use of a dev_t search key is a bit old-fashioned.  Maybe
use the address of inode->i_sb->s_bdev?
