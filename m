Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbVKYVlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbVKYVlc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 16:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbVKYVlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 16:41:32 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:48809 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751478AbVKYVlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 16:41:32 -0500
Subject: [PATCH] IDE compat_semaphore to completion
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, LKML <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Aleksey Makarov <amakarov@dev.rtsoft.ru>
In-Reply-To: <1132929218.11915.2.camel@localhost.localdomain>
References: <438709F5.1050801@dev.rtsoft.ru>
	 <1132929218.11915.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 16:40:52 -0500
Message-Id: <1132954852.24417.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is from Montavista.  I modified it slightly.
Semaphores are currently being used where it makes more sense for
completions.  This patch corrects that.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Source: MontaVista Software, Inc.
Signed-off-by: Aleksey Makarov <amakarov@ru.mvista.com>
Description:
	The patch changes semaphores that are initialized as 
	locked to complete().

Index: linux-2.6.15-rc2-git5/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/drivers/ide/ide-probe.c	2005-11-23 07:59:15.000000000 -0500
+++ linux-2.6.15-rc2-git5/drivers/ide/ide-probe.c	2005-11-25 16:15:01.000000000 -0500
@@ -655,7 +655,7 @@
 {
 	ide_hwif_t *hwif = container_of(dev, ide_hwif_t, gendev);
 
-	up(&hwif->gendev_rel_sem);
+	complete(&hwif->gendev_rel_comp);
 }
 
 static void hwif_register (ide_hwif_t *hwif)
@@ -1325,7 +1325,7 @@
 	drive->queue = NULL;
 	spin_unlock_irq(&ide_lock);
 
-	up(&drive->gendev_rel_sem);
+	complete(&drive->gendev_rel_comp);
 }
 
 /*
Index: linux-2.6.15-rc2-git5/drivers/ide/ide.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/drivers/ide/ide.c	2005-11-23 07:59:15.000000000 -0500
+++ linux-2.6.15-rc2-git5/drivers/ide/ide.c	2005-11-25 16:15:01.000000000 -0500
@@ -222,7 +222,7 @@
 	hwif->mwdma_mask = 0x80;	/* disable all mwdma */
 	hwif->swdma_mask = 0x80;	/* disable all swdma */
 
-	sema_init(&hwif->gendev_rel_sem, 0);
+	init_completion(&hwif->gendev_rel_comp);
 
 	default_hwif_iops(hwif);
 	default_hwif_transport(hwif);
@@ -245,7 +245,7 @@
 		drive->is_flash			= 0;
 		drive->vdma			= 0;
 		INIT_LIST_HEAD(&drive->list);
-		sema_init(&drive->gendev_rel_sem, 0);
+		init_completion(&drive->gendev_rel_comp);
 	}
 }
 
@@ -602,7 +602,7 @@
 		}
 		spin_unlock_irq(&ide_lock);
 		device_unregister(&drive->gendev);
-		down(&drive->gendev_rel_sem);
+		wait_for_completion(&drive->gendev_rel_comp);
 		spin_lock_irq(&ide_lock);
 	}
 	hwif->present = 0;
@@ -662,7 +662,7 @@
 	/* More messed up locking ... */
 	spin_unlock_irq(&ide_lock);
 	device_unregister(&hwif->gendev);
-	down(&hwif->gendev_rel_sem);
+	wait_for_completion(&hwif->gendev_rel_comp);
 
 	/*
 	 * Remove us from the kernel's knowledge
Index: linux-2.6.15-rc2-git5/include/linux/ide.h
===================================================================
--- linux-2.6.15-rc2-git5.orig/include/linux/ide.h	2005-11-23 07:59:21.000000000 -0500
+++ linux-2.6.15-rc2-git5/include/linux/ide.h	2005-11-25 16:25:21.000000000 -0500
@@ -18,6 +18,7 @@
 #include <linux/bio.h>
 #include <linux/device.h>
 #include <linux/pci.h>
+#include <linux/completion.h>
 #include <asm/byteorder.h>
 #include <asm/system.h>
 #include <asm/io.h>
@@ -759,7 +760,7 @@
 	int		crc_count;	/* crc counter to reduce drive speed */
 	struct list_head list;
 	struct device	gendev;
-	struct semaphore gendev_rel_sem;	/* to deal with device release() */
+	struct completion gendev_rel_comp;	/* to deal with device release() */
 } ide_drive_t;
 
 #define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
@@ -915,7 +916,7 @@
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 
 	struct device	gendev;
-	struct semaphore gendev_rel_sem; /* To deal with device release() */
+	struct completion gendev_rel_comp; /* To deal with device release() */
 
 	void		*hwif_data;	/* extra hwif data */
 


