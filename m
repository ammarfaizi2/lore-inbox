Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424225AbWKIWvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424225AbWKIWvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424222AbWKIWvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:51:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424221AbWKIWvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:51:16 -0500
Date: Thu, 9 Nov 2006 14:51:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benoit Boissinot <bboissin@gmail.com>, Mattia Dongili <malattia@linux.it>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5-mm1
Message-Id: <20061109145100.01d6ec46.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0611091655080.2262-100000@iolanthe.rowland.org>
References: <20061109192658.GA2560@inferi.kami.home>
	<Pine.LNX.4.44L0.0611091655080.2262-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006 16:58:31 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Thu, 9 Nov 2006, Mattia Dongili wrote:
> 
> > On Thu, Nov 09, 2006 at 11:04:53AM -0800, Andrew Morton wrote:
> > > 
> > > (added linux-scsi)
> > [...]
> > > > [27526.232000] EIP: [<e8074e26>]
> > > > scsi_device_dev_release_usercontext+0x36/0x100 [scsi_mod] SS:ESP
> > > > 0068:dfdb1e3c
> > > > 
> > > > full dmesg attached, I can test patches and provide any useful
> > > > information if needed (just not now because the dock is at work).
> > > 
> > > You're the second or third person to report this (to no effect, btw). 
> > 
> > oh, great. I was going to report the same (had with usb key unplug).
> > Linux version 2.6.19-rc5-mm1-1 (mattia@tadamune) (gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #4 SMP Wed Nov 8 22:46:11 CET 2006
> 
> I don't know exactly where the problem lies, but I have narrowed it down.
> 
> In drivers/scsi/sd.c:sd_probe(), the call to add_disk() increases the 
> device's refcount by 1.  However in sd_remove(), the call to del_gendisk() 
> decreases the device's refcount by 2.  Consequently the structure is 
> deallocated too early, causing the oops.
> 
> Somebody who knows more than I do about add_disk() and del_gendisk() will 
> have to figure what's going wrong.
> 

hm.  Maybe it's the disk_sysfs_symlinks() changes.

Could someone who can reproduce this please try this revert, on
2.6.19-rc2-mm2 through 2.6.19-rc5-mm1?



 fs/partitions/check.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN fs/partitions/check.c~revert-fix-ide-cs-hang-after-device-removal fs/partitions/check.c
--- a/fs/partitions/check.c~revert-fix-ide-cs-hang-after-device-removal
+++ a/fs/partitions/check.c
@@ -416,7 +416,7 @@ static char *make_block_name(struct gend
 
 static int disk_sysfs_symlinks(struct gendisk *disk)
 {
-	struct device *target = disk->driverfs_dev;
+	struct device *target = get_device(disk->driverfs_dev);
 	int err;
 	char *disk_name = NULL;
 
@@ -452,8 +452,9 @@ err_out_dev_link:
 		sysfs_remove_link(&disk->kobj, "device");
 err_out_disk_name:
 		kfree(disk_name);
-	}
 err_out:
+		put_device(target);
+	}
 	return err;
 }
 
_

