Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbSKBSm3>; Sat, 2 Nov 2002 13:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbSKBSm3>; Sat, 2 Nov 2002 13:42:29 -0500
Received: from [195.39.17.254] ([195.39.17.254]:27908 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261373AbSKBSmT>;
	Sat, 2 Nov 2002 13:42:19 -0500
Date: Sat, 2 Nov 2002 19:47:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Cc: alan@redhat.com
Subject: swsusp: don't eat ide disks
Message-ID: <20021102184735.GA179@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's patch to prevent random scribling over disks during
suspend... In the meantime alan killed (unreferenced at that time)
idedisk_suspend() and idedisk_release(), so I have to reintroduce
them.

Now... There is *another* do_idedisk_suspend / do_idedisk_resume
method in ide_disk.c. As far as I can see, it is not used anywhere,
and is certainly not enough to prevent corruption on swsusp. [Besides,
doing suspend/resume support generically using devicefs, not with ide
stuff seems more right.] Should I go ahead and kill do_idedisk_suspend
and related code?
								Pavel 

--- clean/drivers/ide/ide-disk.c	2002-11-01 00:37:14.000000000 +0100
+++ linux-swsusp/drivers/ide/ide-disk.c	2002-11-01 21:36:54.000000000 +0100
@@ -1561,6 +1561,56 @@
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
+	BUG_ON(in_interrupt());
+
+	printk("Waiting for commands to finish\n");
+
+	/* wait until all commands are finished */
+	/* FIXME: waiting for spinlocks should be done instead. */
+	if (!(HWGROUP(drive)))
+		printk("No hwgroup?\n");
+	while (HWGROUP(drive)->handler)
+		yield();
+
+	/* set the drive to standby */
+	printk(KERN_INFO "suspending: %s ", drive->name);
+	if (drive->driver) {
+		if (drive->driver->standby)
+			drive->driver->standby(drive);
+	}
+	drive->blocked = 1;
+
+	while (HWGROUP(drive)->handler)
+		yield();
+
+	return 0;
+}
+
+static int idedisk_resume(struct device *dev, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+
+	if (level != RESUME_RESTORE_STATE)
+		return 0;
+	if (!drive->blocked)
+		panic("ide: Resume but not suspended?\n");
+
+	drive->blocked = 0;
+	return 0;
+}
+
 static void idedisk_setup (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -1709,6 +1759,10 @@
 	.proc			= idedisk_proc,
 	.attach			= idedisk_attach,
 	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
+	.gen_driver		= {
+		.suspend	= idedisk_suspend,
+		.resume		= idedisk_resume,
+	}
 };
 
 static int idedisk_open(struct inode *inode, struct file *filp)
@@ -1835,8 +1889,7 @@
 
 static int idedisk_init (void)
 {
-	ide_register_driver(&idedisk_driver);
-	return 0;
+	return ide_register_driver(&idedisk_driver);
 }
 
 module_init(idedisk_init);
--- clean/drivers/ide/ide-probe.c	2002-11-01 00:37:14.000000000 +0100
+++ linux-swsusp/drivers/ide/ide-probe.c	2002-11-01 01:26:37.000000000 +0100
@@ -1054,6 +1054,7 @@
 			 "%s","IDE Drive");
 		drive->gendev.parent = &hwif->gendev;
 		drive->gendev.bus = &ide_bus_type;
+		drive->gendev.driver_data = drive;
 		sprintf (name, "host%d/bus%d/target%d/lun%d",
 			(hwif->channel && hwif->mate) ?
 			hwif->mate->index : hwif->index,

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
