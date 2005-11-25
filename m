Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVKYMyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVKYMyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 07:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVKYMyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 07:54:12 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:16805 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932375AbVKYMyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 07:54:12 -0500
Message-ID: <438709F5.1050801@dev.rtsoft.ru>
Date: Fri, 25 Nov 2005 15:56:21 +0300
From: Aleksey Makarov <amakarov@dev.rtsoft.ru>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org, sdietrich@mvista.com
Subject: [PATCH] 2.6.14-rt15 IDE compat_semaphore to completion
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Please consider if this patch could be included into
the next realtime patch.

Aleksey Makarov

Index: linux-2.6.14-rt15/include/linux/ide.h
===================================================================
--- linux-2.6.14-rt15.orig/include/linux/ide.h
+++ linux-2.6.14-rt15/include/linux/ide.h
@@ -18,6 +18,7 @@
  #include <linux/bio.h>
  #include <linux/device.h>
  #include <linux/pci.h>
+#include <linux/completion.h>
  #include <asm/byteorder.h>
  #include <asm/system.h>
  #include <asm/io.h>
@@ -754,7 +755,7 @@ typedef struct ide_drive_s {
  	int		crc_count;	/* crc counter to reduce drive speed */
  	struct list_head list;
  	struct device	gendev;
-	struct compat_semaphore gendev_rel_sem;	/* to deal with device 
release() */
+	struct completion gendev_rel_sem;	/* to deal with device release() */
  } ide_drive_t;

  #define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
@@ -910,7 +911,7 @@ typedef struct hwif_s {
  	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */

  	struct device	gendev;
-	struct compat_semaphore gendev_rel_sem; /* To deal with device 
release() */
+	struct completion gendev_rel_sem; /* To deal with device release() */

  	void		*hwif_data;	/* extra hwif data */

Index: linux-2.6.14-rt15/drivers/ide/ide.c
===================================================================
--- linux-2.6.14-rt15.orig/drivers/ide/ide.c
+++ linux-2.6.14-rt15/drivers/ide/ide.c
@@ -222,7 +222,7 @@ static void init_hwif_data(ide_hwif_t *h
  	hwif->mwdma_mask = 0x80;	/* disable all mwdma */
  	hwif->swdma_mask = 0x80;	/* disable all swdma */

-	sema_init(&hwif->gendev_rel_sem, 0);
+	init_completion(&hwif->gendev_rel_sem);

  	default_hwif_iops(hwif);
  	default_hwif_transport(hwif);
@@ -245,7 +245,7 @@ static void init_hwif_data(ide_hwif_t *h
  		drive->is_flash			= 0;
  		drive->vdma			= 0;
  		INIT_LIST_HEAD(&drive->list);
-		sema_init(&drive->gendev_rel_sem, 0);
+		init_completion(&drive->gendev_rel_sem);
  	}
  }

@@ -602,7 +602,7 @@ void ide_unregister(unsigned int index)
  		}
  		spin_unlock_irq(&ide_lock);
  		device_unregister(&drive->gendev);
-		down(&drive->gendev_rel_sem);
+		wait_for_completion(&drive->gendev_rel_sem);
  		spin_lock_irq(&ide_lock);
  	}
  	hwif->present = 0;
@@ -662,7 +662,7 @@ void ide_unregister(unsigned int index)
  	/* More messed up locking ... */
  	spin_unlock_irq(&ide_lock);
  	device_unregister(&hwif->gendev);
-	down(&hwif->gendev_rel_sem);
+	wait_for_completion(&hwif->gendev_rel_sem);

  	/*
  	 * Remove us from the kernel's knowledge
Index: linux-2.6.14-rt15/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.14-rt15.orig/drivers/ide/ide-probe.c
+++ linux-2.6.14-rt15/drivers/ide/ide-probe.c
@@ -656,7 +656,7 @@ static void hwif_release_dev (struct dev
  {
  	ide_hwif_t *hwif = container_of(dev, ide_hwif_t, gendev);

-	up(&hwif->gendev_rel_sem);
+	complete(&hwif->gendev_rel_sem);
  }

  static void hwif_register (ide_hwif_t *hwif)
@@ -1328,7 +1328,7 @@ static void drive_release_dev (struct de
  	drive->queue = NULL;
  	spin_unlock_irq(&ide_lock);

-	up(&drive->gendev_rel_sem);
+	complete(&drive->gendev_rel_sem);
  }

  /*
