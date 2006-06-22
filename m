Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWFVPRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWFVPRj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbWFVPRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:17:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34968 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751817AbWFVPRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:17:38 -0400
Date: Thu, 22 Jun 2006 16:17:21 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Milan Broz <mbroz@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
Message-ID: <20060622151721.GT19222@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Milan Broz <mbroz@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20060621193121.GP4521@agk.surrey.redhat.com> <20060621205206.35ecdbf8.akpm@osdl.org> <449A51A2.4080601@redhat.com> <20060622012957.97697208.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622012957.97697208.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 01:29:57AM -0700, Andrew Morton wrote:
> OK.  I do think dm needs to remember /dev/sda's file* to get this right
> though.  That's where the ->ioctl methods are.

> Oh dear.  raw_open() doesn't have a file* for the device.
 
Similar with device-mapper: in normal usage dm only sees major:minor.

Yes, the filp dm passes along is incorrect:

- return blkdev_driver_ioctl(bdev->bd_inode, filp, bdev->bd_disk, cmd, arg);
+ return blkdev_driver_ioctl(bdev->bd_inode, NULL, bdev->bd_disk, cmd, arg);

But should unlocked_ioctl become ?

- long (*unlocked_ioctl) (struct file *, unsigned, unsigned long);
+ long (*unlocked_ioctl) (struct inode *, struct file *, unsigned, unsigned long);

so it can be used for block devices?

See also block/scsi_ioctl.c:201 verify_command()  [scsi_cmd_ioctl]
         * file can be NULL from ioctl_by_bdev()...

Or should we be working towards eliminating interfaces that use device numbers?

Alasdair
-- 
agk@redhat.com
