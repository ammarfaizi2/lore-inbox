Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVF2HKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVF2HKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbVF2HKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:10:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25551 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262462AbVF2HKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:10:30 -0400
Date: Wed, 29 Jun 2005 08:10:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] freevxfs: fix buffer_head leak
Message-ID: <20050629071023.GD16850@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi> <20050628162812.483eb566.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628162812.483eb566.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Something like this?
> 
> diff -puN fs/freevxfs/vxfs_fshead.c~freevxfs-fix-buffer_head-leak fs/freevxfs/vxfs_fshead.c
> --- 25/fs/freevxfs/vxfs_fshead.c~freevxfs-fix-buffer_head-leak	Tue Jun 28 16:19:53 2005
> +++ 25-akpm/fs/freevxfs/vxfs_fshead.c	Tue Jun 28 16:24:53 2005
> @@ -78,14 +78,16 @@ vxfs_getfsh(struct inode *ip, int which)
>  	struct buffer_head		*bp;
>  
>  	bp = vxfs_bread(ip, which);
> -	if (buffer_mapped(bp)) {
> +	if (bp && buffer_mapped(bp)) {
>  		struct vxfs_fsh		*fhp;
>  
> -		if (!(fhp = kmalloc(sizeof(*fhp), SLAB_KERNEL)))
> +		if (!(fhp = kmalloc(sizeof(*fhp), GFP_KERNEL))) {
> +			put_bh(bp);
>  			return NULL;
> +		}
>  		memcpy(fhp, bp->b_data, sizeof(*fhp));
>  
> -		brelse(bp);
> +		put_bh(bp);
>  		return (fhp);
>  	}

you're still leaking a buffer in the hypothetical !buffer_mapped() case.
Better remove that check completely.
