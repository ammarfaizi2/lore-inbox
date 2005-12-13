Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVLMJ4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVLMJ4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVLMJ4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:56:31 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36572 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750848AbVLMJ4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:56:30 -0500
Date: Tue, 13 Dec 2005 10:55:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213095544.GA31612@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20051213075441.GB6765@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Ingo Molnar <mingo@elte.hu> wrote:

> all this simplified the 'compatibility conversion' to the patch below.  
> No other non-generic changes are needed.

there were 3 more patches needed, which convert some semaphores to 
completions:

 sx8-sem2completions.patch
 cpu5wdt-sem2completions.patch
 ide-gendev-sem-to-completion.patch

all attached.

	Ingo

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sx8-sem2completions.patch"

 drivers/block/sx8.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

Index: linux/drivers/block/sx8.c
===================================================================
--- linux.orig/drivers/block/sx8.c
+++ linux/drivers/block/sx8.c
@@ -27,6 +27,7 @@
 #include <linux/time.h>
 #include <linux/hdreg.h>
 #include <linux/dma-mapping.h>
+#include <linux/completion.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -303,7 +304,7 @@ struct carm_host {
 
 	struct work_struct		fsm_task;
 
-	struct semaphore		probe_sem;
+	struct completion		probe_comp;
 };
 
 struct carm_response {
@@ -1365,7 +1366,7 @@ static void carm_fsm_task (void *_data)
 	}
 
 	case HST_PROBE_FINISHED:
-		up(&host->probe_sem);
+		complete(&host->probe_comp);
 		break;
 
 	case HST_ERROR:
@@ -1641,7 +1642,7 @@ static int carm_init_one (struct pci_dev
 	host->flags = pci_dac ? FL_DAC : 0;
 	spin_lock_init(&host->lock);
 	INIT_WORK(&host->fsm_task, carm_fsm_task, host);
-	init_MUTEX_LOCKED(&host->probe_sem);
+	init_completion(&host->probe_comp);
 
 	for (i = 0; i < ARRAY_SIZE(host->req); i++)
 		host->req[i].tag = i;
@@ -1710,8 +1711,8 @@ static int carm_init_one (struct pci_dev
 	if (rc)
 		goto err_out_free_irq;
 
-	DPRINTK("waiting for probe_sem\n");
-	down(&host->probe_sem);
+	DPRINTK("waiting for probe_comp\n");
+	wait_for_completion(&host->probe_comp);
 
 	printk(KERN_INFO "%s: pci %s, ports %d, io %lx, irq %u, major %d\n",
 	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpu5wdt-sem2completions.patch"

 drivers/char/watchdog/cpu5wdt.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

Index: linux/drivers/char/watchdog/cpu5wdt.c
===================================================================
--- linux.orig/drivers/char/watchdog/cpu5wdt.c
+++ linux/drivers/char/watchdog/cpu5wdt.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/timer.h>
+#include <linux/completion.h>
 #include <linux/jiffies.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -57,7 +58,7 @@ static int ticks = 10000;
 /* some device data */
 
 static struct {
-	struct semaphore stop;
+	struct completion stop;
 	volatile int running;
 	struct timer_list timer;
 	volatile int queue;
@@ -85,7 +86,7 @@ static void cpu5wdt_trigger(unsigned lon
 	}
 	else {
 		/* ticks doesn't matter anyway */
-		up(&cpu5wdt_device.stop);
+		complete(&cpu5wdt_device.stop);
 	}
 
 }
@@ -239,7 +240,7 @@ static int __devinit cpu5wdt_init(void)
 	if ( !val )
 		printk(KERN_INFO PFX "sorry, was my fault\n");
 
-	init_MUTEX_LOCKED(&cpu5wdt_device.stop);
+	init_completion(&cpu5wdt_device.stop);
 	cpu5wdt_device.queue = 0;
 
 	clear_bit(0, &cpu5wdt_device.inuse);
@@ -269,7 +270,7 @@ static void __devexit cpu5wdt_exit(void)
 {
 	if ( cpu5wdt_device.queue ) {
 		cpu5wdt_device.queue = 0;
-		down(&cpu5wdt_device.stop);
+		wait_for_completion(&cpu5wdt_device.stop);
 	}
 
 	misc_deregister(&cpu5wdt_misc);

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-gendev-sem-to-completion.patch"

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
@@ -759,7 +760,7 @@ typedef struct ide_drive_s {
 	int		crc_count;	/* crc counter to reduce drive speed */
 	struct list_head list;
 	struct device	gendev;
-	struct semaphore gendev_rel_sem;	/* to deal with device release() */
+	struct completion gendev_rel_comp;	/* to deal with device release() */
 } ide_drive_t;
 
 #define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
@@ -915,7 +916,7 @@ typedef struct hwif_s {
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 
 	struct device	gendev;
-	struct semaphore gendev_rel_sem; /* To deal with device release() */
+	struct completion gendev_rel_comp; /* To deal with device release() */
 
 	void		*hwif_data;	/* extra hwif data */
 

--AqsLC8rIMeq19msA--
