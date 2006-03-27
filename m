Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWC0RvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWC0RvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWC0RvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:51:19 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24293 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750905AbWC0RvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:51:19 -0500
Subject: PATCH: Simplex and other mode filtering logic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Mar 2006 18:58:20 +0100
Message-Id: <1143482300.4970.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a field to the host_set called 'flags' (was host_set_flags changed
to suit Jeff)
Add a simplex_claimed field so we can remember who owns the DMA channel
Add a ->mode_filter() hook to allow drivers to filter modes
Add docs for mode_filter and set_mode
Filter according to simplex state
Filter cable in core

This provides the needed framework to support all the mode rules found
in the PATA world. The simplex filter deals with 'to spec' simplex DMA
systems found in older chips. The cable filter avoids duplicating the
same rules in each chip driver with PATA. Finally the mode filter is
neccessary because drive/chip combinations have errata that forbid
certain modes with some drives or types of ATA object.

Drive speed setup remains per channel for now and the filters now use
the framework Tejun put into place which cleans them up a lot from the
older libata-pata patches.

Signed-off-by: Alan Cox <alan@redhat.com>


diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9fcc061..26e0351 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -290,6 +295,9 @@ struct ata_host_set {
 	unsigned int		n_ports;
 	void			*private_data;
 	const struct ata_port_operations *ops;
+	unsigned long		flags;
+	int			simplex_claimed;	/* Keep seperate in case we
+							   ever need to do this locked */
 	struct ata_port *	ports[0];
 };
 
@@ -419,6 +427,7 @@ struct ata_port_operations {
 
 	void (*set_piomode) (struct ata_port *, struct ata_device *);
 	void (*set_dmamode) (struct ata_port *, struct ata_device *);
+	unsigned long (*mode_filter) (const struct ata_port *, struct ata_device *, unsigned long);
 
 	void (*tf_load) (struct ata_port *ap, const struct ata_taskfile *tf);
 	void (*tf_read) (struct ata_port *ap, struct ata_taskfile *tf);

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1cb9813..18d5239 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1814,7 +1824,7 @@ static void ata_host_set_dma(struct ata_
  */
 static void ata_set_mode(struct ata_port *ap)
 {
-	int i, rc;
+	int i, rc, used_dma = 0;
 
 	/* step 1: calculate xfer_mask */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
@@ -1832,6 +1842,9 @@ static void ata_set_mode(struct ata_port
 		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
 		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
 		dev->dma_mode = ata_xfer_mask2mode(dma_mask);
+
+		if (dev->dma_mode)
+			used_dma = 1;
 	}
 
 	/* step 2: always set host PIO timings */
@@ -1853,6 +1866,17 @@ static void ata_set_mode(struct ata_port
 			goto err_out;
 	}
 
+	/*
+	 *	Record simplex status. If we selected DMA then the other
+	 *	host channels are not permitted to do so.
+	 */
+
+	if (used_dma && (ap->host_set->flags & ATA_HOST_SIMPLEX))
+		ap->host_set->simplex_claimed = 1;
+
+	/*
+	 *	Chip specific finalisation
+	 */
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
 
@@ -2642,13 +2666,14 @@ static int ata_dma_blacklisted(const str
  */
 static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev)
 {
+	struct ata_host_set *hs = ap->host_set;
 	unsigned long xfer_mask;
 	int i;
 
 	xfer_mask = ata_pack_xfermask(ap->pio_mask, ap->mwdma_mask,
 				      ap->udma_mask);
 
-	/* use port-wide xfermask for now */
+	/* FIXME: Use port-wide xfermask for now */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *d = &ap->device[i];
 		if (!ata_dev_present(d))
@@ -2658,12 +2683,23 @@ static void ata_dev_xfermask(struct ata_
 		xfer_mask &= ata_id_xfermask(d->id);
 		if (ata_dma_blacklisted(d))
 			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+		/* Apply cable rule here. Don't apply it early because when
+		   we handle hot plug the cable type can itself change */
+		if (ap->cbl == ATA_CBL_PATA40)
+			xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 	}
 
 	if (ata_dma_blacklisted(dev))
 		printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, "
 		       "disabling DMA\n", ap->id, dev->devno);
 
+	if (hs->flags & ATA_HOST_SIMPLEX) {
+		if (hs->simplex_claimed)
+			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+	}
+	if (ap->ops->mode_filter)
+		xfer_mask = ap->ops->mode_filter(ap, dev, xfer_mask);
+
 	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
 			    &dev->udma_mask);
 }
@@ -4527,6 +4539,7 @@ int ata_device_add(const struct ata_prob
 	host_set->mmio_base = ent->mmio_base;
 	host_set->private_data = ent->private_data;
 	host_set->ops = ent->port_ops;
+	host_set->flags = ent->host_set_flags;
 
 	/* register each port bound to this device */
 	for (i = 0; i < ent->n_ports; i++) {
diff --git a/Documentation/DocBook/libata.tmpl b/Documentation/DocBook/libata.tmpl
index d260d92..5bcbb6e 100644
--- a/Documentation/DocBook/libata.tmpl
+++ b/Documentation/DocBook/libata.tmpl
@@ -120,14 +120,27 @@ void (*dev_config) (struct ata_port *, s
 	<programlisting>
 void (*set_piomode) (struct ata_port *, struct ata_device *);
 void (*set_dmamode) (struct ata_port *, struct ata_device *);
-void (*post_set_mode) (struct ata_port *ap);
+void (*post_set_mode) (struct ata_port *);
+unsigned int (*mode_filter) (struct ata_port *, struct ata_device *, unsigned int);
 	</programlisting>
 
 	<para>
 	Hooks called prior to the issue of SET FEATURES - XFER MODE
-	command.  dev->pio_mode is guaranteed to be valid when
-	->set_piomode() is called, and dev->dma_mode is guaranteed to be
-	valid when ->set_dmamode() is called.  ->post_set_mode() is
+	command.  The optional ->mode_filter() hook is called when libata
+	has built a mask of the possible modes. This is passed to the 
+	->mode_filter() function which should return a mask of valid modes
+	after filtering those unsuitable due to hardware limits. It is not
+	valid to use this interface to add modes.
+	</para>
+	<para>
+	dev->pio_mode and dev->dma_mode are guaranteed to be valid when
+	->set_piomode() and when ->set_dmamode() is called. The timings for
+	any other drive sharing the cable will also be valid at this point.
+	That is the library records the decisions for the modes of each
+	drive on a channel before it attempts to set any of them.
+	</para>
+	<para>
+	->post_set_mode() is
 	called unconditionally, after the SET FEATURES - XFER MODE
 	command completes successfully.
 	</para>
@@ -230,6 +243,32 @@ void (*dev_select)(struct ata_port *ap, 
 
 	</sect2>
 
+	<sect2><title>Private tuning method</title>
+	<programlisting>
+void (*set_mode) (struct ata_port *ap);
+	</programlisting>
+
+	<para>
+	By default libata performs drive and controller tuning in
+	accordance with the ATA timing rules and also applies blacklists
+	and cable limits. Some controllers need special handling and have
+	custom tuning rules, typically raid controllers that use ATA
+	commands but do not actually do drive timing.
+	</para>
+
+	<warning>
+	<para>
+	This hook should not be used to replace the standard controller
+	tuning logic when a controller has quirks. Replacing the default
+	tuning logic in that case would bypass handling for drive and
+	bridge quirks that may be important to data reliability. If a
+	controller needs to filter the mode selection it should use the
+	mode_filter hook instead.
+	</para>
+	</warning>
+
+	</sect2>
+
 	<sect2><title>Reset ATA bus</title>
 	<programlisting>
 void (*phy_reset) (struct ata_port *ap);

