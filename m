Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVKYWql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVKYWql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 17:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVKYWql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 17:46:41 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:51391 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932380AbVKYWqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 17:46:40 -0500
Subject: [PATCH] 2.6.14-rt15 IDE compat_semaphore to completion
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>,
       Aleksey Makarov <amakarov@dev.rtsoft.ru>
In-Reply-To: <1132929218.11915.2.camel@localhost.localdomain>
References: <438709F5.1050801@dev.rtsoft.ru>
	 <1132929218.11915.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 17:46:21 -0500
Message-Id: <1132958781.24417.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Here's a patch from MontaVista, that I slightly modified.  I sent this
to the mainline as well (you were CC'd).

-- Steve

Source: MontaVista Software, Inc.
MR: 14219
Type: Defect fix
Disposition: Should be submitted to lkml
Signed-off-by: Aleksey Makarov <amakarov@ru.mvista.com>
Description:
	The patch changes semaphores that are initialized as 
	locked to complete().

Index: linux-2.6.14-rt13/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.14-rt13.orig/drivers/ide/ide-probe.c	2005-11-17 17:43:04.000000000 -0500
+++ linux-2.6.14-rt13/drivers/ide/ide-probe.c	2005-11-17 17:46:01.000000000 -0500
@@ -656,7 +656,7 @@
 {
 	ide_hwif_t *hwif = container_of(dev, ide_hwif_t, gendev);
 
-	up(&hwif->gendev_rel_sem);
+	complete(&hwif->gendev_rel_comp);
 }
 
 static void hwif_register (ide_hwif_t *hwif)
@@ -1328,7 +1328,7 @@
 	drive->queue = NULL;
 	spin_unlock_irq(&ide_lock);
 
-	up(&drive->gendev_rel_sem);
+	complete(&drive->gendev_rel_comp);
 }
 
 /*
Index: linux-2.6.14-rt13/drivers/ide/ide.c
===================================================================
--- linux-2.6.14-rt13.orig/drivers/ide/ide.c	2005-11-17 17:43:04.000000000 -0500
+++ linux-2.6.14-rt13/drivers/ide/ide.c	2005-11-17 17:45:31.000000000 -0500
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
Index: linux-2.6.14-rt13/include/linux/ide.h
===================================================================
--- linux-2.6.14-rt13.orig/include/linux/ide.h	2005-11-17 17:43:04.000000000 -0500
+++ linux-2.6.14-rt13/include/linux/ide.h	2005-11-17 17:44:36.000000000 -0500
@@ -18,6 +18,7 @@
 #include <linux/bio.h>
 #include <linux/device.h>
 #include <linux/pci.h>
+#include <linux/completion.h>
 #include <asm/byteorder.h>
 #include <asm/system.h>
 #include <asm/io.h>
@@ -754,7 +755,7 @@
 	int		crc_count;	/* crc counter to reduce drive speed */
 	struct list_head list;
 	struct device	gendev;
-	struct compat_semaphore gendev_rel_sem;	/* to deal with device release() */
+	struct completion gendev_rel_comp;  /* to deal with device release() */
 } ide_drive_t;
 
 #define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
@@ -910,7 +911,7 @@
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 
 	struct device	gendev;
-	struct semaphore gendev_rel_sem; /* To deal with device release() */
+	struct completion gendev_rel_comp; /* To deal with device release() */
 
 	void		*hwif_data;	/* extra hwif data */
 


