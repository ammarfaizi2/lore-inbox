Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287181AbRL2JDy>; Sat, 29 Dec 2001 04:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287169AbRL2JDs>; Sat, 29 Dec 2001 04:03:48 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:4305 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S287174AbRL2JDh>; Sat, 29 Dec 2001 04:03:37 -0500
Date: Sat, 29 Dec 2001 04:03:35 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Patch for sd_init() failures in 2.4.
Message-ID: <20011229040334.A29220@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three things
 * kfree(sd_gendisks) when it points to static data
 * rscsi_disks is used as flag, but we forget to clean it
 * if ->init() fails the attached flag cannot be undone

-- Pete

diff -ur -X dontdiff linux-2.4.18-pre1/drivers/scsi/hosts.c linux-2.4.18-pre1-p3/drivers/scsi/hosts.c
--- linux-2.4.18-pre1/drivers/scsi/hosts.c	Thu Jul  5 11:28:17 2001
+++ linux-2.4.18-pre1-p3/drivers/scsi/hosts.c	Fri Dec 28 22:52:11 2001
@@ -275,6 +275,24 @@
     return 0;
 }
 
+void
+scsi_deregister_device(struct Scsi_Device_Template * tpnt)
+{
+    struct Scsi_Device_Template *spnt;
+    struct Scsi_Device_Template *prev_spnt;
+
+    spnt = scsi_devicelist;
+    prev_spnt = NULL;
+    while (spnt != tpnt) {
+	prev_spnt = spnt;
+	spnt = spnt->next;
+    }
+    if (prev_spnt == NULL)
+        scsi_devicelist = tpnt->next;
+    else
+        prev_spnt->next = spnt->next;
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -ur -X dontdiff linux-2.4.18-pre1/drivers/scsi/hosts.h linux-2.4.18-pre1-p3/drivers/scsi/hosts.h
--- linux-2.4.18-pre1/drivers/scsi/hosts.h	Thu Nov 22 11:49:15 2001
+++ linux-2.4.18-pre1-p3/drivers/scsi/hosts.h	Fri Dec 28 22:52:11 2001
@@ -526,6 +526,7 @@
 void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt);
 
 int scsi_register_device(struct Scsi_Device_Template * sdpnt);
+void scsi_deregister_device(struct Scsi_Device_Template * tpnt);
 
 /* These are used by loadable modules */
 extern int scsi_register_module(int, void *);
diff -ur -X dontdiff linux-2.4.18-pre1/drivers/scsi/scsi.c linux-2.4.18-pre1-p3/drivers/scsi/scsi.c
--- linux-2.4.18-pre1/drivers/scsi/scsi.c	Fri Dec 21 09:41:55 2001
+++ linux-2.4.18-pre1-p3/drivers/scsi/scsi.c	Fri Dec 28 22:52:11 2001
@@ -2261,7 +2261,7 @@
 		for (SDpnt = shpnt->host_queue; SDpnt;
 		     SDpnt = SDpnt->next) {
 			if (tpnt->detect)
-				SDpnt->attached += (*tpnt->detect) (SDpnt);
+				SDpnt->detected = (*tpnt->detect) (SDpnt);
 		}
 	}
 
@@ -2269,9 +2269,19 @@
 	 * If any of the devices would match this driver, then perform the
 	 * init function.
 	 */
-	if (tpnt->init && tpnt->dev_noticed)
-		if ((*tpnt->init) ())
+	if (tpnt->init && tpnt->dev_noticed) {
+		if ((*tpnt->init) ()) {
+			for (shpnt = scsi_hostlist; shpnt;
+			     shpnt = shpnt->next) {
+				for (SDpnt = shpnt->host_queue; SDpnt;
+				     SDpnt = SDpnt->next) {
+					SDpnt->detected = 0;
+				}
+			}
+			scsi_deregister_device(tpnt);
 			return 1;
+		}
+	}
 
 	/*
 	 * Now actually connect the devices to the new driver.
@@ -2279,6 +2289,8 @@
 	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
 		for (SDpnt = shpnt->host_queue; SDpnt;
 		     SDpnt = SDpnt->next) {
+			SDpnt->attached += SDpnt->detected;
+			SDpnt->detected = 0;
 			if (tpnt->attach)
 				(*tpnt->attach) (SDpnt);
 			/*
@@ -2314,9 +2326,7 @@
 {
 	Scsi_Device *SDpnt;
 	struct Scsi_Host *shpnt;
-	struct Scsi_Device_Template *spnt;
-	struct Scsi_Device_Template *prev_spnt;
-	
+
 	lock_kernel();
 	/*
 	 * If we are busy, this is not going to fly.
@@ -2347,16 +2357,7 @@
 	/*
 	 * Extract the template from the linked list.
 	 */
-	spnt = scsi_devicelist;
-	prev_spnt = NULL;
-	while (spnt != tpnt) {
-		prev_spnt = spnt;
-		spnt = spnt->next;
-	}
-	if (prev_spnt == NULL)
-		scsi_devicelist = tpnt->next;
-	else
-		prev_spnt->next = spnt->next;
+	scsi_deregister_device(tpnt);
 
 	MOD_DEC_USE_COUNT;
 	unlock_kernel();
diff -ur -X dontdiff linux-2.4.18-pre1/drivers/scsi/scsi.h linux-2.4.18-pre1-p3/drivers/scsi/scsi.h
--- linux-2.4.18-pre1/drivers/scsi/scsi.h	Thu Nov 22 11:49:15 2001
+++ linux-2.4.18-pre1-p3/drivers/scsi/scsi.h	Fri Dec 28 22:52:11 2001
@@ -575,8 +575,8 @@
 					 * vendor-specific cmd's */
 	unsigned sector_size;	/* size in bytes */
 
-	int attached;		/* # of high level drivers attached to 
-				 * this */
+	int attached;		/* # of high level drivers attached to this */
+	int detected;		/* Delta attached - don't use in drivers! */
 	int access_count;	/* Count of open channels/mounts */
 
 	void *hostdata;		/* available to low-level driver */
diff -ur -X dontdiff linux-2.4.18-pre1/drivers/scsi/sd.c linux-2.4.18-pre1-p3/drivers/scsi/sd.c
--- linux-2.4.18-pre1/drivers/scsi/sd.c	Fri Nov  9 14:05:06 2001
+++ linux-2.4.18-pre1-p3/drivers/scsi/sd.c	Fri Dec 28 22:52:11 2001
@@ -1078,6 +1078,7 @@
 		for (i = 0; i < N_USED_SD_MAJORS; i++) {
 			if (devfs_register_blkdev(SD_MAJOR(i), "sd", &sd_fops)) {
 				printk("Unable to get major %d for SCSI disk\n", SD_MAJOR(i));
+				sd_template.dev_noticed = 0;
 				return 1;
 			}
 		}
@@ -1175,7 +1176,8 @@
 		kfree(sd_gendisks[i].de_arr);
 		kfree(sd_gendisks[i].flags);
 	}
-	kfree(sd_gendisks);
+	if (sd_gendisks != &sd_gendisk)
+		kfree(sd_gendisks);
 cleanup_sd_gendisks:
 	kfree(sd);
 cleanup_sd:
@@ -1188,11 +1190,13 @@
 	kfree(sd_sizes);
 cleanup_disks:
 	kfree(rscsi_disks);
+	rscsi_disks = NULL;
 cleanup_devfs:
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
 		devfs_unregister_blkdev(SD_MAJOR(i), "sd");
 	}
 	sd_registered--;
+	sd_template.dev_noticed = 0;
 	return 1;
 }
 
@@ -1251,7 +1255,7 @@
 	if (SDp->type != TYPE_DISK && SDp->type != TYPE_MOD)
 		return 0;
 
-	if (sd_template.nr_dev >= sd_template.dev_max) {
+	if (sd_template.nr_dev >= sd_template.dev_max || rscsi_disks == NULL) {
 		SDp->attached--;
 		return 1;
 	}
@@ -1259,8 +1263,13 @@
 		if (!dpnt->device)
 			break;
 
-	if (i >= sd_template.dev_max)
-		panic("scsi_devices corrupt (sd)");
+	if (i >= sd_template.dev_max) {
+		printk(KERN_WARNING "scsi_devices corrupt (sd),"
+		    " nr_dev %d dev_max %d\n",
+		    sd_template.nr_dev, sd_template.dev_max);
+		SDp->attached--;
+		return 1;
+	}
 
 	rscsi_disks[i].device = SDp;
 	rscsi_disks[i].has_part_table = 0;
@@ -1347,6 +1356,9 @@
 	int i, j;
 	int max_p;
 	int start;
+
+	if (rscsi_disks == NULL)
+		return;
 
 	for (dpnt = rscsi_disks, i = 0; i < sd_template.dev_max; i++, dpnt++)
 		if (dpnt->device == SDp) {
diff -ur -X dontdiff linux-2.4.18-pre1/drivers/scsi/sg.c linux-2.4.18-pre1-p3/drivers/scsi/sg.c
--- linux-2.4.18-pre1/drivers/scsi/sg.c	Fri Dec 21 09:41:55 2001
+++ linux-2.4.18-pre1-p3/drivers/scsi/sg.c	Fri Dec 28 22:52:11 2001
@@ -1344,6 +1344,7 @@
             printk(KERN_ERR "Unable to get major %d for generic SCSI device\n",
                    SCSI_GENERIC_MAJOR);
 	    write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+            sg_template.dev_noticed = 0;
             return 1;
         }
         sg_registered++;
@@ -1356,6 +1357,7 @@
     if (NULL == sg_dev_arr) {
         printk(KERN_ERR "sg_init: no space for sg_dev_arr\n");
 	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+        sg_template.dev_noticed = 0;
         return 1;
     }
     memset(sg_dev_arr, 0, sg_template.dev_max * sizeof(Sg_device *));
diff -ur -X dontdiff linux-2.4.18-pre1/drivers/scsi/sr.c linux-2.4.18-pre1-p3/drivers/scsi/sr.c
--- linux-2.4.18-pre1/drivers/scsi/sr.c	Thu Oct 25 13:58:35 2001
+++ linux-2.4.18-pre1-p3/drivers/scsi/sr.c	Fri Dec 28 22:52:11 2001
@@ -789,6 +789,7 @@
 	if (!sr_registered) {
 		if (devfs_register_blkdev(MAJOR_NR, "sr", &sr_bdops)) {
 			printk("Unable to get major %d for SCSI-CD\n", MAJOR_NR);
+			sr_template.dev_noticed = 0;
 			return 1;
 		}
 		sr_registered++;
@@ -830,8 +831,10 @@
 	kfree(sr_sizes);
 cleanup_cds:
 	kfree(scsi_CDs);
+	scsi_CDs = NULL;
 cleanup_devfs:
 	devfs_unregister_blkdev(MAJOR_NR, "sr");
+	sr_template.dev_noticed = 0;
 	sr_registered--;
 	return 1;
 }
@@ -905,6 +908,8 @@
 	Scsi_CD *cpnt;
 	int i;
 
+	if (scsi_CDs == NULL)
+		return;
 	for (cpnt = scsi_CDs, i = 0; i < sr_template.dev_max; i++, cpnt++)
 		if (cpnt->device == SDp) {
 			/*
diff -ur -X dontdiff linux-2.4.18-pre1/drivers/scsi/st.c linux-2.4.18-pre1-p3/drivers/scsi/st.c
--- linux-2.4.18-pre1/drivers/scsi/st.c	Fri Nov  9 13:52:21 2001
+++ linux-2.4.18-pre1-p3/drivers/scsi/st.c	Fri Dec 28 22:52:11 2001
@@ -3818,6 +3818,7 @@
 			write_unlock_irqrestore(&st_dev_arr_lock, flags);
 			printk(KERN_ERR "Unable to get major %d for SCSI tapes\n",
                                MAJOR_NR);
+			st_template.dev_noticed = 0;
 			return 1;
 		}
 		st_registered++;
