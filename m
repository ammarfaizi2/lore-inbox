Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129300AbRAaWYr>; Wed, 31 Jan 2001 17:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129351AbRAaWYi>; Wed, 31 Jan 2001 17:24:38 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:12019 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129300AbRAaWYZ>; Wed, 31 Jan 2001 17:24:25 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101312223.f0VMNjP30699@webber.adilger.net>
Subject: Re: kernel BUG at inode.c:889!
In-Reply-To: From "(env:" "adilger)" at "Jan 31, 2001 12:42:27 pm"
To: adilger@webber.adilger.net
Date: Wed, 31 Jan 2001 15:23:44 -0700 (MST)
CC: Timo Jantunen <jeti@iki.fi>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I previously wrote:
> Below is a patch which should fix this.  It _should_ prevent you from
> mounting this filesystem in the first place, and should also stop the BUG
> in inode.c.  I'm not 100% sure of correctness, however:
> - is calling clear_inode() in these error cases OK?
> - is calling dput() the right thing to do for the root dentry?  This
>   is what kill_super() does when cleaning up the filesystem.
> 
> Cheers, Andreas
> ============================================================================
> --- fs/ext2/super.c.orig	Tue Jan 23 17:24:45 2001
> +++ fs/ext2/super.c	Wed Jan 31 12:27:25 2001
> @@ -628,13 +628,19 @@
>  	 */
>  	sb->s_op = &ext2_sops;
>  	sb->s_root = d_alloc_root(iget(sb, EXT2_ROOT_INO));
> -	if (!sb->s_root) {
> +	if (!sb->s_root || !S_ISDIR(sb->s_root->d_inode) ||

This should be !S_ISDIR(sb->s_root->d_inode->i_mode).

> +	    !sb->s_root->d_inode->i_blocks || !sb->s_root->d_inode->i_size) {
> +		if (sb->s_root) {
> +			dput(sb->s_root);
> +			sb->s_root = NULL;
> +			printk ("EXT2-fs: corrupt root inode, run e2fsck\n");
> +		} else
> +			printk ("EXT2-fs: get root inode failed\n");

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
