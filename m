Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbTCJQQz>; Mon, 10 Mar 2003 11:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbTCJQQz>; Mon, 10 Mar 2003 11:16:55 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:34045 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S261341AbTCJQQe>; Mon, 10 Mar 2003 11:16:34 -0500
Date: Mon, 10 Mar 2003 09:25:46 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] concurrent block allocation for ext3
Message-ID: <20030310092546.D12806@schatzie.adilger.int>
Mail-Followup-To: Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>
References: <m3zno3grfz.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3zno3grfz.fsf@lexa.home.net>; from bzzz@tmi.comex.ru on Mon, Mar 10, 2003 at 06:41:04PM +0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 10, 2003  18:41 +0300, Alex Tomas wrote:
> Here is the small patch which implements concurrent block allocation
> for ext3. It removes lock_super() in ext3_new_block() and ext3_free_blocks().
> Modifications of counters in superblock and group descriptors are protected
> by spinlock. Tested on SMP for several hours.

Any ideas on how much this improves the performance?  What sort of tests
were you running?  We could improve things a bit further by having separate
per-group locks for the update of the group descriptor info, and only
lazily update the superblock at statfs and unmount time (with a suitable
feature flag so e2fsck can fix this up at recovery time), but you seem
to have gotten the majority of the parallelism from this fix.

> @@ -214,11 +213,13 @@
>  				      block + i);
>  			BUFFER_TRACE(bitmap_bh, "bit already cleared");
>  		} else {
> +			spin_lock(&EXT3_SB(sb)->s_alloc_lock);
>  			dquot_freed_blocks++;
>  			gdp->bg_free_blocks_count =
>  			  cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count)+1);
>  			es->s_free_blocks_count =
>  			  cpu_to_le32(le32_to_cpu(es->s_free_blocks_count)+1);
> +			spin_unlock(&EXT3_SB(sb)->s_alloc_lock);

One minor nit is that you left an ext3_error() for the "bit already cleared"
case just above this patch hunk.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

