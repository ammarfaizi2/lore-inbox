Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269796AbUJAOKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269796AbUJAOKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 10:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269798AbUJAOKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 10:10:39 -0400
Received: from main.gmane.org ([80.91.229.2]:43240 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269796AbUJAOKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 10:10:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: PATCH: fix block layer ioctl bug
Date: Fri, 01 Oct 2004 09:56:08 -0400
Message-ID: <87lleqfsp3.fsf@coraid.com>
References: <1V9VL-3ty-5@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-217-57-234.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:/+yjfENJlmrBP5s8SBGnYU9gAbw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> The block layer checks for -EINVAL from block layer driver ioctls. This
> is wrong - ENOTTY is unknown and some drivers correctly use this. I suspect
> for an internal ioctl 2.7 should change to -ENOIOCTLCMD and bitch about
> old style returns
> 
> This is conservative fix for the 2.6 case, it keeps the bogus -EINVAL to
> avoid breaking stuff
> 
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/block/ioctl.c linux-2.6.6/drivers/block/ioctl.c
> --- linux.vanilla-2.6.6/drivers/block/ioctl.c	2004-05-10 03:31:59.000000000 +0100
> +++ linux-2.6.6/drivers/block/ioctl.c	2004-05-11 20:05:09.000000000 +0100
> @@ -203,7 +203,8 @@
>  	case BLKROSET:
>  		if (disk->fops->ioctl) {
>  			ret = disk->fops->ioctl(inode, file, cmd, arg);
> -			if (ret != -EINVAL)
> +			/* -EINVAL to handle old uncorrected drivers */
> +			if (ret != -EINVAL && ret != -ENOTTY)
>  				return ret;
>  		}
>  		if (!capable(CAP_SYS_ADMIN))

There's a case just above BLKROSET that seems to be in need of a
similar change.  In 2.6.8.1, on a BLKFLSBUF ioctl, if a driver returns
-EINVAL, the block layer will call fsync_bdev, invalidate_bdev, and
return 0.  It only gets the default behavior if it's returning
-EINVAL, though.  

If returning -ENOTTY for unhandled ioctls is the correct thing for a
driver to do, shouldn't the BLKFLSBUF ioctl sync the block device when
the driver returns -ENOTTY?

If so, this patch follows the one above, supporting the drivers that
return -ENOTTY correctly as well as the ones that still return
-EINVAL, at least for now.

--- linux-2.6.8.1/drivers/block/ioctl.c.20041001	Fri Oct  1 08:31:52 2004
+++ linux-2.6.8.1/drivers/block/ioctl.c	Fri Oct  1 08:42:05 2004
@@ -192,11 +192,12 @@ int blkdev_ioctl(struct inode *inode, st
 	case BLKFLSBUF:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 		if (disk->fops->ioctl) {
 			ret = disk->fops->ioctl(inode, file, cmd, arg);
-			if (ret != -EINVAL)
+			/* -EINVAL to handle old uncorrected drivers */
+			if (ret != -EINVAL && ret != -ENOTTY)
 				return ret;
 		}
 		fsync_bdev(bdev);
 		invalidate_bdev(bdev, 0);
 		return 0;


-- 
  Ed L Cashin <ecashin@coraid.com>

