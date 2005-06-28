Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVF1XsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVF1XsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVF1Xpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:45:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55752 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261385AbVF1X2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:28:12 -0400
Date: Tue, 28 Jun 2005 16:28:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] freevxfs: fix buffer_head leak
Message-Id: <20050628162812.483eb566.akpm@osdl.org>
In-Reply-To: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi>
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> This patch fixes a buffer_head leak in the function vxfs_getfsh by
> allocating the buffer before doing sb_bread(). In addition, the patch
> replaces misused SLAB_KERNEL flag with the proper GFP_KERNEL and adds
> a NULL check for sb_bread.
> 

Yes, there does seem to be a leak there.

> ===================================================================
> --- 2.6.orig/fs/freevxfs/vxfs_fshead.c	2005-06-28 19:48:12.000000000 +0300
> +++ 2.6/fs/freevxfs/vxfs_fshead.c	2005-06-28 19:48:34.000000000 +0300
> @@ -76,19 +76,22 @@
>  vxfs_getfsh(struct inode *ip, int which)
>  {
>  	struct buffer_head		*bp;
> +	struct vxfs_fsh			*fhp;
> +
> +	if (!(fhp = kmalloc(sizeof(*fhp), GFP_KERNEL)))
> +		goto failed;
>  
>  	bp = vxfs_bread(ip, which);
> -	if (buffer_mapped(bp)) {
> -		struct vxfs_fsh		*fhp;
> +	if (!bp || !buffer_mapped(bp))
> +		goto failed;
>  
> -		if (!(fhp = kmalloc(sizeof(*fhp), SLAB_KERNEL)))
> -			return NULL;
> -		memcpy(fhp, bp->b_data, sizeof(*fhp));
> +	memcpy(fhp, bp->b_data, sizeof(*fhp));
>  
> -		brelse(bp);
> -		return (fhp);
> -	}
> +	brelse(bp);
> +	return fhp;
>  
> +failed:
> +	kfree(fhp);
>  	return NULL;
>  }
>  

But your change means that we'll always perform that kmalloc, even if the
buffer came back !buffer_mapped().

<looks>

I don't think sb_bread() can return an unmapped buffer at all.

And sb_bread() can return NULL (I/O error) and we're not checking for that
in there.

Something like this?

diff -puN fs/freevxfs/vxfs_fshead.c~freevxfs-fix-buffer_head-leak fs/freevxfs/vxfs_fshead.c
--- 25/fs/freevxfs/vxfs_fshead.c~freevxfs-fix-buffer_head-leak	Tue Jun 28 16:19:53 2005
+++ 25-akpm/fs/freevxfs/vxfs_fshead.c	Tue Jun 28 16:24:53 2005
@@ -78,14 +78,16 @@ vxfs_getfsh(struct inode *ip, int which)
 	struct buffer_head		*bp;
 
 	bp = vxfs_bread(ip, which);
-	if (buffer_mapped(bp)) {
+	if (bp && buffer_mapped(bp)) {
 		struct vxfs_fsh		*fhp;
 
-		if (!(fhp = kmalloc(sizeof(*fhp), SLAB_KERNEL)))
+		if (!(fhp = kmalloc(sizeof(*fhp), GFP_KERNEL))) {
+			put_bh(bp);
 			return NULL;
+		}
 		memcpy(fhp, bp->b_data, sizeof(*fhp));
 
-		brelse(bp);
+		put_bh(bp);
 		return (fhp);
 	}
 
_

