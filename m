Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263815AbTCVRcs>; Sat, 22 Mar 2003 12:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263813AbTCVRc3>; Sat, 22 Mar 2003 12:32:29 -0500
Received: from verein.lst.de ([212.34.181.86]:21510 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S263684AbTCVR3R>;
	Sat, 22 Mar 2003 12:29:17 -0500
Date: Sat, 22 Mar 2003 18:40:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devfs_mk_dir simplification
Message-ID: <20030322184018.C21623@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All arguments except the nameare unused - remove them and make the
name printf-like to avoid a few snprintf in the surrounding code.

(also fixes compilation to due a superflous endif in dvb core)


diff -Nru a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
--- a/arch/um/drivers/ubd_kern.c	Sat Mar 22 15:38:04 2003
+++ b/arch/um/drivers/ubd_kern.c	Sat Mar 22 15:38:04 2003
@@ -682,7 +682,7 @@
 {
         int i;
 
-	ubd_dir_handle = devfs_mk_dir(NULL, "ubd", NULL);
+	ubd_dir_handle = devfs_mk_dir("ubd");
 	if (register_blkdev(MAJOR_NR, "ubd"))
 		return -1;
 
@@ -693,7 +693,7 @@
 		char name[sizeof("ubd_nnn\0")];
 
 		snprintf(name, sizeof(name), "ubd_%d", fake_major);
-		ubd_fake_dir_handle = devfs_mk_dir(NULL, name, NULL);
+		ubd_fake_dir_handle = devfs_mk_dir(name);
 		if (register_blkdev(fake_major, "ubd"))
 			return -1;
 	}
diff -Nru a/drivers/block/acsi_slm.c b/drivers/block/acsi_slm.c
--- a/drivers/block/acsi_slm.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/block/acsi_slm.c	Sat Mar 22 15:38:04 2003
@@ -1006,7 +1006,7 @@
 	BufferP = SLMBuffer;
 	SLMState = IDLE;
 	
-	devfs_mk_dir (NULL, "slm", NULL);
+	devfs_mk_dir("slm");
 	for (i = 0; i < MAX_SLM; i++) {
 		char name[16];
 		sprintf(name, "slm/%d", i);
diff -Nru a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/block/cpqarray.c	Sat Mar 22 15:38:04 2003
@@ -1679,9 +1679,8 @@
 
 				}
 				if (!disk->de) {
-					char txt[16];
-					sprintf(txt,"ida/c%dd%d",ctlr,log_unit);
-					disk->de = devfs_mk_dir(NULL,txt,NULL);
+					disk->de = devfs_mk_dir("ida/c%dd%d",
+							ctlr, log_unit);
 				}
 				info_p->phys_drives =
 				    sense_config_buf->ctlr_phys_drv;
diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/block/floppy.c	Sat Mar 22 15:38:04 2003
@@ -4233,7 +4233,7 @@
 			goto Enomem;
 	}
 
-	devfs_mk_dir (NULL, "floppy", NULL);
+	devfs_mk_dir ("floppy");
 	if (register_blkdev(FLOPPY_MAJOR,"fd")) {
 		err = -EBUSY;
 		goto out;
diff -Nru a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/block/loop.c	Sat Mar 22 15:38:05 2003
@@ -1020,7 +1020,7 @@
 	if (register_blkdev(LOOP_MAJOR, "loop"))
 		return -EIO;
 
-	devfs_mk_dir(NULL, "loop", NULL);
+	devfs_mk_dir("loop");
 
 	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
 	if (!loop_dev)
diff -Nru a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/block/nbd.c	Sat Mar 22 15:38:04 2003
@@ -565,7 +565,7 @@
 	printk("nbd: registered device at major %d\n", NBD_MAJOR);
 #endif
 	blk_init_queue(&nbd_queue, do_nbd_request, &nbd_lock);
-	devfs_mk_dir (NULL, "nbd", NULL);
+	devfs_mk_dir("nbd");
 	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
 		char name[16];
diff -Nru a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/block/paride/pg.c	Sat Mar 22 15:38:05 2003
@@ -642,7 +642,7 @@
 		  if (PG.present) pi_release(PI);
 		return -1;
 	}
-	devfs_mk_dir (NULL, "pg", NULL);
+	devfs_mk_dir ("pg");
 	for (unit=0; unit<PG_UNITS; unit++)
 		if (PG.present) {
 			char name[16];
diff -Nru a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/block/paride/pt.c	Sat Mar 22 15:38:04 2003
@@ -913,7 +913,7 @@
 		return -1;
 	}
 
-	devfs_mk_dir (NULL, "pt", NULL);
+	devfs_mk_dir ("pt");
 	for (unit=0;unit<PT_UNITS;unit++)
 		if (PT.present) {
 			char name[16];
diff -Nru a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/block/rd.c	Sat Mar 22 15:38:05 2003
@@ -416,7 +416,7 @@
 
 	blk_queue_make_request(&rd_queue, &rd_make_request);
 
-	devfs_mk_dir (NULL, "rd", NULL);
+	devfs_mk_dir("rd");
 
 	for (i = 0; i < NUM_RAMDISKS; i++) {
 		struct gendisk *disk = rd_disks[i];
diff -Nru a/drivers/block/swim3.c b/drivers/block/swim3.c
--- a/drivers/block/swim3.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/block/swim3.c	Sat Mar 22 15:38:04 2003
@@ -979,7 +979,7 @@
 	int err = -ENOMEM;
 	int i;
 
-	floppy_devfs_handle = devfs_mk_dir(NULL, "floppy", NULL);
+	floppy_devfs_handle = devfs_mk_dir("floppy");
 
 	swim = find_devices("floppy");
 	while (swim && (floppy_count < MAX_FLOPPIES))
diff -Nru a/drivers/block/umem.c b/drivers/block/umem.c
--- a/drivers/block/umem.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/block/umem.c	Sat Mar 22 15:38:05 2003
@@ -1154,7 +1154,8 @@
 		if (!mm_gendisk[i])
 			goto out;
 	}
-	devfs_mk_dir(NULL, "umem", NULL);
+
+	devfs_mk_dir("umem");
 
 	for (i = 0; i < num_cards; i++) {
 		struct gendisk *disk = mm_gendisk[i];
diff -Nru a/drivers/block/xd.c b/drivers/block/xd.c
--- a/drivers/block/xd.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/block/xd.c	Sat Mar 22 15:38:05 2003
@@ -173,7 +173,7 @@
 	if (register_blkdev(XT_DISK_MAJOR, "xd"))
 		goto out1;
 
-	devfs_mk_dir(NULL, "xd", NULL);
+	devfs_mk_dir("xd");
 	blk_init_queue(&xd_queue, do_xd_request, &xd_lock);
 	if (xd_detect(&controller,&address)) {
 
diff -Nru a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
--- a/drivers/cdrom/sbpcd.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/cdrom/sbpcd.c	Sat Mar 22 15:38:04 2003
@@ -5805,7 +5805,7 @@
 
 	blk_init_queue(&sbpcd_queue, do_sbpcd_request, &sbpcd_lock);
 
-	devfs_mk_dir (NULL, "sbp", NULL);
+	devfs_mk_dir("sbp");
 
 	for (j=0;j<NR_SBPCD;j++)
 	{
diff -Nru a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
--- a/drivers/char/ipmi/ipmi_devintf.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/char/ipmi/ipmi_devintf.c	Sat Mar 22 15:38:05 2003
@@ -489,7 +489,7 @@
 		ipmi_major = rv;
 	}
 
-	devfs_handle = devfs_mk_dir(NULL, DEVICE_NAME, NULL);
+	devfs_handle = devfs_mk_dir(DEVICE_NAME);
 
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
diff -Nru a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/char/istallion.c	Sat Mar 22 15:38:05 2003
@@ -5334,7 +5334,7 @@
 		printk(KERN_ERR "STALLION: failed to register serial memory "
 				"device\n");
 
-	devfs_mk_dir (NULL, "staliomem", NULL);
+	devfs_mk_dir("staliomem");
 	for (i = 0; i < 4; i++) {
 		char name[16];
 		sprintf(name, "staliomem/%d", i);
diff -Nru a/drivers/char/lp.c b/drivers/char/lp.c
--- a/drivers/char/lp.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/char/lp.c	Sat Mar 22 15:38:04 2003
@@ -906,7 +906,7 @@
 		return -EIO;
 	}
 
-	devfs_mk_dir (NULL, "printers", NULL);
+	devfs_mk_dir("printers");
 
 	if (parport_register_driver (&lp_driver)) {
 		printk (KERN_ERR "lp: unable to register with parport\n");
diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/char/misc.c	Sat Mar 22 15:38:05 2003
@@ -196,7 +196,7 @@
 	if (misc->minor < DYNAMIC_MINORS)
 		misc_minors[misc->minor >> 3] |= 1 << (misc->minor & 7);
 	if (!devfs_handle)
-		devfs_handle = devfs_mk_dir (NULL, "misc", NULL);
+		devfs_handle = devfs_mk_dir("misc");
 	dir = strchr (misc->name, '/') ? NULL : devfs_handle;
 	misc->devfs_handle =
 		devfs_register (dir, misc->name, DEVFS_FL_NONE,
diff -Nru a/drivers/char/ppdev.c b/drivers/char/ppdev.c
--- a/drivers/char/ppdev.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/char/ppdev.c	Sat Mar 22 15:38:05 2003
@@ -758,7 +758,7 @@
 			PP_MAJOR);
 		return -EIO;
 	}
-	devfs_mk_dir (NULL, "parports", NULL);
+	devfs_mk_dir("parports");
 	for (i = 0; i < PARPORT_MAX; i++) {
 		char name[16];
 		sprintf(name, "parports/%d", i);
diff -Nru a/drivers/char/pty.c b/drivers/char/pty.c
--- a/drivers/char/pty.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/char/pty.c	Sat Mar 22 15:38:04 2003
@@ -432,7 +432,7 @@
 
 	/* Unix98 devices */
 #ifdef CONFIG_UNIX98_PTYS
-	devfs_mk_dir (NULL, "pts", NULL);
+	devfs_mk_dir("pts");
 	printk("pty: %d Unix98 ptys configured\n", UNIX98_NR_MAJORS*NR_PTYS);
 	for ( i = 0 ; i < UNIX98_NR_MAJORS ; i++ ) {
 		int j;
diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/char/stallion.c	Sat Mar 22 15:38:05 2003
@@ -3213,7 +3213,7 @@
  */
 	if (register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stl_fsiomem))
 		printk("STALLION: failed to register serial board device\n");
-	devfs_mk_dir (NULL, "staliomem", NULL);
+	devfs_mk_dir("staliomem");
 	for (i = 0; i < 4; i++) {
 		char name[16];
 		sprintf(name, "staliomem/%d", i);
diff -Nru a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/char/tipar.c	Sat Mar 22 15:38:05 2003
@@ -490,7 +490,7 @@
 	}
 
 	/* Use devfs with tree: /dev/ticables/par/[0..2] */
-	devfs_mk_dir(NULL, "ticables/par", NULL);
+	devfs_mk_dir("ticables/par");
 
 	if (parport_register_driver(&tipar_driver)) {
 		printk("tipar: unable to register with parport\n");
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/i2c/i2c-dev.c	Sat Mar 22 15:38:05 2003
@@ -436,7 +436,7 @@
 		       I2C_MAJOR);
 		return -EIO;
 	}
-	devfs_mk_dir(NULL, "i2c", NULL);
+	devfs_mk_dir("i2c");
 	if ((res = i2c_add_driver(&i2cdev_driver))) {
 		printk(KERN_ERR "i2c-dev.o: Driver registration failed, module not inserted.\n");
 		devfs_remove("i2c");
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/ide/ide-probe.c	Sat Mar 22 15:38:05 2003
@@ -1304,7 +1304,7 @@
 			hwif->channel, unit, drive->lun);
 		if (drive->present) {
 			device_register(&drive->gendev);
-			drive->de = devfs_mk_dir(NULL, name, NULL);
+			drive->de = devfs_mk_dir(name);
 		}
 	}
 	blk_register_region(MKDEV(hwif->major, 0), MAX_DRIVES << PARTN_BITS,
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/ide/ide.c	Sat Mar 22 15:38:04 2003
@@ -2470,7 +2470,7 @@
 	static char banner_printed;
 	if (!banner_printed) {
 		printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
-		devfs_mk_dir(NULL, "ide", NULL);
+		devfs_mk_dir("ide");
 		system_bus_speed = ide_system_bus_speed();
 		banner_printed = 1;
 	}
diff -Nru a/drivers/ieee1394/dv1394.c b/drivers/ieee1394/dv1394.c
--- a/drivers/ieee1394/dv1394.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/ieee1394/dv1394.c	Sat Mar 22 15:38:05 2003
@@ -2648,12 +2648,9 @@
 #endif
 
 #ifdef CONFIG_DEVFS_FS
-	snprintf(buf, sizeof(buf), "ieee1394/dv/host%d", ohci->id);
-	devfs_mk_dir(NULL, buf, NULL);
-	snprintf(buf, sizeof(buf), "ieee1394/dv/host%d/NTSC", ohci->id);
-	devfs_mk_dir(NULL, buf, NULL);
-	snprintf(buf, sizeof(buf), "ieee1394/dv/host%d/PAL", ohci->id);
-	devfs_mk_dir(NULL, buf, NULL);
+	devfs_mk_dir("ieee1394/dv/host%d", ohci->id);
+	devfs_mk_dir("ieee1394/dv/host%d/NTSC", ohci->id);
+	devfs_mk_dir("ieee1394/dv/host%d/PAL", ohci->id);
 #endif
 	
 	dv1394_init(ohci, DV1394_NTSC, MODE_RECEIVE);
@@ -2919,7 +2916,7 @@
 	}
 
 #ifdef CONFIG_DEVFS_FS
-	if (!devfs_mk_dir(NULL, "ieee1394/dv", NULL)) {
+	if (!devfs_mk_dir("ieee1394/dv")) {
 		printk(KERN_ERR "dv1394: unable to create /dev/ieee1394/dv\n");
 		ieee1394_unregister_chardev(IEEE1394_MINOR_BLOCK_DV1394);
 		return -ENOMEM;
diff -Nru a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
--- a/drivers/ieee1394/ieee1394_core.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/ieee1394/ieee1394_core.c	Sat Mar 22 15:38:04 2003
@@ -1155,7 +1155,7 @@
 	hpsb_packet_cache = kmem_cache_create("hpsb_packet", sizeof(struct hpsb_packet),
 					      0, 0, NULL, NULL);
 
-	ieee1394_devfs_handle = devfs_mk_dir(NULL, "ieee1394", NULL);
+	ieee1394_devfs_handle = devfs_mk_dir("ieee1394");
 
 	if (register_chrdev(IEEE1394_MAJOR, "ieee1394", &ieee1394_chardev_ops)) {
 		HPSB_ERR("unable to register character device major %d!\n", IEEE1394_MAJOR);
diff -Nru a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
--- a/drivers/ieee1394/video1394.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/ieee1394/video1394.c	Sat Mar 22 15:38:04 2003
@@ -1486,7 +1486,7 @@
 		return -EIO;
         }
 
-	devfs_handle = devfs_mk_dir(NULL, VIDEO1394_DRIVER_NAME, NULL);
+	devfs_handle = devfs_mk_dir(VIDEO1394_DRIVER_NAME);
 
 	hl_handle = hpsb_register_highlevel (VIDEO1394_DRIVER_NAME, &hl_ops);
 	if (hl_handle == NULL) {
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/input/input.c	Sat Mar 22 15:38:05 2003
@@ -696,7 +696,7 @@
 		return -EBUSY;
 	}
 
-	input_devfs_handle = devfs_mk_dir(NULL, "input", NULL);
+	input_devfs_handle = devfs_mk_dir("input");
 
 	return 0;
 }
diff -Nru a/drivers/isdn/i4l/isdn_common.c b/drivers/isdn/i4l/isdn_common.c
--- a/drivers/isdn/i4l/isdn_common.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/isdn/i4l/isdn_common.c	Sat Mar 22 15:38:04 2003
@@ -2186,7 +2186,7 @@
 	int i;
 #  endif
 
-	devfs_mk_dir (NULL, "isdn", NULL);
+	devfs_mk_dir("isdn");
 #  ifdef CONFIG_ISDN_PPP
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
 		char buf[16];
diff -Nru a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
--- a/drivers/md/dm-ioctl.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/md/dm-ioctl.c	Sat Mar 22 15:38:04 2003
@@ -56,7 +56,7 @@
 {
 	init_buckets(_name_buckets);
 	init_buckets(_uuid_buckets);
-	devfs_mk_dir(NULL, DM_DIR, NULL);
+	devfs_mk_dir(DM_DIR);
 	return 0;
 }
 
diff -Nru a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/md/md.c	Sat Mar 22 15:38:04 2003
@@ -3597,7 +3597,7 @@
 	if (register_blkdev(MAJOR_NR, "md"))
 		return -1;
 
-	devfs_mk_dir(NULL, "md", NULL);
+	devfs_mk_dir("md");
 	blk_register_region(MKDEV(MAJOR_NR, 0), MAX_MD_DEVS, THIS_MODULE,
 				md_probe, NULL, NULL);
 	for (minor=0; minor < MAX_MD_DEVS; ++minor) {
diff -Nru a/drivers/media/dvb/dvb-core/dvbdev.c b/drivers/media/dvb/dvb-core/dvbdev.c
--- a/drivers/media/dvb/dvb-core/dvbdev.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/media/dvb/dvb-core/dvbdev.c	Sat Mar 22 15:38:04 2003
@@ -111,8 +111,6 @@
 	.owner =	THIS_MODULE,
 	.open =		dvb_device_open,
 };
-#endif /* CONFIG_DVB_DEVFS_ONLY */
-
 
 
 int dvb_generic_open(struct inode *inode, struct file *file)
@@ -271,7 +269,6 @@
 
 int dvb_register_adapter(struct dvb_adapter **padap, char *name)
 {
-	char dirname[16];
 	struct dvb_adapter *adap;
 	int num;
 
@@ -295,8 +292,7 @@
 
 	printk ("DVB: registering new adapter (%s).\n", name);
 	
-	sprintf(dirname, "dvb/adapter%d", num);
-	adap->devfs_handle = devfs_mk_dir(NULL, dirname, NULL);
+	adap->devfs_handle = devfs_mk_dir("dvb/adapter%d", num);
 	adap->num = num;
 
 	list_add_tail (&adap->list_head, &dvb_adapter_list);
@@ -323,7 +319,7 @@
 static
 int __init init_dvbdev(void)
 {
-	dvb_devfs_handle = devfs_mk_dir (NULL, "dvb", NULL);
+	dvb_devfs_handle = devfs_mk_dir ("dvb");
 #ifndef CONFIG_DVB_DEVFS_ONLY
 	if(register_chrdev(DVB_MAJOR,"DVB", &dvb_device_fops)) {
 		printk("video_dev: unable to get major %d\n", DVB_MAJOR);
diff -Nru a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
--- a/drivers/mtd/mtdblock.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/mtd/mtdblock.c	Sat Mar 22 15:38:04 2003
@@ -575,7 +575,7 @@
 		return -EAGAIN;
 
 #ifdef CONFIG_DEVFS_FS
-	devfs_mk_dir(NULL, DEVICE_NAME, NULL);
+	devfs_mk_dir(DEVICE_NAME);
 #endif
 	register_mtd_user(&notifier);
 	
diff -Nru a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
--- a/drivers/mtd/mtdchar.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/mtd/mtdchar.c	Sat Mar 22 15:38:05 2003
@@ -497,7 +497,7 @@
 	}
 
 #ifdef CONFIG_DEVFS_FS
-	devfs_mk_dir(NULL, "mtd", NULL);
+	devfs_mk_dir("mtd");
 
 	register_mtd_user(&notifier);
 #endif
diff -Nru a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
--- a/drivers/net/wan/cosa.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/net/wan/cosa.c	Sat Mar 22 15:38:04 2003
@@ -390,7 +390,7 @@
 		unregister_chrdev(cosa_major, "cosa");
 		return -ENODEV;
 	}
-	devfs_mk_dir (NULL, "cosa", NULL);
+	devfs_mk_dir("cosa");
 	for (i=0; i<nr_cards; i++) {
 		char name[16];
 		sprintf(name, "cosa/%d", i);
diff -Nru a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
--- a/drivers/s390/block/dasd.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/s390/block/dasd.c	Sat Mar 22 15:38:04 2003
@@ -174,7 +174,6 @@
 static inline int
 dasd_state_new_to_known(dasd_device_t *device)
 {
-	char buffer[10];
 	dasd_devmap_t *devmap;
 	umode_t devfs_perm;
 	devfs_handle_t dir;
@@ -193,8 +192,7 @@
 	minor = devmap->devindex % DASD_PER_MAJOR;
 
 	/* Add a proc directory and the dasd device entry to devfs. */
- 	sprintf(buffer, "dasd/%04x", device->devno);
- 	dir = devfs_mk_dir(NULL, buffer, NULL);
+ 	dir = devfs_mk_dir("dasd/%04x", device->devno);
 	device->gdp->de = dir;
 	if (device->ro_flag)
 		devfs_perm = S_IFBLK | S_IRUSR;
@@ -2077,7 +2075,7 @@
 
 	DBF_EVENT(DBF_EMERG, "%s", "debug area created");
 
-	if (devfs_mk_dir(NULL, "dasd", NULL)) {
+	if (devfs_mk_dir("dasd")) {
 		DBF_EVENT(DBF_ALERT, "%s", "no devfs");
 		rc = -ENOSYS;
 		goto failed;
diff -Nru a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
--- a/drivers/s390/block/xpram.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/s390/block/xpram.c	Sat Mar 22 15:38:05 2003
@@ -434,7 +434,7 @@
 	if (rc < 0)
 		goto out;
 
-	devfs_mk_dir(NULL, "slram", NULL);
+	devfs_mk_dir("slram");
 
 	/*
 	 * Assign the other needed values: make request function, sizes and
diff -Nru a/drivers/s390/char/tubfs.c b/drivers/s390/char/tubfs.c
--- a/drivers/s390/char/tubfs.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/s390/char/tubfs.c	Sat Mar 22 15:38:05 2003
@@ -73,7 +73,7 @@
 		return -1;
 	}
 #ifdef CONFIG_DEVFS_FS
-	fs3270_devfs_dir = devfs_mk_dir(NULL, "3270", NULL);
+	fs3270_devfs_dir = devfs_mk_dir("3270");
 	fs3270_devfs_tub = 
 		devfs_register(fs3270_devfs_dir, "tub", DEVFS_FL_DEFAULT,
 			       IBM_FS3270_MAJOR, 0,
diff -Nru a/drivers/sbus/char/bpp.c b/drivers/sbus/char/bpp.c
--- a/drivers/sbus/char/bpp.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/sbus/char/bpp.c	Sat Mar 22 15:38:04 2003
@@ -1049,7 +1049,7 @@
 		instances[idx].opened = 0;
 		probeLptPort(idx);
 	}
-	devfs_mk_dir (NULL, "bpp", NULL);
+	devfs_mk_dir("bpp");
 	for (idx = 0; idx < BPP_NO; idx++) {
 		char name[16];
 		sprintf(name, "bpp/%d", idx);
diff -Nru a/drivers/sbus/char/vfc_dev.c b/drivers/sbus/char/vfc_dev.c
--- a/drivers/sbus/char/vfc_dev.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/sbus/char/vfc_dev.c	Sat Mar 22 15:38:05 2003
@@ -681,7 +681,7 @@
 		kfree(vfc_dev_lst);
 		return -EIO;
 	}
-	devfs_mk_dir (NULL, "vfc", NULL);
+	devfs_mk_dir("vfc");
 	instance = 0;
 	for_all_sbusdev(sdev, sbus) {
 		if (strcmp(sdev->prom_name, "vfc") == 0) {
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/scsi/scsi.c	Sat Mar 22 15:38:05 2003
@@ -1495,7 +1495,7 @@
 		INIT_LIST_HEAD(&done_q[i]);
 
 	scsi_host_init();
-	devfs_mk_dir(NULL, "scsi", NULL);
+	devfs_mk_dir("scsi");
 	open_softirq(SCSI_SOFTIRQ, scsi_softirq, NULL);
 	printk(KERN_NOTICE "SCSI subsystem initialized\n");
 	return 0;
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/scsi/scsi_scan.c	Sat Mar 22 15:38:05 2003
@@ -1128,8 +1128,6 @@
 static int scsi_add_lun(Scsi_Device *sdev, Scsi_Request *sreq,
 		char *inq_result, int *bflags)
 {
-	char devname[64];
-
 	/*
 	 * XXX do not save the inquiry, since it can change underneath us,
 	 * save just vendor/model/rev.
@@ -1230,13 +1228,10 @@
 	
 	scsi_device_register(sdev);
 
-	sprintf(devname, "scsi/host%d/bus%d/target%d/lun%d",
-		sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
-	if (sdev->de)
-		printk(KERN_WARNING "scsi devfs dir: \"%s\" already exists\n",
-		       devname);
-	else
-		sdev->de = devfs_mk_dir(NULL, devname, NULL);
+	sdev->de = devfs_mk_dir("scsi/host%d/bus%d/target%d/lun%d",
+				sdev->host->host_no, sdev->channel,
+				sdev->id, sdev->lun);
+
 	/*
 	 * End driverfs/devfs code.
 	 */
diff -Nru a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c	Sat Mar 22 15:38:05 2003
+++ b/drivers/usb/core/file.c	Sat Mar 22 15:38:05 2003
@@ -76,7 +76,7 @@
 		return -EBUSY;
 	}
 
-	usb_devfs_handle = devfs_mk_dir(NULL, "usb", NULL);
+	usb_devfs_handle = devfs_mk_dir("usb");
 
 	return 0;
 }
diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/usb/input/hiddev.c	Sat Mar 22 15:38:04 2003
@@ -774,7 +774,7 @@
 
 int __init hiddev_init(void)
 {
-	hiddev_devfs_handle = devfs_mk_dir(NULL, "usb/hid", NULL);
+	hiddev_devfs_handle = devfs_mk_dir("usb/hid");
 	usb_register(&hiddev_driver);
 	return 0;
 }
diff -Nru a/drivers/usb/misc/tiglusb.c b/drivers/usb/misc/tiglusb.c
--- a/drivers/usb/misc/tiglusb.c	Sat Mar 22 15:38:04 2003
+++ b/drivers/usb/misc/tiglusb.c	Sat Mar 22 15:38:04 2003
@@ -478,7 +478,7 @@
 	}
 
 	/* Use devfs, tree: /dev/ticables/usb/[0..3] */
-	devfs_mk_dir (NULL, "ticables/usb", NULL);
+	devfs_mk_dir ("ticables/usb");
 
 	/* register USB module */
 	result = usb_register (&tiglusb_driver);
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Sat Mar 22 15:38:03 2003
+++ b/drivers/video/fbmem.c	Sat Mar 22 15:38:03 2003
@@ -1132,7 +1132,7 @@
 
 	create_proc_read_entry("fb", 0, 0, fbmem_read_proc, NULL);
 
-	devfs_mk_dir(NULL, "fb", NULL);
+	devfs_mk_dir("fb");
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
 
diff -Nru a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Sat Mar 22 15:38:04 2003
+++ b/fs/devfs/base.c	Sat Mar 22 15:38:04 2003
@@ -1682,10 +1682,8 @@
 
 /**
  *	devfs_mk_dir - Create a directory in the devfs namespace.
- *	@dir: The handle to the parent devfs directory entry. If this is %NULL the
  *		new name is relative to the root of the devfs.
- *	@name: The name of the entry.
- *	@info: An arbitrary pointer which will be associated with the entry.
+ *	@fmt: The name of the entry.
  *
  *	Use of this function is optional. The devfs_register() function
  *	will automatically create intermediate directories as needed. This function
@@ -1694,36 +1692,42 @@
  *	On failure %NULL is returned.
  */
 
-devfs_handle_t devfs_mk_dir (devfs_handle_t dir, const char *name, void *info)
+devfs_handle_t devfs_mk_dir(const char *fmt, ...)
 {
-    int err;
-    struct devfs_entry *de, *old;
+	struct devfs_entry *dir = NULL, *de = NULL, *old;
+	char buf[64];
+	va_list args;
+	int n;
 
-    if (name == NULL)
-    {
-	PRINTK ("(): NULL name pointer\n");
-	return NULL;
-    }
-    if ( ( de = _devfs_prepare_leaf (&dir, name, MODE_DIR) ) == NULL )
-    {
-	PRINTK ("(%s): could not prepare leaf\n", name);
-	return NULL;
-    }
-    de->info = info;
-    if ( ( err = _devfs_append_entry (dir, de, &old) ) != 0 )
-    {
-	PRINTK ("(%s): could not append to dir: %p \"%s\", err: %d\n",
-		name, dir, dir->name, err);
-	devfs_put (old);
-	devfs_put (dir);
-	return NULL;
-    }
-    DPRINTK (DEBUG_REGISTER, "(%s): de: %p dir: %p \"%s\"\n",
-	     name, de, dir, dir->name);
-    devfsd_notify (de, DEVFSD_NOTIFY_REGISTERED, 0);
-    devfs_put (dir);
-    return de;
-}   /*  End Function devfs_mk_dir  */
+	va_start(args, fmt);
+	n = vsnprintf(buf, 64, fmt, args);
+	if (n >= 64 || !buf[0]) {
+		printk(KERN_WARNING "%s: invalid argument.", __FUNCTION__);
+		return NULL;
+	}
+
+	de = _devfs_prepare_leaf(&dir, buf, MODE_DIR);
+	if (!de) {
+		PRINTK("(%s): could not prepare leaf\n", buf);
+		return NULL;
+	}
+
+	de->info = NULL;
+	if (_devfs_append_entry(dir, de, &old)) {
+		PRINTK("(%s): could not append to dir: %p \"%s\"\n",
+				buf, dir, dir->name);
+		devfs_put(old);
+		goto out_put;
+	}
+	
+	DPRINTK(DEBUG_REGISTER, "(%s): de: %p dir: %p \"%s\"\n",
+			buf, de, dir, dir->name);
+	devfsd_notify(de, DEVFSD_NOTIFY_REGISTERED, 0);
+
+ out_put:
+	devfs_put(dir);
+	return de;
+}
 
 
 void devfs_remove(const char *fmt, ...)
diff -Nru a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Sat Mar 22 15:38:05 2003
+++ b/fs/partitions/check.c	Sat Mar 22 15:38:05 2003
@@ -200,7 +200,7 @@
 		/*  Unaware driver: construct "real" directory  */
 		sprintf(dirname, "../%s/disc%d", dev->disk_name,
 			dev->first_minor >> dev->minor_shift);
-		dir = devfs_mk_dir(NULL, dirname + 3, NULL);
+		dir = devfs_mk_dir(dirname + 3);
 		dev->de = dir;
 	}
 	dev->number = devfs_alloc_unique_number (&disc_numspace);
diff -Nru a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h	Sat Mar 22 15:38:05 2003
+++ b/include/linux/devfs_fs_kernel.h	Sat Mar 22 15:38:05 2003
@@ -22,8 +22,6 @@
 
 #ifdef CONFIG_DEVFS_FS
 
-extern void devfs_remove(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-
 struct unique_numspace
 {
     spinlock_t init_lock;
@@ -42,8 +40,10 @@
 				      umode_t mode, void *ops, void *info);
 extern void devfs_unregister (devfs_handle_t de);
 extern int devfs_mk_symlink (const char *name, const char *link);
-extern devfs_handle_t devfs_mk_dir (devfs_handle_t dir, const char *name,
-				    void *info);
+extern devfs_handle_t devfs_mk_dir(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
+extern void devfs_remove(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
 extern int devfs_generate_path (devfs_handle_t de, char *path, int buflen);
 extern int devfs_register_tape (devfs_handle_t de);
 extern void devfs_unregister_tape(int num);
@@ -80,8 +80,7 @@
 {
     return 0;
 }
-static inline devfs_handle_t devfs_mk_dir (devfs_handle_t dir,
-					   const char *name, void *info)
+static inline devfs_handle_t devfs_mk_dir(const char *fmt, ...)
 {
     return NULL;
 }
diff -Nru a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c	Sat Mar 22 15:38:04 2003
+++ b/mm/shmem.c	Sat Mar 22 15:38:04 2003
@@ -1882,7 +1882,7 @@
 		goto out2;
 	}
 #ifdef CONFIG_TMPFS
-	devfs_mk_dir(NULL, "shm", NULL);
+	devfs_mk_dir("shm");
 #endif
 	shm_mnt = kern_mount(&tmpfs_fs_type);
 	if (IS_ERR(shm_mnt)) {
diff -Nru a/net/netlink/netlink_dev.c b/net/netlink/netlink_dev.c
--- a/net/netlink/netlink_dev.c	Sat Mar 22 15:38:04 2003
+++ b/net/netlink/netlink_dev.c	Sat Mar 22 15:38:04 2003
@@ -198,7 +198,7 @@
 		printk(KERN_ERR "netlink: unable to get major %d\n", NETLINK_MAJOR);
 		return -EIO;
 	}
-	devfs_mk_dir (NULL, "netlink", NULL);
+	devfs_mk_dir("netlink");
 	/*  Someone tell me the official names for the uppercase ones  */
 	for (i = 0; i < sizeof(entries)/sizeof(entries[0]); i++) {
 		char name[20];
diff -Nru a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c	Sat Mar 22 15:38:05 2003
+++ b/sound/core/sound.c	Sat Mar 22 15:38:05 2003
@@ -346,7 +346,7 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
 	devfs_handle = devfs_mk_dir(NULL, "snd", 3, NULL);
 #else
-	devfs_handle = devfs_mk_dir(NULL, "snd", NULL);
+	devfs_handle = devfs_mk_dir("snd");
 #endif
 #endif
 	if (register_chrdev(major, "alsa", &snd_fops)) {
diff -Nru a/sound/sound_core.c b/sound/sound_core.c
--- a/sound/sound_core.c	Sat Mar 22 15:38:05 2003
+++ b/sound/sound_core.c	Sat Mar 22 15:38:05 2003
@@ -567,7 +567,7 @@
 		printk(KERN_ERR "soundcore: sound device already in use.\n");
 		return -EBUSY;
 	}
-	devfs_mk_dir (NULL, "sound", NULL);
+	devfs_mk_dir ("sound");
 
 	return 0;
 }
