Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWACQtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWACQtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWACQs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:48:58 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16551 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932447AbWACQsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:48:10 -0500
Date: Tue, 3 Jan 2006 17:47:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 18/19] mutex subsystem, semaphore to completion: IDE ->gendev_rel_sem
Message-ID: <20060103164751.GS25802@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksey Makarov <amakarov@ru.mvista.com>

The patch changes semaphores that are initialized as 
locked to complete().

Source: MontaVista Software, Inc.

Modified-by: Steven Rostedt <rostedt@goodmis.org>

The following patch is from Montavista.  I modified it slightly.
Semaphores are currently being used where it makes more sense for
completions.  This patch corrects that.

Signed-off-by: Aleksey Makarov <amakarov@ru.mvista.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 drivers/ide/ide-probe.c |    4 ++--
 drivers/ide/ide.c       |    8 ++++----
 include/linux/ide.h     |    5 +++--
 3 files changed, 9 insertions(+), 8 deletions(-)

Index: linux/drivers/ide/ide-probe.c
===================================================================
--- linux.orig/drivers/ide/ide-probe.c
+++ linux/drivers/ide/ide-probe.c
@@ -655,7 +655,7 @@ static void hwif_release_dev (struct dev
 {
 	ide_hwif_t *hwif = container_of(dev, ide_hwif_t, gendev);
 
-	up(&hwif->gendev_rel_sem);
+	complete(&hwif->gendev_rel_comp);
 }
 
 static void hwif_register (ide_hwif_t *hwif)
@@ -1325,7 +1325,7 @@ static void drive_release_dev (struct de
 	drive->queue = NULL;
 	spin_unlock_irq(&ide_lock);
 
-	up(&drive->gendev_rel_sem);
+	complete(&drive->gendev_rel_comp);
 }
 
 /*
Index: linux/drivers/ide/ide.c
===================================================================
--- linux.orig/drivers/ide/ide.c
+++ linux/drivers/ide/ide.c
@@ -222,7 +222,7 @@ static void init_hwif_data(ide_hwif_t *h
 	hwif->mwdma_mask = 0x80;	/* disable all mwdma */
 	hwif->swdma_mask = 0x80;	/* disable all swdma */
 
-	sema_init(&hwif->gendev_rel_sem, 0);
+	init_completion(&hwif->gendev_rel_comp);
 
 	default_hwif_iops(hwif);
 	default_hwif_transport(hwif);
@@ -245,7 +245,7 @@ static void init_hwif_data(ide_hwif_t *h
 		drive->is_flash			= 0;
 		drive->vdma			= 0;
 		INIT_LIST_HEAD(&drive->list);
-		sema_init(&drive->gendev_rel_sem, 0);
+		init_completion(&drive->gendev_rel_comp);
 	}
 }
 
@@ -602,7 +602,7 @@ void ide_unregister(unsigned int index)
 		}
 		spin_unlock_irq(&ide_lock);
 		device_unregister(&drive->gendev);
-		down(&drive->gendev_rel_sem);
+		wait_for_completion(&drive->gendev_rel_comp);
 		spin_lock_irq(&ide_lock);
 	}
 	hwif->present = 0;
@@ -662,7 +662,7 @@ void ide_unregister(unsigned int index)
 	/* More messed up locking ... */
 	spin_unlock_irq(&ide_lock);
 	device_unregister(&hwif->gendev);
-	down(&hwif->gendev_rel_sem);
+	wait_for_completion(&hwif->gendev_rel_comp);
 
 	/*
 	 * Remove us from the kernel's knowledge
Index: linux/include/linux/ide.h
===================================================================
--- linux.orig/include/linux/ide.h
+++ linux/include/linux/ide.h
@@ -18,6 +18,7 @@
 #include <linux/bio.h>
 #include <linux/device.h>
 #include <linux/pci.h>
+#include <linux/completion.h>
 #include <asm/byteorder.h>
 #include <asm/system.h>
 #include <asm/io.h>
@@ -638,7 +639,7 @@ typedef struct ide_drive_s {
 	int		crc_count;	/* crc counter to reduce drive speed */
 	struct list_head list;
 	struct device	gendev;
-	struct semaphore gendev_rel_sem;	/* to deal with device release() */
+	struct completion gendev_rel_comp;	/* to deal with device release() */
 } ide_drive_t;
 
 #define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
@@ -794,7 +795,7 @@ typedef struct hwif_s {
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 
 	struct device	gendev;
-	struct semaphore gendev_rel_sem; /* To deal with device release() */
+	struct completion gendev_rel_comp; /* To deal with device release() */
 
 	void		*hwif_data;	/* extra hwif data */
 
