Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSKMVuP>; Wed, 13 Nov 2002 16:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbSKMVuP>; Wed, 13 Nov 2002 16:50:15 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9988 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264610AbSKMVuH>;
	Wed, 13 Nov 2002 16:50:07 -0500
Date: Wed, 13 Nov 2002 22:56:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: sysfs support for ide disks
Message-ID: <20021113215618.GA8744@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

sc1200 was doing ide disk suspension by hand. That's wrong -- how to
suspend ide-disk has nothing to do with sc1200. This fixes it, and
relies on sysfs to iterate over disks to do the suspension.

As a side effect, swsusp should no longer damage data. [It is
incremental to previous patch].

I had to select between standby written in ide-disk.c (uses
ide_raw_taskfile) and standby written in sc1200.c (uses
ide_wait_cmd). I do not know which one is correct, but I tend to trust
ide-disk.c version a bit more, and used that.

Apply if it looks good to you,
								Pavel


--- linux-ac.kill/drivers/ide/ide-disk.c	2002-11-13 22:00:22.000000000 +0100
+++ linux-ac/drivers/ide/ide-disk.c	2002-11-13 22:44:03.000000000 +0100
@@ -1536,6 +1536,39 @@
 #endif
 }
 
+static int idedisk_suspend(struct device *dev, u32 state, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+
+	printk("Suspending device %p\n", dev->driver_data);
+
+	/* I hope that every freeze operation from the upper levels have
+	 * already been done...
+	 */
+
+	if (level != SUSPEND_SAVE_STATE)
+		return 0;
+
+	/* set the drive to standby */
+	printk(KERN_INFO "suspending: %s ", drive->name);
+	do_idedisk_standby(drive);
+	drive->blocked = 1;
+
+	BUG_ON (HWGROUP(drive)->handler);
+	return 0;
+}
+
+static int idedisk_resume(struct device *dev, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+
+	if (level != RESUME_RESTORE_STATE)
+		return 0;
+	BUG_ON(!drive->blocked);
+	drive->blocked = 0;
+	return 0;
+}
+
 static void idedisk_setup (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -1682,6 +1715,10 @@
 	.proc			= idedisk_proc,
 	.attach			= idedisk_attach,
 	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
+	.gen_driver		= {
+		.suspend	= idedisk_suspend,
+		.resume		= idedisk_resume,
+	}
 };
 
 static int idedisk_open(struct inode *inode, struct file *filp)
--- linux-ac.kill/drivers/ide/ide-probe.c	2002-11-13 21:38:11.000000000 +0100
+++ linux-ac/drivers/ide/ide-probe.c	2002-11-13 22:22:36.000000000 +0100
@@ -1060,6 +1060,7 @@
 			 "%s","IDE Drive");
 		drive->gendev.parent = &hwif->gendev;
 		drive->gendev.bus = &ide_bus_type;
+		drive->gendev.driver_data = drive;
 		sprintf (name, "host%d/bus%d/target%d/lun%d",
 			(hwif->channel && hwif->mate) ?
 			hwif->mate->index : hwif->index,
--- linux-ac.kill/drivers/ide/pci/sc1200.c	2002-11-13 21:38:11.000000000 +0100
+++ linux-ac/drivers/ide/pci/sc1200.c	2002-11-13 22:31:35.000000000 +0100
@@ -373,19 +373,6 @@
  	}
 }
 
-static int sc1200_spindown_drive (ide_drive_t *drive)
-{
-	int rc;
-
-#if 0
-	fsync_dev(MKDEV(HWIF(drive)->major, 0));	// what to do instead of this?  nothing?
-#endif
-	if ((rc = ide_wait_cmd(drive, WIN_STANDBYNOW1, 0, 0, 0, NULL))
-	 && (rc = ide_wait_cmd(drive, WIN_STANDBYNOW2, 0, 0, 0, NULL)))
-		printk("%s: spindown failed\n", drive->name);
-	return rc;
-}
-
 static ide_hwif_t *lookup_pci_dev (ide_hwif_t *prev, struct pci_dev *dev)
 {
 	int	h;
@@ -446,25 +433,9 @@
 {
 	ide_hwif_t	*hwif = NULL;
 
-printk("SC1200: suspend(%u)\n", state);
-	//
-	// loop over all interfaces that are part of this pci device:
-	//
-	while ((hwif = lookup_pci_dev(hwif, dev)) != NULL) {
-		unsigned int	d;
-printk("%s: SC1200: suspend\n", hwif->name);
-		//
-		// Spin down all drives on this interface
-		//
-		for (d = 0; d < MAX_DRIVES; ++d) {
-			ide_drive_t *drive = &(hwif->drives[d]);
-			if (drive->present && drive->media == ide_disk) {
-				if (sc1200_spindown_drive(drive)) {
-					return -EBUSY;	// failed to suspend
-				}
-			}
-		}
-	}
+	printk("SC1200: suspend(%u)\n", state);
+	/* You don't need to iterate over disks -- sysfs should have done that for you already */ 
+
 	pci_disable_device(dev);
 	pci_set_power_state(dev,state);
 	dev->current_state = state;

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
