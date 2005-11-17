Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVKQM1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVKQM1v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 07:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVKQM1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 07:27:51 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:41130 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750782AbVKQM1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 07:27:51 -0500
Subject: Re: [PATCH 1/4] add compat_ioctl methods to dasd
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Christoph Hellwig <hch@lst.de>
Cc: wein@de.ibm.com, Horst.Hummel@de.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051116084544.GA25181@lst.de>
References: <20051104221652.GB9384@lst.de> <20051112093340.GA15702@lst.de>
	 <1132066277.6014.35.camel@localhost.localdomain>
	 <20051115172438.GA10445@lst.de>  <20051116084544.GA25181@lst.de>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 13:27:32 +0100
Message-Id: <1132230452.5463.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 09:45 +0100, Christoph Hellwig wrote:
> On Tue, Nov 15, 2005 at 06:24:38PM +0100, Christoph Hellwig wrote:
> > > and doesn't work after fixing the compile problem. It's a
> > > problem with the bdev->bd_disk->private_data which is NULL at the time
> > > the partition detection code calls the BIODASDINFO and HDIO_GETGEO ioctl
> > > with ioctl_by_bdev. I don't see an easy way to fix this right now.
> > 
> > my patch doesn't change anything related to dereferencing those fields.
> > 
> > I see the problem that you're probably having: ioctl_by_bdev calls
> > ->ioctl without ensuring ->open has been called previously.  But I don't
> > see why this couldn't have happened previously.
> 
> So looking at it again I found a bug:  we return EINVAL on an invalid
> ioctl, but the compat layer expects ENOIOCTLCMD so it returns using the
> generic compat bits.  Returning ENOIOCTLCMD from unlocked_ioctl is fine
> aswell as the ioctl layer turns it back.  The patch below fix this issue
> and the missing semicolon after lock_kernel()

Still doesn't work. The reason is ioctl_by_bdev:

int ioctl_by_bdev(struct block_device *bdev,
                  unsigned cmd, unsigned long arg)
{
        int res;
        mm_segment_t old_fs = get_fs();
        set_fs(KERNEL_DS);
        res = blkdev_ioctl(bdev->bd_inode, NULL, cmd, arg);
        set_fs(old_fs);
        return res;
}

blkdev_ioctl is explicitly called with a NULL file pointer. That can't
work with block device drivers that use unlocked ioctls. We'd need to
create a struct file with at least a valid f_dentry->d_inode->i_bdev
chain in ioctl_by_bdev to make it work with unlocked ioctls. Not nice ..

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


