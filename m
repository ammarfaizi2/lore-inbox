Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276522AbRJPRom>; Tue, 16 Oct 2001 13:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276538AbRJPRof>; Tue, 16 Oct 2001 13:44:35 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:51872 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S276522AbRJPRnW>;
	Tue, 16 Oct 2001 13:43:22 -0400
Message-ID: <3BCC7117.49CAF9F8@sun.com>
Date: Tue, 16 Oct 2001 10:40:39 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH] IDE flush on reboot notify
Content-Type: multipart/mixed;
 boundary="------------67500D06EF03FA2452D65FBE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------67500D06EF03FA2452D65FBE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre, Alan, Linus,

This patch registers a reboot notifier for IDE devices, forcing a cache
flush before reboot/poweroff.   Without it, we've experienced disk
corruption (verified by Seagate, I believe).

Please apply for the next 2.4.x, or let me know of any problems.

thanks!

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------67500D06EF03FA2452D65FBE
Content-Type: text/plain; charset=us-ascii;
 name="ide-reboot.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-reboot.diff"

diff -ruN dist-2.4.12+patches/drivers/ide/ide.c cvs-2.4.12+patches/drivers/ide/ide.c
--- dist-2.4.12+patches/drivers/ide/ide.c	Mon Oct 15 10:21:50 2001
+++ cvs-2.4.12+patches/drivers/ide/ide.c	Mon Oct 15 10:21:50 2001
@@ -149,6 +149,7 @@
 #include <linux/ide.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/completion.h>
+#include <linux/reboot.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -3716,6 +3720,58 @@
 
 EXPORT_SYMBOL(system_bus_clock);
 
+static int ide_notify_reboot(struct notifier_block *this,
+			     unsigned long event, void *x)
+{
+	unsigned long flags;
+	ide_hwif_t *hwif;
+	ide_drive_t *drive;
+	int i, unit;
+
+	switch (event) {
+	case SYS_HALT:
+	case SYS_POWER_OFF:
+	case SYS_RESTART:
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	printk("flushing ide devices: ");
+
+	spin_lock_irqsave(&io_request_lock, flags);
+	for (i = 0; i < MAX_HWIFS; i++) {
+		hwif = &ide_hwifs[i];
+		if (!hwif->present)
+			continue;
+		for (unit = 0; unit < MAX_DRIVES; ++unit) {
+			drive = &hwif->drives[unit];
+			if (!drive->present)
+				continue;
+
+			/* set the drive to standby */
+			printk("%s ", drive->name);
+			SELECT_DRIVE(hwif,drive);
+			udelay (20);
+			OUT_BYTE (event == SYS_RESTART ? 
+				  WIN_FLUSH_CACHE : WIN_STANDBYNOW1, 
+				  IDE_COMMAND_REG);
+			if (drive->driver != NULL && 
+			    DRIVER(drive)->cleanup(drive))
+			        continue;
+		}
+	}
+	printk("\n");
+	spin_unlock_irqrestore(&io_request_lock, flags);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ide_notifier = {
+	ide_notify_reboot,
+	NULL,
+	5
+};
+
 /*
  * This is gets invoked once during initialization, to set *everything* up
  */
@@ -3743,6 +3799,7 @@
 			ide_geninit(hwif);
 	}
 
+	register_reboot_notifier(&ide_notifier); 
 	return 0;
 }
 
@@ -3774,6 +3831,7 @@
 {
 	int index;
 
+	unregister_reboot_notifier(&ide_notifier); 
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		ide_unregister(index);
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
diff -ruN dist-2.4.12+patches/include/linux/hdreg.h cvs-2.4.12+patches/include/linux/hdreg.h
--- dist-2.4.12+patches/include/linux/hdreg.h	Mon Oct 15 10:23:41 2001
+++ cvs-2.4.12+patches/include/linux/hdreg.h	Mon Oct 15 10:23:42 2001
@@ -59,6 +59,7 @@
 #define WIN_SLEEPNOW2		0x99
 #define WIN_CHECKPOWERMODE1	0xE5
 #define WIN_CHECKPOWERMODE2	0x98
+#define WIN_FLUSH_CACHE		0xE7
 
 #define WIN_DOORLOCK		0xDE	/* lock door on removable drives */
 #define WIN_DOORUNLOCK		0xDF	/* unlock door on removable drives */

--------------67500D06EF03FA2452D65FBE--

