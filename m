Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWF3PKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWF3PKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 11:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWF3PKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 11:10:50 -0400
Received: from bay0-omc1-s34.bay0.hotmail.com ([65.54.246.106]:60479 "EHLO
	bay0-omc1-s34.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1750750AbWF3PKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 11:10:49 -0400
Message-ID: <BAY109-F32262A180407EC02E12579D67D0@phx.gbl>
X-Originating-IP: [203.101.32.54]
X-Originating-Email: [agovinda04@hotmail.com]
From: "govind raj" <agovinda04@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Hot swap support in SATA(Linux kernel-2.6.16) 
Date: Fri, 30 Jun 2006 20:40:45 +0530
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_5fb6_53ce_6298"
X-OriginalArrivalTime: 30 Jun 2006 15:10:48.0972 (UTC) FILETIME=[5E979CC0:01C69C57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_5fb6_53ce_6298
Content-Type: text/plain; format=flowed

Hi all,

We are using the linux kernel 2.6.16 version on an Intel SE7230NH1 board 
using the 4 onboard SATA ports. We have applied the following two  patches  
from:

http://lkml.org/lkml/2005/11/15/385
http://www.gatago.com/linux/kernel/14695643.html


With using a compatible SATA backplane for the support of hotswap, we are 
finding that the disks are not 'really' hot-swappable. We are using 
Maxtor300GB SATA HDDs. We are observing the following behavior:

A) When we insert a new disk into an available slot, we observe that the 
disk does not show up in the available disks. We use the 'fdisk' command for 
this purpose. Only a system reboot, does the disk showup in the list of 
available disks for the system.

B) When we remove a disk that is already inserted, we get a timeout error 
"abnormal status 0x7F on port " on the console port and subsequently all the 
disk I/O related commands go into an hanging state - till such time that we 
insert the disk back into the slot.

Both (A) and (B) goes against the principle of hot-swappability. Is there 
something that needs to be done additionally apart from applying these 
twopatches? We have also enclosed the patch difference that we had applied 
onthis kernel version tree.

Any inputs on this would be much appreciated.


Thanks in advance,
Govind


------=_NextPart_000_5fb6_53ce_6298
Content-Type: text/x-patch; name="2.6.16.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="2.6.16.patch"

--- linux-2.6.16/drivers/scsi/libata-core.c.old 2005-07-21 13:35:31.609832324 -0400
+++ linux-2.6.16/drivers/scsi/libata-core.c 2005-07-21 13:42:53.945386060 -0400
@@ -44,7 +44,6 @@
#include <scsi/scsi_host.h>
#include <linux/libata.h>
#include <asm/io.h>
-#include <asm/semaphore.h>
#include <asm/byteorder.h>

#include "libata.h"
@@ -65,6 +64,7 @@ static void __ata_qc_complete(struct ata

static unsigned int ata_unique_id = 1;
static struct workqueue_struct *ata_wq;
+static struct workqueue_struct *ata_irq_wq;

MODULE_AUTHOR("Jeff Garzik");
MODULE_DESCRIPTION("Library module for ATA devices");
@@ -1134,6 +1134,11 @@ static void ata_dev_identify(struct ata_
return;
}

+ /* Necessary if we had an LBA48 drive in, we pulled it out, and put in
+ * a non-LBA48 drive to replace it.
+ */
+ dev->flags &= ~ATA_DFLAG_LBA48;
+
if (ap->flags & (ATA_FLAG_SRST | ATA_FLAG_SATA_RESET))
using_edd = 0;
else
@@ -3635,6 +3640,73 @@ idle_irq:
return 0; /* irq not handled */
}

+void ata_check_kill_qc(struct ata_port *ap)
+{
+ struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+
+ if (unlikely(qc)) {
+ /* This is SO bad. But we can't just run
+ * ata_qc_complete without doing this, because
+ * ata_scsi_qc_complete wants to talk to the device,
+ * and we can't let it do that since it doesn't exist
+ * anymore.
+ */
+ ata_scsi_prepare_qc_abort(qc);
+ ata_qc_complete(qc, ATA_ERR);
+ }
+}
+

+static void ata_hotplug_unplug_func(void *_data)
+{
+ struct ata_port *ap = (struct ata_port *)_data;
+ DPRINTK("Got an unplug request on port %d\n", ap->id);
+
+ down(&ap->hotplug_mutex);
+
+ ata_scsi_handle_unplug(ap);
+
+ up(&ap->hotplug_mutex);
+}
+
+static void ata_hotplug_plug_func(void *_data)
+{
+ struct ata_port *ap = (struct ata_port *)_data;
+ DPRINTK("Got a plug request on port %d\n", ap->id);
+
+ down(&ap->hotplug_mutex);
+ /* Pure evil. Suppose that you have an 'unplug' waiting on your
+ * queue, and this function executes while it's there (because
+ * you unplugged/plugged in a disk on an SMP system VERY FAST).


+ * REALLY bad news, because when you unplugged your disk, you
+ * might have had a pending qc which will now sit there and time
+ * out like the mofo it is. Check to see if we have one sitting
+ * around and KILL IT if this is so.
+ */
+ ata_check_kill_qc(ap);
+ // Observed necessary on some Seagate drives.
+ ap->flags |= ATA_FLAG_SATA_RESET;
+ ap->udma_mask = ap->orig_udma_mask;
+
+ if (ata_bus_probe(ap) /* Does its own locking */)
+ ata_scsi_handle_unplug(ap); //might be necessary on SMP
+ else
+ ata_scsi_handle_plug(ap);
+ up(&ap->hotplug_mutex);
+}
+
+/* Should be protected by host_set->lock */
+void ata_hotplug_unplug(struct ata_port *ap)
+{
+ ata_port_disable(ap); //disable this NOW, device is gone
+ queue_work(ata_irq_wq, &ap->hotplug_unplug_task);
+}
+
+/* Should be protected by host_set->lock */
+void ata_hotplug_plug(struct ata_port *ap)
+{
+ queue_work(ata_irq_wq, &ap->hotplug_plug_task);
+}
+
/**
* ata_interrupt - Default ATA host interrupt handler
* @irq: irq line (unused)
@@ -3860,7 +3932,11 @@ static void ata_host_init(struct ata_por
ap->cbl = ATA_CBL_NONE;
ap->active_tag = ATA_TAG_POISON;
ap->last_ctl = 0xFF;
+ ap->orig_udma_mask = ent->udma_mask;

+ init_MUTEX(&ap->hotplug_mutex);
+ INIT_WORK(&ap->hotplug_plug_task, ata_hotplug_plug_func, ap);
+ INIT_WORK(&ap->hotplug_unplug_task, ata_hotplug_unplug_func, ap);
INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
INIT_WORK(&ap->pio_task, ata_pio_task, ap);

@@ -4468,6 +4544,11 @@ static int __init ata_init(void)
ata_wq = create_workqueue("ata");
if (!ata_wq)
return -ENOMEM;
+ ata_irq_wq = create_workqueue("ata_irq");
+ if (!ata_irq_wq) {
+ destroy_workqueue(ata_wq);
+ return -ENOMEM;
+ }

printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
return 0;
@@ -4476,6 +4557,7 @@ static int __init ata_init(void)
static void __exit ata_exit(void)
{
destroy_workqueue(ata_wq);
+ destroy_workqueue(ata_irq_wq);
}

module_init(ata_init);
@@ -4531,6 +4613,8 @@ EXPORT_SYMBOL_GPL(ata_dev_classify);
EXPORT_SYMBOL_GPL(ata_dev_id_string);
EXPORT_SYMBOL_GPL(ata_dev_config);
EXPORT_SYMBOL_GPL(ata_scsi_simulate);
+EXPORT_SYMBOL_GPL(ata_hotplug_unplug);
+EXPORT_SYMBOL_GPL(ata_hotplug_plug);

#ifdef CONFIG_PCI
EXPORT_SYMBOL_GPL(pci_test_config_bits);
--- linux-2.6.13-rc3/drivers/scsi/libata-scsi.c.old 2005-07-21 13:35:35.622684850 -0400
+++ linux-2.6.13-rc3/drivers/scsi/libata-scsi.c 2005-07-21 13:42:53.950384627 -0400
@@ -1011,6 +1011,53 @@ static int ata_scsi_qc_complete(struct a
return 0;
}

+static int ata_scsi_qc_abort(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+ struct scsi_cmnd *cmd = qc->scsicmd;
+
+ cmd->result = SAM_STAT_TASK_ABORTED; //FIXME: Is this what we want?
+
+ qc->scsidone(cmd);
+
+ return 0;
+}
+
+void ata_scsi_prepare_qc_abort(struct ata_queued_cmd *qc)
+{
+ // For some reason or another, we can't allow a normal scsi_qc_complete
+ if (qc->complete_fn == ata_scsi_qc_complete);
+ qc->complete_fn = ata_scsi_qc_abort;
+}
+
+void ata_scsi_handle_plug(struct ata_port *ap)
+{
+ //Currently SATA only
+ scsi_add_device(ap->host, 0, 0, 0);
+}
+
+void ata_scsi_handle_unplug(struct ata_port *ap)
+{
+ //SATA only, no PATA
+ struct scsi_device *scd = scsi_device_lookup(ap->host, 0, 0, 0);
+ /* scd might not exist; someone did 'echo "scsi remove-single-device
+ * ... " > /proc/scsi/scsi' or somebody was turning the key in the
+ * hotswap bay between on and off really really fast.
+ */
+ if (scd) {
+ scsi_device_set_state(scd, SDEV_CANCEL);
+ /* We might have a pending qc on I/O to a removed device,
+ * however, I argue it's impossible unless we have an 'scd'
+ * because it means we never completed a 'plug' into the system
+ * (or no device was present on bootup), so either we have no
+ * possible I/O, or a qc which 'ata_hotplug_plug_func' took
+ * care of
+ */
+ ata_check_kill_qc(ap);
+ scsi_remove_device(scd);
+ scsi_device_put(scd);
+ }
+}
+

--- include/linux/libata.h.bak	2006-06-30 19:47:54.000000000 +0530
+++ include/linux/libata.h	2006-06-30 12:06:06.000000000 +0530
@@ -33,6 +33,7 @@
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
+#include <asm/semaphore.h>
 
 /*
  * compile-time options
@@ -352,6 +353,9 @@
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
+	struct semaphore hotplug_mutex;
+	struct work_struct hotplug_plug_task;
+	struct work_struct hotplug_unplug_task;
 
 	struct work_struct	packet_task;
 
@@ -360,6 +364,7 @@
 	unsigned long		pio_task_timeout;
 
 	void			*private_data;
+	unsigned int 		orig_udma_mask;
 };
 
 struct ata_port_operations {
@@ -452,6 +457,8 @@
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+extern void ata_hotplug_unplug(struct ata_port *ap);
+extern void ata_hotplug_plug(struct ata_port *ap);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *);
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
@@ -631,7 +638,7 @@
 	u8 status;
 
 	do {
-		udelay(10);
+		udelay(100);
 		status = ata_chk_status(ap);
 		max--;
 	} while ((status & bits) && (max > 0));
@@ -653,7 +660,7 @@
 
 static inline u8 ata_wait_idle(struct ata_port *ap)
 {
-	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
+	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10000);
 
 	if (status & (ATA_BUSY | ATA_DRQ)) {
 		unsigned long l = ap->ioaddr.status_addr;
--- include/linux/libata.h.old	2006-06-30 19:47:54.000000000 +0530
+++ include/linux/libata.h	2006-06-30 12:06:06.000000000 +0530
@@ -33,6 +33,7 @@
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
+#include <asm/semaphore.h>
 
 /*
  * compile-time options
@@ -352,6 +353,9 @@
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
+	struct semaphore hotplug_mutex;
+	struct work_struct hotplug_plug_task;
+	struct work_struct hotplug_unplug_task;
 
 	struct work_struct	packet_task;
 
@@ -360,6 +364,7 @@
 	unsigned long		pio_task_timeout;
 
 	void			*private_data;
+	unsigned int 		orig_udma_mask;
 };
 
 struct ata_port_operations {
@@ -452,6 +457,8 @@
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+extern void ata_hotplug_unplug(struct ata_port *ap);
+extern void ata_hotplug_plug(struct ata_port *ap);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *);
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
@@ -631,7 +638,7 @@
 	u8 status;
 
 	do {
-		udelay(10);
+		udelay(100);
 		status = ata_chk_status(ap);
 		max--;
 	} while ((status & bits) && (max > 0));
@@ -653,7 +660,7 @@
 
 static inline u8 ata_wait_idle(struct ata_port *ap)
 {
-	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
+	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10000);
 
 	if (status & (ATA_BUSY | ATA_DRQ)) {
 		unsigned long l = ap->ioaddr.status_addr;
--- drivers/scsi/libata-scsi.c.old	2006-06-30 11:50:19.000000000 +0530
+++ drivers/scsi/libata-scsi.c	2006-06-30 11:51:55.000000000 +0530
@@ -2624,3 +2624,50 @@
 }
 
 
+static int ata_scsi_qc_abort(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+ struct scsi_cmnd *cmd = qc->scsicmd;
+
+ cmd->result = SAM_STAT_TASK_ABORTED; //FIXME: Is this what we want?
+
+ qc->scsidone(cmd);
+
+ return 0;
+}
+
+void ata_scsi_prepare_qc_abort(struct ata_queued_cmd *qc)
+{
+ // For some reason or another, we can't allow a normal scsi_qc_complete
+ if (qc->complete_fn == ata_scsi_qc_complete);
+ qc->complete_fn = ata_scsi_qc_abort;
+}
+
+void ata_scsi_handle_plug(struct ata_port *ap)
+{
+ //Currently SATA only
+ scsi_add_device(ap->host, 0, 0, 0);
+}
+
+void ata_scsi_handle_unplug(struct ata_port *ap)
+{
+ //SATA only, no PATA
+ struct scsi_device *scd = scsi_device_lookup(ap->host, 0, 0, 0);
+ /* scd might not exist; someone did 'echo "scsi remove-single-device
+ * ... " > /proc/scsi/scsi' or somebody was turning the key in the
+ * hotswap bay between on and off really really fast.
+ */
+ if (scd) {
+ scsi_device_set_state(scd, SDEV_CANCEL);
+ /* We might have a pending qc on I/O to a removed device,
+ * however, I argue it's impossible unless we have an 'scd'
+ * because it means we never completed a 'plug' into the system
+ * (or no device was present on bootup), so either we have no
+ * possible I/O, or a qc which 'ata_hotplug_plug_func' took
+ * care of
+ */
+ ata_check_kill_qc(ap);
+ scsi_remove_device(scd);
+ scsi_device_put(scd);
+ }
+}
+


------=_NextPart_000_5fb6_53ce_6298--
