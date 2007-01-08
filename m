Return-Path: <linux-kernel-owner+w=401wt.eu-S1751053AbXAHV3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbXAHV3K (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbXAHV3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:29:10 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44813 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbXAHV3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:29:08 -0500
Date: Mon, 8 Jan 2007 13:28:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 19/24] Unionfs: Helper macros/inlines
Message-Id: <20070108132817.5c9a30d6.akpm@osdl.org>
In-Reply-To: <11682295994056-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	<11682295994056-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Jan 2007 23:13:11 -0500
"Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:

> From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> 
> This patch contains many macros and inline functions used thoughout Unionfs.
> 
> ..
>
> +#define ibstart(ino) (UNIONFS_I(ino)->bstart)
> +#define ibend(ino) (UNIONFS_I(ino)->bend)
> +
> +/* Superblock to private data */
> +#define UNIONFS_SB(super) ((struct unionfs_sb_info *)(super)->s_fs_info)
> +#define sbstart(sb) 0
> +#define sbend(sb) (UNIONFS_SB(sb)->bend)
> +#define sbmax(sb) (UNIONFS_SB(sb)->bend + 1)
> +
> +/* File to private Data */
> +#define UNIONFS_F(file) ((struct unionfs_file_info *)((file)->private_data))
> +#define fbstart(file) (UNIONFS_F(file)->bstart)
> +#define fbend(file) (UNIONFS_F(file)->bend)
>
> ...
>
> +#define dbstart(dent) (UNIONFS_D(dent)->bstart)
> +#define set_dbstart(dent, val) do { UNIONFS_D(dent)->bstart = val; } while(0)
> +#define dbend(dent) (UNIONFS_D(dent)->bend)
> +#define set_dbend(dent, val) do { UNIONFS_D(dent)->bend = val; } while(0)
> +#define dbopaque(dent) (UNIONFS_D(dent)->bopaque)
> +#define set_dbopaque(dent, val) do { UNIONFS_D(dent)->bopaque = val; } while (0)

Please prefer to use inlined C fucntions.  Macros should only be used if
there is some reason why an inlined fucntion will not work.

> +#define lock_dentry(d)		down(&UNIONFS_D(d)->sem)
> +#define unlock_dentry(d)	up(&UNIONFS_D(d)->sem)
> +#define verify_locked(d)

Ditto.

Please use mutexes where possible.  Semaphores should only be used when
their counting feature is employed.  And, arguably, in situations where a
lock is locked and unlocked from different threads, because this presently
triggers mutex debugging warnings, although we should find a way of fixing
this in the mutex code.

I can't say I like the name "lock_dentry" much.  It sounds like a VFS
function and we may well gain a generic lock_dentry() at some time in the
future.  unionfs_lock_dentry() would be a better choice.
