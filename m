Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUHaI0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUHaI0B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267465AbUHaI0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:26:01 -0400
Received: from wasp.net.au ([203.190.192.17]:10469 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S267454AbUHaIZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:25:41 -0400
Message-ID: <41343626.109@wasp.net.au>
Date: Tue, 31 Aug 2004 12:26:14 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_wasp.net.au-22928-1093940736-0001-2"
To: lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata basic detection and errata for PATA->SATA bridges
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_wasp.net.au-22928-1093940736-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ok Jeff, I can take a hint! :p)
Patch against 2.6.9-rc1 Vanilla

This patch works around an issue with WD drives (and possibly others) over SiL PATA->SATA Bridges on 
SATA controllers locking up with transfers > 200 sectors.


Signed-off-by: Brad Campbell <brad@wasp.net.au>

--=_wasp.net.au-22928-1093940736-0001-2
Content-Type: text/plain; name=diff3; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff3"

diff -ur orig/linux-2.6.0/drivers/scsi/libata-core.c linux-2.6.9-rc1/drivers/scsi/libata-core.c
--- orig/linux-2.6.0/drivers/scsi/libata-core.c	2004-08-30 20:48:35.000000000 +0400
+++ linux-2.6.9-rc1/drivers/scsi/libata-core.c	2004-08-30 21:02:42.000000000 +0400
@@ -1128,6 +1128,37 @@
 	DPRINTK("EXIT, err\n");
 }
 
+
+static inline u8 ata_dev_knobble(struct ata_port *ap)
+{
+	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device)));
+}
+
+/**
+ * 	ata_dev_config - Run device specific handlers and check for
+ * 			 SATA->PATA bridges
+ * 	@ap: Bus 
+ * 	@i:  Device
+ *
+ * 	LOCKING:
+ */
+ 
+void ata_dev_config(struct ata_port *ap, unsigned int i)
+{
+	/* limit bridge transfers to udma5, 200 sectors */
+	if (ata_dev_knobble(ap)) {
+		printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
+			ap->id, ap->device->devno);
+		ap->udma_mask &= ATA_UDMA5;
+		ap->host->max_sectors = ATA_MAX_SECTORS;
+		ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
+		ap->device->flags |= ATA_DFLAG_LOCK_SECTORS;
+	}
+
+	if (ap->ops->dev_config)
+		ap->ops->dev_config(ap, &ap->device[i]);
+}
+
 /**
  *	ata_bus_probe - Reset and probe ATA bus
  *	@ap: Bus to probe
@@ -1150,8 +1181,7 @@
 		ata_dev_identify(ap, i);
 		if (ata_dev_present(&ap->device[i])) {
 			found = 1;
-			if (ap->ops->dev_config)
-				ap->ops->dev_config(ap, &ap->device[i]);
+			ata_dev_config(ap,i);
 		}
 	}
 
@@ -1226,7 +1256,7 @@
 		ata_port_disable(ap);
 		return;
 	}
-
+	ap->cbl = ATA_CBL_SATA;
 	ata_bus_reset(ap);
 }
 
@@ -3567,3 +3597,4 @@
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
+EXPORT_SYMBOL_GPL(ata_dev_config);
nly in linux-2.6.9-rc1/include: config
diff -ur orig/linux-2.6.0/include/linux/ata.h linux-2.6.9-rc1/include/linux/ata.h
--- orig/linux-2.6.0/include/linux/ata.h	2004-08-30 20:48:35.000000000 +0400
+++ linux-2.6.9-rc1/include/linux/ata.h	2004-08-30 18:42:41.000000000 +0400
@@ -218,6 +218,7 @@
 };
 
 #define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
+#define ata_id_is_sata(dev)	((dev)->id[93] == 0)
 #define ata_id_rahead_enabled(dev) ((dev)->id[85] & (1 << 6))
 #define ata_id_wcache_enabled(dev) ((dev)->id[85] & (1 << 5))
 #define ata_id_has_flush(dev) ((dev)->id[83] & (1 << 12))
diff -ur orig/linux-2.6.0/include/linux/libata.h linux-2.6.9-rc1/include/linux/libata.h
--- orig/linux-2.6.0/include/linux/libata.h	2004-08-30 20:48:35.000000000 +0400
+++ linux-2.6.9-rc1/include/linux/libata.h	2004-08-30 20:42:05.000000000 +0400
@@ -400,6 +400,7 @@
 		 unsigned int n_elem);
 extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
+extern void ata_dev_config(struct ata_port *ap, unsigned int i);
 extern void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_setup_pio (struct ata_queued_cmd *qc);


--=_wasp.net.au-22928-1093940736-0001-2--
