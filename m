Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUE0Pt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUE0Pt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264822AbUE0Pt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:49:28 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:39553 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264821AbUE0PtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:49:21 -0400
Date: Thu, 27 May 2004 19:49:20 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 2.6] don't put IDE disks in standby mode on halt on Alpha
Message-ID: <20040527194920.A1709@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spinning the disks down across a 'halt' on Alpha is even
worse than doing that on reboot on i386 (assuming the
boot device is IDE disk).
Typically, the sequence to boot another kernel is:
# halt
kernel shuts down, firmware re-initializes,
then on firmware prompt we type something like
>>> boot -file new_kernel_image.gz

Unfortunately, the firmware does not expect the IDE drive
to be in standby mode and reports 'bootstrap failure' on
the first and all subsequent boot attempts until the
drive spins up, which is extremely annoying and
confuses users a lot.

This patch allows architectures override the default
behavior (don't spin the disks down on reboot only)
in asm/ide.h.

Ivan.

--- 2.6/drivers/ide/ide-disk.c	Fri May 21 21:06:12 2004
+++ linux/drivers/ide/ide-disk.c	Fri May 21 21:48:09 2004
@@ -1723,7 +1723,7 @@ static void ide_device_shutdown(struct d
 {
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
 
-	if (system_state == SYSTEM_RESTART) {
+	if (ide_shutdown_omit_standby(system_state)) {
 		ide_cacheflush_p(drive);
 		return;
 	}
--- 2.6/include/linux/ide.h	Fri May 21 21:47:13 2004
+++ linux/include/linux/ide.h	Fri May 21 21:48:09 2004
@@ -1709,4 +1709,8 @@ static inline int ata_can_queue(ide_driv
 
 extern struct bus_type ide_bus_type;
 
+#ifndef ide_shutdown_omit_standby
+#define ide_shutdown_omit_standby(sys_state)	(sys_state == SYSTEM_RESTART)
+#endif
+
 #endif /* _IDE_H */
--- 2.6/include/asm-alpha/ide.h	Fri May 21 21:47:54 2004
+++ linux/include/asm-alpha/ide.h	Fri May 21 21:48:34 2004
@@ -52,6 +52,8 @@ static inline unsigned long ide_default_
 #define ide_init_default_irq(base)	ide_default_irq(base)
 #endif
 
+#define ide_shutdown_omit_standby(sys_state)	(sys_state != SYSTEM_POWER_OFF)
+
 #include <asm-generic/ide_iops.h>
 
 #endif /* __KERNEL__ */
