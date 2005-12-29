Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVL2XX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVL2XX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVL2XX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:23:58 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:32830 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751154AbVL2XX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:23:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=H2Ny/tVV0jbA+HblPUxHwwEFKMFjPOfIz4tW9lz+EtWDAWHYHAg4+CHsIrP/IvR6YlkzoakG+808icS1E2nHTu0VRZXkS7MXH8MCcNbTE0n8ExFVBREQnjtrmdA5iYJfyERsQ42/FF6xPT8Wm2Hx2aG2JAB+dhQd8bvuOc/Bsmw=
Message-ID: <355e5e5e0512291523u6cc6d7ebr479a973ff1907245@mail.gmail.com>
Date: Thu, 29 Dec 2005 18:23:55 -0500
From: Lukasz Kosewski <lkosewsk@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.6.15-rc7-git3 2/3] libata: framework API for hotswapping drives on libata controllers
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7590_23772725.1135898635787"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7590_23772725.1135898635787
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

VGhpcyBwYXRjaCBhZGRzIGEgZnJhbWV3b3JrIGZvciBob3Qtc3dhcHBpbmcgZHJpdmVzIG9uIGxp
YmF0YS1ydW4KY29udHJvbGxlcnMuICBUaGUgZnVuY3Rpb25zICdzYXRhX2hvdF9wbHVnJyBhbmQg
J3NhdGFfaG90X3VucGx1ZycgY2FuCmJlIGNhbGxlZCBieSBsb3cgbGV2ZWwgaG90c3dhcC1jYXBh
YmxlIFNBVEEgY29udHJvbGxlcnMsIGFuZApzdWJzZXF1ZW50IGZ1bmN0aW9ucyBpbiB0aGUgY2Fs
bCBjaGFpbiB3aWxsIChpbiB0aGUgZnV0dXJlKSBiZSBlbnRyeQpwb2ludHMgZm9yIFBBVEEgd2Fy
bS1zd2FwcGluZyBvZiBkcml2ZXMuCgpTaWduZWQtb2ZmLWJ5OiAgTHVrZSBLb3Nld3NraSA8bGtv
c2V3c2tAZ21haWwuY29tPgoKTHVrZSBLb3Nld3NraQo=
------=_Part_7590_23772725.1135898635787
Content-Type: text/x-patch; 
	name=02-libata_hotswap_infrastructure-2.6.15-rc7-git3.diff; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="02-libata_hotswap_infrastructure-2.6.15-rc7-git3.diff"

29.12.05    Luke Kosewski   <lkosewsk@gmail.com>

	* A patch which adds a framework for drive hotswap in libata drivers.
	  For hotswap-capable SATA controllers, the functions sata_hot_plug and
	  sata_hot_unplug will allow handling of new or removed disks in the
	  system.  Further up the call chain are entry points which (in the
	  future) will allow for PATA warm-swapping.

	Signed-off-by:  Luke Kosewski <lkosewsk@gmail.com>

--- linux-2.6.15-rc7/drivers/scsi/libata-core.c.old	2005-12-28 18:15:53.000000000 -0500
+++ linux-2.6.15-rc7/drivers/scsi/libata-core.c	2005-12-29 15:53:32.000000000 -0500
@@ -77,6 +77,7 @@ static void __ata_qc_complete(struct ata
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
+static struct workqueue_struct *ata_hotplug_wq;
 
 int atapi_enabled = 0;
 module_param(atapi_enabled, int, 0444);
@@ -1110,6 +1111,9 @@ static void ata_dev_identify(struct ata_
 		return;
 	}
 
+	/* wipe all flags; this might be a different drive on hotswap. */
+	dev->flags = 0;
+
 	if (ap->flags & (ATA_FLAG_SRST | ATA_FLAG_SATA_RESET))
 		using_edd = 0;
 	else
@@ -3982,6 +3986,103 @@ idle_irq:
 	return 0;	/* irq not handled */
 }
 
+void ata_check_kill_qc(struct ata_port *ap, unsigned int device)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+
+	if (unlikely(qc) && device == qc->dev->devno) {
+		/* Kill outstanding qc to device if one exists */
+		ata_qc_complete(qc, ATA_ERR);
+	}
+}
+
+static void ata_hotplug_task(void *_data)
+{
+	struct ata_port *ap = (struct ata_port *)_data;
+	enum hotplug_states hotplug_todo[ATA_MAX_DEVICES];
+	unsigned long flags;
+	int i;
+
+	/* This function could have just one loop, but then we'd have to acquire
+	 * the spin_lock multiple times.  Better to just have two loops.
+	 */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	for (i = 0; i < ATA_MAX_DEVICES; ++i) {
+		/* Make sure we don't modify while reading! */
+		hotplug_todo[i] = ap->device[i].plug; 
+		ap->device[i].plug = HOT_NOOP;
+	}
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	for (i = 0; i < ATA_MAX_DEVICES; ++i) {
+		switch (hotplug_todo[i]) {
+			case HOT_PLUG:
+				DPRINTK("Got a plug request on port %d\n", ap->id);
+
+				/* This might be necessary if we unplug and plug
+				 * in a drive within ATA_TMOUT_HOTPLUG / HZ
+				 * seconds... due to the debounce timer, one
+				 * event is generated.  Since the last event was
+				 * a plug, the unplug routine never gets called,
+				 * so we need to clean up the mess first.  If
+				 * there was never a drive here in the first
+				 * place, this will just do nothing.  Otherwise,
+				 * it basically prevents 'plug' from being
+				 * called twice with no unplug in between.
+				 */
+				ata_scsi_hot_unplug(ap, i);
+
+				/* This is necessary for some Seagate drives. */
+				if (ap->flags & ATA_FLAG_SATA)
+					ap->flags |= ATA_FLAG_SATA_RESET; 
+				ap->udma_mask = ap->orig_udma_mask;
+
+				if (!ata_bus_probe(ap)) /* Success */
+					ata_scsi_hot_plug(ap, i);
+				break;
+			case HOT_UNPLUG:
+				DPRINTK("Got an unplug request on port %d\n", ap->id);
+
+				ata_scsi_hot_unplug(ap, i);
+				/* Fall through */
+			case HOT_NOOP:
+				/* No-op; do nothing */
+				break;
+			default:
+				/* Should never happen */
+				BUG();
+		}
+	}
+}
+
+void sata_hot_plug(struct ata_port *ap)
+{
+	if (ap->ops->hotplug_plug_janitor)
+		ap->ops->hotplug_plug_janitor(ap);
+
+	/* This line should be protected by a host_set->lock.  If we follow the
+	 * call chain up from this function, it's called from within an
+	 * interrupt handler.  Make sure that, when called, this function is
+	 * protected in said handler.
+	 */
+	ap->device[0].plug = HOT_PLUG;
+
+	queue_delayed_work(ata_hotplug_wq, &ap->hotplug_task, ATA_TMOUT_HOTPLUG);
+}
+
+void sata_hot_unplug(struct ata_port *ap)
+{
+	ap->device[0].class = ATA_DEV_NONE;
+	
+	if (ap->ops->hotplug_unplug_janitor)
+		ap->ops->hotplug_unplug_janitor(ap);
+	
+	/* See comment near similar line in sata_hot_plug function. */
+	ap->device[0].plug = HOT_UNPLUG;
+
+	queue_delayed_work(ata_hotplug_wq, &ap->hotplug_task, ATA_TMOUT_HOTPLUG);
+}
+
 /**
  *	ata_interrupt - Default ATA host interrupt handler
  *	@irq: irq line (unused)
@@ -4224,12 +4325,16 @@ static void ata_host_init(struct ata_por
 	ap->cbl = ATA_CBL_NONE;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
+	ap->orig_udma_mask = ent->udma_mask;
 
+	INIT_WORK(&ap->hotplug_task, ata_hotplug_task, ap);
 	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
 	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		ap->device[i].devno = i;
+		ap->device[i].plug = HOT_NOOP;
+	}
 
 #ifdef ATA_IRQ_TRAP
 	ap->stats.unhandled_irq = 1;
@@ -4868,6 +4973,11 @@ static int __init ata_init(void)
 	ata_wq = create_workqueue("ata");
 	if (!ata_wq)
 		return -ENOMEM;
+	ata_hotplug_wq = create_workqueue("ata_hotplug");
+	if (!ata_hotplug_wq) {
+		destroy_workqueue(ata_wq);
+		return -ENOMEM;
+	}
 
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
@@ -4876,6 +4986,7 @@ static int __init ata_init(void)
 static void __exit ata_exit(void)
 {
 	destroy_workqueue(ata_wq);
+	destroy_workqueue(ata_hotplug_wq);
 }
 
 module_init(ata_init);
@@ -4953,6 +5064,8 @@ EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
 EXPORT_SYMBOL_GPL(ata_dev_config);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
+EXPORT_SYMBOL_GPL(sata_hot_plug);
+EXPORT_SYMBOL_GPL(sata_hot_unplug);
 
 EXPORT_SYMBOL_GPL(ata_timing_compute);
 EXPORT_SYMBOL_GPL(ata_timing_merge);
--- linux-2.6.15-rc7/drivers/scsi/libata-scsi.c.old	2005-12-28 18:16:17.000000000 -0500
+++ linux-2.6.15-rc7/drivers/scsi/libata-scsi.c	2005-12-29 16:11:10.000000000 -0500
@@ -1210,6 +1210,11 @@ static int ata_scsi_qc_complete(struct a
 	u8 *cdb = cmd->cmnd;
  	int need_sense = (err_mask != 0);
 
+	if (unlikely(!ata_scsi_find_dev(qc->ap, cmd->device))) {
+		cmd->result = (DID_BAD_TARGET << 16);
+		goto out_no_dev;
+	}
+
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
 	 * generate because the user forced us to, a check condition
@@ -1239,11 +1244,39 @@ static int ata_scsi_qc_complete(struct a
 		ata_dump_status(qc->ap->id, &qc->tf);
 	}
 
+out_no_dev:
 	qc->scsidone(cmd);
 
 	return 0;
 }
 
+void ata_scsi_hot_plug(struct ata_port *ap, unsigned int device)
+{
+	/* libata uses the 'id' or 'target' value */
+	scsi_add_device(ap->host, 0, device, 0);
+}
+
+void ata_scsi_hot_unplug(struct ata_port *ap, unsigned int device)
+{
+	/* libata uses the 'id' or 'target' value */
+	struct scsi_device *scd = scsi_device_lookup(ap->host, 0, device, 0);
+
+	/* Make sure that we set this here, in case we aren't called as a
+	 * result of sata_hot_unplug */
+	ap->device[device].class = ATA_DEV_NONE;
+
+	if (scd)  /* Set to cancel state to block further I/O */
+		scsi_device_set_state(scd, SDEV_CANCEL);
+
+	/* We might have a pending qc on I/O to a removed device. */
+	ata_check_kill_qc(ap, device);
+	
+	if (scd) {
+		scsi_remove_device(scd);
+		scsi_device_put(scd);
+	}
+}
+
 /**
  *	ata_scsi_translate - Translate then issue SCSI command to ATA device
  *	@ap: ATA port to which the command is addressed
--- linux-2.6.15-rc7/drivers/scsi/libata.h.old	2005-12-28 18:16:08.000000000 -0500
+++ linux-2.6.15-rc7/drivers/scsi/libata.h	2005-12-29 13:01:33.000000000 -0500
@@ -46,6 +46,7 @@ extern void ata_rwcmd_protocol(struct at
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern int ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
+extern void ata_check_kill_qc(struct ata_port *ap, unsigned int device);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
@@ -84,5 +85,7 @@ extern void ata_scsi_set_sense(struct sc
 extern void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
                         unsigned int (*actor) (struct ata_scsi_args *args,
                                            u8 *rbuf, unsigned int buflen));
+extern void ata_scsi_hot_plug(struct ata_port *ap, unsigned int device);
+extern void ata_scsi_hot_unplug(struct ata_port *ap, unsigned int device);
 
 #endif /* __LIBATA_H__ */
--- linux-2.6.15-rc7/include/linux/libata.h.old	2005-12-28 18:16:33.000000000 -0500
+++ linux-2.6.15-rc7/include/linux/libata.h	2005-12-29 15:20:49.000000000 -0500
@@ -136,6 +136,7 @@ enum {
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* hueristic */
 	ATA_TMOUT_CDB		= 30 * HZ,
 	ATA_TMOUT_CDB_QUICK	= 5 * HZ,
+	ATA_TMOUT_HOTPLUG	= HZ / 2,	/* FIXME:  Guess value? */
 
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
@@ -188,6 +189,12 @@ enum ata_completion_errors {
 	AC_ERR_HOST_BUS		= (1 << 3),
 };
 
+enum hotplug_states {
+	HOT_NOOP,
+	HOT_PLUG,
+	HOT_UNPLUG,
+};
+
 /* forward declarations */
 struct scsi_device;
 struct ata_port_operations;
@@ -311,6 +318,8 @@ struct ata_device {
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
 	u16			sectors;	/* Number of sectors per track */
+	/* For hotplug */
+	enum hotplug_states	plug;
 };
 
 struct ata_port {
@@ -348,6 +357,7 @@ struct ata_port {
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
 
+	struct work_struct	hotplug_task;
 	struct work_struct	packet_task;
 
 	struct work_struct	pio_task;
@@ -355,6 +365,8 @@ struct ata_port {
 	unsigned long		pio_task_timeout;
 
 	void			*private_data;
+
+	unsigned int		orig_udma_mask;
 };
 
 struct ata_port_operations {
@@ -400,6 +412,8 @@ struct ata_port_operations {
 
 	void (*bmdma_stop) (struct ata_queued_cmd *qc);
 	u8   (*bmdma_status) (struct ata_port *ap);
+	void (*hotplug_plug_janitor) (struct ata_port *ap);
+	void (*hotplug_unplug_janitor) (struct ata_port *ap);
 };
 
 struct ata_port_info {
@@ -445,6 +459,8 @@ extern int ata_scsi_queuecmd(struct scsi
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+extern void sata_hot_plug(struct ata_port *ap);
+extern void sata_hot_unplug(struct ata_port *ap);
 extern int ata_ratelimit(void);
 
 /*


------=_Part_7590_23772725.1135898635787--
