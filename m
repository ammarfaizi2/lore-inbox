Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUAXUX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 15:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUAXUX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 15:23:29 -0500
Received: from fep21-0.kolumbus.fi ([193.229.0.48]:41895 "EHLO
	fep21-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261298AbUAXUXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 15:23:18 -0500
Date: Sat, 24 Jan 2004 22:23:12 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Darren Dupre <darren@dmdtech.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 Oops when attempting to access /dev/st0 without st module
 loaded
In-Reply-To: <002e01c3e2b1$6414f650$1e01a8c0@dmdtech2>
Message-ID: <Pine.LNX.4.58.0401242210210.9128@kai.makisara.local>
References: <002e01c3e2b1$6414f650$1e01a8c0@dmdtech2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jan 2004, Darren Dupre wrote:

> I was about to do a tape backup, so I did the following:
> 
> modprobe advansys (automaticaly loads scsi_mod first)
> 
> tar --exclude=/sys --exclude=/proc --exclude=/mnt -cvf /dev/st0 /
> which results in a segmentation fault as soon as tar is executed.
> 
> If I load the st module and try to backup, it says no such device
> 
> I believe it did this because I forgot to modprobe st (shouldn't it be done
> automatically?) which I normally do but forgot to do this time around. I
> keep all this stuff as modules becuase I like to be able to unhook the tape
> drive and use it on other machines without having to reboot.
> 
Have you loaded and unloaded the module after booting the kernel but 
before this has happened? If you have, the patch at the end of this 
message should help. (This is the same patch posted to linux-scsi earlier 
today).

The problem is that st_remove() did not call cdev_umap() before 
cdev_del(). The device was deleted but it was left in a list where chrdev_open()
finds this non-existing device.

If you have not loaded and unloaded the st module after reboot, then you 
have another problem.

(The patch is against 2.6.2-rc1 but it should apply also to 2.6.1. It also 
solves the "sleeping function called from invalid context" bug.)

-- 
Kai
---------------------------------------8<--------------------------------------
--- linux-2.6.2-rc1/drivers/scsi/st.c	2004-01-20 20:16:20.000000000 +0200
+++ linux-2.6.2-rc1-k1/drivers/scsi/st.c	2004-01-22 23:16:04.000000000 +0200
@@ -9,7 +9,7 @@
    Steve Hirsch, Andreas Koppenh"ofer, Michael Leodolter, Eyal Lebedinsky,
    Michael Schaefer, J"org Weule, and Eric Youngdale.
 
-   Copyright 1992 - 2003 Kai Makisara
+   Copyright 1992 - 2004 Kai Makisara
    email Kai.Makisara@kolumbus.fi
 
    Some small formal changes - aeb, 950809
@@ -17,7 +17,7 @@
    Last modified: 18-JAN-1998 Richard Gooch <rgooch@atnf.csiro.au> Devfs support
  */
 
-static char *verstr = "20031228";
+static char *verstr = "20040122";
 
 #include <linux/module.h>
 
@@ -3846,27 +3846,53 @@
 		STm->default_compression = ST_DONT_TOUCH;
 		STm->default_blksize = (-1);	/* No forced size */
 		STm->default_density = (-1);	/* No forced density */
+	}
+
+	for (i = 0; i < ST_NBR_PARTITIONS; i++) {
+		STps = &(tpnt->ps[i]);
+		STps->rw = ST_IDLE;
+		STps->eof = ST_NOEOF;
+		STps->at_sm = 0;
+		STps->last_block_valid = FALSE;
+		STps->drv_block = (-1);
+		STps->drv_file = (-1);
+	}
+
+	tpnt->current_mode = 0;
+	tpnt->modes[0].defined = TRUE;
 
+	tpnt->density_changed = tpnt->compression_changed =
+	    tpnt->blksize_changed = FALSE;
+	init_MUTEX(&tpnt->lock);
+
+	st_nr_dev++;
+	write_unlock(&st_dev_arr_lock);
+
+	for (mode = 0; mode < ST_NBR_MODES; ++mode) {
+		STm = &(tpnt->modes[mode]);
 		for (j=0; j < 2; j++) {
 			cdev = cdev_alloc();
 			if (!cdev) {
 				printk(KERN_ERR
-				       "st: out of memory. Device not attached.\n");
-				goto out_put_disk;
+				       "st%d: out of memory. Device not attached.\n",
+				       dev_num);
+				goto out_free_tape;
 			}
 			snprintf(cdev->kobj.name, KOBJ_NAME_LEN, "%sm%d%s", disk->disk_name,
-				 i, j ? "n" : "");
+				 mode, j ? "n" : "");
 			cdev->owner = THIS_MODULE;
 			cdev->ops = &st_fops;
-			STm->cdevs[j] = cdev;
 
-			error = cdev_add(STm->cdevs[j],
-					 MKDEV(SCSI_TAPE_MAJOR, TAPE_MINOR(dev_num, i, j)),
+			error = cdev_add(cdev,
+					 MKDEV(SCSI_TAPE_MAJOR, TAPE_MINOR(dev_num, mode, j)),
 					 1);
 			if (error) {
 				printk(KERN_ERR "st%d: Can't add %s-rewind mode %d\n",
-				       dev_num, j ? "non" : "auto", i);
+				       dev_num, j ? "non" : "auto", mode);
+				printk(KERN_ERR "st%d: Device not attached.\n", dev_num);
+				goto out_free_tape;
 			}
+			STm->cdevs[j] = cdev;
 
 			error = sysfs_create_link(&STm->cdevs[j]->kobj, &SDp->sdev_gendev.kobj,
 						  "device");
@@ -3884,35 +3910,15 @@
 		       dev_num);
 	}
 
-	for (i = 0; i < ST_NBR_PARTITIONS; i++) {
-		STps = &(tpnt->ps[i]);
-		STps->rw = ST_IDLE;
-		STps->eof = ST_NOEOF;
-		STps->at_sm = 0;
-		STps->last_block_valid = FALSE;
-		STps->drv_block = (-1);
-		STps->drv_file = (-1);
-	}
-
-	tpnt->current_mode = 0;
-	tpnt->modes[0].defined = TRUE;
-
-	tpnt->density_changed = tpnt->compression_changed =
-	    tpnt->blksize_changed = FALSE;
-	init_MUTEX(&tpnt->lock);
-
-	st_nr_dev++;
-	write_unlock(&st_dev_arr_lock);
-
 	for (mode = 0; mode < ST_NBR_MODES; ++mode) {
-	    /*  Rewind entry  */
-	    devfs_mk_cdev(MKDEV(SCSI_TAPE_MAJOR, dev_num + (mode << 5)),
-				S_IFCHR | S_IRUGO | S_IWUGO,
-				"%s/mt%s", SDp->devfs_name, st_formats[mode]);
-	    /*  No-rewind entry  */
-	    devfs_mk_cdev(MKDEV(SCSI_TAPE_MAJOR, dev_num + (mode << 5) + 128),
-				S_IFCHR | S_IRUGO | S_IWUGO,
-				"%s/mt%sn", SDp->devfs_name, st_formats[mode]);
+		/*  Rewind entry  */
+		devfs_mk_cdev(MKDEV(SCSI_TAPE_MAJOR, dev_num + (mode << 5)),
+			      S_IFCHR | S_IRUGO | S_IWUGO,
+			      "%s/mt%s", SDp->devfs_name, st_formats[mode]);
+		/*  No-rewind entry  */
+		devfs_mk_cdev(MKDEV(SCSI_TAPE_MAJOR, dev_num + (mode << 5) + 128),
+			      S_IFCHR | S_IRUGO | S_IWUGO,
+			      "%s/mt%sn", SDp->devfs_name, st_formats[mode]);
 	}
 	disk->number = devfs_register_tape(SDp->devfs_name);
 
@@ -3924,18 +3930,30 @@
 
 	return 0;
 
+out_free_tape:
+	for (mode=0; mode < ST_NBR_MODES; mode++) {
+		STm = &(tpnt->modes[mode]);
+		for (j=0; j < 2; j++) {
+			if (STm->cdevs[j]) {
+				if (cdev == STm->cdevs[j])
+					cdev = NULL;
+				sysfs_remove_link(&STm->cdevs[j]->kobj, "device");
+				cdev_unmap(MKDEV(SCSI_TAPE_MAJOR,
+						 TAPE_MINOR(dev_num, mode, j)), 1);
+				cdev_del(STm->cdevs[j]);
+			}
+		}
+	}
+	if (cdev)
+		kobject_put(&cdev->kobj);
+	write_lock(&st_dev_arr_lock);
+	scsi_tapes[dev_num] = NULL;
+	st_nr_dev--;
+	write_unlock(&st_dev_arr_lock);
 out_put_disk:
 	put_disk(disk);
-	if (tpnt) {
-		for (i=0; i < ST_NBR_MODES; i++) {
-			STm = &(tpnt->modes[i]);
-			if (STm->cdevs[0])
-				kobject_put(&STm->cdevs[0]->kobj);
-			if (STm->cdevs[1])
-				kobject_put(&STm->cdevs[1]->kobj);
-		}
+	if (tpnt)
 		kfree(tpnt);
-	}
 out_buffer_free:
 	kfree(buffer);
 out:
@@ -3964,6 +3982,8 @@
 				for (j=0; j < 2; j++) {
 					sysfs_remove_link(&tpnt->modes[mode].cdevs[j]->kobj,
 							  "device");
+					cdev_unmap(MKDEV(SCSI_TAPE_MAJOR,
+							 TAPE_MINOR(i, mode, j)), 1);
 					cdev_del(tpnt->modes[mode].cdevs[j]);
 					tpnt->modes[mode].cdevs[j] = NULL;
 				}
