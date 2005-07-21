Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVGUVSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVGUVSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 17:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVGUVQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 17:16:15 -0400
Received: from ptr-64-201-187-87.ptr.terago.ca ([64.201.187.87]:52626 "HELO
	mars.net-itech.com") by vger.kernel.org with SMTP id S261882AbVGUVOl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 17:14:41 -0400
Message-ID: <42E01040.3080102@nit.ca>
Date: Thu, 21 Jul 2005 17:14:40 -0400
From: Lukasz Kosewski <lkosewsk@nit.ca>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jgarzik@pobox.com, linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Add disk hotswap support to libata
Content-Type: multipart/mixed;
 boundary="------------000205080608080606040801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000205080608080606040801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch is probably the most contentious one; adding a hotswap 
framework to libata to allow it to handle disk plugs/unplugs.

The design goals for this framework were as follows:
- easy, stable API.
- simplicity of design and code
- as damn near as we can get to a guarantee that we will NOT panic the 
kernel if the user does something stupid, an an attempt to guarantee 
correct behaviour anyways.

To meet these goals, I have many comments.  The new API, as far as 
driver writers see, is two functions 'ata_hotplug_plug' and 
'ata_hotplug_unplug'.  Respectively, these should be called when a new 
disk is picked up or removed.  This seems like the most logical way to 
go about this.

The functions use a single shared workqueue to schedule plug and unplug 
events.  In the 'normal case' where a user merely plugs in or unplugs a 
disk, you can trivially follow the functionality.  The edge cases all 
have to do with these cases:  what happens when the user really quickly 
plugs/unplugs disks, or has pending I/O?

You'll note at a cursory glance that we need to call an ata_bus_reset 
when plugging in a disk; this means that we have to wait a bit for 
everything to settle.  If the user goes and unplugs the disk on us, we 
need to immediately take corrective action.

As such, the 'plug' function is a little complicated.

There is also the issue of I/O (or other requests?) pending on a device 
when we unplug it.  Since we do not want to panic the kernel, we need to 
handle them gracefully.  As it stands, the SCSI layer does this for us 
rather nicely, EXCEPT in the case that we have an outstanding qc on our 
device, waiting for completion.  This is the explanation for the 'if 
(qc)' checks in various parts of the code to kill these functions.

I must point out that I have NOT tested this on SMP systems, where we 
can potentially be servicing more than one request from our request 
queue.  Potentially doing a plug/unplug/plug/unplug/etc. kind of action 
very fast might lead us to running multiple 'plug' and 'unplug' 
functions simultaneously.

I did NOT want to complicate the libata code by throwing spinlocks 
around all over the place to protect against this (changing working, 
existing code), instead, I have wrapped the 'plug' and 'unplug' 
functions within a mutex.  This should ensure no erroneous behaviour, 
and still service requests in a timely fashion 99% of the time (on UP 
systems, it actually makes no difference).

There are GRATUITOUS comments put in the code for you to look at to see 
if my logic is flawed.  Have fun!

Luke Kosewski
Human Cannonball
Net Integration Technologies

Signed-off-by:  Luke Kosewski <lkosewsk@nit.ca>

--------------000205080608080606040801
Content-Type: text/plain;
 name="02-libata_hotswap_infrastructure-2.6.13-rc3-mm1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-libata_hotswap_infrastructure-2.6.13-rc3-mm1.diff"

21.07.05  Luke Kosewski  <lkosewsk@nit.ca>

	* A patch to add a general-purpose hotswap framework to libata.  From
	  the point of view of the driver writer, we only have two new API
	  functions; 'ata_hotplug_plug' and 'ata_hotplug_unplug', which have
	  rather self-explanatory functions.
	* A few misc changes are necessary to properly reset flags which are
	  set by devices when they are present to make sure that new devices
	  (for instance, disks with different max UDMA transfer rates, not using
	  LBA48, etc.) being swapped in do not assume values for the old
	  devices.
	* Gratuitous comments here that can probably be removed, so that anyone
	  looking at this can understand this and poke holes in my logic.

Signed-off-by:  Luke Kosewski <lkosewsk@nit.ca>

--- linux-2.6.13-rc3/drivers/scsi/libata-core.c.old	2005-07-21 13:35:31.609832324 -0400
+++ linux-2.6.13-rc3/drivers/scsi/libata-core.c	2005-07-21 13:42:53.945386060 -0400
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
 
+	/* Necessary if we had an LBA48 drive in, we pulled it out, and put in
+	 * a non-LBA48 drive to replace it.
+	 */
+	dev->flags &= ~ATA_DFLAG_LBA48;
+
 	if (ap->flags & (ATA_FLAG_SRST | ATA_FLAG_SATA_RESET))
 		using_edd = 0;
 	else
@@ -3635,6 +3640,73 @@ idle_irq:
 	return 0;	/* irq not handled */
 }
 
+void ata_check_kill_qc(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+
+	if (unlikely(qc)) {
+		/* This is SO bad.  But we can't just run
+		 * ata_qc_complete without doing this, because
+		 * ata_scsi_qc_complete wants to talk to the device,
+		 * and we can't let it do that since it doesn't exist
+		 * anymore.
+		 */
+		ata_scsi_prepare_qc_abort(qc);
+		ata_qc_complete(qc, ATA_ERR);
+	}
+}
+
+static void ata_hotplug_unplug_func(void *_data)
+{
+	struct ata_port *ap = (struct ata_port *)_data;
+	DPRINTK("Got an unplug request on port %d\n", ap->id);
+
+	down(&ap->hotplug_mutex);
+
+	ata_scsi_handle_unplug(ap);
+
+	up(&ap->hotplug_mutex);
+}
+
+static void ata_hotplug_plug_func(void *_data)
+{
+	struct ata_port *ap = (struct ata_port *)_data;
+	DPRINTK("Got a plug request on port %d\n", ap->id);
+
+	down(&ap->hotplug_mutex);
+	/* Pure evil.  Suppose that you have an 'unplug' waiting on your
+	 * queue, and this function executes while it's there (because 
+	 * you unplugged/plugged in a disk on an SMP system VERY FAST).
+	 * REALLY bad news, because when you unplugged your disk, you
+	 * might have had a pending qc which will now sit there and time
+	 * out like the mofo it is.  Check to see if we have one sitting
+	 * around and KILL IT if this is so.
+	 */
+	ata_check_kill_qc(ap);
+	// Observed necessary on some Seagate drives.
+	ap->flags |= ATA_FLAG_SATA_RESET;
+	ap->udma_mask = ap->orig_udma_mask;
+
+	if (ata_bus_probe(ap) /* Does its own locking */)
+		ata_scsi_handle_unplug(ap);  //might be necessary on SMP
+	else
+		ata_scsi_handle_plug(ap);
+	up(&ap->hotplug_mutex);
+}
+
+/* Should be protected by host_set->lock */
+void ata_hotplug_unplug(struct ata_port *ap)
+{
+	ata_port_disable(ap); //disable this NOW, device is gone
+	queue_work(ata_irq_wq, &ap->hotplug_unplug_task);
+}
+
+/* Should be protected by host_set->lock */
+void ata_hotplug_plug(struct ata_port *ap)
+{
+	queue_work(ata_irq_wq, &ap->hotplug_plug_task);
+}
+
 /**
  *	ata_interrupt - Default ATA host interrupt handler
  *	@irq: irq line (unused)
@@ -3860,7 +3932,11 @@ static void ata_host_init(struct ata_por
 	ap->cbl = ATA_CBL_NONE;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
+	ap->orig_udma_mask = ent->udma_mask;
 
+	init_MUTEX(&ap->hotplug_mutex);
+	INIT_WORK(&ap->hotplug_plug_task, ata_hotplug_plug_func, ap);
+	INIT_WORK(&ap->hotplug_unplug_task, ata_hotplug_unplug_func, ap);
 	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
 	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
 
@@ -4468,6 +4544,11 @@ static int __init ata_init(void)
 	ata_wq = create_workqueue("ata");
 	if (!ata_wq)
 		return -ENOMEM;
+	ata_irq_wq = create_workqueue("ata_irq");
+	if (!ata_irq_wq) {
+		destroy_workqueue(ata_wq);
+		return -ENOMEM;
+	}
 
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
@@ -4476,6 +4557,7 @@ static int __init ata_init(void)
 static void __exit ata_exit(void)
 {
 	destroy_workqueue(ata_wq);
+	destroy_workqueue(ata_irq_wq);
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
--- linux-2.6.13-rc3/drivers/scsi/libata-scsi.c.old	2005-07-21 13:35:35.622684850 -0400
+++ linux-2.6.13-rc3/drivers/scsi/libata-scsi.c	2005-07-21 13:42:53.950384627 -0400
@@ -1011,6 +1011,53 @@ static int ata_scsi_qc_complete(struct a
 	return 0;
 }
 
+static int ata_scsi_qc_abort(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+
+	cmd->result = SAM_STAT_TASK_ABORTED; //FIXME:  Is this what we want?
+
+	qc->scsidone(cmd);
+
+	return 0;
+}
+
+void ata_scsi_prepare_qc_abort(struct ata_queued_cmd *qc)
+{
+	// For some reason or another, we can't allow a normal scsi_qc_complete
+	if (qc->complete_fn == ata_scsi_qc_complete);
+		qc->complete_fn = ata_scsi_qc_abort;
+}
+
+void ata_scsi_handle_plug(struct ata_port *ap)
+{
+	//Currently SATA only
+	scsi_add_device(ap->host, 0, 0, 0);
+}
+
+void ata_scsi_handle_unplug(struct ata_port *ap)
+{
+	//SATA only, no PATA
+	struct scsi_device *scd = scsi_device_lookup(ap->host, 0, 0, 0);
+	/* scd might not exist; someone did 'echo "scsi remove-single-device
+	 * ... " > /proc/scsi/scsi' or somebody  was turning the key in the
+	 * hotswap bay between on and off really really fast.
+	 */
+	if (scd) {
+		scsi_device_set_state(scd, SDEV_CANCEL);
+		/* We might have a pending qc on I/O to a removed device,
+		 * however, I argue it's impossible unless we have an 'scd'
+		 * because it means we never completed a 'plug' into the system
+		 * (or no device was present on bootup), so either we have no
+		 * possible I/O, or a qc which 'ata_hotplug_plug_func' took
+		 * care of
+		 */
+		ata_check_kill_qc(ap);
+		scsi_remove_device(scd);
+		scsi_device_put(scd);
+	}
+}
+
 /**
  *	ata_scsi_translate - Translate then issue SCSI command to ATA device
  *	@ap: ATA port to which the command is addressed
--- linux-2.6.13-rc3/drivers/scsi/libata.h.old	2005-07-21 13:35:24.217945955 -0400
+++ linux-2.6.13-rc3/drivers/scsi/libata.h	2005-07-21 13:42:53.955383193 -0400
@@ -40,6 +40,7 @@ extern struct ata_queued_cmd *ata_qc_new
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern int ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
+extern void ata_check_kill_qc(struct ata_port *ap);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
@@ -76,6 +77,9 @@ extern void ata_scsi_badcmd(struct scsi_
 extern void ata_scsi_rbuf_fill(struct ata_scsi_args *args, 
                         unsigned int (*actor) (struct ata_scsi_args *args,
                                            u8 *rbuf, unsigned int buflen));
+extern void ata_scsi_prepare_qc_abort(struct ata_queued_cmd *qc);
+extern void ata_scsi_handle_plug(struct ata_port *ap);
+extern void ata_scsi_handle_unplug(struct ata_port *ap);
 
 static inline void ata_bad_scsiop(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
 {
--- linux-2.6.13-rc3/include/linux/libata.h.old	2005-07-21 13:35:50.548416576 -0400
+++ linux-2.6.13-rc3/include/linux/libata.h	2005-07-21 13:42:53.960381760 -0400
@@ -29,6 +29,7 @@
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
+#include <asm/semaphore.h>
 
 /*
  * compile-time options
@@ -319,6 +320,9 @@ struct ata_port {
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
 
+	struct semaphore	hotplug_mutex;
+	struct work_struct	hotplug_plug_task;
+	struct work_struct	hotplug_unplug_task;
 	struct work_struct	packet_task;
 
 	struct work_struct	pio_task;
@@ -326,6 +330,8 @@ struct ata_port {
 	unsigned long		pio_task_timeout;
 
 	void			*private_data;
+
+	unsigned int		orig_udma_mask;
 };
 
 struct ata_port_operations {
@@ -402,6 +408,8 @@ extern int ata_scsi_queuecmd(struct scsi
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+extern void ata_hotplug_unplug(struct ata_port *ap);
+extern void ata_hotplug_plug(struct ata_port *ap);
 /*
  * Default driver ops implementations
  */

--------------000205080608080606040801--
