Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWELXvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWELXvL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWELXvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:51:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49128 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932203AbWELXuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:50:44 -0400
Date: Fri, 12 May 2006 16:50:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Erik Mouw <erik@harddisk-recovery.com>, Or Gerlitz <or.gerlitz@gmail.com>,
       linux-scsi@vger.kernel.org, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
In-Reply-To: <20060512233711.GW27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0605121647250.3866@g5.osdl.org>
References: <20060512203416.GA17120@flint.arm.linux.org.uk>
 <20060512214354.GP27946@ftp.linux.org.uk> <20060512215520.GH17120@flint.arm.linux.org.uk>
 <20060512220807.GR27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121519420.3866@g5.osdl.org>
 <20060512222816.GS27946@ftp.linux.org.uk> <20060512224804.GT27946@ftp.linux.org.uk>
 <20060512225101.GU27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121559490.3866@g5.osdl.org>
 <20060512232131.GV27946@ftp.linux.org.uk> <20060512233711.GW27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 May 2006, Al Viro wrote:
> 
> BTW, the best option is to kill bdev_uevent() again.  Short of that,
> skip PHYSDEV mess if disk doesn't have GENHD_FL_UP.

I do think the mount/umount events are valid and interesting, so I'd much 
rather see the second version.

However, that does beg the question: wouldn't that effectively be what the 
patch I posted would do? Notably the "disk->driverfs_dev = NULL" part 
after we've dropped it (the "KOBJ_REMOVE" event move is a separate issue, 
mixed here into the same patch, but should result in possibly better name 
generation for the event).

Basically, onces driverfs_dev has been dropped, we NULL it out, and then 
the people who use it automatically get the right result.

Yes? No? "You're a total klutz, Linus, that patch won't actually do 
anything, because <xyz>"?

		Linus

---
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index 45ae7dd..7ef1f09 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -533,6 +533,7 @@ void del_gendisk(struct gendisk *disk)
 
 	devfs_remove_disk(disk);
 
+	kobject_uevent(&disk->kobj, KOBJ_REMOVE);
 	if (disk->holder_dir)
 		kobject_unregister(disk->holder_dir);
 	if (disk->slave_dir)
@@ -545,7 +546,7 @@ void del_gendisk(struct gendisk *disk)
 			kfree(disk_name);
 		}
 		put_device(disk->driverfs_dev);
+		disk->driverfs_dev = NULL;
 	}
-	kobject_uevent(&disk->kobj, KOBJ_REMOVE);
 	kobject_del(&disk->kobj);
 }
