Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTIMXyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 19:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbTIMXyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 19:54:09 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:50048
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262251AbTIMXyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 19:54:05 -0400
Date: Sat, 13 Sep 2003 19:54:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6][ floppy cleanup timers/resources on unload
Message-ID: <Pine.LNX.4.53.0309090857050.14426@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug has a corresponding bugzilla entry at;

http://bugme.osdl.org/show_bug.cgi?id=1061

The floppy driver currently can leave pending timers after unloading 
itself.

Index: linux-2.6.0-test5/drivers/block/floppy.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test5/drivers/block/floppy.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 floppy.c
--- linux-2.6.0-test5/drivers/block/floppy.c	8 Sep 2003 22:07:57 -0000	1.1.1.1
+++ linux-2.6.0-test5/drivers/block/floppy.c	9 Sep 2003 11:57:00 -0000
@@ -219,6 +219,7 @@ static int use_virtual_dma;
  */
 
 static spinlock_t floppy_lock = SPIN_LOCK_UNLOCKED;
+static struct completion device_release;
 
 static unsigned short virtual_dma_port=0x3f0;
 irqreturn_t floppy_interrupt(int irq, void *dev_id, struct pt_regs * regs);
@@ -4203,9 +4204,17 @@ static int __init floppy_setup(char *str
 
 static int have_no_fdc= -ENODEV;
 
+static void floppy_device_release(struct device *dev)
+{
+	complete(&device_release);
+}
+
 static struct platform_device floppy_device = {
 	.name		= "floppy",
 	.id		= 0,
+	.dev		= {
+			.release = floppy_device_release,
+	}
 };
 
 static struct kobject *floppy_find(dev_t dev, int *part, void *data)
@@ -4576,11 +4585,15 @@ int init_module(void)
 void cleanup_module(void)
 {
 	int drive;
-		
+
+	init_completion(&device_release);	
 	platform_device_unregister(&floppy_device);
 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
+	
 	for (drive = 0; drive < N_DRIVE; drive++) {
+		del_timer_sync(&motor_off_timer[drive]);
+
 		if ((allowed_drive_mask & (1 << drive)) &&
 		    fdc_state[FDC(drive)].version != FDC_NONE) {
 			del_gendisk(disks[drive]);
@@ -4590,9 +4603,17 @@ void cleanup_module(void)
 	}
 	devfs_remove("floppy");
 
+	del_timer_sync(&fd_timeout);
+	del_timer_sync(&fd_timer);
 	blk_cleanup_queue(floppy_queue);
+
+	if (usage_count)
+		floppy_release_irq_and_dma();
+
 	/* eject disk, if any */
 	fd_eject(0);
+
+	wait_for_completion(&device_release);
 }
 
 MODULE_PARM(floppy,"s");
