Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVF2Eac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVF2Eac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 00:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVF2Eab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 00:30:31 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:12683 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262266AbVF2E0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 00:26:19 -0400
Subject: Re: [PATCH 1/3] freevxfs: fix buffer_head leak
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050628162812.483eb566.akpm@osdl.org>
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi>
	 <20050628162812.483eb566.akpm@osdl.org>
Date: Wed, 29 Jun 2005 07:25:47 +0300
Message-Id: <1120019148.9658.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 16:28 -0700, Andrew Morton wrote:
> But your change means that we'll always perform that kmalloc, even if the
> buffer came back !buffer_mapped().

I think I originally dropped that buffer_mapped() check (which doesn't
make sense to me) which is why I shuffled the code around.

On Tue, 2005-06-28 at 16:28 -0700, Andrew Morton wrote:
> Something like this?

Works for me. Thanks.

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
>  
> _
> 

