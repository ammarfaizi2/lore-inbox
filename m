Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbTDUMSm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 08:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTDUMSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 08:18:42 -0400
Received: from angband.namesys.com ([212.16.7.85]:28041 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP id S263833AbTDUMSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 08:18:41 -0400
Date: Mon, 21 Apr 2003 16:30:39 +0400
From: Oleg Drokin <green@namesys.com>
To: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: "[PATCH] devfs: switch over ubd to ->devfs_name" breaks ubd/sysfs
Message-ID: <20030421163039.A7965@namesys.com>
References: <20030421155530.A7544@namesys.com> <20030421141845.A25822@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421141845.A25822@lst.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Apr 21, 2003 at 02:18:45PM +0200, Christoph Hellwig wrote:
> >    The "[PATCH] devfs: switch over ubd to ->devfs_name" patch that was included into 2.5.68,
> >    have broken UML's ubd/sysfs interaction.
> >    Sysfs is very upset when something tries to register several devices with 
> >    same name, so I was forced to use following patch.
> >    If this is wrong, then please explain to me why, and suggest the correct way of handling
> >    this situation.
> Patch looks okay to me.  But I'm still a bit confused about all
> that fake_major stuff.  Someone care to explain it?

fake major is easy, it allows you to register ubd device on two majors.
This is useful e.g. for installing distros inside of UML.
Distro installers are tend to look for IDE disk on major 3, for example.
Then if you boot with ubd=3, installer will find the disk ;)

Actually the patch consits of two parts, as there might be more than one
ubd device, we need to name them differently.

Actually I just see that if one enables fake major stuff, the sysfs will still
be upset, as names for both UBD_MAJOR and fake_major would be the same.

So perhaps fillowing patch should be used.

Bye,
    Oleg

===== arch/um/drivers/ubd_kern.c 1.32 vs edited =====
--- 1.32/arch/um/drivers/ubd_kern.c	Sun Apr 20 01:17:05 2003
+++ edited/arch/um/drivers/ubd_kern.c	Mon Apr 21 16:29:21 2003
@@ -494,8 +494,13 @@
 	disk->first_minor = unit << UBD_SHIFT;
 	disk->fops = &ubd_blops;
 	set_capacity(disk, size / 512);
-	sprintf(disk->disk_name, "ubd");
-	sprintf(disk->devfs_name, "ubd/disc%d", unit);
+	if ( major == MAJOR_NR ) {
+		sprintf(disk->disk_name, "ubd%d", unit);
+		sprintf(disk->devfs_name, "ubd/disc%d", unit);
+	} else {
+		sprintf(disk->disk_name, "ubd_fake%d", unit);
+		sprintf(disk->devfs_name, "ubd_fake/disc%d", unit);
+	}
 
 	disk->private_data = &ubd_dev[unit];
 	disk->queue = &ubd_queue;
@@ -527,7 +532,7 @@
 	if(err) 
 		return(err);
  
-	if(fake_major)
+	if(fake_major != MAJOR_NR)
 		ubd_new_disk(fake_major, dev->size, n, 
 			     &fake_gendisk[n]);
 
