Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267925AbRGXQZL>; Tue, 24 Jul 2001 12:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267931AbRGXQZC>; Tue, 24 Jul 2001 12:25:02 -0400
Received: from c1399491-a.hlndpk1.il.home.com ([24.14.108.88]:50425 "EHLO
	stompy.outflux.net") by vger.kernel.org with ESMTP
	id <S267925AbRGXQYp>; Tue, 24 Jul 2001 12:24:45 -0400
Date: Tue, 24 Jul 2001 11:24:51 -0500
From: Kees Cook <linux-kernel@outflux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add "autorun" interface to md
Message-ID: <20010724112451.B6287@cpoint.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I sent this to the linux-raid list, but the list appears dead?  I guess
I'll go here instead.  Flame me nicely if I should send it elsewhere.  :)

After boot-up (or as a module) the "md" driver has no interface to run the 
"autostart_arrays" function.  In the case of removable disks (eg USB, or 
in my case, FireWire), since the disks may not appear in the same place, 
or in the same order, the standard raidtools' "raidstart" will not work 
(calling the md.c "raidstart" interface) because the device names don't 
match up.

While I have this sneaking worry that md's persistant superblock may be
the part of this design that needs adjusting, the existing code lacks an
interface to the "autorun" feature available during boot time.  The
interface I've made depends on the user to hand md.c the partitions to use
for the auto-starting (normally this is done by the "partitions" code).

I'm not sure if this is done properly (we used the proc interface example 
from /proc/scsi/scsi), but I'd like to at least start a discussion so I 
can autorun my removable raid the "right" way.  ;)

Thanks go to Aaron Botsis who got me started by writing the proc-write
skeleton while I was agonizing over how to parse the input.

For reference, this would auto-run a raid on the sdd1, sde1, sdf1, 
sdg1 partitions:

echo "autorun 8:49 8:65 8:81 8:97" > /proc/mdstat


---begin---
--- linux-2.4.7/drivers/md/md.orig.c	Wed Jul 18 09:32:13 2001
+++ linux-2.4.7/drivers/md/md.c	Sat Jul 21 09:19:35 2001
@@ -52,6 +52,11 @@
 #define MAJOR_NR MD_MAJOR
 #define MD_DRIVER
 
+#define PROC_BLOCK_SIZE (3*1024)     /* 4K page size, but our output routines
+                                      * use some slack for overruns
+                                      */
+
+
 #include <linux/blk.h>
 
 #define DEBUG 0
@@ -61,9 +66,7 @@
 # define dprintk(x...) do { } while(0)
 #endif
 
-#ifndef MODULE
 static void autostart_arrays (void);
-#endif
 
 static mdk_personality_t *pers[MAX_PERSONALITY];
 
@@ -1086,8 +1089,10 @@
 	mdk_rdev_t *rdev;
 	unsigned int size;
 
-	if (find_rdev_all(newdev))
+	if (find_rdev_all(newdev)) {
+		printk("find_rdev_all failed for %s!\n", partition_name(newdev));
 		return -EEXIST;
+	}
 
 	rdev = (mdk_rdev_t *) kmalloc(sizeof(*rdev), GFP_KERNEL);
 	if (!rdev) {
@@ -1103,8 +1108,10 @@
 		goto abort_free;
 	}
 
-	if ((err = alloc_disk_sb(rdev)))
+	if ((err = alloc_disk_sb(rdev))) {
+		printk("alloc_disk_sb failed for %s!\n", partition_name(newdev));
 		goto abort_free;
+	}
 
 	rdev->dev = newdev;
 	if (lock_rdev(rdev)) {
@@ -1721,15 +1728,15 @@
 #define STILL_MOUNTED KERN_WARNING \
 "md: md%d still mounted.\n"
 #define	STILL_IN_USE \
-"md: md%d still in use.\n"
+"md: md%d still in use(%d).\n"
 
 static int do_md_stop (mddev_t * mddev, int ro)
 {
-	int err = 0, resync_interrupted = 0;
+	int active, err = 0, resync_interrupted = 0;
 	kdev_t dev = mddev_to_kdev(mddev);
 
- 	if (atomic_read(&mddev->active)>1) {
- 		printk(STILL_IN_USE, mdidx(mddev));
+ 	if ((active=atomic_read(&mddev->active))>1) {
+ 		printk(STILL_IN_USE, mdidx(mddev), active);
  		OUT(-EBUSY);
  	}
 
@@ -2777,6 +2784,7 @@
 static int md_release (struct inode *inode, struct file * file)
 {
 	mddev_t *mddev = kdev_to_mddev(inode->i_rdev);
+
 	if (mddev)
 		atomic_dec(&mddev->active);
 	return 0;
@@ -3038,6 +3046,53 @@
 	return sz;
 }
 
+static int md_status_write_proc(struct file *file, const char *buf,
+				unsigned long count, void *data)
+{
+	char *page;
+	char *ptr;
+	
+	if (count > PROC_BLOCK_SIZE) 
+	 return -EOVERFLOW;
+	
+	if (!(page=(char *) __get_free_page(GFP_KERNEL)))
+	 return -ENOMEM;
+	
+	copy_from_user(page, buf, count);
+
+
+	if (count > 0 && page[count-1]=='\n') {
+		page[count-1]='\0';
+	}
+	else return -EINVAL;
+
+	if (count<11)
+	 return -EINVAL;
+
+	if (!strncmp("autorun ",page,8)) {
+		char * devstr;
+		char * major, * minor;
+		int dev;
+
+		ptr=page+8;
+
+		while ((devstr=strsep(&ptr," \n"))) {
+			printk("md: adding %s...\n",devstr);
+			major=strsep(&devstr,":");
+			minor=strsep(&devstr,":");
+
+			dev=MKDEV(simple_strtoul(major,NULL,0),
+				  simple_strtoul(minor,NULL,0));
+			md_autodetect_dev(dev);
+		}
+
+		autostart_arrays();
+	}
+
+
+	free_page((ulong) page);
+	return count;
+}
 static int md_status_read_proc(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
@@ -3489,6 +3544,7 @@
 static void md_geninit (void)
 {
 	int i;
+	struct proc_dir_entry *p;
 
 	for(i = 0; i < MAX_MD_DEVS; i++) {
 		md_blocksizes[i] = 1024;
@@ -3504,7 +3560,8 @@
 	dprintk("md: sizeof(mdp_super_t) = %d\n", (int)sizeof(mdp_super_t));
 
 #ifdef CONFIG_PROC_FS
-	create_proc_read_entry("mdstat", 0, NULL, md_status_read_proc, NULL);
+	p=create_proc_read_entry("mdstat", 0, NULL, md_status_read_proc, NULL);
+	p->write_proc=md_status_write_proc;
 #endif
 }
 
@@ -3553,8 +3610,6 @@
 }
 
 
-#ifndef MODULE
-
 /*
  * When md (and any require personalities) are compiled into the kernel
  * (not a module), arrays can be assembles are boot time using with AUTODETECT
@@ -3617,6 +3672,7 @@
 	autorun_devices(-1);
 }
 
+#ifndef MODULE
 static struct {
 	char device_set [MAX_MD_DEVS];
 	int pers[MAX_MD_DEVS];
---end---



-- 
Kees Cook                                            @outflux.net
