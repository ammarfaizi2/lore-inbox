Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265214AbSJPAFs>; Tue, 15 Oct 2002 20:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265216AbSJPAFs>; Tue, 15 Oct 2002 20:05:48 -0400
Received: from ns.suse.de ([213.95.15.193]:37134 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265214AbSJPAFo> convert rfc822-to-8bit;
	Tue, 15 Oct 2002 20:05:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Andrew Morton <akpm@digeo.com>, tytso@mit.edu
Subject: Re: [PATCH 1/3] Add extended attributes to ext2/3
Date: Wed, 16 Oct 2002 02:11:39 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <E181a3N-0006No-00@snap.thunk.org> <3DACAC0C.D4C497C1@digeo.com>
In-Reply-To: <3DACAC0C.D4C497C1@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210160211.39284.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 October 2002 02:00, Andrew Morton wrote:
> tytso@mit.edu wrote:
> > This is an updated submission of the extended attribute patches for
> > ext2/3 (versus bk-current).  Many thanks to Cristoph, Andrea, and Andrew
> > for their suggestions and cleanups.
> >
> > This patch creates a meta block cache which is utilized by the ext3 and
> > ext2 extended attribute patches (patches 2 and 3, respectively).  This
> > cache allows directory blocks to be indexed by multiple keys.  In the
> > case of the extended attribute patches, it is used to look up blocks by
> > both the block number and by the hash of the extended attributes.  This
> > is extremely important to allow the sharing of acl's when stored as
> > extended attributes.  Otherwise every single file would require its own,
> > separate, one block overhead to store then ACL, even though there might
> > be a large number of files that have the same ACL.
>
> The key thing here appears to be the cache entry:
>
> +struct mb_cache_entry {
> +       struct list_head                e_lru_list;
> +       struct mb_cache                 *e_cache;
> +       atomic_t                        e_used;
> +       dev_t                           e_dev;
> +       unsigned long                   e_block;
> +       struct list_head                e_block_list;
> +       struct mb_cache_entry_index     e_indexes[0];
> +};
>
> This should be converted to use sector_t for >2TB support, and tested
> with CONFIG_LBD=y and n.

e_block is the block number; the e_indexes are hash values. Ext[23] only has 
32bit block numbers. Am I getting you wrong?

> The use of a dev_t search key is a bit old-fashioned.  Maybe
> use the address of inode->i_sb->s_bdev?

That would do as well.

A related issue:

Would switching to a more decent hash algorithm in fs/ext?/xattr.c make sense? 
I think there are better ones in 2.5. This would only degrade sharing on 
"legacy" systems for a while, but the slow down would vanish over time.

--Andreas.

