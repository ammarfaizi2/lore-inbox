Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274444AbRIYDKj>; Mon, 24 Sep 2001 23:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274450AbRIYDKb>; Mon, 24 Sep 2001 23:10:31 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:12509 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S274444AbRIYDKU>; Mon, 24 Sep 2001 23:10:20 -0400
Date: Mon, 24 Sep 2001 21:09:57 -0600
Message-Id: <200109250309.f8P39vh18306@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] sd-many for 2.4.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, Linus. Here is my complete sd-many patch for 2.4.10. It's
tested, it works and it's safe. Please apply.

Patch generated against 2.4.10-pre14 but applies cleanly against
2.4.10.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

diff -urN linux-2.4.10-pre14/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.10-pre14/Documentation/Configure.help	Sat Sep 22 00:26:10 2001
+++ linux/Documentation/Configure.help	Sat Sep 22 00:36:08 2001
@@ -5453,6 +5453,17 @@
   located on a SCSI disk. In this case, do not compile the driver for
   your SCSI host adapter (below) as a module either.
 
+Many SCSI Discs support
+CONFIG_SD_MANY
+  This allows you to support a very large number of SCSI discs
+  (approximately 2080). You will also need to set CONFIG_DEVFS_FS=y
+  later. This option may consume all unassigned block majors
+  (i.e. those which do not have an allocation in
+  Documentation/devices.txt). Enabling this will consume a few extra
+  kilobytes of kernel memory.
+
+  Unless you have a large storage array, say N.
+
 Extra SCSI Disks
 CONFIG_SD_EXTRA_DEVS
   This controls the amount of additional space allocated in tables for
diff -urN linux-2.4.10-pre14/drivers/scsi/Config.in linux/drivers/scsi/Config.in
--- linux-2.4.10-pre14/drivers/scsi/Config.in	Sat Sep 22 00:26:14 2001
+++ linux/drivers/scsi/Config.in	Sat Sep 22 00:40:04 2001
@@ -3,7 +3,8 @@
 dep_tristate '  SCSI disk support' CONFIG_BLK_DEV_SD $CONFIG_SCSI
 
 if [ "$CONFIG_BLK_DEV_SD" != "n" ]; then
-   int  'Maximum number of SCSI disks that can be loaded as modules' CONFIG_SD_EXTRA_DEVS 40
+   bool '    Many (~2080) SCSI discs support (requires devfs)' CONFIG_SD_MANY
+   int  '    Maximum number of SCSI disks that can be loaded as modules' CONFIG_SD_EXTRA_DEVS 40
 fi
 
 dep_tristate '  SCSI tape support' CONFIG_CHR_DEV_ST $CONFIG_SCSI
diff -urN linux-2.4.10-pre14/drivers/scsi/hosts.h linux/drivers/scsi/hosts.h
--- linux-2.4.10-pre14/drivers/scsi/hosts.h	Thu Sep 20 22:33:51 2001
+++ linux/drivers/scsi/hosts.h	Sat Sep 22 00:27:45 2001
@@ -506,9 +506,8 @@
     const char * tag;
     struct module * module;	  /* Used for loadable modules */
     unsigned char scsi_type;
-    unsigned int major;
-    unsigned int min_major;      /* Minimum major in range. */ 
-    unsigned int max_major;      /* Maximum major in range. */
+    unsigned int *majors;         /* Array of majors used by driver */
+    unsigned int num_majors;      /* Number of majors used by driver */
     unsigned int nr_dev;	  /* Number currently attached */
     unsigned int dev_noticed;	  /* Number of devices detected. */
     unsigned int dev_max;	  /* Current size of arrays */
diff -urN linux-2.4.10-pre14/drivers/scsi/osst.c linux/drivers/scsi/osst.c
--- linux-2.4.10-pre14/drivers/scsi/osst.c	Thu Jul 19 22:18:15 2001
+++ linux/drivers/scsi/osst.c	Sat Sep 22 00:27:45 2001
@@ -160,7 +160,6 @@
        name:		"OnStream tape",
        tag:		"osst",
        scsi_type:	TYPE_TAPE,
-       major:		OSST_MAJOR,
        detect:		osst_detect,
        init:		osst_init,
        attach:		osst_attach,
diff -urN linux-2.4.10-pre14/drivers/scsi/scsi_lib.c linux/drivers/scsi/scsi_lib.c
--- linux-2.4.10-pre14/drivers/scsi/scsi_lib.c	Sun Aug 12 11:51:42 2001
+++ linux/drivers/scsi/scsi_lib.c	Sat Sep 22 00:27:45 2001
@@ -788,25 +788,10 @@
 		 * Search for a block device driver that supports this
 		 * major.
 		 */
-		if (spnt->blk && spnt->major == major) {
-			return spnt;
-		}
-		/*
-		 * I am still not entirely satisfied with this solution,
-		 * but it is good enough for now.  Disks have a number of
-		 * major numbers associated with them, the primary
-		 * 8, which we test above, and a secondary range of 7
-		 * different consecutive major numbers.   If this ever
-		 * becomes insufficient, then we could add another function
-		 * to the structure, and generalize this completely.
-		 */
-		if( spnt->min_major != 0 
-		    && spnt->max_major != 0
-		    && major >= spnt->min_major
-		    && major <= spnt->max_major )
-		{
-			return spnt;
-		}
+		int i;
+		if (!spnt->blk || !spnt->majors) continue;
+		for (i = 0; i < spnt->num_majors; ++i)
+			if (spnt->majors[i] == major) return spnt;
 	}
 	return NULL;
 }
diff -urN linux-2.4.10-pre14/drivers/scsi/sd.c linux/drivers/scsi/sd.c
--- linux-2.4.10-pre14/drivers/scsi/sd.c	Sat Sep 22 00:26:14 2001
+++ linux/drivers/scsi/sd.c	Sat Sep 22 00:37:11 2001
@@ -28,6 +28,8 @@
  *	
  *	 Modified by Alex Davis <letmein@erols.com>
  *       Fix problem where removable media could be ejected after sd_open.
+ *
+ *       Modified by Richard Gooch rgooch@atnf.csiro.au to support >128 discs.
  */
 
 #include <linux/config.h>
@@ -65,7 +67,11 @@
  *  static const char RCSid[] = "$Header:";
  */
 
-#define SD_MAJOR(i) (!(i) ? SCSI_DISK0_MAJOR : SCSI_DISK1_MAJOR-1+(i))
+#ifdef CONFIG_SD_MANY
+#  define SD_MAJOR(i) sd_template.majors[(i)]
+#else
+#  define SD_MAJOR(i) (!(i) ? SCSI_DISK0_MAJOR : SCSI_DISK1_MAJOR-1+(i))
+#endif
 
 #define SCSI_DISKS_PER_MAJOR	16
 #define SD_MAJOR_NUMBER(i)	SD_MAJOR((i) >> 8)
@@ -77,6 +83,14 @@
 
 #define MAX_RETRIES 5
 
+#ifdef CONFIG_SD_MANY
+#  define sdmalloc(size) vmalloc((size))
+#  define sdfree(ptr) vfree((ptr))
+#else
+#  define sdmalloc(size) kmalloc((size),GFP_ATOMIC)
+#  define sdfree(ptr) kfree((ptr))
+#endif
+
 /*
  *  Time out in seconds for disks and Magneto-opticals (which are slower).
  */
@@ -109,12 +123,6 @@
 	name:"disk",
 	tag:"sd",
 	scsi_type:TYPE_DISK,
-	major:SCSI_DISK0_MAJOR,
-        /*
-         * Secondary range of majors that this driver handles.
-         */
-	min_major:SCSI_DISK1_MAJOR,
-	max_major:SCSI_DISK7_MAJOR,
 	blk:1,
 	detect:sd_detect,
 	init:sd_init,
@@ -124,6 +132,19 @@
 	init_command:sd_init_command,
 };
 
+#ifdef CONFIG_SD_MANY
+static inline int sd_devnum_to_index (int devnum)
+{
+    int i, major = MAJOR (devnum);
+
+    for (i = 0; i < sd_template.num_majors; ++i)
+    {
+        if (sd_template.majors[i] != major) continue;
+        return (i << 4) | (MINOR (devnum) >> 4);
+    }
+    return -ENODEV;
+}
+#endif
 
 static void rw_intr(Scsi_Cmnd * SCpnt);
 
@@ -1049,6 +1070,43 @@
 	return i;
 }
 
+static int sd_alloc_majors (void)
+/*  Allocate as many majors as required
+ */
+{
+	int i, major;
+
+	if ( ( sd_template.majors =
+	       kmalloc (sizeof *sd_template.majors * N_USED_SD_MAJORS,
+			GFP_KERNEL) ) == NULL ) {
+		printk ("sd.c: unable to allocate major array\n");
+		return -ENOMEM;
+	}
+	sd_template.majors[0] = SCSI_DISK0_MAJOR;
+	for (i = 1; (i < N_USED_SD_MAJORS) && (i <N_SD_PREASSIGNED_MAJORS);++i)
+		sd_template.majors[i] = SCSI_DISK1_MAJOR + i - 1;
+	for (; (i >= N_SD_PREASSIGNED_MAJORS) && (i < N_USED_SD_MAJORS); ++i) {
+		if ( ( major = devfs_alloc_major (DEVFS_SPECIAL_BLK) ) < 0 ) {
+			printk (KERN_WARNING __FUNCTION__ "() major[%d] allocation failed\n", i);
+			break;
+		}
+		sd_template.majors[i] = major;
+	}
+	sd_template.dev_max = i * SCSI_DISKS_PER_MAJOR;
+	sd_template.num_majors = i;
+	return 0;
+}	/*  End Function sd_alloc_majors  */
+
+static void sd_dealloc_majors (void)
+/*  Deallocate all the allocated majors
+ */
+{
+	int i;
+
+	for (i = sd_template.num_majors - 1; i >= N_SD_PREASSIGNED_MAJORS; --i)
+		devfs_dealloc_major (DEVFS_SPECIAL_BLK, sd_template.majors[i]);
+}	/*  End Function sd_dealloc_majors  */
+
 /*
  * The sd_init() function looks at all SCSI drives present, determines
  * their size, and reads partition table entries for them.
@@ -1063,16 +1121,20 @@
 	if (sd_template.dev_noticed == 0)
 		return 0;
 
-	if (!rscsi_disks)
+	if (!rscsi_disks) {
+		if ( in_interrupt () ) {
+			printk (__FUNCTION__ "(): called from interrupt\n");
+			return 1;
+		}
 		sd_template.dev_max = sd_template.dev_noticed + SD_EXTRA_DEVS;
-
-	if (sd_template.dev_max > N_SD_MAJORS * SCSI_DISKS_PER_MAJOR)
-		sd_template.dev_max = N_SD_MAJORS * SCSI_DISKS_PER_MAJOR;
+		if ( sd_alloc_majors() ) return 1;
+	}
 
 	if (!sd_registered) {
 		for (i = 0; i < N_USED_SD_MAJORS; i++) {
 			if (devfs_register_blkdev(SD_MAJOR(i), "sd", &sd_fops)) {
 				printk("Unable to get major %d for SCSI disk\n", SD_MAJOR(i));
+				sd_dealloc_majors();
 				return 1;
 			}
 		}
@@ -1082,26 +1144,26 @@
 	if (rscsi_disks)
 		return 0;
 
-	rscsi_disks = kmalloc(sd_template.dev_max * sizeof(Scsi_Disk), GFP_ATOMIC);
+	rscsi_disks = sdmalloc(sd_template.dev_max * sizeof(Scsi_Disk));
 	if (!rscsi_disks)
 		goto cleanup_devfs;
 	memset(rscsi_disks, 0, sd_template.dev_max * sizeof(Scsi_Disk));
 
 	/* for every (necessary) major: */
-	sd_sizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	sd_sizes = sdmalloc((sd_template.dev_max << 4) * sizeof(int));
 	if (!sd_sizes)
 		goto cleanup_disks;
 	memset(sd_sizes, 0, (sd_template.dev_max << 4) * sizeof(int));
 
-	sd_blocksizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	sd_blocksizes = sdmalloc((sd_template.dev_max << 4) * sizeof(int));
 	if (!sd_blocksizes)
 		goto cleanup_sizes;
 	
-	sd_hardsizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	sd_hardsizes = sdmalloc((sd_template.dev_max << 4) * sizeof(int));
 	if (!sd_hardsizes)
 		goto cleanup_blocksizes;
 
-	sd_max_sectors = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	sd_max_sectors = sdmalloc((sd_template.dev_max << 4) * sizeof(int));
 	if (!sd_max_sectors)
 		goto cleanup_max_sectors;
 
@@ -1125,9 +1187,7 @@
 	 * FIXME: should unregister blksize_size, hardsect_size and max_sectors when
 	 * the module is unloaded.
 	 */
-	sd = kmalloc((sd_template.dev_max << 4) *
-					  sizeof(struct hd_struct),
-					  GFP_ATOMIC);
+	sd = sdmalloc((sd_template.dev_max << 4) * sizeof(struct hd_struct));
 	if (!sd)
 		goto cleanup_sd;
 	memset(sd, 0, (sd_template.dev_max << 4) * sizeof(struct hd_struct));
@@ -1172,21 +1232,22 @@
 	}
 	kfree(sd_gendisks);
 cleanup_sd_gendisks:
-	kfree(sd);
+	sdfree(sd);
 cleanup_sd:
-	kfree(sd_max_sectors);
+	sdfree(sd_max_sectors);
 cleanup_max_sectors:
-	kfree(sd_hardsizes);
+	sdfree(sd_hardsizes);
 cleanup_blocksizes:
-	kfree(sd_blocksizes);
+	sdfree(sd_blocksizes);
 cleanup_sizes:
-	kfree(sd_sizes);
+	sdfree(sd_sizes);
 cleanup_disks:
-	kfree(rscsi_disks);
+	sdfree(rscsi_disks);
 cleanup_devfs:
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
 		devfs_unregister_blkdev(SD_MAJOR(i), "sd");
 	}
+	sd_dealloc_majors();
 	sd_registered--;
 	return 1;
 }
@@ -1385,16 +1446,17 @@
 
 	scsi_unregister_module(MODULE_SCSI_DEV, &sd_template);
 
+	sd_dealloc_majors();
 	for (i = 0; i < N_USED_SD_MAJORS; i++)
 		devfs_unregister_blkdev(SD_MAJOR(i), "sd");
 
 	sd_registered--;
 	if (rscsi_disks != NULL) {
-		kfree(rscsi_disks);
-		kfree(sd_sizes);
-		kfree(sd_blocksizes);
-		kfree(sd_hardsizes);
-		kfree((char *) sd);
+		sdfree(rscsi_disks);
+		sdfree(sd_sizes);
+		sdfree(sd_blocksizes);
+		sdfree(sd_hardsizes);
+		sdfree((char *) sd);
 	}
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
 		del_gendisk(&sd_gendisks[i]);
diff -urN linux-2.4.10-pre14/drivers/scsi/sd.h linux/drivers/scsi/sd.h
--- linux-2.4.10-pre14/drivers/scsi/sd.h	Thu Sep 20 22:33:51 2001
+++ linux/drivers/scsi/sd.h	Sat Sep 22 00:27:45 2001
@@ -42,10 +42,14 @@
  */
 extern kdev_t sd_find_target(void *host, int tgt);
 
-#define N_SD_MAJORS	8
+#define N_SD_PREASSIGNED_MAJORS	8
 
-#define SD_MAJOR_MASK	(N_SD_MAJORS - 1)
+#ifdef CONFIG_SD_MANY
+#define SD_PARTITION(i)		((sd_devnum_to_index((i)) << 4) | ((i)&0x0f))
+#else
+#define SD_MAJOR_MASK	(N_SD_PREASSIGNED_MAJORS - 1)
 #define SD_PARTITION(i)		(((MAJOR(i) & SD_MAJOR_MASK) << 8) | (MINOR(i) & 255))
+#endif
 
 #endif
 
diff -urN linux-2.4.10-pre14/drivers/scsi/sg.c linux/drivers/scsi/sg.c
--- linux-2.4.10-pre14/drivers/scsi/sg.c	Sat Sep 22 00:26:14 2001
+++ linux/drivers/scsi/sg.c	Sat Sep 22 00:27:45 2001
@@ -123,7 +123,6 @@
 {
       tag:"sg",
       scsi_type:0xff,
-      major:SCSI_GENERIC_MAJOR,
       detect:sg_detect,
       init:sg_init,
       finish:sg_finish,
diff -urN linux-2.4.10-pre14/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- linux-2.4.10-pre14/drivers/scsi/sr.c	Sat Sep 22 00:26:14 2001
+++ linux/drivers/scsi/sr.c	Sat Sep 22 00:27:45 2001
@@ -69,12 +69,15 @@
 
 static int sr_init_command(Scsi_Cmnd *);
 
+static unsigned int sr_major = SCSI_CDROM_MAJOR;
+
 static struct Scsi_Device_Template sr_template =
 {
 	name:"cdrom",
 	tag:"sr",
 	scsi_type:TYPE_ROM,
-	major:SCSI_CDROM_MAJOR,
+	majors:&sr_major,
+	num_majors:1,
 	blk:1,
 	detect:sr_detect,
 	init:sr_init,
diff -urN linux-2.4.10-pre14/drivers/scsi/st.c linux/drivers/scsi/st.c
--- linux-2.4.10-pre14/drivers/scsi/st.c	Sun Aug 12 12:21:47 2001
+++ linux/drivers/scsi/st.c	Sat Sep 22 00:27:45 2001
@@ -166,7 +166,6 @@
 	name:"tape", 
 	tag:"st", 
 	scsi_type:TYPE_TAPE,
-	major:SCSI_TAPE_MAJOR, 
 	detect:st_detect, 
 	init:st_init,
 	attach:st_attach, 
diff -urN linux-2.4.10-pre14/include/linux/blk.h linux/include/linux/blk.h
--- linux-2.4.10-pre14/include/linux/blk.h	Thu Sep 20 22:33:32 2001
+++ linux/include/linux/blk.h	Sat Sep 22 00:27:45 2001
@@ -144,7 +144,11 @@
 
 #define DEVICE_NAME "scsidisk"
 #define TIMEOUT_VALUE (2*HZ)
+#ifdef CONFIG_SD_MANY
+#define DEVICE_NR(device) sd_devnum_to_index((device))
+#else
 #define DEVICE_NR(device) (((MAJOR(device) & SD_MAJOR_MASK) << (8 - 4)) + (MINOR(device) >> 4))
+#endif
 
 /* Kludge to use the same number for both char and block major numbers */
 #elif  (MAJOR_NR == MD_MAJOR) && defined(MD_DRIVER)
