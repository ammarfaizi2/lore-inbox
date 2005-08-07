Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753092AbVHGXYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbVHGXYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 19:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbVHGXYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 19:24:40 -0400
Received: from mail.autoweb.net ([198.172.237.26]:11937 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1753091AbVHGXYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 19:24:39 -0400
Message-ID: <42F69832.2030404@michonline.com>
Date: Sun, 07 Aug 2005 19:24:34 -0400
From: Ryan Anderson <ryan@michonline.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
CC: Andrew Morton <akpm@osdl.org>, Robert Love <rml@novell.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.6.13-rc5-git-current (0d317fb72fe3cf0f611608cf3a3015bbe6cd2a66)
References: <20050807035630.GA5271@mythryan2.michonline.com> <20050807200814.GA2464@localhost.localdomain>
In-Reply-To: <20050807200814.GA2464@localhost.localdomain>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alexander Nyberg wrote:
> (akpm: a fix for this needs to go into 2.6.13, inotify + nfs 
> trivially oopses otherwise, even if inotify isn't actively used)

This patch seems to have fixed it for me.

I upgraded to fdbd22dad31982b64a4e663fd056a8a7cfac9607 and applied this
patch on top of it, and I can't retrigger the oops.  (It seemed rather
easy to hit on the other kernel)

So, I guess:

Seems-to-fix-it: Ryan Anderson <ryan@michoneline.com>

> It looks like the following sequence is done in the wrong order.
> When vfs_unlink() is called from sys_unlink() it has taken a ref
> on the inode and sys_unlink() does the last iput() but when called
> from other callsites vfs_unlink() might do the last iput() and
> free inode, so inotify_inode_queue_event() will receive an already
> freed object and dereference an already freed object.
> 
> Signed-off-by: Alexander Nyberg <alexn@telia.com>
> 
> Index: mm/fs/namei.c
> ===================================================================
> --- mm.orig/fs/namei.c	2005-08-07 12:06:16.000000000 +0200
> +++ mm/fs/namei.c	2005-08-07 18:17:20.000000000 +0200
> @@ -1869,8 +1869,8 @@
>  	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
>  	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
>  		struct inode *inode = dentry->d_inode;
> -		d_delete(dentry);
>  		fsnotify_unlink(dentry, inode, dir);
> +		d_delete(dentry);
>  	}
>  
>  	return error;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC9pgyfhVDhkBuUKURAjbSAKCavd7s4zdk/uce1TZ0CX018RGRmgCfXWFI
XjAPhBcEoLyJDWnjk9oI+XI=
=NMc4
-----END PGP SIGNATURE-----
