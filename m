Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262598AbSJBVQu>; Wed, 2 Oct 2002 17:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262605AbSJBVQB>; Wed, 2 Oct 2002 17:16:01 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:4828 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262602AbSJBVOv>;
	Wed, 2 Oct 2002 17:14:51 -0400
Date: Wed, 2 Oct 2002 14:21:22 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: akpm@digeo.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       dougg@gear.torque.net
Subject: Re: 2.4.39 "Sleeping function called from illegal context at slab.c:1374"
Message-ID: <20021002212122.GF1317@beaverton.ibm.com>
Mail-Followup-To: akpm@digeo.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, dougg@gear.torque.net
References: <3D99885B.533C320D@aitel.hist.no> <3D99EF62.3A3E6932@digeo.com> <20021001215907.GA8273@midgaard.us> <3D9A207A.14BFF440@digeo.com> <20021002162443.GA1317@beaverton.ibm.com> <20021002184437.GA17474@midgaard.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002184437.GA17474@midgaard.us>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas,
	Here is the updated patch.

-andmike
--
Michael Anderson
andmike@us.ibm.com

 sg.c |   59 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 40 insertions(+), 19 deletions(-)

diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Wed Oct  2 12:19:48 2002
+++ b/drivers/scsi/sg.c	Wed Oct  2 12:19:48 2002
@@ -1354,32 +1354,42 @@
 {
 	static int sg_registered = 0;
 	unsigned long iflags;
+	int tmp_dev_max;
+	Sg_device **tmp_da;
 
 	if ((sg_template.dev_noticed == 0) || sg_dev_arr)
 		return 0;
 
+	SCSI_LOG_TIMEOUT(3, printk("sg_init\n"));
+
 	write_lock_irqsave(&sg_dev_arr_lock, iflags);
+	tmp_dev_max = sg_template.dev_noticed + SG_DEV_ARR_LUMP;
+	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+
+	tmp_da = (Sg_device **)vmalloc(
+				tmp_dev_max * sizeof(Sg_device *));
+	if (NULL == tmp_da) {
+		printk(KERN_ERR "sg_init: no space for sg_dev_arr\n");
+		return 1;
+	}
+	write_lock_irqsave(&sg_dev_arr_lock, iflags);
+
 	if (!sg_registered) {
 		if (register_chrdev(SCSI_GENERIC_MAJOR, "sg", &sg_fops)) {
 			printk(KERN_ERR
 			       "Unable to get major %d for generic SCSI device\n",
 			       SCSI_GENERIC_MAJOR);
 			write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+			vfree((char *) tmp_da);
 			return 1;
 		}
 		sg_registered++;
 	}
 
-	SCSI_LOG_TIMEOUT(3, printk("sg_init\n"));
-	sg_template.dev_max = sg_template.dev_noticed + SG_DEV_ARR_LUMP;
-	sg_dev_arr = (Sg_device **)vmalloc(
-			sg_template.dev_max * sizeof(Sg_device *));
-	if (NULL == sg_dev_arr) {
-		printk(KERN_ERR "sg_init: no space for sg_dev_arr\n");
-		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-		return 1;
-	}
-	memset(sg_dev_arr, 0, sg_template.dev_max * sizeof (Sg_device *));
+	memset(tmp_da, 0, tmp_dev_max * sizeof (Sg_device *));
+	sg_template.dev_max = tmp_dev_max;
+	sg_dev_arr = tmp_da;
+
 	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 #ifdef CONFIG_PROC_FS
 	sg_proc_init();
@@ -1430,7 +1440,7 @@
 static int
 sg_attach(Scsi_Device * scsidp)
 {
-	Sg_device *sdp;
+	Sg_device *sdp = NULL;
 	unsigned long iflags;
 	int k;
 
@@ -1439,15 +1449,16 @@
 		Sg_device **tmp_da;
 		int tmp_dev_max = sg_template.nr_dev + SG_DEV_ARR_LUMP;
 
+		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 		tmp_da = (Sg_device **)vmalloc(
 				tmp_dev_max * sizeof(Sg_device *));
 		if (NULL == tmp_da) {
 			scsidp->attached--;
-			write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 			printk(KERN_ERR
 			       "sg_attach: device array cannot be resized\n");
 			return 1;
 		}
+		write_lock_irqsave(&sg_dev_arr_lock, iflags);
 		memset(tmp_da, 0, tmp_dev_max * sizeof (Sg_device *));
 		memcpy(tmp_da, sg_dev_arr,
 		       sg_template.dev_max * sizeof (Sg_device *));
@@ -1456,6 +1467,7 @@
 		sg_template.dev_max = tmp_dev_max;
 	}
 
+find_empty_slot:
 	for (k = 0; k < sg_template.dev_max; k++)
 		if (!sg_dev_arr[k])
 			break;
@@ -1467,11 +1479,19 @@
 		       " type=%d, minor number exceed %d\n",
 		       scsidp->host->host_no, scsidp->channel, scsidp->id,
 		       scsidp->lun, scsidp->type, SG_MAX_DEVS_MASK);
+		if (NULL != sdp)
+			vfree((char *) sdp);
 		return 1;
 	}
-	if (k < sg_template.dev_max)
-		sdp = (Sg_device *)vmalloc(sizeof(Sg_device));
-	else
+	if (k < sg_template.dev_max) {
+		if (NULL == sdp) {
+			write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+			sdp = (Sg_device *)vmalloc(sizeof(Sg_device));
+			write_lock_irqsave(&sg_dev_arr_lock, iflags);
+			if (!sg_dev_arr[k])
+				goto find_empty_slot;
+		}
+	} else
 		sdp = NULL;
 	if (NULL == sdp) {
 		scsidp->attached--;
@@ -1498,17 +1518,18 @@
 		scsidp->sdev_driverfs_dev.name);
 	sdp->sg_driverfs_dev.parent = &scsidp->sdev_driverfs_dev;
 	sdp->sg_driverfs_dev.bus = &scsi_driverfs_bus_type;
+
+	sg_template.nr_dev++;
+	sg_dev_arr[k] = sdp;
+	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+
 	device_register(&sdp->sg_driverfs_dev);
 	device_create_file(&sdp->sg_driverfs_dev, &dev_attr_type);
 	device_create_file(&sdp->sg_driverfs_dev, &dev_attr_kdev);
-
 	sdp->de = devfs_register(scsidp->de, "generic", DEVFS_FL_DEFAULT,
 				 SCSI_GENERIC_MAJOR, k,
 				 S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
 				 &sg_fops, sdp);
-	sg_template.nr_dev++;
-	sg_dev_arr[k] = sdp;
-	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 	switch (scsidp->type) {
 	case TYPE_DISK:
 	case TYPE_MOD:
