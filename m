Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSGEEjg>; Fri, 5 Jul 2002 00:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSGEEjf>; Fri, 5 Jul 2002 00:39:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48631 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315285AbSGEEjd>;
	Fri, 5 Jul 2002 00:39:33 -0400
Date: Fri, 5 Jul 2002 00:42:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cdrom.c cleanups
Message-ID: <Pine.GSO.4.21.0207050038320.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* Bunch of functions in cdrom.c used to get kdev_t and use it
only to do cdrom_find_device(dev), even though their callers already
had struct cdrom_device_info * in question.  Switched to passing
said pointer directly.
	* useless exports removed; stuff not used outside of cdrom.c
made static.


diff -urN C24-0/drivers/cdrom/cdrom.c C24-current/drivers/cdrom/cdrom.c
--- C24-0/drivers/cdrom/cdrom.c	Wed Apr  3 20:23:26 2002
+++ C24-current/drivers/cdrom/cdrom.c	Sun Jun 23 19:04:01 2002
@@ -318,8 +318,9 @@
 static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
 		     unsigned long arg);
 
-int cdrom_get_last_written(kdev_t dev, long *last_written);
-int cdrom_get_next_writable(kdev_t dev, long *next_writable);
+int cdrom_get_last_written(struct cdrom_device_info *, long *);
+static int cdrom_get_next_writable(struct cdrom_device_info *, long *);
+static void cdrom_count_tracks(struct cdrom_device_info *, tracktype*);
 
 #ifdef CONFIG_SYSCTL
 static void cdrom_sysctl_register(void);
@@ -436,7 +437,7 @@
 	return 0;
 }
 
-struct cdrom_device_info *cdrom_find_device(kdev_t dev)
+static struct cdrom_device_info *cdrom_find_device(kdev_t dev)
 {
 	struct cdrom_device_info *cdi;
 
@@ -775,7 +776,7 @@
 	return cdi->ops->generic_packet(cdi, &cgc);
 }
 
-int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
+static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 {
 	struct cdrom_changer_info info;
 	int curslot;
@@ -859,7 +860,7 @@
 }
 
 /* badly broken, I know. Is due for a fixup anytime. */
-void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype* tracks)
+static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype* tracks)
 {
 	struct cdrom_tochdr header;
 	struct cdrom_tocentry entry;
@@ -1921,7 +1922,6 @@
 {		
 	struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_generic_command cgc;
-	kdev_t dev = cdi->dev;
 	char buffer[32];
 	int ret = 0;
 
@@ -2193,7 +2193,7 @@
 	case CDROM_NEXT_WRITABLE: {
 		long next = 0;
 		cdinfo(CD_DO_IOCTL, "entering CDROM_NEXT_WRITABLE\n"); 
-		if ((ret = cdrom_get_next_writable(dev, &next)))
+		if ((ret = cdrom_get_next_writable(cdi, &next)))
 			return ret;
 		IOCTL_OUT(arg, long, next);
 		return 0;
@@ -2201,7 +2201,7 @@
 	case CDROM_LAST_WRITTEN: {
 		long last = 0;
 		cdinfo(CD_DO_IOCTL, "entering CDROM_LAST_WRITTEN\n"); 
-		if ((ret = cdrom_get_last_written(dev, &last)))
+		if ((ret = cdrom_get_last_written(cdi, &last)))
 			return ret;
 		IOCTL_OUT(arg, long, last);
 		return 0;
@@ -2211,10 +2211,9 @@
 	return -ENOTTY;
 }
 
-int cdrom_get_track_info(kdev_t dev, __u16 track, __u8 type,
+static int cdrom_get_track_info(struct cdrom_device_info *cdi, __u16 track, __u8 type,
 			 track_information *ti)
 {
-        struct cdrom_device_info *cdi = cdrom_find_device(dev);
 	struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_generic_command cgc;
 	int ret;
@@ -2241,9 +2240,8 @@
 }
 
 /* requires CD R/RW */
-int cdrom_get_disc_info(kdev_t dev, disc_information *di)
+static int cdrom_get_disc_info(struct cdrom_device_info *cdi, disc_information *di)
 {
-	struct cdrom_device_info *cdi = cdrom_find_device(dev);
 	struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_generic_command cgc;
 	int ret;
@@ -2273,9 +2271,8 @@
 
 /* return the last written block on the CD-R media. this is for the udf
    file system. */
-int cdrom_get_last_written(kdev_t dev, long *last_written)
-{	
-	struct cdrom_device_info *cdi = cdrom_find_device(dev);
+int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
+{
 	struct cdrom_tocentry toc;
 	disc_information di;
 	track_information ti;
@@ -2285,17 +2282,17 @@
 	if (!CDROM_CAN(CDC_GENERIC_PACKET))
 		goto use_toc;
 
-	if ((ret = cdrom_get_disc_info(dev, &di)))
+	if ((ret = cdrom_get_disc_info(cdi, &di)))
 		goto use_toc;
 
 	last_track = (di.last_track_msb << 8) | di.last_track_lsb;
-	if ((ret = cdrom_get_track_info(dev, last_track, 1, &ti)))
+	if ((ret = cdrom_get_track_info(cdi, last_track, 1, &ti)))
 		goto use_toc;
 
 	/* if this track is blank, try the previous. */
 	if (ti.blank) {
 		last_track--;
-		if ((ret = cdrom_get_track_info(dev, last_track, 1, &ti)))
+		if ((ret = cdrom_get_track_info(cdi, last_track, 1, &ti)))
 			goto use_toc;
 	}
 
@@ -2325,9 +2322,8 @@
 }
 
 /* return the next writable block. also for udf file system. */
-int cdrom_get_next_writable(kdev_t dev, long *next_writable)
+static int cdrom_get_next_writable(struct cdrom_device_info *cdi, long *next_writable)
 {
-	struct cdrom_device_info *cdi = cdrom_find_device(dev);
 	disc_information di;
 	track_information ti;
 	__u16 last_track;
@@ -2336,17 +2332,17 @@
 	if (!CDROM_CAN(CDC_GENERIC_PACKET))
 		goto use_last_written;
 
-	if ((ret = cdrom_get_disc_info(dev, &di)))
+	if ((ret = cdrom_get_disc_info(cdi, &di)))
 		goto use_last_written;
 
 	last_track = (di.last_track_msb << 8) | di.last_track_lsb;
-	if ((ret = cdrom_get_track_info(dev, last_track, 1, &ti)))
+	if ((ret = cdrom_get_track_info(cdi, last_track, 1, &ti)))
 		goto use_last_written;
 
         /* if this track is blank, try the previous. */
 	if (ti.blank) {
 		last_track--;
-		if ((ret = cdrom_get_track_info(dev, last_track, 1, &ti)))
+		if ((ret = cdrom_get_track_info(cdi, last_track, 1, &ti)))
 			goto use_last_written;
 	}
 
@@ -2359,7 +2355,7 @@
 	return 0;
 
 use_last_written:
-	if ((ret = cdrom_get_last_written(dev, next_writable))) {
+	if ((ret = cdrom_get_last_written(cdi, next_writable))) {
 		*next_writable = 0;
 		return ret;
 	} else {
@@ -2368,11 +2364,7 @@
 	}
 }
 
-EXPORT_SYMBOL(cdrom_get_disc_info);
-EXPORT_SYMBOL(cdrom_get_track_info);
-EXPORT_SYMBOL(cdrom_get_next_writable);
 EXPORT_SYMBOL(cdrom_get_last_written);
-EXPORT_SYMBOL(cdrom_count_tracks);
 EXPORT_SYMBOL(register_cdrom);
 EXPORT_SYMBOL(unregister_cdrom);
 EXPORT_SYMBOL(cdrom_open);
@@ -2380,11 +2372,9 @@
 EXPORT_SYMBOL(cdrom_ioctl);
 EXPORT_SYMBOL(cdrom_media_changed);
 EXPORT_SYMBOL(cdrom_number_of_slots);
-EXPORT_SYMBOL(cdrom_select_disc);
 EXPORT_SYMBOL(cdrom_mode_select);
 EXPORT_SYMBOL(cdrom_mode_sense);
 EXPORT_SYMBOL(init_cdrom_command);
-EXPORT_SYMBOL(cdrom_find_device);
 
 #ifdef CONFIG_SYSCTL
 
diff -urN C24-0/drivers/ide/ide-cd.c C24-current/drivers/ide/ide-cd.c
--- C24-0/drivers/ide/ide-cd.c	Thu Jun 20 13:37:03 2002
+++ C24-current/drivers/ide/ide-cd.c	Sun Jun 23 16:45:26 2002
@@ -1937,9 +1937,9 @@
 /* Try to read the entire TOC for the disk into our internal buffer. */
 static int cdrom_read_toc(struct ata_device *drive, struct request_sense *sense)
 {
-	int minor, stat, ntracks, i;
-	kdev_t dev;
+	int stat, ntracks, i;
 	struct cdrom_info *info = drive->driver_data;
+	struct cdrom_device_info *cdi = &info->devinfo;
 	struct atapi_toc *toc = info->toc;
 	struct {
 		struct atapi_toc_header hdr;
@@ -2071,10 +2071,8 @@
 	toc->xa_flag = (ms_tmp.hdr.first_track != ms_tmp.hdr.last_track);
 
 	/* Now try to get the total cdrom capacity. */
-	minor = (drive->select.b.unit) << PARTN_BITS;
-	dev = mk_kdev(drive->channel->major, minor);
 	/* FIXME: This is making worng assumptions about register layout. */
-	stat = cdrom_get_last_written(dev, (unsigned long *) &toc->capacity);
+	stat = cdrom_get_last_written(cdi, (unsigned long *) &toc->capacity);
 	if (stat)
 		stat = cdrom_read_capacity(drive, &toc->capacity, sense);
 	if (stat)
diff -urN C24-0/drivers/scsi/sr.c C24-current/drivers/scsi/sr.c
--- C24-0/drivers/scsi/sr.c	Thu Jun 20 13:37:24 2002
+++ C24-current/drivers/scsi/sr.c	Sun Jun 23 16:49:49 2002
@@ -522,8 +522,8 @@
 		SCp->needs_sector_size = 1;
 	} else {
 #if 0
-		if (cdrom_get_last_written(mkdev(MAJOR_NR, i),
-					   &scsi_CDs[i].capacity))
+		if (cdrom_get_last_written(&SCp->cdi,
+					   &SCp->capacity))
 #endif
 			SCp->capacity = 1 + ((buffer[0] << 24) |
 						    (buffer[1] << 16) |
diff -urN C24-0/include/linux/cdrom.h C24-current/include/linux/cdrom.h
--- C24-0/include/linux/cdrom.h	Mon May 27 14:54:52 2002
+++ C24-current/include/linux/cdrom.h	Sun Jun 23 16:56:20 2002
@@ -805,11 +805,8 @@
     long error;
 } tracktype;
 
-extern void cdrom_count_tracks(struct cdrom_device_info *cdi,tracktype* tracks);
-extern int cdrom_get_next_writable(kdev_t dev, long *next_writable);
-extern int cdrom_get_last_written(kdev_t dev, long *last_written);
+extern int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written);
 extern int cdrom_number_of_slots(struct cdrom_device_info *cdi);
-extern int cdrom_select_disc(struct cdrom_device_info *cdi, int slot);
 extern int cdrom_mode_select(struct cdrom_device_info *cdi,
 			     struct cdrom_generic_command *cgc);
 extern int cdrom_mode_sense(struct cdrom_device_info *cdi,
@@ -817,7 +814,6 @@
 			    int page_code, int page_control);
 extern void init_cdrom_command(struct cdrom_generic_command *cgc,
 			       void *buffer, int len, int type);
-extern struct cdrom_device_info *cdrom_find_device(kdev_t dev);
 
 typedef struct {
 	__u16 disc_information_length;
@@ -900,10 +896,6 @@
 	__u32 track_size;
 	__u32 last_rec_address;
 } track_information;
-
-extern int cdrom_get_disc_info(kdev_t dev, disc_information *di);
-extern int cdrom_get_track_info(kdev_t dev, __u16 track, __u8 type,
-				track_information *ti);
 
 /* The SCSI spec says there could be 256 slots. */
 #define CDROM_MAX_SLOTS	256

