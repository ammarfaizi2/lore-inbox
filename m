Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSKWMPO>; Sat, 23 Nov 2002 07:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbSKWMPO>; Sat, 23 Nov 2002 07:15:14 -0500
Received: from angband.namesys.com ([212.16.7.85]:10631 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265246AbSKWMPN>; Sat, 23 Nov 2002 07:15:13 -0500
Date: Sat, 23 Nov 2002 15:22:23 +0300
From: Oleg Drokin <green@namesys.com>
To: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Problem in using kobjects for block devices and partitions
Message-ID: <20021123152223.A17314@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Problem code is in register_disk, and though it was included at the end of
   November, but problems started to appear very recently.

   At the beginning of register_disk() we see this snippet:

           s = strchr(disk->kobj.name, '/');
           if (s)
                   *s = '!';
           kobject_register(&disk->kobj);
           disk_sysfs_symlinks(disk);

   And now kobject_register() frees disk structure if registration was
   unsuccesful, so doing anything else with this structure is not very
   nice thing. This is especially observable if you turn on SLAB poisoning,
   then it will die during disk_sysfs_symlinks (actually two levels deeper).

   I think here we should at least check return value of kobject_register
   and print something useful. This won't help much against crashing since
   accessing /proc/partition afterwards will still kill the box (in case
   of SLAB poisoning, otherwise some other unpredictable stuff will happen).

   It seems that making register_disk() to return error back to caller
   does not makes much sence either, since struct gendisk is already destroyed
   and we cannot get it off the lists that easily.

   May be it was just a bad decision to destroy whole structure of underlying
   object when kobject creation have failed? 

   Anyway at least below patch is a good thing to easy problem diagnostics
   when kobject_register() fails during registering block devices (e.g. because
   some of them have same base name).
   
Bye,
    Oleg

===== fs/partitions/check.c 1.88 vs edited =====
--- 1.88/fs/partitions/check.c	Thu Nov 21 06:08:39 2002
+++ edited/fs/partitions/check.c	Sat Nov 23 15:17:28 2002
@@ -400,13 +400,23 @@
 	struct block_device *bdev;
 	char *s;
 	int j;
+	int error;
+	 /* In case of error disk structure will be freed, so we cannot
+	    dereference it. Let's save some useful info so that we can
+	    print meaningful error message. */
+	int minor=disk->first_minor, major=disk->major;
 
 	strncpy(disk->kobj.name,disk->disk_name,KOBJ_NAME_LEN);
 	/* ewww... some of these buggers have / in name... */
 	s = strchr(disk->kobj.name, '/');
 	if (s)
 		*s = '!';
-	kobject_register(&disk->kobj);
+
+	error = kobject_register(&disk->kobj);
+	if ( error ) {
+		printk(KERN_ERR "%s: Failed to create kernel object for disk major %d, first minor %d. Reason: %d\n", __FUNCTION__, major, minor, error );
+		return;
+	}
 	disk_sysfs_symlinks(disk);
 
 	if (disk->flags & GENHD_FL_CD)
