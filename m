Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWELUaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWELUaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWELUaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:30:20 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:58510 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932220AbWELUaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:30:19 -0400
Date: Fri, 12 May 2006 22:30:17 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Or Gerlitz <or.gerlitz@gmail.com>,
       linux-scsi@vger.kernel.org, rmk@arm.linux.org.uk, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512203016.GD29077@harddisk-recovery.com>
References: <20060511151456.GD3755@harddisk-recovery.com> <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com> <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org> <1147456038.3769.39.camel@mulgrave.il.steeleye.com> <1147460325.3769.46.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147460325.3769.46.camel@mulgrave.il.steeleye.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 01:58:45PM -0500, James Bottomley wrote:
> On Fri, 2006-05-12 at 12:47 -0500, James Bottomley wrote:
> > I'll look at the release paths and see if I can work out what it is.
> 
> OK, here's the scoop.  The problem patch adds a get of driverfs_dev in
> add_disk(), but doesn't put it again until disk_release() (which occurs
> on final put_disk() of the gendisk).
> 
> However, in SCSI, the driverfs_dev is the sdev_gendev.  That means
> there's a reference held on sdev_gendev  until final disk put.
> Unfortunately, we use the driver model driver_remove to trigger
> del_gendisk (which removes the gendisk from visibility and decrements
> the refcount), so we've introduced an unbreakable deadlock in the
> reference counting with this.

That explains why I could only trigger the bug with a disk attached to
the controller.


Thanks for figuring out,

Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
