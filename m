Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278788AbRKHWpB>; Thu, 8 Nov 2001 17:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278755AbRKHWov>; Thu, 8 Nov 2001 17:44:51 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:8190 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S278737AbRKHWoj>;
	Thu, 8 Nov 2001 17:44:39 -0500
Date: Thu, 8 Nov 2001 15:43:12 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrew Morton <akpm@zip.com.au>, ext2-devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext2/ialloc.c cleanup
Message-ID: <20011108154311.E9043@lynx.no>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Andrew Morton <akpm@zip.com.au>, ext2-devel@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BEAEEE5.5F5BA8C0@zip.com.au> <Pine.GSO.4.21.0111081707490.8052-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.GSO.4.21.0111081707490.8052-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Nov 08, 2001 at 05:16:17PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 08, 2001  17:16 -0500, Alexander Viro wrote:
> +		get_random_bytes(&group, sizeof(group));
> +		goto fallback;

Little chance that 0 <= group < ngroups.  Even so, value is unused, AFAICS.

> +fallback:
> +	for (i = 0; i < ngroups; i++) {
> +		group = (parent_cg + i) % ngroups;
> +		cg = ext2_get_group_desc (sb, group, &bh);
> +		if (!cg || !cg->bg_free_inodes_count)
> +			continue;
> +		if (le16_to_cpu(cg->bg_free_inodes_count) >= avefreei)
> +			goto found;
> +	}
> +
> +	return -1;


> diff -urN S14/include/linux/ext2_fs_sb.h S14-ext2/include/linux/ext2_fs_sb.h
> --- S14/include/linux/ext2_fs_sb.h	Fri Feb 16 21:29:52 2001
> +++ S14-ext2/include/linux/ext2_fs_sb.h	Thu Nov  8 15:28:34 2001
> @@ -56,6 +56,8 @@
>  	int s_desc_per_block_bits;
>  	int s_inode_size;
>  	int s_first_ino;
> +	unsigned long s_dir_count;
> +	u8 *debts;
>  };

I had thought a couple of times it may be useful to have an in-memory list
of group descriptors, each with a pointer to the on-disk struct, like
ext2_sb points to s_es.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

