Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285983AbRLHV4m>; Sat, 8 Dec 2001 16:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285982AbRLHV4Y>; Sat, 8 Dec 2001 16:56:24 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:46654 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S285981AbRLHV4J>; Sat, 8 Dec 2001 16:56:09 -0500
Date: Sat, 8 Dec 2001 16:56:07 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200112082156.fB8Lu7g00441@devserv.devel.redhat.com>
To: Andries.Brouwer@cwi.nl
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Would the father of init_mem_lth please stand up
In-Reply-To: <mailman.1007844368.15393.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1007844368.15393.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And then, my beautiful code is not at all crap that should not
> have been applied. It fixes a real bug. But there was another bug
> there that it left, namely that the freed pointers should have been
> zeroed, so that nobody can come and use them with random results.
> If nobody else does it, I'll send also that small fix, but maybe
> not today.

Look at this, just a food for thought - once we start zeroing
rscsi_disks, it starts popping up in places. You don't need to
do it exactly this way, of course.

------------------------------------------------
* kfree(static) in sd.c.
* Fix for sd_init failures: scsi_device.detected; zeroing of xx.dev_noticed.
* "scsi_devices corrupt" == rscsi_disks pointing to kfree-d memory.

diff -ur -X dontdiff linux-2.4.7-10/drivers/scsi/hosts.c linux-2.4.7-10s/drivers/scsi/hosts.c
--- linux-2.4.7-10/drivers/scsi/hosts.c	Thu Jul  5 11:28:17 2001
+++ linux-2.4.7-10s/drivers/scsi/hosts.c	Wed Dec  5 03:32:33 2001
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
diff -ur -X dontdiff linux-2.4.7-10/drivers/scsi/hosts.h linux-2.4.7-10s/drivers/scsi/hosts.h
--- linux-2.4.7-10/drivers/scsi/hosts.h	Fri Jul 20 12:55:46 2001
+++ linux-2.4.7-10s/drivers/scsi/hosts.h	Wed Dec  5 02:47:00 2001
@@ -526,6 +526,7 @@
 void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt);
 
 int scsi_register_device(struct Scsi_Device_Template * sdpnt);
+void scsi_deregister_device(struct Scsi_Device_Template * tpnt);
 
 /* These are used by loadable modules */
 extern int scsi_register_module(int, void *);
diff -ur -X dontdiff linux-2.4.7-10/drivers/scsi/scsi.c linux-2.4.7-10s/drivers/scsi/scsi.c
--- linux-2.4.7-10/drivers/scsi/scsi.c	Sun Oct  7 16:13:41 2001
+++ linux-2.4.7-10s/drivers/scsi/scsi.c	Wed Dec  5 05:15:57 2001
@@ -2227,7 +2227,7 @@
 		for (SDpnt = shpnt->host_queue; SDpnt;
 		     SDpnt = SDpnt->next) {
 			if (tpnt->detect)
-				SDpnt->attached += (*tpnt->detect) (SDpnt);
+				SDpnt->detected = (*tpnt->detect) (SDpnt);
 		}
 	}
 
@@ -2235,9 +2235,19 @@
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
@@ -2245,6 +2255,8 @@
 	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
 		for (SDpnt = shpnt->host_queue; SDpnt;
 		     SDpnt = SDpnt->next) {
+			SDpnt->attached += SDpnt->detected;
+			SDpnt->detected = 0;
 			if (tpnt->attach)
 				(*tpnt->attach) (SDpnt);
 			/*
@@ -2280,9 +2292,7 @@
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
@@ -2313,16 +2323,7 @@
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
diff -ur -X dontdiff linux-2.4.7-10/drivers/scsi/scsi.h linux-2.4.7-10s/drivers/scsi/scsi.h
--- linux-2.4.7-10/drivers/scsi/scsi.h	Sun Oct  7 16:13:41 2001
+++ linux-2.4.7-10s/drivers/scsi/scsi.h	Wed Dec  5 02:35:48 2001
@@ -575,8 +575,8 @@
 					 * vendor-specific cmd's */
 	unsigned sector_size;	/* size in bytes */
 
-	int attached;		/* # of high level drivers attached to 
-				 * this */
+	int attached;		/* # of high level drivers attached to this */
+	int detected;		/* Delta attached - don't use in drivers! */
 	int access_count;	/* Count of open channels/mounts */
 
 	void *hostdata;		/* available to low-level driver */
diff -ur -X dontdiff linux-2.4.7-10/drivers/scsi/sd.c linux-2.4.7-10s/drivers/scsi/sd.c
--- linux-2.4.7-10/drivers/scsi/sd.c	Sun Oct  7 16:13:48 2001
+++ linux-2.4.7-10s/drivers/scsi/sd.c	Wed Dec  5 05:16:34 2001
@@ -575,7 +575,7 @@
         &sd_fops,		/* file operations */
 };
 
-static struct gendisk *sd_gendisks = &sd_gendisk;
+static struct gendisk *sd_gendisks;
 
 #define SD_GENDISK(i)    sd_gendisks[(i) / SCSI_DISKS_PER_MAJOR]
 #define LAST_SD_GENDISK  sd_gendisks[N_USED_SD_MAJORS - 1]
@@ -1064,6 +1064,7 @@
 static int sd_init()
 {
 	int i;
+	int size;
 
 	if (sd_template.dev_noticed == 0)
 		return 0;
@@ -1078,6 +1079,7 @@
 		for (i = 0; i < N_USED_SD_MAJORS; i++) {
 			if (devfs_register_blkdev(SD_MAJOR(i), "sd", &sd_fops)) {
 				printk("Unable to get major %d for SCSI disk\n", SD_MAJOR(i));
+				sd_template.dev_noticed = 0;
 				return 1;
 			}
 		}
@@ -1115,19 +1117,21 @@
 		blksize_size[SD_MAJOR(i)] = sd_blocksizes + i * (SCSI_DISKS_PER_MAJOR << 4);
 		hardsect_size[SD_MAJOR(i)] = sd_hardsizes + i * (SCSI_DISKS_PER_MAJOR << 4);
 	}
-	sd = kmalloc((sd_template.dev_max << 4) *
-					  sizeof(struct hd_struct),
-					  GFP_ATOMIC);
-	if (!sd)
+	/* This array may be _enormous_, so no GFP_ATOMIC */
+	size = (sd_template.dev_max << 4) * sizeof(struct hd_struct);
+	if (!(sd = kmalloc(size, GFP_KERNEL))) {
+		printk(KERN_ERR "sd_init: cannot allocate %d(0x%x) for sd[]\n",
+		    size, size);
 		goto cleanup_sd;
-	memset(sd, 0, (sd_template.dev_max << 4) * sizeof(struct hd_struct));
+	}
+	memset(sd, 0, size);
+
+	sd_gendisks = kmalloc(N_USED_SD_MAJORS * sizeof(struct gendisk), GFP_ATOMIC);
+	if (!sd_gendisks)
+		goto cleanup_sd_gendisks;
 
-	if (N_USED_SD_MAJORS > 1)
-		sd_gendisks = kmalloc(N_USED_SD_MAJORS * sizeof(struct gendisk), GFP_ATOMIC);
-		if (!sd_gendisks)
-			goto cleanup_sd_gendisks;
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
-		sd_gendisks[i] = sd_gendisk;
+		sd_gendisks[i] = sd_gendisk;	/* <-- memcpy */
 		sd_gendisks[i].de_arr = kmalloc (SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].de_arr,
                                                  GFP_ATOMIC);
 		if (!sd_gendisks[i].de_arr)
@@ -1142,8 +1146,6 @@
                         SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].flags);
 		sd_gendisks[i].major = SD_MAJOR(i);
 		sd_gendisks[i].major_name = "sd";
-		sd_gendisks[i].minor_shift = 4;
-		sd_gendisks[i].max_p = 1 << 4;
 		sd_gendisks[i].part = sd + (i * SCSI_DISKS_PER_MAJOR << 4);
 		sd_gendisks[i].sizes = sd_sizes + (i * SCSI_DISKS_PER_MAJOR << 4);
 		sd_gendisks[i].nr_real = 0;
@@ -1163,6 +1165,7 @@
 		kfree(sd_gendisks[i].flags);
 	}
 	kfree(sd_gendisks);
+	sd_gendisks = NULL;	/* Was super-buggy code, catch early. */
 cleanup_sd_gendisks:
 	kfree(sd);
 cleanup_sd:
@@ -1173,11 +1176,13 @@
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
 
@@ -1242,7 +1247,7 @@
 	if (SDp->type != TYPE_DISK && SDp->type != TYPE_MOD)
 		return 0;
 
-	if (sd_template.nr_dev >= sd_template.dev_max) {
+	if (sd_template.nr_dev >= sd_template.dev_max || rscsi_disks == NULL) {
 		SDp->attached--;
 		return 1;
 	}
@@ -1250,8 +1255,13 @@
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
@@ -1296,8 +1306,8 @@
 	}
 	DEVICE_BUSY = 1;
 
-	max_p = sd_gendisks->max_p;
-	start = target << sd_gendisks->minor_shift;
+	max_p = sd_gendisk.max_p;
+	start = target << sd_gendisk.minor_shift;
 
 	for (i = max_p - 1; i >= 0; i--) {
 		int index = start + i;
@@ -1339,6 +1349,9 @@
 	int max_p;
 	int start;
 
+	if (rscsi_disks == NULL)
+		return;
+
 	for (dpnt = rscsi_disks, i = 0; i < sd_template.dev_max; i++, dpnt++)
 		if (dpnt->device == SDp) {
 
@@ -1356,7 +1369,6 @@
 			}
                         devfs_register_partitions (&SD_GENDISK (i),
                                                    SD_MINOR_NUMBER (start), 1);
-			/* unregister_disk() */
 			dpnt->has_part_table = 0;
 			dpnt->device = NULL;
 			dpnt->capacity = 0;
@@ -1419,8 +1431,7 @@
 		read_ahead[SD_MAJOR(i)] = 0;
 	}
 	sd_template.dev_max = 0;
-	if (sd_gendisks != &sd_gendisk)
-		kfree(sd_gendisks);
+	kfree(sd_gendisks);
 }
 
 module_init(init_sd);
diff -ur -X dontdiff linux-2.4.7-10/drivers/scsi/sg.c linux-2.4.7-10s/drivers/scsi/sg.c
--- linux-2.4.7-10/drivers/scsi/sg.c	Wed Jul  4 15:39:28 2001
+++ linux-2.4.7-10s/drivers/scsi/sg.c	Wed Dec  5 02:59:14 2001
@@ -1170,6 +1170,7 @@
             printk("Unable to get major %d for generic SCSI device\n",
                    SCSI_GENERIC_MAJOR);
 	    write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+            sg_template.dev_noticed = 0;
             return 1;
         }
         sg_registered++;
@@ -1182,6 +1183,7 @@
     if (NULL == sg_dev_arr) {
         printk("sg_init: no space for sg_dev_arr\n");
 	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+        sg_template.dev_noticed = 0;
         return 1;
     }
     memset(sg_dev_arr, 0, sg_template.dev_max * sizeof(Sg_device *));
diff -ur -X dontdiff linux-2.4.7-10/drivers/scsi/sr.c linux-2.4.7-10s/drivers/scsi/sr.c
--- linux-2.4.7-10/drivers/scsi/sr.c	Sun Oct  7 16:13:49 2001
+++ linux-2.4.7-10s/drivers/scsi/sr.c	Wed Dec  5 04:59:22 2001
@@ -768,6 +768,7 @@
 	if (!sr_registered) {
 		if (devfs_register_blkdev(MAJOR_NR, "sr", &cdrom_fops)) {
 			printk("Unable to get major %d for SCSI-CD\n", MAJOR_NR);
+			sr_template.dev_noticed = 0;
 			return 1;
 		}
 		sr_registered++;
@@ -809,8 +810,10 @@
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
@@ -884,6 +887,8 @@
 	Scsi_CD *cpnt;
 	int i;
 
+	if (scsi_CDs == NULL)
+		return;
 	for (cpnt = scsi_CDs, i = 0; i < sr_template.dev_max; i++, cpnt++)
 		if (cpnt->device == SDp) {
 			/*
diff -ur -X dontdiff linux-2.4.7-10/drivers/scsi/st.c linux-2.4.7-10s/drivers/scsi/st.c
--- linux-2.4.7-10/drivers/scsi/st.c	Sun Oct  7 16:13:48 2001
+++ linux-2.4.7-10s/drivers/scsi/st.c	Wed Dec  5 02:58:27 2001
@@ -3722,6 +3722,7 @@
 			write_unlock_irqrestore(&st_dev_arr_lock, flags);
 			printk(KERN_ERR "Unable to get major %d for SCSI tapes\n",
                                MAJOR_NR);
+			st_template.dev_noticed = 0;
 			return 1;
 		}
 		st_registered++;
