Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932761AbWFVD4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbWFVD4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWFVD4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:56:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15552 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751292AbWFVD4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:56:31 -0400
Date: Wed, 21 Jun 2006 20:56:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, mbroz@redhat.com
Subject: Re: [PATCH 02/15] dm linear: support ioctls
Message-Id: <20060621205619.e7c583bc.akpm@osdl.org>
In-Reply-To: <20060621193308.GQ4521@agk.surrey.redhat.com>
References: <20060621193308.GQ4521@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 20:33:08 +0100
Alasdair G Kergon <agk@redhat.com> wrote:

> From: Milan Broz <mbroz@redhat.com>
> 
> When an ioctl is performed on a device with a linear target, simply
> pass it on to the underlying block device.
> 
> Note that the ioctl will pass through the filtering in blkdev_ioctl()
> twice.
>  
> Signed-off-by: Milan Broz <mbroz@redhat.com>
> Signed-off-by: Alasdair G Kergon <agk@redhat.com>
> 
> Index: linux-2.6.17/drivers/md/dm-linear.c
> ===================================================================
> --- linux-2.6.17.orig/drivers/md/dm-linear.c	2006-06-21 17:45:16.000000000 +0100
> +++ linux-2.6.17/drivers/md/dm-linear.c	2006-06-21 18:32:07.000000000 +0100
> @@ -96,14 +96,25 @@ static int linear_status(struct dm_targe
>  	return 0;
>  }
>  
> +static int linear_ioctl(struct dm_target *ti, struct inode *inode,
> +			struct file *filp, unsigned int cmd,
> +			unsigned long arg)
> +{
> +	struct linear_c *lc = (struct linear_c *) ti->private;
> +	struct block_device *bdev = lc->dev->bdev;
> +
> +	return blkdev_ioctl(bdev->bd_inode, filp, cmd, arg);
> +}

but, but..  the blockdev's driver may have decided to use a different ioctl
handler.

We should go through file_operations.ioctl/unlocked_ioctl.
