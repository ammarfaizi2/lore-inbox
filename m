Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268590AbUH3RRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268590AbUH3RRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUH3RRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:17:38 -0400
Received: from wasp.net.au ([203.190.192.17]:11465 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268578AbUH3RRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:17:20 -0400
Message-ID: <41336141.7010407@wasp.net.au>
Date: Mon, 30 Aug 2004 21:17:53 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_wasp.net.au-23117-1093886238-0001-2"
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata ATA vs SATA detection and workaround.
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com> <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com> <41321F7F.7050300@pobox.com> <41333CDC.5040106@wasp.net.au> <41334058.4050902@wasp.net.au> <413350A2.1000003@pobox.com> <41335723.40907@wasp.net.au> <413357AE.3000009@pobox.com>
In-Reply-To: <413357AE.3000009@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_wasp.net.au-23117-1093886238-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

> For now I think moving your code to ata_dev_config() function is 
> sufficient, with one modification:
> 
> Move the
>     ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device)))
> test into a separate function all its own, "ata_knobble_device" or 
> somesuch.  static inline if you wish.
> 
> Then it will be trivial to add a 'knobble' module parm later on, by 
> simply modifying ata_knobble_device() to also check the module parameter 
> in addition to the existing tests.

Pretty new at kernel code. (And C for that matter)
I did note that it appears it's not going to do the right thing if we have more than one device per 
host, but I guess thats not going to be an issue for SATA for the near future anyway.

How's this grab you?

Regards,
Brad

--=_wasp.net.au-23117-1093886238-0001-2
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


--=_wasp.net.au-23117-1093886238-0001-2--
