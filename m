Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261706AbTCGSjc>; Fri, 7 Mar 2003 13:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbTCGSjc>; Fri, 7 Mar 2003 13:39:32 -0500
Received: from hera.cwi.nl ([192.16.191.8]:37863 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261706AbTCGSjH>;
	Fri, 7 Mar 2003 13:39:07 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 7 Mar 2003 19:49:40 +0100 (MET)
Message-Id: <UTC200303071849.h27Ineg11598.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] register_blkdev
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch does the following:

- static const char *blkdevs[MAX_BLKDEV]; disappears
- get_blkdev_list, (un)register_blkdev, __bdevname
  are moved from block_dev.c to genhd.c
- the third "fops" parameter of register_blkdev was unused;
  now removed everywhere
- zillions of places had printk("cannot get major") upon
  error return from register_blkdev; removed all of these
  and inserted a single printk in register_blkdev.

Of course the reason for the patch is that one fixed size
array is eliminated.

Andries

-----
diff -u --recursive --new-file -X /linux/dontdiff a/Documentation/cdrom/cdrom-standard.tex b/Documentation/cdrom/cdrom-standard.tex
--- a/Documentation/cdrom/cdrom-standard.tex	Fri Nov 22 22:40:24 2002
+++ b/Documentation/cdrom/cdrom-standard.tex	Fri Mar  7 19:02:00 2003
@@ -758,11 +758,8 @@
 \subsection{$Struct\ file_operations\ cdrom_fops$}
 
 The contents of this structure were described in section~\ref{cdrom.c}.
-As already stated, this structure should be used to register block
-devices with the kernel:
-$$
-register_blkdev(major, <name>, \&cdrom_fops);
-$$
+A pointer to this structure is assigned to the $fops$ field
+of the $struct gendisk$.
 
 \subsection{$Int\ register_cdrom( struct\ cdrom_device_info\ * cdi)$}
 
diff -u --recursive --new-file -X /linux/dontdiff a/arch/m68k/atari/stram.c b/arch/m68k/atari/stram.c
--- a/arch/m68k/atari/stram.c	Sat Jan 18 23:54:38 2003
+++ b/arch/m68k/atari/stram.c	Fri Mar  7 19:02:00 2003
@@ -1052,8 +1052,7 @@
 	if (!stram_disk)
 		return -ENOMEM;
 
-	if (register_blkdev( STRAM_MAJOR, "stram", &stram_fops)) {
-		printk(KERN_ERR "stram: Unable to get major %d\n", STRAM_MAJOR);
+	if (register_blkdev(STRAM_MAJOR, "stram")) {
 		put_disk(stram_disk);
 		return -ENXIO;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
--- a/arch/um/drivers/ubd_kern.c	Tue Feb 11 09:14:17 2003
+++ b/arch/um/drivers/ubd_kern.c	Fri Mar  7 19:02:00 2003
@@ -673,7 +673,7 @@
 static int ubd_mc_init(void)
 {
 	mconsole_register_dev(&ubd_mc);
-	return(0);
+	return 0;
 }
 
 __initcall(ubd_mc_init);
@@ -682,29 +682,24 @@
 {
         int i;
 
-	ubd_dir_handle = devfs_mk_dir (NULL, "ubd", NULL);
-	if(register_blkdev(MAJOR_NR, "ubd", &ubd_blops)){
-		printk(KERN_ERR "ubd: unable to get major %d\n", MAJOR_NR);
+	ubd_dir_handle = devfs_mk_dir(NULL, "ubd", NULL);
+	if (register_blkdev(MAJOR_NR, "ubd"))
 		return -1;
-	}
 
 	blk_init_queue(&ubd_queue, do_ubd_request, &ubd_io_lock);
 	elevator_init(&ubd_queue, &elevator_noop);
 
-	if(fake_major != 0){
+	if (fake_major != 0) {
 		char name[sizeof("ubd_nnn\0")];
 
 		snprintf(name, sizeof(name), "ubd_%d", fake_major);
 		ubd_fake_dir_handle = devfs_mk_dir(NULL, name, NULL);
-		if(register_blkdev(fake_major, "ubd", &ubd_blops)){
-			printk(KERN_ERR "ubd: unable to get major %d\n",
-			       fake_major);
+		if (register_blkdev(fake_major, "ubd"))
 			return -1;
-		}
 	}
-	for(i = 0; i < MAX_DEV; i++) 
+	for (i = 0; i < MAX_DEV; i++) 
 		ubd_add(i);
-	return(0);
+	return 0;
 }
 
 late_initcall(ubd_init);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/acorn/block/fd1772.c b/drivers/acorn/block/fd1772.c
--- a/drivers/acorn/block/fd1772.c	Wed Mar  5 10:47:19 2003
+++ b/drivers/acorn/block/fd1772.c	Fri Mar  7 19:02:00 2003
@@ -1539,11 +1539,9 @@
 			goto err_disk;
 	}
 
-	err = register_blkdev(MAJOR_NR, "fd", &floppy_fops);
-	if (err) {
-		printk("Unable to get major %d for floppy\n", MAJOR_NR);
+	err = register_blkdev(MAJOR_NR, "fd");
+	if (err)
 		goto err_disk;
-	}
 
 	err = -EBUSY;
 	if (request_dma(FLOPPY_DMA, "fd1772")) {
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/acorn/block/mfmhd.c b/drivers/acorn/block/mfmhd.c
--- a/drivers/acorn/block/mfmhd.c	Wed Mar  5 10:47:19 2003
+++ b/drivers/acorn/block/mfmhd.c	Fri Mar  7 19:02:00 2003
@@ -1267,11 +1267,9 @@
 	if (!request_region (mfm_addr, 10, "mfm"))
 		goto out1;
 
-	ret = register_blkdev(MAJOR_NR, "mfm", &mfm_fops);
-	if (ret) {
-		printk("mfm_init: unable to get major number %d\n", MAJOR_NR);
+	ret = register_blkdev(MAJOR_NR, "mfm");
+	if (ret)
 		goto out2;
-	}
 
 	/* Stuff for the assembler routines to get to */
 	hdc63463_baseaddress	= ioaddr(mfm_addr);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/DAC960.c b/drivers/block/DAC960.c
--- a/drivers/block/DAC960.c	Sat Feb 15 20:41:56 2003
+++ b/drivers/block/DAC960.c	Fri Mar  7 19:02:00 2003
@@ -13,9 +13,6 @@
   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
   for complete details.
 
-  The author respectfully requests that any modifications to this software be
-  sent directly to him for evaluation and testing.
-
 */
 
 
@@ -2381,13 +2378,9 @@
   /*
     Register the Block Device Major Number for this DAC960 Controller.
   */
-  if (register_blkdev(MajorNumber, "dac960",
-			    &DAC960_BlockDeviceOperations) < 0)
-    {
-      DAC960_Error("UNABLE TO ACQUIRE MAJOR NUMBER %d - DETACHING\n",
-		   Controller, MajorNumber);
+  if (register_blkdev(MajorNumber, "dac960") < 0)
       return false;
-    }
+
   /*
     Initialize the I/O Request Queue.
   */
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/acsi.c b/drivers/block/acsi.c
--- a/drivers/block/acsi.c	Thu Jan  2 14:32:02 2003
+++ b/drivers/block/acsi.c	Fri Mar  7 19:02:00 2003
@@ -1613,7 +1613,6 @@
 
 
 int acsi_init( void )
-
 {
 	int err = 0;
 	int i, target, lun;
@@ -1623,8 +1622,7 @@
 #endif
 	if (!MACH_IS_ATARI || !ATARIHW_PRESENT(ACSI))
 		return 0;
-	if (register_blkdev( ACSI_MAJOR, "ad", &acsi_fops )) {
-		printk( KERN_ERR "Unable to get major %d for ACSI\n", ACSI_MAJOR );
+	if (register_blkdev(ACSI_MAJOR, "ad")) {
 		err = -EBUSY;
 		goto out1;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/amiflop.c b/drivers/block/amiflop.c
--- a/drivers/block/amiflop.c	Thu Jan  2 14:32:02 2003
+++ b/drivers/block/amiflop.c	Fri Mar  7 19:02:00 2003
@@ -1754,10 +1754,9 @@
 	if (!AMIGAHW_PRESENT(AMI_FLOPPY))
 		return -ENXIO;
 
-	if (register_blkdev(FLOPPY_MAJOR,"fd",&floppy_fops)) {
-		printk("fd: Unable to get major %d for floppy\n",FLOPPY_MAJOR);
+	if (register_blkdev(FLOPPY_MAJOR,"fd"))
 		return -EBUSY;
-	}
+
 	/*
 	 *  We request DSKPTR, DSKLEN and DSKDATA only, because the other
 	 *  floppy registers are too spreaded over the custom register space
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/ataflop.c b/drivers/block/ataflop.c
--- a/drivers/block/ataflop.c	Thu Jan  2 14:32:02 2003
+++ b/drivers/block/ataflop.c	Fri Mar  7 19:02:00 2003
@@ -1929,10 +1929,8 @@
 		/* Hades doesn't have Atari-compatible floppy */
 		return -ENXIO;
 
-	if (register_blkdev(FLOPPY_MAJOR,"fd",&floppy_fops)) {
-		printk(KERN_ERR "Unable to get major %d for floppy\n",FLOPPY_MAJOR);
+	if (register_blkdev(FLOPPY_MAJOR,"fd"))
 		return -EBUSY;
-	}
 
 	for (i = 0; i < FD_MAX_UNITS; i++) {
 		unit[i].disk = alloc_disk(1);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/cciss.c b/drivers/block/cciss.c
--- a/drivers/block/cciss.c	Wed Mar  5 10:47:19 2003
+++ b/drivers/block/cciss.c	Fri Mar  7 19:02:00 2003
@@ -2437,14 +2437,12 @@
 		return -ENODEV;
 	}
 
-	if( register_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname, &cciss_fops))
-	{
-		printk(KERN_ERR "cciss:  Unable to get major number "
-			"%d for %s\n", COMPAQ_CISS_MAJOR+i, hba[i]->devname);
+	if (register_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname)) {
 		release_io_mem(hba[i]);
 		free_hba(i);
-		return(-1);
+		return -1;
 	}
+
 	/* make sure the board interrupts are off */
 	hba[i]->access.set_intr_mask(hba[i], CCISS_INTR_OFF);
 	if( request_irq(hba[i]->intr, do_cciss_intr, 
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c	Wed Mar  5 10:47:19 2003
+++ b/drivers/block/cpqarray.c	Fri Mar  7 19:02:00 2003
@@ -339,11 +339,9 @@
 	for(i=0; i < nr_ctlr; i++) {
 	  	/* If this successful it should insure that we are the only */
 		/* instance of the driver */	
-		if (register_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname, &ida_fops)) {
-                        printk(KERN_ERR "cpqarray: Unable to get major number %d for ida\n",
-                                COMPAQ_SMART2_MAJOR+i);
+		if (register_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname))
                         continue;
-                }
+
 		hba[i]->access.set_intr_mask(hba[i], 0);
 		if (request_irq(hba[i]->intr, do_ida_intr,
 			SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i])) {
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Mon Feb 24 23:02:47 2003
+++ b/drivers/block/floppy.c	Fri Mar  7 19:02:00 2003
@@ -4232,8 +4232,7 @@
 	}
 
 	devfs_mk_dir (NULL, "floppy", NULL);
-	if (register_blkdev(FLOPPY_MAJOR,"fd",&floppy_fops)) {
-		printk("Unable to get major %d for floppy\n",FLOPPY_MAJOR);
+	if (register_blkdev(FLOPPY_MAJOR,"fd")) {
 		err = -EBUSY;
 		goto out;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	Wed Mar  5 10:47:19 2003
+++ b/drivers/block/genhd.c	Fri Mar  7 19:13:42 2003
@@ -14,10 +14,16 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 
+#define MAX_PROBE_HASH 255	/* random */
 
 static struct subsystem block_subsys;
 
-#define MAX_PROBE_HASH 23	/* random */
+/* Can be merged with blk_probe or deleted altogether. Later. */
+static struct blk_major_name {
+	struct blk_major_name *next;
+	int major;
+	char name[16];
+} *major_names[MAX_PROBE_HASH];
 
 static struct blk_probe {
 	struct blk_probe *next;
@@ -30,9 +36,132 @@
 } *probes[MAX_PROBE_HASH];
 
 /* index in the above - for now: assume no multimajor ranges */
+static inline int major_to_index(int major)
+{
+	return major % MAX_PROBE_HASH;
+}
+
 static inline int dev_to_index(dev_t dev)
 {
-	return MAJOR(dev) % MAX_PROBE_HASH;
+	return major_to_index(MAJOR(dev));
+}
+
+const char *__bdevname(dev_t dev)
+{
+	static char buffer[40];
+	char *name = "unknown-block";
+	unsigned int major = MAJOR(dev);
+	unsigned int minor = MINOR(dev);
+	int index = major_to_index(major);
+	struct blk_major_name *n;
+
+	down_read(&block_subsys.rwsem);
+	for (n = major_names[index]; n; n = n->next)
+		if (n->major == major)
+			break;
+	if (n)
+		name = &(n->name[0]);
+	sprintf(buffer, "%s(%u,%u)", name, major, minor);
+	up_read(&block_subsys.rwsem);
+
+	return buffer;
+}
+
+/* get block device names in somewhat random order */
+int get_blkdev_list(char *p)
+{
+	struct blk_major_name *n;
+	int i, len;
+
+	len = sprintf(p, "\nBlock devices:\n");
+
+	down_read(&block_subsys.rwsem);
+	for (i = 0; i < ARRAY_SIZE(major_names); i++) {
+		for (n = major_names[i]; n; n = n->next)
+			len += sprintf(p+len, "%3d %s\n",
+				       n->major, n->name);
+	}
+	up_read(&block_subsys.rwsem);
+
+	return len;
+}
+
+int register_blkdev(unsigned int major, const char *name)
+{
+	struct blk_major_name **n, *p;
+	int index, ret = 0;
+
+	if (devfs_only())
+		return 0;
+
+	/* temporary */
+	if (major == 0) {
+		down_read(&block_subsys.rwsem);
+		for (index = ARRAY_SIZE(major_names)-1; index > 0; index--)
+			if (major_names[index] == NULL)
+				break;
+		up_read(&block_subsys.rwsem);
+
+		if (index == 0) {
+			printk("register_blkdev: failed to get major for %s\n",
+			       name);
+			return -EBUSY;
+		}
+		ret = major = index;
+	}
+
+	p = kmalloc(sizeof(struct blk_major_name), GFP_KERNEL);
+	if (p == NULL)
+		return -ENOMEM;
+
+	p->major = major;
+	strncpy(p->name, name, sizeof(p->name)-1);
+	p->name[sizeof(p->name)-1] = 0;
+	p->next = 0;
+	index = major_to_index(major);
+
+	down_write(&block_subsys.rwsem);
+	for (n = &major_names[index]; *n; n = &(*n)->next)
+		if ((*n)->major == major)
+			break;
+	if (!*n)
+		*n = p;
+	else
+		ret = -EBUSY;
+	up_write(&block_subsys.rwsem);
+
+	if (ret < 0)
+		printk("register_blkdev: cannot get major %d for %s\n",
+		       major, name);
+
+	return ret;
+}
+
+/* todo: make void - error printk here */
+int unregister_blkdev(unsigned int major, const char *name)
+{
+	struct blk_major_name **n, *p;
+	int index;
+	int ret = 0;
+
+	if (devfs_only())
+		return 0;
+	index = major_to_index(major);
+
+	down_write(&block_subsys.rwsem);
+	for (n = &major_names[index]; *n; n = &(*n)->next)
+		if ((*n)->major == major)
+			break;
+	if (!*n || strcmp((*n)->name, name))
+		ret = -EINVAL;
+	else {
+		p = *n;
+		*n = p->next;
+		kfree(p);
+	}
+	up_write(&block_subsys.rwsem);
+
+	return ret;
 }
 
 /*
@@ -48,6 +177,9 @@
 	struct blk_probe *p = kmalloc(sizeof(struct blk_probe), GFP_KERNEL);
 	struct blk_probe **s;
 
+	if (p == NULL)
+		return;
+
 	p->owner = module;
 	p->get = probe;
 	p->lock = lock;
@@ -98,9 +230,9 @@
 
 /**
  * add_gendisk - add partitioning information to kernel list
- * @gp: per-device partitioning information
+ * @disk: per-device partitioning information
  *
- * This function registers the partitioning information in @gp
+ * This function registers the partitioning information in @disk
  * with the kernel.
  */
 void add_disk(struct gendisk *disk)
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Wed Mar  5 10:47:19 2003
+++ b/drivers/block/loop.c	Fri Mar  7 19:02:00 2003
@@ -1017,11 +1017,8 @@
 		max_loop = 8;
 	}
 
-	if (register_blkdev(LOOP_MAJOR, "loop", &lo_fops)) {
-		printk(KERN_WARNING "Unable to get major number %d for loop"
-				    " device\n", LOOP_MAJOR);
+	if (register_blkdev(LOOP_MAJOR, "loop"))
 		return -EIO;
-	}
 
 	devfs_mk_dir(NULL, "loop", NULL);
 
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c	Sat Feb 15 20:41:56 2003
+++ b/drivers/block/nbd.c	Fri Mar  7 19:02:00 2003
@@ -564,9 +564,7 @@
 		nbd_dev[i].disk = disk;
 	}
 
-	if (register_blkdev(NBD_MAJOR, "nbd", &nbd_fops)) {
-		printk("Unable to get major number %d for NBD\n",
-		       NBD_MAJOR);
+	if (register_blkdev(NBD_MAJOR, "nbd")) {
 		err = -EIO;
 		goto out;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
--- a/drivers/block/paride/pcd.c	Tue Dec 10 18:42:30 2002
+++ b/drivers/block/paride/pcd.c	Fri Mar  7 19:02:00 2003
@@ -942,8 +942,7 @@
 	/* get the atapi capabilities page */
 	pcd_probe_capabilities();
 
-	if (register_blkdev(major, name, &pcd_bdops)) {
-		printk("pcd: unable to get major number %d\n", major);
+	if (register_blkdev(major, name)) {
 		for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
 			put_disk(cd->disk);
 		return -1;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
--- a/drivers/block/paride/pd.c	Tue Dec 10 18:42:30 2002
+++ b/drivers/block/paride/pd.c	Fri Mar  7 19:02:00 2003
@@ -890,10 +890,9 @@
 {
 	if (disable)
 		return -1;
-	if (register_blkdev(major, name, &pd_fops)) {
-		printk("%s: unable to get major number %d\n", name, major);
+	if (register_blkdev(major, name))
 		return -1;
-	}
+
 	blk_init_queue(&pd_queue, do_pd_request, &pd_lock);
 	blk_queue_max_sectors(&pd_queue, cluster);
 
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
--- a/drivers/block/paride/pf.c	Tue Dec 10 18:42:30 2002
+++ b/drivers/block/paride/pf.c	Fri Mar  7 19:02:00 2003
@@ -957,8 +957,7 @@
 		return -1;
 	pf_busy = 0;
 
-	if (register_blkdev(major, name, &pf_fops)) {
-		printk("pf_init: unable to get major number %d\n", major);
+	if (register_blkdev(major, name)) {
 		for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
 			put_disk(pf->disk);
 		return -1;
@@ -969,6 +968,7 @@
 
 	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
 		struct gendisk *disk = pf->disk;
+
 		if (!pf->present)
 			continue;
 		disk->private_data = pf;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/ps2esdi.c b/drivers/block/ps2esdi.c
--- a/drivers/block/ps2esdi.c	Tue Dec 10 18:42:30 2002
+++ b/drivers/block/ps2esdi.c	Fri Mar  7 19:02:00 2003
@@ -146,13 +146,10 @@
 
 	int error = 0;
 
-	/* register the device - pass the name, major number and operations
-	   vector .                                                 */
-	if (register_blkdev(PS2ESDI_MAJOR, "ed", &ps2esdi_fops)) {
-		printk("%s: Unable to get major number %d\n", DEVICE_NAME,
-				PS2ESDI_MAJOR);
+	/* register the device - pass the name and major number */
+	if (register_blkdev(PS2ESDI_MAJOR, "ed"))
 		return -1;
-	}
+
 	/* set up some global information - indicating device specific info */
 	blk_init_queue(&ps2esdi_queue, do_ps2esdi_request, &ps2esdi_lock);
 
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c	Wed Dec 18 12:51:59 2002
+++ b/drivers/block/rd.c	Fri Mar  7 19:02:00 2003
@@ -409,8 +409,7 @@
 			goto out;
 	}
 
-	if (register_blkdev(RAMDISK_MAJOR, "ramdisk", &rd_bd_op)) {
-		printk("RAMDISK: Could not get major %d", RAMDISK_MAJOR);
+	if (register_blkdev(RAMDISK_MAJOR, "ramdisk")) {
 		err = -EIO;
 		goto out;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/swim3.c b/drivers/block/swim3.c
--- a/drivers/block/swim3.c	Tue Dec 10 18:42:30 2002
+++ b/drivers/block/swim3.c	Fri Mar  7 19:02:00 2003
@@ -1004,9 +1004,7 @@
 			goto out;
 	}
 
-	if (register_blkdev(FLOPPY_MAJOR, "fd", &floppy_fops)) {
-		printk(KERN_ERR"Unable to get major %d for floppy\n",
-				FLOPPY_MAJOR);
+	if (register_blkdev(FLOPPY_MAJOR, "fd")) {
 		err = -EBUSY;
 		goto out;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/swim_iop.c b/drivers/block/swim_iop.c
--- a/drivers/block/swim_iop.c	Thu Jan  2 14:32:02 2003
+++ b/drivers/block/swim_iop.c	Fri Mar  7 19:02:00 2003
@@ -137,13 +137,12 @@
 	current_req = NULL;
 	floppy_count = 0;
 
-	if (!iop_ism_present) return -ENODEV;
+	if (!iop_ism_present)
+		return -ENODEV;
 
-	if (register_blkdev(FLOPPY_MAJOR, "fd", &floppy_fops)) {
-		printk(KERN_ERR "SWIM-IOP: Unable to get major %d for floppy\n",
-		       FLOPPY_MAJOR);
+	if (register_blkdev(FLOPPY_MAJOR, "fd"))
 		return -EBUSY;
-	}
+
 	blk_init_queue(&swim_queue, do_fd_request, &swim_iop_lock);
 	printk("SWIM-IOP: %s by Joshua M. Thompson (funaho@jurai.org)\n",
 		DRIVER_VERSION);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/umem.c b/drivers/block/umem.c
--- a/drivers/block/umem.c	Sat Jan 18 23:54:28 2003
+++ b/drivers/block/umem.c	Fri Mar  7 19:02:00 2003
@@ -1145,11 +1145,9 @@
 	if (retval)
 		return -ENOMEM;
 
-	err = major_nr = register_blkdev(0, "umem", &mm_fops);
-	if (err < 0) {
-		printk(KERN_ERR "MM: Could not register block device\n");
+	err = major_nr = register_blkdev(0, "umem");
+	if (err < 0)
 		return -EIO;
-	}
 
 	for (i = 0; i < num_cards; i++) {
 		mm_gendisk[i] = alloc_disk(1 << MM_SHIFT);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/xd.c b/drivers/block/xd.c
--- a/drivers/block/xd.c	Tue Dec 10 18:42:30 2002
+++ b/drivers/block/xd.c	Fri Mar  7 19:02:00 2003
@@ -154,9 +154,9 @@
 
 #ifdef MODULE
 	for (i = 4; i > 0; i--)
-		if(((xd[i] = xd[i-1]) >= 0) && !count)
+		if (((xd[i] = xd[i-1]) >= 0) && !count)
 			count = i;
-	if((xd[0] = count))
+	if ((xd[0] = count))
 		do_xd_setup(xd);
 #endif
 
@@ -170,10 +170,9 @@
 	}
 
 	err = -EBUSY;
-	if (register_blkdev(XT_DISK_MAJOR,"xd",&xd_fops)) {
-		printk("xd: Unable to get major number %d\n",XT_DISK_MAJOR);
+	if (register_blkdev(XT_DISK_MAJOR, "xd"))
 		goto out1;
-	}
+
 	devfs_mk_dir(NULL, "xd", NULL);
 	blk_init_queue(&xd_queue, do_xd_request, &xd_lock);
 	if (xd_detect(&controller,&address)) {
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/z2ram.c b/drivers/block/z2ram.c
--- a/drivers/block/z2ram.c	Thu Jan  2 14:32:02 2003
+++ b/drivers/block/z2ram.c	Fri Mar  7 19:02:00 2003
@@ -331,21 +331,18 @@
 static struct request_queue z2_queue;
 
 int __init 
-z2_init( void )
+z2_init(void)
 {
 
-    if ( !MACH_IS_AMIGA )
+    if (!MACH_IS_AMIGA)
 	return -ENXIO;
 
-    if ( register_blkdev( Z2RAM_MAJOR, DEVICE_NAME, &z2_fops ) )
-    {
-	printk( KERN_ERR DEVICE_NAME ": Unable to get major %d\n",
-	    Z2RAM_MAJOR );
+    if (register_blkdev(Z2RAM_MAJOR, DEVICE_NAME))
 	return -EBUSY;
-    }
+
     z2ram_gendisk = alloc_disk(1);
     if (!z2ram_gendisk) {
-	unregister_blkdev( Z2RAM_MAJOR, DEVICE_NAME );
+	unregister_blkdev(Z2RAM_MAJOR, DEVICE_NAME);
 	return -ENOMEM;
     }
     z2ram_gendisk->major = Z2RAM_MAJOR;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/cdrom/aztcd.c b/drivers/cdrom/aztcd.c
--- a/drivers/cdrom/aztcd.c	Tue Dec 10 18:42:30 2002
+++ b/drivers/cdrom/aztcd.c	Fri Mar  7 19:02:00 2003
@@ -1910,12 +1910,12 @@
 	azt_disk = alloc_disk(1);
 	if (!azt_disk)
 		goto err_out;
-	if (register_blkdev(MAJOR_NR, "aztcd", &azt_fops) != 0) {
-		printk(KERN_WARNING "aztcd: Unable to get major %d for Aztech"
-		       " CD-ROM\n", MAJOR_NR);
+
+	if (register_blkdev(MAJOR_NR, "aztcd")) {
 		ret = -EIO;
 		goto err_out2;
 	}
+
 	blk_init_queue(&azt_queue, do_aztcd_request, &aztSpin);
 	blk_queue_hardsect_size(&azt_queue, 2048);
 	azt_disk->major = MAJOR_NR;
@@ -1931,7 +1931,7 @@
 	azt_invalidate_buffers();
 	aztPresent = 1;
 	aztCloseDoor();
-	return (0);
+	return 0;
 err_out2:
 	put_disk(azt_disk);
 err_out:
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/cdrom/cdu31a.c b/drivers/cdrom/cdu31a.c
--- a/drivers/cdrom/cdu31a.c	Fri Nov 22 22:40:52 2002
+++ b/drivers/cdrom/cdu31a.c	Fri Mar  7 19:02:00 2003
@@ -3368,11 +3368,8 @@
 	if (!request_region(cdu31a_port, 4, "cdu31a"))
 		goto errout3;
 
-	if (register_blkdev(MAJOR_NR, "cdu31a", &scd_bdops)) {
-		printk("Unable to get major %d for CDU-31a\n",
-		       MAJOR_NR);
+	if (register_blkdev(MAJOR_NR, "cdu31a"))
 		goto errout2;
-	}
 
 	disk = alloc_disk(1);
 	if (!disk)
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/cdrom/cm206.c b/drivers/cdrom/cm206.c
--- a/drivers/cdrom/cm206.c	Fri Nov 22 22:40:59 2002
+++ b/drivers/cdrom/cm206.c	Fri Mar  7 19:02:00 2003
@@ -1489,10 +1489,10 @@
 		goto out_probe;
 	}
 	printk(".\n");
-	if (register_blkdev(MAJOR_NR, "cm206", &cm206_bdops) != 0) {
-		printk(KERN_INFO "Cannot register for major %d!\n", MAJOR_NR);
+
+	if (register_blkdev(MAJOR_NR, "cm206"))
 		goto out_blkdev;
-	}
+
 	disk = alloc_disk(1);
 	if (!disk)
 		goto out_disk;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/cdrom/gscd.c b/drivers/cdrom/gscd.c
--- a/drivers/cdrom/gscd.c	Tue Dec 10 18:42:30 2002
+++ b/drivers/cdrom/gscd.c	Fri Mar  7 19:02:00 2003
@@ -959,12 +959,11 @@
 	gscd_disk->fops = &gscd_fops;
 	sprintf(gscd_disk->disk_name, "gscd");
 
-	if (register_blkdev(MAJOR_NR, "gscd", &gscd_fops) != 0) {
-		printk(KERN_WARNING "GSCD: Unable to get major %d for GoldStar "
-		       "CD-ROM\n", MAJOR_NR);
+	if (register_blkdev(MAJOR_NR, "gscd")) {
 		ret = -EIO;
 		goto err_out2;
 	}
+
 	devfs_register(NULL, "gscd", DEVFS_FL_DEFAULT, MAJOR_NR, 0,
 		       S_IFBLK | S_IRUGO | S_IWUGO, &gscd_fops, NULL);
 
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/cdrom/mcd.c b/drivers/cdrom/mcd.c
--- a/drivers/cdrom/mcd.c	Fri Nov 22 22:40:49 2002
+++ b/drivers/cdrom/mcd.c	Fri Mar  7 19:02:00 2003
@@ -1068,8 +1068,7 @@
 		put_disk(disk);
 		return -EIO;
 	}
-	if (register_blkdev(MAJOR_NR, "mcd", &mcd_bdops) != 0) {
-		printk(KERN_ERR "mcd: Unable to get major %d for Mitsumi CD-ROM\n", MAJOR_NR);
+	if (register_blkdev(MAJOR_NR, "mcd")) {
 		put_disk(disk);
 		return -EIO;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/cdrom/mcdx.c b/drivers/cdrom/mcdx.c
--- a/drivers/cdrom/mcdx.c	Fri Nov 22 22:40:41 2002
+++ b/drivers/cdrom/mcdx.c	Fri Mar  7 19:02:00 2003
@@ -1193,11 +1193,9 @@
 	}
 
 	xtrace(INIT, "init() register blkdev\n");
-	if (register_blkdev(MAJOR_NR, "mcdx", &mcdx_bdops) != 0) {
+	if (register_blkdev(MAJOR_NR, "mcdx")) {
 		release_region((unsigned long) stuffp->wreg_data,
 			       MCDX_IO_SIZE);
-		xwarn("%s=0x%3p,%d: Init failed. Can't get major %d.\n",
-		      MCDX, stuffp->wreg_data, stuffp->irq, MAJOR_NR);
 		kfree(stuffp);
 		put_disk(disk);
 		return 1;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/cdrom/optcd.c b/drivers/cdrom/optcd.c
--- a/drivers/cdrom/optcd.c	Fri Nov 22 22:40:23 2002
+++ b/drivers/cdrom/optcd.c	Fri Mar  7 19:02:00 2003
@@ -2047,8 +2047,7 @@
 		put_disk(optcd_disk);
 		return -EIO;
 	}
-	if (register_blkdev(MAJOR_NR, "optcd", &opt_fops) != 0) {
-		printk(KERN_ERR "optcd: unable to get major %d\n", MAJOR_NR);
+	if (register_blkdev(MAJOR_NR, "optcd")) {
 		release_region(optcd_port, 4);
 		put_disk(optcd_disk);
 		return -EIO;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
--- a/drivers/cdrom/sbpcd.c	Wed Mar  5 10:47:19 2003
+++ b/drivers/cdrom/sbpcd.c	Fri Mar  7 19:02:00 2003
@@ -5795,15 +5795,14 @@
 	OUT(MIXER_data,0xCC); /* one nibble per channel, max. value: 0xFF */
 #endif /* SOUND_BASE */
 
-	if (register_blkdev(MAJOR_NR, major_name, &sbpcd_bdops) != 0)
-	{
-		msg(DBG_INF, "Can't get MAJOR %d for Matsushita CDROM\n", MAJOR_NR);
+	if (register_blkdev(MAJOR_NR, major_name)) {
 #ifdef MODULE
 		return -EIO;
 #else
 		goto init_done;
 #endif /* MODULE */
 	}
+
 	blk_init_queue(&sbpcd_queue, do_sbpcd_request, &sbpcd_lock);
 
 	devfs_mk_dir (NULL, "sbp", NULL);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/cdrom/sjcd.c b/drivers/cdrom/sjcd.c
--- a/drivers/cdrom/sjcd.c	Fri Nov 22 22:40:51 2002
+++ b/drivers/cdrom/sjcd.c	Fri Mar  7 19:02:00 2003
@@ -1677,11 +1677,8 @@
 	printk("SJCD: sjcd=0x%x: ", sjcd_base);
 #endif
 
-	if (register_blkdev(MAJOR_NR, "sjcd", &sjcd_fops) != 0) {
-		printk("SJCD: Unable to get major %d for Sanyo CD-ROM\n",
-		       MAJOR_NR);
-		return (-EIO);
-	}
+	if (register_blkdev(MAJOR_NR, "sjcd"))
+		return -EIO;
 
 	blk_init_queue(&sjcd_queue, do_sjcd_request, &sjcd_lock);
 	blk_queue_hardsect_size(&sjcd_queue, 2048);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/cdrom/sonycd535.c b/drivers/cdrom/sonycd535.c
--- a/drivers/cdrom/sonycd535.c	Thu Jan  2 14:32:02 2003
+++ b/drivers/cdrom/sonycd535.c	Fri Mar  7 19:02:00 2003
@@ -1546,9 +1546,7 @@
 		printk("IRQ%d, ", tmp_irq);
 	printk("using %d byte buffer\n", sony_buffer_size);
 
-	if (register_blkdev(MAJOR_NR, CDU535_HANDLE, &cdu_fops)) {
-		printk("Unable to get major %d for %s\n",
-				MAJOR_NR, CDU535_MESSAGE_NAME);
+	if (register_blkdev(MAJOR_NR, CDU535_HANDLE)) {
 		err = -EIO;
 		goto out1;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Mon Feb 24 23:02:47 2003
+++ b/drivers/ide/ide-probe.c	Fri Mar  7 19:02:00 2003
@@ -1292,11 +1292,8 @@
 	/* we set it back to 1 if all is ok below */	
 	hwif->present = 0;
 
-	if (register_blkdev (hwif->major, hwif->name, ide_fops)) {
-		printk("%s: UNABLE TO GET MAJOR NUMBER %d\n",
-			hwif->name, hwif->major);
+	if (register_blkdev(hwif->major, hwif->name))
 		return 0;
-	}
 
 	if (alloc_disks(hwif) < 0)
 		goto out;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/legacy/hd.c b/drivers/ide/legacy/hd.c
--- a/drivers/ide/legacy/hd.c	Fri Nov 22 22:40:12 2002
+++ b/drivers/ide/legacy/hd.c	Fri Mar  7 19:02:00 2003
@@ -708,10 +708,10 @@
 static int __init hd_init(void)
 {
 	int drive;
-	if (register_blkdev(MAJOR_NR,"hd",&hd_fops)) {
-		printk("hd: unable to get major %d for hard disk\n",MAJOR_NR);
+
+	if (register_blkdev(MAJOR_NR,"hd"))
 		return -1;
-	}
+
 	blk_init_queue(&hd_queue, do_hd_request, &hd_lock);
 	blk_queue_max_sectors(&hd_queue, 255);
 	init_timer(&device_timer);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/md/dm.c b/drivers/md/dm.c
--- a/drivers/md/dm.c	Thu Jan  9 18:07:11 2003
+++ b/drivers/md/dm.c	Fri Mar  7 19:02:00 2003
@@ -79,9 +79,8 @@
 		return -ENOMEM;
 
 	_major = major;
-	r = register_blkdev(_major, _name, &dm_blk_dops);
+	r = register_blkdev(_major, _name);
 	if (r < 0) {
-		DMERR("register_blkdev failed");
 		kmem_cache_destroy(_io_cache);
 		return r;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Wed Mar  5 10:47:21 2003
+++ b/drivers/md/md.c	Fri Mar  7 19:13:00 2003
@@ -3214,11 +3214,10 @@
 			MD_MAJOR_VERSION, MD_MINOR_VERSION,
 			MD_PATCHLEVEL_VERSION, MAX_MD_DEVS, MD_SB_DISKS);
 
-	if (register_blkdev (MAJOR_NR, "md", &md_fops)) {
-		printk(KERN_ALERT "md: Unable to get major %d for md\n", MAJOR_NR);
-		return (-1);
-	}
-	devfs_mk_dir (NULL, "md", NULL);
+	if (register_blkdev(MAJOR_NR, "md"))
+		return -1;
+
+	devfs_mk_dir(NULL, "md", NULL);
 	blk_register_region(MKDEV(MAJOR_NR, 0), MAX_MD_DEVS, THIS_MODULE,
 				md_probe, NULL, NULL);
 	for (minor=0; minor < MAX_MD_DEVS; ++minor) {
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/message/i2o/i2o_block.c b/drivers/message/i2o/i2o_block.c
--- a/drivers/message/i2o/i2o_block.c	Wed Mar  5 10:47:21 2003
+++ b/drivers/message/i2o/i2o_block.c	Fri Mar  7 19:02:00 2003
@@ -1608,12 +1608,8 @@
 	/*
 	 *	Register the block device interfaces
 	 */
-
-	if (register_blkdev(MAJOR_NR, "i2o_block", &i2ob_fops)) {
-		printk(KERN_ERR "Unable to get major number %d for i2o_block\n",
-		       MAJOR_NR);
+	if (register_blkdev(MAJOR_NR, "i2o_block"))
 		return -EIO;
-	}
 
 	for (i = 0; i < MAX_I2OB; i++) {
 		struct gendisk *disk = alloc_disk(16);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
--- a/drivers/mtd/ftl.c	Wed Mar  5 10:47:21 2003
+++ b/drivers/mtd/ftl.c	Fri Mar  7 19:02:00 2003
@@ -1281,11 +1281,9 @@
 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
 	DEBUG(0, "$Id: ftl.c,v 1.39 2001/10/02 15:05:11 dwmw2 Exp $\n");
 
-	if (register_blkdev(FTL_MAJOR, "ftl", &ftl_blk_fops)) {
-		printk(KERN_NOTICE "ftl_cs: unable to grab major "
-		       "device number!\n");
+	if (register_blkdev(FTL_MAJOR, "ftl"))
 		return -EAGAIN;
-	}
+
 	blk_init_queue(&ftl_queue, &do_ftl_request, &lock);
 	register_mtd_user(&ftl_notifier);
 	return 0;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
--- a/drivers/mtd/mtdblock.c	Sat Feb 15 20:41:57 2003
+++ b/drivers/mtd/mtdblock.c	Fri Mar  7 19:02:00 2003
@@ -570,11 +570,10 @@
 int __init init_mtdblock(void)
 {
 	spin_lock_init(&mtdblks_lock);
-	if (register_blkdev(MAJOR_NR,DEVICE_NAME,&mtd_fops)) {
-		printk(KERN_NOTICE "Can't allocate major number %d for Memory Technology Devices.\n",
-		       MTD_BLOCK_MAJOR);
+
+	if (register_blkdev(MAJOR_NR, DEVICE_NAME))
 		return -EAGAIN;
-	}
+
 #ifdef CONFIG_DEVFS_FS
 	devfs_mk_dir(NULL, DEVICE_NAME, NULL);
 #endif
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/mtd/mtdblock_ro.c b/drivers/mtd/mtdblock_ro.c
--- a/drivers/mtd/mtdblock_ro.c	Fri Nov 22 22:40:42 2002
+++ b/drivers/mtd/mtdblock_ro.c	Fri Mar  7 19:02:00 2003
@@ -240,20 +240,13 @@
 
 int __init init_mtdblock(void)
 {
-	int err;
-
-	if (register_blkdev(MAJOR_NR,DEVICE_NAME,&mtd_fops)) {
-		printk(KERN_NOTICE "Can't allocate major number %d for Memory Technology Devices.\n",
-		       MTD_BLOCK_MAJOR);
-		err = -EAGAIN;
-		goto out;
-	}
+	if (register_blkdev(MAJOR_NR, DEVICE_NAME))
+		return -EAGAIN;
 
 	blk_init_queue(&mtdro_queue, &mtdblock_request, &mtdro_lock);
 	register_mtd_user(&notifier);
-	err = 0;
- out:
-	return err;
+
+	return 0;
 }
 
 static void __exit cleanup_mtdblock(void)
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/mtd/nftlcore.c b/drivers/mtd/nftlcore.c
--- a/drivers/mtd/nftlcore.c	Wed Mar  5 10:47:21 2003
+++ b/drivers/mtd/nftlcore.c	Fri Mar  7 19:02:00 2003
@@ -928,10 +928,8 @@
 	printk(KERN_INFO "NFTL driver: nftlcore.c $Revision: 1.82 $, nftlmount.c %s\n", nftlmountrev);
 #endif
 
-	if (register_blkdev(MAJOR_NR, "nftl", &nftl_fops)) {
-		printk("unable to register NFTL block device on major %d\n", MAJOR_NR);
+	if (register_blkdev(MAJOR_NR, "nftl"))
 		return -EBUSY;
-	}
 
 	blk_register_region(MKDEV(MAJOR_NR, 0), 256,
 			THIS_MODULE, nftl_probe, NULL, NULL);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
--- a/drivers/s390/block/dasd_genhd.c	Tue Dec 10 18:42:33 2002
+++ b/drivers/s390/block/dasd_genhd.c	Fri Mar  7 19:02:00 2003
@@ -60,11 +60,8 @@
 	}
 
 	/* Register block device. */
-	new_major = register_blkdev(major, "dasd", &dasd_device_operations);
+	new_major = register_blkdev(major, "dasd");
 	if (new_major < 0) {
-		MESSAGE(KERN_WARNING,
-			"Cannot register to major no %d, rc = %d",
-			major, new_major);
 		kfree(mi);
 		return new_major;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
--- a/drivers/s390/block/xpram.c	Tue Dec 10 18:42:33 2002
+++ b/drivers/s390/block/xpram.c	Fri Mar  7 19:02:00 2003
@@ -430,13 +430,11 @@
 	/*
 	 * Register xpram major.
 	 */
-	rc = register_blkdev(XPRAM_MAJOR, XPRAM_NAME, &xpram_devops);
-	if (rc < 0) {
-		PRINT_ERR("Can't get xpram major %d\n", XPRAM_MAJOR);
+	rc = register_blkdev(XPRAM_MAJOR, XPRAM_NAME);
+	if (rc < 0)
 		goto out;
-	}
 
-	devfs_mk_dir (NULL, "slram", NULL);
+	devfs_mk_dir(NULL, "slram", NULL);
 
 	/*
 	 * Assign the other needed values: make request function, sizes and
@@ -452,6 +450,7 @@
 	for (i = 0; i < xpram_devs; i++) {
 		struct gendisk *disk = xpram_disks[i];
 		char name[16];
+
 		xpram_devices[i].size = xpram_sizes[i] / 4;
 		xpram_devices[i].offset = offset;
 		offset += xpram_devices[i].size;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/s390/char/tape_block.c b/drivers/s390/char/tape_block.c
--- a/drivers/s390/char/tape_block.c	Tue Dec 10 18:42:33 2002
+++ b/drivers/s390/char/tape_block.c	Fri Mar  7 19:02:00 2003
@@ -333,12 +333,10 @@
 	int rc;
 
 	/* Register the tape major number to the kernel */
-	rc = register_blkdev(tapeblock_major, "tBLK", &tapeblock_fops);
-	if (rc < 0) {
-		PRINT_ERR("can't get major %d for block device\n",
-			  tapeblock_major);
+	rc = register_blkdev(tapeblock_major, "tBLK");
+	if (rc < 0)
 		return rc;
-	}
+
 	if (tapeblock_major == 0)
 		tapeblock_major = rc;
 	PRINT_INFO("tape gets major %d for block device\n", tapeblock_major);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
--- a/drivers/sbus/char/jsflash.c	Fri Nov 22 22:40:41 2002
+++ b/drivers/sbus/char/jsflash.c	Fri Mar  7 19:02:00 2003
@@ -570,9 +570,7 @@
 		jsfd_disk[i] = disk;
 	}
 
-	if (register_blkdev(JSFD_MAJOR, "jsfd", &jsfd_fops)) {
-		printk("jsfd_init: unable to get major number %d\n",
-		    JSFD_MAJOR);
+	if (register_blkdev(JSFD_MAJOR, "jsfd")) {
 		err = -EIO;
 		goto out;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Wed Mar  5 10:47:26 2003
+++ b/drivers/scsi/sd.c	Fri Mar  7 19:02:00 2003
@@ -1389,14 +1389,9 @@
 
 	SCSI_LOG_HLQUEUE(3, printk("init_sd: sd driver entry point\n"));
 
-	for (i = 0; i < SD_MAJORS; i++) {
-		if (register_blkdev(sd_major(i), "sd", &sd_fops))
-			printk(KERN_NOTICE
-			       "Unable to get major %d for SCSI disk\n",
-			       sd_major(i));
-		else
+	for (i = 0; i < SD_MAJORS; i++)
+		if (register_blkdev(sd_major(i), "sd") == 0)
 			majors++;
-	}
 
 	if (!majors)
 		return -ENODEV;
@@ -1409,7 +1404,7 @@
 }
 
 /**
- *	exit_sd - exit point for this driver (when it is	a module).
+ *	exit_sd - exit point for this driver (when it is a module).
  *
  *	Note: this function unregisters this driver from the scsi mid-level.
  **/
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	Wed Mar  5 10:47:26 2003
+++ b/drivers/scsi/sr.c	Fri Mar  7 19:02:00 2003
@@ -835,7 +835,7 @@
 {
 	int rc;
 
-	rc = register_blkdev(SCSI_CDROM_MAJOR, "sr", &sr_bdops);
+	rc = register_blkdev(SCSI_CDROM_MAJOR, "sr");
 	if (rc)
 		return rc;
 	return scsi_register_device(&sr_template);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c	Wed Mar  5 10:47:26 2003
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c	Fri Mar  7 19:02:00 2003
@@ -221,7 +221,7 @@
  */
 static void sym_soft_reset (hcb_p np)
 {
-	u_char istat;
+	u_char istat = 0;
 	int i;
 
 	if (!(np->features & FE_ISTAT1) || !(INB (nc_istat1) & SCRUN))
diff -u --recursive --new-file -X /linux/dontdiff a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	Sat Jan 18 23:54:40 2003
+++ b/fs/block_dev.c	Fri Mar  7 19:02:00 2003
@@ -436,56 +436,6 @@
 	spin_unlock(&bdev_lock);
 }
 
-static const char *blkdevs[MAX_BLKDEV];
-
-int get_blkdev_list(char * p)
-{
-	int i;
-	int len;
-
-	len = sprintf(p, "\nBlock devices:\n");
-	for (i = 0; i < MAX_BLKDEV ; i++) {
-		if (blkdevs[i])
-			len += sprintf(p+len, "%3d %s\n", i, blkdevs[i]);
-	}
-	return len;
-}
-
-int register_blkdev(unsigned int major, const char * name, struct block_device_operations *bdops)
-{
-	if (devfs_only())
-		return 0;
-	if (major == 0) {
-		for (major = MAX_BLKDEV-1; major > 0; major--) {
-			if (blkdevs[major] == NULL) {
-				blkdevs[major] = name;
-				return major;
-			}
-		}
-		return -EBUSY;
-	}
-	if (major >= MAX_BLKDEV)
-		return -EINVAL;
-	if (blkdevs[major])
-		return -EBUSY;
-	blkdevs[major] = name;
-	return 0;
-}
-
-int unregister_blkdev(unsigned int major, const char * name)
-{
-	if (devfs_only())
-		return 0;
-	if (major >= MAX_BLKDEV)
-		return -EINVAL;
-	if (!blkdevs[major])
-		return -EINVAL;
-	if (strcmp(blkdevs[major], name))
-		return -EINVAL;
-	blkdevs[major] = NULL;
-	return 0;
-}
-
 /*
  * This routine checks whether a removable media has been changed,
  * and invalidates all buffer-cache-entries in that case. This
@@ -786,18 +736,6 @@
 	return res;
 }
 
-const char *__bdevname(dev_t dev)
-{
-	static char buffer[32];
-	const char * name = blkdevs[MAJOR(dev)];
-
-	if (!name)
-		name = "unknown-block";
-
-	sprintf(buffer, "%s(%d,%d)", name, MAJOR(dev), MINOR(dev));
-	return buffer;
-}
-
 /**
  * lookup_bdev  - lookup a struct block_device by name
  *
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Wed Mar  5 10:47:30 2003
+++ b/include/linux/fs.h	Fri Mar  7 19:02:00 2003
@@ -1033,7 +1033,7 @@
 #define putname(name)	kmem_cache_free(names_cachep, (void *)(name))
 
 enum {BDEV_FILE, BDEV_SWAP, BDEV_FS, BDEV_RAW};
-extern int register_blkdev(unsigned int, const char *, struct block_device_operations *);
+extern int register_blkdev(unsigned int, const char *);
 extern int unregister_blkdev(unsigned int, const char *);
 extern struct block_device *bdget(dev_t);
 extern int bd_acquire(struct inode *inode);
