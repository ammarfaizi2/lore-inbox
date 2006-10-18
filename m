Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWJRJuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWJRJuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWJRJuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:50:04 -0400
Received: from verein.lst.de ([213.95.11.210]:59070 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932108AbWJRJuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:50:02 -0400
Date: Wed, 18 Oct 2006 11:49:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: xfs-masters@oss.sgi.com
Cc: linux kernel <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: [xfs-masters] [PATCH] fs/xfs: Handcrafted MIN/MAX macro removal
Message-ID: <20061018094956.GA19048@lst.de>
References: <1161160132.20400.115.camel@amol.verismonetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161160132.20400.115.camel@amol.verismonetworks.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 01:58:52PM +0530, Amol Lad wrote:
> --- linux-2.6.19-rc2-orig/fs/xfs/xfs_btree.h	2006-10-18 09:29:18.000000000 +0530
> +++ linux-2.6.19-rc2/fs/xfs/xfs_btree.h	2006-10-18 11:25:46.000000000 +0530
> @@ -18,6 +18,8 @@
>  #ifndef __XFS_BTREE_H__
>  #define	__XFS_BTREE_H__
>  
> +#include <linux/kernel.h>
> +

This file is also used in libxfs, so you can't just include this header
directly.  On the other hand it should always get kernel.h through
xfs_linux.h anyway so you might aswell just leave the include out.

> +#define	XFS_EXTLEN_MIN(a,b)   (min_t(xfs_extlen_t,a,b))
> +#define	XFS_EXTLEN_MAX(a,b)	  (max_t(xfs_extlen_t,a,b))
> +#define	XFS_AGBLOCK_MIN(a,b)  (min_t(xfs_agblock_t,a,b))
> +#define	XFS_AGBLOCK_MAX(a,b)  (max_t(xfs_agblock_t,a,b))
> +#define	XFS_FILEOFF_MIN(a,b)  (min_t(xfs_fileoff_t,a,b))
> +#define	XFS_FILEOFF_MAX(a,b)  (max_t(xfs_fileoff_t,a,b))
> +#define	XFS_FILBLKS_MIN(a,b)  (min_t(xfs_filblks_t,a,b))
> +#define	XFS_FILBLKS_MAX(a,b)  (max_t(xfs_filblks_t,a,b))

At this point we might aswell kill these UGLY SHOUTING macros and
use min_t/max_t (or just min/max where appropinquate) directly.

>  			error = xfs_rtallocate_extent_block(mp, tp, i,
> -					XFS_RTMAX(minlen, 1 << l),
> -					XFS_RTMIN(maxlen, (1 << (l + 1)) - 1),
> +					max(minlen, (xfs_extlen_t)(1 << l)),
> +					min(maxlen, (xfs_extlen_t)((1 << (l + 1)) - 1)),

these would be a lot more readable as

					max_t(xfs_extlen_t, minlen, (1 << l)),
					min_t(xfs_extlen_t, maxlen,
					      ((1 << (l + 1)) - 1)),

wouldn, it?

> -		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
> +		lastbit = min(bit + len, (xfs_extlen_t)XFS_NBWORD);

> -		firstbit = XFS_RTMAX((xfs_srtblock_t)(bit - len + 1), 0);
> +		firstbit = max((xfs_srtblock_t)(bit - len + 1), (xfs_srtblock_t)0);

> -		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
> +		lastbit = min(bit + len, (xfs_rtblock_t)XFS_NBWORD);

> -		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
> +		lastbit = min(bit + len, (xfs_extlen_t)XFS_NBWORD);

> -			XFS_RTMIN(nrblocks,
> -				  nsbp->sb_rbmblocks * NBBY *
> -				  nsbp->sb_blocksize * nsbp->sb_rextsize);
> +			min(nrblocks,
> +				  (xfs_drfsbno_t)(nsbp->sb_rbmblocks * NBBY *
> +				  nsbp->sb_blocksize * nsbp->sb_rextsize));

ditto

