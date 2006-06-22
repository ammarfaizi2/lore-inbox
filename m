Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWFVQ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWFVQ4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWFVQ4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:56:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751157AbWFVQ4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:56:05 -0400
Date: Thu, 22 Jun 2006 09:55:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: mbroz@redhat.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
Message-Id: <20060622095551.b5c6ddce.akpm@osdl.org>
In-Reply-To: <20060622151721.GT19222@agk.surrey.redhat.com>
References: <20060621193121.GP4521@agk.surrey.redhat.com>
	<20060621205206.35ecdbf8.akpm@osdl.org>
	<449A51A2.4080601@redhat.com>
	<20060622012957.97697208.akpm@osdl.org>
	<20060622151721.GT19222@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 16:17:21 +0100
Alasdair G Kergon <agk@redhat.com> wrote:

> On Thu, Jun 22, 2006 at 01:29:57AM -0700, Andrew Morton wrote:
> > OK.  I do think dm needs to remember /dev/sda's file* to get this right
> > though.  That's where the ->ioctl methods are.
> 
> > Oh dear.  raw_open() doesn't have a file* for the device.
>  
> Similar with device-mapper: in normal usage dm only sees major:minor.
> 
> Yes, the filp dm passes along is incorrect:
> 
> - return blkdev_driver_ioctl(bdev->bd_inode, filp, bdev->bd_disk, cmd, arg);
> + return blkdev_driver_ioctl(bdev->bd_inode, NULL, bdev->bd_disk, cmd, arg);
> 
> But should unlocked_ioctl become ?
> 
> - long (*unlocked_ioctl) (struct file *, unsigned, unsigned long);
> + long (*unlocked_ioctl) (struct inode *, struct file *, unsigned, unsigned long);
> 
> so it can be used for block devices?

Perhaps it should (have).  It's a bit nasty, but we do have at least two
internal callers who don't have a file*.

The alternative would be to cook up a fake file* like blkdev_get() does,
but we don't want to propagate that practice.

Oh well.  I suppose a lock_kernel() won't kill us.

> See also block/scsi_ioctl.c:201 verify_command()  [scsi_cmd_ioctl]
>          * file can be NULL from ioctl_by_bdev()...
> 
> Or should we be working towards eliminating interfaces that use device numbers?

If possible.  I guess that would require DM to track the devices with
file*'s or inode*'s or bdev*'s.  Which, I assume, would be non-trivial.
