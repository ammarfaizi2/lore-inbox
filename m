Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSKYVMS>; Mon, 25 Nov 2002 16:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbSKYVMS>; Mon, 25 Nov 2002 16:12:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:21424 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265689AbSKYVMR>;
	Mon, 25 Nov 2002 16:12:17 -0500
Date: Mon, 25 Nov 2002 15:13:20 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, <cliffw@osdl.org>,
       <ricklind@us.ibm.com>
Subject: Re: Unable to mount root device under .49 (possibly earlier than
 .47)
In-Reply-To: <Pine.LNX.4.50.0211241510130.1462-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.33.0211251457540.898-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem was that having the floppy driver configured in, but not 
having any floppy drives in the system caused us to leak references to the 
block_subsys structure. When it hit 0, its directory was removed, and the 
block devices were prevented from gaining a reference to it. 

(Zwane sent me his sysfs tree and dmesg output off-list, and Cliff 
verified the OSDL machine had the same characteristics).

The configuration is not wrong, but unusual, which is why it didn't pop up
before. For the record, I should have caught this earlier, as I don't have
a floppy drive myself, but I had the floppy driver configured as a module
for some reason..

The appended patch should fix the problem. If you can, please try it and 
verify it solves the problem. 

Thanks,


	-pat

P.S. I noticed in alloc_disk() that rand_initialize_disk() happened
outside the check if (disk != NULL). It blindly references disk, so it's
moved inside the if block.


===== drivers/block/genhd.c 1.59 vs edited =====
--- 1.59/drivers/block/genhd.c	Sat Nov  9 14:42:00 2002
+++ edited/drivers/block/genhd.c	Mon Nov 25 13:20:27 2002
@@ -408,11 +408,11 @@
 		disk->minors = minors;
 		while (minors >>= 1)
 			disk->minor_shift++;
-		kobject_init(&disk->kobj);
 		disk->kobj.subsys = &block_subsys;
+		kobject_init(&disk->kobj);
 		INIT_LIST_HEAD(&disk->full_list);
+		rand_initialize_disk(disk);
 	}
-	rand_initialize_disk(disk);
 	return disk;
 }
 
===== fs/partitions/check.c 1.88 vs edited =====
--- 1.88/fs/partitions/check.c	Wed Nov 20 21:08:39 2002
+++ edited/fs/partitions/check.c	Mon Nov 25 12:44:58 2002
@@ -377,7 +377,6 @@
 	p->start_sect = start;
 	p->nr_sects = len;
 	devfs_register_partition(disk, part);
-	kobject_init(&p->kobj);
 	snprintf(p->kobj.name,KOBJ_NAME_LEN,"%s%d",disk->kobj.name,part);
 	p->kobj.parent = &disk->kobj;
 	p->kobj.subsys = &part_subsys;
@@ -406,7 +405,7 @@
 	s = strchr(disk->kobj.name, '/');
 	if (s)
 		*s = '!';
-	kobject_register(&disk->kobj);
+	kobject_add(&disk->kobj);
 	disk_sysfs_symlinks(disk);
 
 	if (disk->flags & GENHD_FL_CD)
@@ -529,8 +528,7 @@
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
 		put_device(disk->driverfs_dev);
 	}
-	kobject_get(&disk->kobj);	/* kobject model is fucked in head */
-	kobject_unregister(&disk->kobj);
+	kobject_del(&disk->kobj);
 }
 
 struct dev_name {

