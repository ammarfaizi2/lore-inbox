Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264834AbUEPWPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264834AbUEPWPs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 18:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUEPWPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 18:15:48 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:666 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S264834AbUEPWPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 18:15:13 -0400
Message-ID: <40A7E788.7080008@keyaccess.nl>
Date: Mon, 17 May 2004 00:13:28 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [RFT][PATCH] ide-disk.c: more write cache fixes
References: <200405132116.44201.bzolnier@elka.pw.edu.pl> <200405162220.23971.bzolnier@elka.pw.edu.pl> <40A7D9E6.1090900@keyaccess.nl> <200405162330.35547.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405162330.35547.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/mixed;
 boundary="------------040407010109000909000801"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040407010109000909000801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bartlomiej Zolnierkiewicz wrote:

>>Bart, could something like:
>>
>>if (system_state == SYSTEM_RESTART) {
>>	ide_cache_flush_p(drive)
>>	return;
>>}
>>
>>(as opposed to just the return in that patch and -mm3) possibly help? I
> 
> Yep, this may fix it.

Oh, wonderful. Alan, first attachment is a new version of the rollup 
with this incorporated (ie, again versus 2.6.6 vanilla).

Andrew, second attachment is for you. Guess it's largely a "can't hurt", 
but please wait for Alan to ack. If that drive is really screwy, this 
still won't do.

Rene.

--------------040407010109000909000801
Content-Type: text/plain;
 name="linux-2.6.6_rollup3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.6_rollup3.diff"

diff -urN linux-2.6.6.orig/drivers/ide/ide-disk.c linux-2.6.6/drivers/ide/ide-disk.c
--- linux-2.6.6.orig/drivers/ide/ide-disk.c	2004-05-10 09:31:44.000000000 +0200
+++ linux-2.6.6/drivers/ide/ide-disk.c	2004-05-16 23:38:55.000000000 +0200
@@ -740,8 +740,6 @@
 		return __ide_do_rw_disk(drive, rq, block);
 }
 
-static int do_idedisk_flushcache(ide_drive_t *drive);
-
 static u8 idedisk_dump_status (ide_drive_t *drive, const char *msg, u8 stat)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -1359,11 +1357,18 @@
 	return 0;
 }
 
+/* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
+#define ide_id_has_flush_cache(id)	((id)->cfs_enable_2 & 0x3000)
+
+/* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
+#define ide_id_has_flush_cache_ext(id)	\
+	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
+
 static int write_cache (ide_drive_t *drive, int arg)
 {
 	ide_task_t args;
 
-	if (!(drive->id->cfs_enable_2 & 0x3000))
+	if (!ide_id_has_flush_cache(drive->id))
 		return 1;
 
 	memset(&args, 0, sizeof(ide_task_t));
@@ -1383,7 +1388,7 @@
 	ide_task_t args;
 
 	memset(&args, 0, sizeof(ide_task_t));
-	if (drive->id->cfs_enable_2 & 0x2400)
+	if (ide_id_has_flush_cache_ext(drive->id))
 		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE_EXT;
 	else
 		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE;
@@ -1513,11 +1518,11 @@
 	switch (rq->pm->pm_step) {
 	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) */
 		/* Not supported? Switch to next step now. */
-		if (!drive->wcache) {
+		if (!drive->wcache || !ide_id_has_flush_cache(drive->id)) {
 			idedisk_complete_power_step(drive, rq, 0, 0);
 			return ide_stopped;
 		}
-		if (drive->id->cfs_enable_2 & 0x2400)
+		if (ide_id_has_flush_cache_ext(drive->id))
 			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
 		else
 			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
@@ -1678,8 +1683,12 @@
 #endif	/* CONFIG_IDEDISK_MULTI_MODE */
 	}
 	drive->no_io_32bit = id->dword_io ? 1 : 0;
-	if (drive->id->cfs_enable_2 & 0x3000)
-		write_cache(drive, (id->cfs_enable_2 & 0x3000));
+
+	/* write cache enabled? */
+	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
+		drive->wcache = 1;
+
+	write_cache(drive, 1);
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
 	if (drive->using_dma)
@@ -1687,9 +1696,17 @@
 #endif
 }
 
+static void ide_cacheflush_p(ide_drive_t *drive)
+{
+	if (!drive->wcache || !ide_id_has_flush_cache(drive->id))
+		return;
+
+	if (do_idedisk_flushcache(drive))
+		printk(KERN_INFO "%s: wcache flush failed!\n", drive->name);
+}
+
 static int idedisk_cleanup (ide_drive_t *drive)
 {
-	static int ide_cacheflush_p(ide_drive_t *drive);
 	struct gendisk *g = drive->disk;
 	ide_cacheflush_p(drive);
 	if (ide_unregister_subdriver(drive))
@@ -1706,6 +1723,11 @@
 {
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
 
+	if (system_state == SYSTEM_RESTART) {
+		ide_cacheflush_p(drive);
+		return;
+	}
+
 	printk("Shutdown: %s\n", drive->name);
 	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
 }
@@ -1740,7 +1762,6 @@
 
 static int idedisk_open(struct inode *inode, struct file *filp)
 {
-	u8 cf;
 	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
 	drive->usage++;
 	if (drive->removable && drive->usage == 1) {
@@ -1758,35 +1779,6 @@
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking = 0;
 	}
-	drive->wcache = 0;
-	/* Cache enabled? */
-	if (drive->id->csfo & 1)
-		drive->wcache = 1;
-	/* Cache command set available? */
-	if (drive->id->cfs_enable_1 & (1 << 5))
-		drive->wcache = 1;
-	/* ATA6 cache extended commands */
-	cf = drive->id->command_set_2 >> 24;
-	if ((cf & 0xC0) == 0x40 && (cf & 0x30) != 0)
-		drive->wcache = 1;
-	return 0;
-}
-
-static int ide_cacheflush_p(ide_drive_t *drive)
-{
-	if (!(drive->id->cfs_enable_2 & 0x3000))
-		return 0;
-
-	if(drive->wcache)
-	{
-		if (do_idedisk_flushcache(drive))
-		{
-			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
-				drive->name);
-			return -EIO;
-		}
-		return 1;
-	}
 	return 0;
 }
 
@@ -1867,10 +1859,7 @@
 	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n",
 			drive->name, drive->head);
-		if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
-			if (do_idedisk_flushcache(drive))
-				printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
-					drive->name);
+		ide_cacheflush_p(drive);
 		ide_unregister_subdriver(drive);
 		DRIVER(drive)->busy--;
 		goto failed;
diff -urN linux-2.6.6.orig/include/linux/kernel.h linux-2.6.6/include/linux/kernel.h
--- linux-2.6.6.orig/include/linux/kernel.h	2004-05-10 09:31:47.000000000 +0200
+++ linux-2.6.6/include/linux/kernel.h	2004-05-16 23:35:26.000000000 +0200
@@ -109,14 +109,17 @@
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_on_oops;
-extern int system_state;		/* See values below */
 extern int tainted;
 extern const char *print_tainted(void);
 
 /* Values used for system_state */
-#define SYSTEM_BOOTING 0
-#define SYSTEM_RUNNING 1
-#define SYSTEM_SHUTDOWN 2
+extern enum system_states {
+	SYSTEM_BOOTING,
+	SYSTEM_RUNNING,
+	SYSTEM_HALT,
+	SYSTEM_POWER_OFF,
+	SYSTEM_RESTART,
+} system_state;
 
 #define TAINT_PROPRIETARY_MODULE	(1<<0)
 #define TAINT_FORCED_MODULE		(1<<1)
diff -urN linux-2.6.6.orig/init/main.c linux-2.6.6/init/main.c
--- linux-2.6.6.orig/init/main.c	2004-05-10 09:31:47.000000000 +0200
+++ linux-2.6.6/init/main.c	2004-05-16 23:35:26.000000000 +0200
@@ -95,7 +95,8 @@
 extern void tc_init(void);
 #endif
 
-int system_state;	/* SYSTEM_BOOTING/RUNNING/SHUTDOWN */
+enum system_states system_state;
+EXPORT_SYMBOL(system_state);
 
 /*
  * Boot command-line arguments
diff -urN linux-2.6.6.orig/kernel/sys.c linux-2.6.6/kernel/sys.c
--- linux-2.6.6.orig/kernel/sys.c	2004-05-10 09:31:47.000000000 +0200
+++ linux-2.6.6/kernel/sys.c	2004-05-16 23:35:26.000000000 +0200
@@ -447,7 +447,7 @@
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system.\n");
 		machine_restart(NULL);
@@ -463,7 +463,7 @@
 
 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_HALT;
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
@@ -473,7 +473,7 @@
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_POWER_OFF;
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
@@ -489,7 +489,7 @@
 		buffer[sizeof(buffer) - 1] = '\0';
 
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);

--------------040407010109000909000801
Content-Type: text/plain;
 name="linux-2.6.6-mm3_reboot.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.6-mm3_reboot.diff"

--- linux-2.6.6-mm3/drivers/ide/ide-disk.c.orig	2004-05-16 23:43:15.000000000 +0200
+++ linux-2.6.6-mm3/drivers/ide/ide-disk.c	2004-05-16 23:44:51.000000000 +0200
@@ -1723,8 +1723,10 @@
 {
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
 
-	if (system_state == SYSTEM_RESTART)
+	if (system_state == SYSTEM_RESTART) {
+		ide_cacheflush_p(drive);
 		return;
+	}
 
 	printk("Shutdown: %s\n", drive->name);
 	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);

--------------040407010109000909000801--
