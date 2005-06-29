Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVF2HXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVF2HXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVF2HXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:23:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262465AbVF2HXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:23:09 -0400
Date: Wed, 29 Jun 2005 00:21:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: penberg@cs.helsinki.fi, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] freevxfs: fix buffer_head leak
Message-Id: <20050629002139.6acd4be7.akpm@osdl.org>
In-Reply-To: <20050629071023.GD16850@infradead.org>
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi>
	<20050628162812.483eb566.akpm@osdl.org>
	<20050629071023.GD16850@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> you're still leaking a buffer in the hypothetical !buffer_mapped() case.
>  Better remove that check completely.

OK..


--- 25/fs/freevxfs/vxfs_fshead.c~freevxfs-fix-buffer_head-leak	2005-06-28 23:55:53.000000000 -0700
+++ 25-akpm/fs/freevxfs/vxfs_fshead.c	2005-06-29 00:21:23.000000000 -0700
@@ -78,17 +78,18 @@ vxfs_getfsh(struct inode *ip, int which)
 	struct buffer_head		*bp;
 
 	bp = vxfs_bread(ip, which);
-	if (buffer_mapped(bp)) {
+	if (bp) {
 		struct vxfs_fsh		*fhp;
 
-		if (!(fhp = kmalloc(sizeof(*fhp), SLAB_KERNEL)))
-			return NULL;
+		if (!(fhp = kmalloc(sizeof(*fhp), GFP_KERNEL)))
+			goto out;
 		memcpy(fhp, bp->b_data, sizeof(*fhp));
 
-		brelse(bp);
+		put_bh(bp);
 		return (fhp);
 	}
-
+out:
+	brelse(bp);
 	return NULL;
 }
 
_

