Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131148AbQKXOTa>; Fri, 24 Nov 2000 09:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131179AbQKXOTY>; Fri, 24 Nov 2000 09:19:24 -0500
Received: from roc-24-93-10-55.rochester.rr.com ([24.93.10.55]:63476 "EHLO
        suzaku.fynet.org") by vger.kernel.org with ESMTP id <S131229AbQKXOHm>;
        Fri, 24 Nov 2000 09:07:42 -0500
Message-ID: <3A1E6EB2.DC20BA01@fsc-usa.com>
Date: Fri, 24 Nov 2000 08:35:46 -0500
From: Brian Kress <kressb@fsc-usa.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: Heinz.Mauelshagen@t-online.de, linux-kernel@vger.kernel.org
Subject: [PATCH] Generalize disk_name in fs/partitions/check.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This is a patch that generalizes the code in 
fs/partitions/check.c for the disk_name() function.  With
the way the code is right now, it has a big if/then/else
block that requires generic code to know specific things 
about drivers.  This patch makes it so the driver can 
supply the code to name its devices.  It does this with
three sets of changes:

1)  Add a function pointer to struct gendisk called hd_name.

2)  Make disk_name in fs/partitions/check.c use that function
    pointer if its non-null.

3)  Change the following drivers to use this method. (adding the
    driver specific method and removing the old code in check.c)

drivers/md/lvm.c
drivers/md/md.c
drivers/ide/ide-probe.c
drivers/scsi/sd.c
drivers/block/cpqarray.c
drivers/block/cciss.c
drivers/block/DAC960.c


	This method means new drivers can name their disks the
way they want to.  It also means LVM disks are named correctly
now (they weren't before).  It also gets rid of lots of 
#ifdefs.  Could you consider applying this patch?


Brian Kress
kressb@fsc-usa.com


--------------------------------- Patch
---------------------------------

diff -u --recursive linux-2.4.0-test11/drivers/block/DAC960.c
linux-2.4.0-test11-ppfix/drivers/block/DAC960.c
--- linux-2.4.0-test11/drivers/block/DAC960.c	Mon Nov 20 15:17:25 2000
+++ linux-2.4.0-test11-ppfix/drivers/block/DAC960.c	Thu Nov 23 14:29:37
2000
@@ -1885,6 +1885,21 @@
 }
 
 
+char *DAC960_disk_name(struct gendisk *hd, int minor, char *buf)
+
+{
+	int ctlr = hd->major - DAC960_MAJOR;
+	int disk = minor >> hd->minor_shift;
+	int part = minor & ((1 << hd->minor_shift) - 1);
+
+	if (part)
+		sprintf(buf, "%s/c%dd%dp%d", hd->major_name, ctlr, disk, part);
+	else
+		sprintf(buf, "%s/c%dd%d", hd->major_name, ctlr, disk);
+	return buf;
+}
+
+
 /*
   DAC960_RegisterBlockDevice registers the Block Device structures
   associated with Controller.
@@ -1945,6 +1960,7 @@
   Controller->GenericDiskInfo.nr_real = Controller->LogicalDriveCount;
   Controller->GenericDiskInfo.next = NULL;
   Controller->GenericDiskInfo.fops = &DAC960_BlockDeviceOperations;
+  Controller->GenericDiskInfo.hd_name = DAC960_disk_name;
   /*
     Install the Generic Disk Information structure at the end of the
list.
   */
diff -u --recursive linux-2.4.0-test11/drivers/block/cciss.c
linux-2.4.0-test11-ppfix/drivers/block/cciss.c
--- linux-2.4.0-test11/drivers/block/cciss.c	Mon Nov 20 15:17:25 2000
+++ linux-2.4.0-test11-ppfix/drivers/block/cciss.c	Thu Nov 23 14:22:55
2000
@@ -1749,6 +1749,20 @@
 	kfree(size_buff);
 }	
 
+char *cciss_disk_name(struct gendisk *hd, int minor, char *buf)
+
+{
+	int ctlr = hd->major - COMPAQ_CISS_MAJOR;
+	int disk = minor >> hd->minor_shift;
+	int part = minor & ((1 << hd->minor_shift) - 1);
+
+	if (part)
+		sprintf(buf, "%s/c%dd%dp%d", hd->major_name, ctlr, disk, part);
+	else
+		sprintf(buf, "%s/c%dd%d", hd->major_name, ctlr, disk);
+	return buf;
+}
+
 /*
  *  This is it.  Find all the controllers and register them.  I really
hate
  *  stealing all these major device numbers.
@@ -1851,6 +1865,7 @@
 		hba[i]->gendisk.part = hba[i]->hd;
 		hba[i]->gendisk.sizes = hba[i]->sizes;
 		hba[i]->gendisk.nr_real = hba[i]->num_luns;
+		hba[i]->gendisk.hd_name = cciss_disk_name;
 
 		/* Get on the disk list */ 
 		hba[i]->gendisk.next = gendisk_head;
diff -u --recursive linux-2.4.0-test11/drivers/block/cpqarray.c
linux-2.4.0-test11-ppfix/drivers/block/cpqarray.c
--- linux-2.4.0-test11/drivers/block/cpqarray.c	Mon Nov 20 15:20:29 2000
+++ linux-2.4.0-test11-ppfix/drivers/block/cpqarray.c	Thu Nov 23
14:14:03 2000
@@ -362,6 +362,20 @@
 }
 #endif /* MODULE */
 
+char *ida_disk_name(struct gendisk *hd, int minor, char *buf)
+
+{
+	int ctlr = hd->major - COMPAQ_SMART2_MAJOR;
+	int disk = minor >> hd->minor_shift;
+	int part = minor & ((1 << hd->minor_shift) - 1);
+
+	if (part)
+		sprintf(buf, "%s/c%dd%dp%d", hd->major_name, ctlr, disk, part);
+	else
+		sprintf(buf, "%s/c%dd%d", hd->major_name, ctlr, disk);
+	return buf;                                                   
+}
+
 /*
  *  This is it.  Find all the controllers and register them.  I really
hate
  *  stealing all these major device numbers.
@@ -512,6 +526,7 @@
 		ida_gendisk[i].part = ida + (i*256);
 		ida_gendisk[i].sizes = ida_sizes + (i*256);
 		ida_gendisk[i].nr_real = 0; 
+		ida_gendisk[i].hd_name = ida_disk_name;
 	
 		/* Get on the disk list */
 		ida_gendisk[i].next = gendisk_head;
diff -u --recursive linux-2.4.0-test11/drivers/ide/ide-probe.c
linux-2.4.0-test11-ppfix/drivers/ide/ide-probe.c
--- linux-2.4.0-test11/drivers/ide/ide-probe.c	Thu Aug  3 19:29:49 2000
+++ linux-2.4.0-test11-ppfix/drivers/ide/ide-probe.c	Thu Nov 23 12:32:16
2000
@@ -726,6 +726,40 @@
 	return 0;
 }
 
+char* ide_disk_name(struct gendisk *hd, int minor, char *buf)
+
+{
+	int unit = (minor >> hd->minor_shift) + 'a';                         
+	unsigned int part = minor & ((1 << hd->minor_shift) - 1);
+
+	switch (hd->major) {
+		case IDE9_MAJOR:
+			unit += 2;
+		case IDE8_MAJOR:
+			unit += 2;
+		case IDE7_MAJOR:
+			unit += 2;
+		case IDE6_MAJOR:
+			unit += 2;
+		case IDE5_MAJOR:
+			unit += 2;
+		case IDE4_MAJOR:
+			unit += 2;
+		case IDE3_MAJOR:
+			unit += 2;
+		case IDE2_MAJOR:
+			unit += 2;
+		case IDE1_MAJOR:
+			unit += 2;
+		case IDE0_MAJOR:
+	}
+	if (part)
+		sprintf(buf, "hd%c%d", unit, part);
+	else
+		sprintf(buf, "hd%c", unit);
+	return buf;                                                          
+}
+
 /*
  * init_gendisk() (as opposed to ide_geninit) is called for each major
device,
  * after probing for drives, to allocate partition tables and other
data
@@ -781,6 +815,7 @@
 	gd->fops        = ide_fops;             /* file operations */
 	gd->de_arr	= kmalloc (sizeof *gd->de_arr * units, GFP_KERNEL);
 	gd->flags	= kmalloc (sizeof *gd->flags * units, GFP_KERNEL);
+	gd->hd_name	= ide_disk_name;
 	if (gd->de_arr)
 		memset (gd->de_arr, 0, sizeof *gd->de_arr * units);
 	if (gd->flags)
diff -u --recursive linux-2.4.0-test11/drivers/md/lvm.c
linux-2.4.0-test11-ppfix/drivers/md/lvm.c
--- linux-2.4.0-test11/drivers/md/lvm.c	Mon Nov 20 15:20:30 2000
+++ linux-2.4.0-test11-ppfix/drivers/md/lvm.c	Thu Nov 23 07:47:20 2000
@@ -213,9 +213,7 @@
 &lvm_proc_get_info;
 #endif
 
-#ifdef LVM_HD_NAME
-void lvm_hd_name(char *, int);
-#endif
+char *lvm_hd_name(struct gendisk *, int, char *);
 /* End external function prototypes */
 
 
@@ -230,9 +228,6 @@
 int lvm_snapshot_alloc(lv_t *);
 void lvm_snapshot_release(lv_t *); 
 
-#ifdef LVM_HD_NAME
-extern void (*lvm_hd_name_ptr) (char *, int);
-#endif
 static int lvm_map(struct buffer_head *, int);
 static int lvm_do_lock_lvm(void);
 static int lvm_do_le_remap(vg_t *, void *);
@@ -397,11 +392,6 @@
 		lvm_gendisk.next = NULL;
 	}
 
-#ifdef LVM_HD_NAME
-	/* reference from drivers/block/genhd.c */
-	lvm_hd_name_ptr = lvm_hd_name;
-#endif
-
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR),
lvm_make_request_fn);
 	blk_queue_pluggable(BLK_DEFAULT_QUEUE(MAJOR_NR),
lvm_plug_device_noop);
@@ -460,11 +450,6 @@
 	remove_proc_entry(LVM_NAME, &proc_root);
 #endif
 
-#ifdef LVM_HD_NAME
-	/* reference from linux/drivers/block/genhd.c */
-	lvm_hd_name_ptr = NULL;
-#endif
-
 	printk(KERN_INFO "%s -- Module successfully deactivated\n", lvm_name);
 
 	return;
@@ -1448,24 +1433,22 @@
  * internal support functions
  */
 
-#ifdef LVM_HD_NAME
 /*
  * generate "hard disk" name
  */
-void lvm_hd_name(char *buf, int minor)
+char *lvm_hd_name(struct gendisk *hd, int minor, char *buf)
 {
 	int len = 0;
 	lv_t *lv_ptr;
 
 	if (vg[VG_BLK(minor)] == NULL ||
 	    (lv_ptr = vg[VG_BLK(minor)]->lv[LV_BLK(minor)]) == NULL)
-		return;
+		return buf;
 	len = strlen(lv_ptr->lv_name) - 5;
 	memcpy(buf, &lv_ptr->lv_name[5], len);
 	buf[len] = 0;
-	return;
+	return buf;
 }
-#endif
 
 
 /*
@@ -2515,6 +2498,8 @@
 
 	blksize_size[MAJOR_NR] = lvm_blocksizes;
 	blk_size[MAJOR_NR] = lvm_size;
+
+	lvm_gendisk.hd_name=lvm_hd_name;
 
 	return;
 } /* lvm_gen_init() */
diff -u --recursive linux-2.4.0-test11/drivers/md/md.c
linux-2.4.0-test11-ppfix/drivers/md/md.c
--- linux-2.4.0-test11/drivers/md/md.c	Mon Nov 20 15:20:30 2000
+++ linux-2.4.0-test11-ppfix/drivers/md/md.c	Thu Nov 23 07:56:06 2000
@@ -113,6 +113,8 @@
 extern struct block_device_operations md_fops;
 static devfs_handle_t devfs_handle;
 
+char *md_disk_name(struct gendisk*, int, char *);
+
 static struct gendisk md_gendisk=
 {
 	major: MD_MAJOR,
@@ -125,6 +127,7 @@
 	real_devices: NULL,
 	next: NULL,
 	fops: &md_fops,
+	hd_name: md_disk_name,
 };
 
 /*
@@ -215,6 +218,14 @@
 	MOD_INC_USE_COUNT;
 
 	return mddev;
+}
+
+char * md_disk_name(struct gendisk *hd, int minor, char* buf)
+
+{
+	int unit = (minor >> hd->minor_shift) + '0';
+	sprintf(buf, "%s%c", hd->major_name, unit);
+        return buf;
 }
 
 struct gendisk * find_gendisk (kdev_t dev)
diff -u --recursive linux-2.4.0-test11/drivers/scsi/sd.c
linux-2.4.0-test11-ppfix/drivers/scsi/sd.c
--- linux-2.4.0-test11/drivers/scsi/sd.c	Mon Nov 20 15:17:18 2000
+++ linux-2.4.0-test11-ppfix/drivers/scsi/sd.c	Thu Nov 23 09:53:01 2000
@@ -1013,6 +1013,30 @@
 	return i;
 }
 
+char *scsi_disk_name(struct gendisk *hd, int minor, char *buf)
+
+{
+	int unit = (minor >> hd->minor_shift) + 'a';
+	unsigned int part = minor & ((1 << hd->minor_shift) - 1);
+
+	if (hd->major >= SCSI_DISK1_MAJOR && hd->major <= SCSI_DISK7_MAJOR) {
+		unit = unit + (hd->major - SCSI_DISK1_MAJOR + 1) * 16;
+		if (unit > 'z') {
+			unit -= 'z' + 1;
+			sprintf(buf, "sd%c%c", 'a' + unit / 26, 'a' + unit % 26);
+			if (part)
+				sprintf(buf + 4, "%d", part);
+			return buf;
+		}
+	}
+
+	if (part)
+		sprintf(buf, "sd%c%d", unit, part);
+	else
+		sprintf(buf, "sd%c", unit);
+	return buf;
+}
+
 /*
  * The sd_init() function looks at all SCSI drives present, determines
  * their size, and reads partition table entries for them.
@@ -1109,6 +1133,7 @@
 		sd_gendisks[i].next = sd_gendisks + i + 1;
 		sd_gendisks[i].real_devices =
 		    (void *) (rscsi_disks + i * SCSI_DISKS_PER_MAJOR);
+		sd_gendisks[i].hd_name=scsi_disk_name;
 	}
 
 	LAST_SD_GENDISK.next = NULL;
diff -u --recursive linux-2.4.0-test11/fs/partitions/check.c
linux-2.4.0-test11-ppfix/fs/partitions/check.c
--- linux-2.4.0-test11/fs/partitions/check.c	Mon Nov 20 15:17:27 2000
+++ linux-2.4.0-test11-ppfix/fs/partitions/check.c	Thu Nov 23 14:30:45
2000
@@ -83,11 +83,10 @@
  */
 char *disk_name (struct gendisk *hd, int minor, char *buf)
 {
-	unsigned int part;
 	const char *maj = hd->major_name;
 	int unit = (minor >> hd->minor_shift) + 'a';
+	unsigned int part = minor & ((1 << hd->minor_shift) - 1);
 
-	part = minor & ((1 << hd->minor_shift) - 1);
 	if (hd->part[minor].de) {
 		int pos;
 
@@ -95,77 +94,8 @@
 		if (pos >= 0)
 			return buf + pos;
 	}
-	/*
-	 * IDE devices use multiple major numbers, but the drives
-	 * are named as:  {hda,hdb}, {hdc,hdd}, {hde,hdf}, {hdg,hdh}..
-	 * This requires special handling here.
-	 */
-	switch (hd->major) {
-		case IDE9_MAJOR:
-			unit += 2;
-		case IDE8_MAJOR:
-			unit += 2;
-		case IDE7_MAJOR:
-			unit += 2;
-		case IDE6_MAJOR:
-			unit += 2;
-		case IDE5_MAJOR:
-			unit += 2;
-		case IDE4_MAJOR:
-			unit += 2;
-		case IDE3_MAJOR:
-			unit += 2;
-		case IDE2_MAJOR:
-			unit += 2;
-		case IDE1_MAJOR:
-			unit += 2;
-		case IDE0_MAJOR:
-			maj = "hd";
-			break;
-		case MD_MAJOR:
-			unit -= 'a'-'0';
-			break;
-	}
-	if (hd->major >= SCSI_DISK1_MAJOR && hd->major <= SCSI_DISK7_MAJOR) {
-		unit = unit + (hd->major - SCSI_DISK1_MAJOR + 1) * 16;
-		if (unit > 'z') {
-			unit -= 'z' + 1;
-			sprintf(buf, "sd%c%c", 'a' + unit / 26, 'a' + unit % 26);
-			if (part)
-				sprintf(buf + 4, "%d", part);
-			return buf;
-		}
-	}
-	if (hd->major >= COMPAQ_SMART2_MAJOR && hd->major <=
COMPAQ_SMART2_MAJOR+7) {
-		int ctlr = hd->major - COMPAQ_SMART2_MAJOR;
- 		int disk = minor >> hd->minor_shift;
- 		int part = minor & (( 1 << hd->minor_shift) - 1);
- 		if (part == 0)
- 			sprintf(buf, "%s/c%dd%d", maj, ctlr, disk);
- 		else
- 			sprintf(buf, "%s/c%dd%dp%d", maj, ctlr, disk, part);
- 		return buf;
- 	}
-	if (hd->major >= COMPAQ_CISS_MAJOR && hd->major <=
COMPAQ_CISS_MAJOR+7) {
-                int ctlr = hd->major - COMPAQ_CISS_MAJOR;
-                int disk = minor >> hd->minor_shift;
-                int part = minor & (( 1 << hd->minor_shift) - 1);
-                if (part == 0)
-                        sprintf(buf, "%s/c%dd%d", maj, ctlr, disk);
-                else
-                        sprintf(buf, "%s/c%dd%dp%d", maj, ctlr, disk,
part);
-                return buf;
-	}
-	if (hd->major >= DAC960_MAJOR && hd->major <= DAC960_MAJOR+7) {
-		int ctlr = hd->major - DAC960_MAJOR;
- 		int disk = minor >> hd->minor_shift;
- 		int part = minor & (( 1 << hd->minor_shift) - 1);
- 		if (part == 0)
- 			sprintf(buf, "%s/c%dd%d", maj, ctlr, disk);
- 		else
- 			sprintf(buf, "%s/c%dd%dp%d", maj, ctlr, disk, part);
- 		return buf;
- 	}
+	if (hd->hd_name) return hd->hd_name(hd, minor, buf);
+
 	if (part)
 		sprintf(buf, "%s%c%d", maj, unit, part);
 	else
diff -u --recursive linux-2.4.0-test11/include/linux/genhd.h
linux-2.4.0-test11-ppfix/include/linux/genhd.h
--- linux-2.4.0-test11/include/linux/genhd.h	Mon Nov 20 15:31:01 2000
+++ linux-2.4.0-test11-ppfix/include/linux/genhd.h	Thu Nov 23 07:44:35
2000
@@ -72,6 +72,8 @@
 
 	devfs_handle_t *de_arr;         /* one per physical disc */
 	char *flags;                    /* one per physical disc */
+
+	char *(*hd_name) (struct gendisk *, int, char *);
 };
 #endif  /*  __KERNEL__  */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
