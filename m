Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbUKXOrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbUKXOrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUKXOpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:45:22 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:58382 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262732AbUKXOmq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:42:46 -0500
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
References: <20041118194959.3f1a3c8e.colin@colino.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 24 Nov 2004 23:02:06 +0900
In-Reply-To: <20041118194959.3f1a3c8e.colin@colino.net> (Colin Leroy's
 message of "Thu, 18 Nov 2004 19:49:59 +0100")
Message-ID: <87pt23wdk1.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Leroy <colin@colino.net> writes:

> @@ -764,6 +765,11 @@
>  	dir->i_atime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
>  	mark_inode_dirty(dir);
>  
> +	sb = dir->i_sb;
> +
> +	if (sb->s_flags & MS_SYNCHRONOUS)
> +		sync_dirty_buffer(bh);
> +

This bh is already released.

>  	retval = generic_file_write(filp, buf, count, ppos);
>  	if (retval > 0) {
>  		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
>  		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
>  		mark_inode_dirty(inode);
> +		if (sb->s_flags & MS_SYNCHRONOUS) {
> +			bh = sb_bread(sb, MSDOS_SB(sb)->fsinfo_sector);
> +			if (bh != NULL) {
> +				sync_dirty_buffer(bh);
> +				brelse(bh);
> +			} else {
> +				BUG_ON(1);
> +			}
> +		}

FAT12/16 doesn't have FSINFO sector.  And if sb_bread() returns NULL,
we should return the valid error.

> @@ -105,4 +118,8 @@
>  	unlock_kernel();
>  	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
>  	mark_inode_dirty(inode);
> +	if (sb->s_flags & MS_SYNCHRONOUS) {
> +		bh = sb_bread(sb, sbi->fsinfo_sector);
> +		sync_dirty_buffer(bh);
> +	}

Ditto.

Aren't you forgetting to update the inode and various metadata (e.g. FAT)?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
