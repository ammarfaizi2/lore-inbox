Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268486AbUH3O5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbUH3O5j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268482AbUH3O5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:57:38 -0400
Received: from wasp.net.au ([203.190.192.17]:13252 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268476AbUH3O46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:56:58 -0400
Message-ID: <41334058.4050902@wasp.net.au>
Date: Mon, 30 Aug 2004 18:57:28 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_wasp.net.au-21256-1093877811-0001-2"
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata ATA vs SATA detection and workaround.
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com> <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com> <41321F7F.7050300@pobox.com> <41333CDC.5040106@wasp.net.au>
In-Reply-To: <41333CDC.5040106@wasp.net.au>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_wasp.net.au-21256-1093877811-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Brad Campbell wrote:
> 
> It works here anyway.
> Patch against vanilla 2.6.9-rc1 attached (including your ata.h patch)
> 

Lets try this one that won't undo the work that the sata_sil Seagate/Maxtor blacklist does!

Regards,
Brad.

--=_wasp.net.au-21256-1093877811-0001-2
Content-Type: text/plain; name=diff2; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff2"

diff -ur orig/linux/drivers/scsi/libata-core.c linux-2.6.9-rc1/drivers/scsi/libata-core.c
--- orig/linux/drivers/scsi/libata-core.c	2004-08-30 18:52:54.000000000 +0400
+++ linux-2.6.9-rc1/drivers/scsi/libata-core.c	2004-08-30 18:53:42.000000000 +0400
@@ -1150,6 +1150,15 @@
 		ata_dev_identify(ap, i);
 		if (ata_dev_present(&ap->device[i])) {
 			found = 1;
+			/* limit bridge transfers to udma5, 200 sectors */
+			if ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device))) {
+				printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
+					ap->id, ap->device->devno);
+				ap->udma_mask &= ATA_UDMA5;
+				ap->host->max_sectors = ATA_MAX_SECTORS;
+				ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
+				ap->device->flags |= ATA_DFLAG_LOCK_SECTORS;
+			}
 			if (ap->ops->dev_config)
 				ap->ops->dev_config(ap, &ap->device[i]);
 		}
@@ -1226,7 +1235,7 @@
 		ata_port_disable(ap);
 		return;
 	}
-
+	ap->cbl = ATA_CBL_SATA;
 	ata_bus_reset(ap);
 }
 
diff -ur orig/linux/include/linux/ata.h linux-2.6.9-rc1/include/linux/ata.h
--- orig/linux/include/linux/ata.h	2004-08-30 18:52:54.000000000 +0400
+++ linux-2.6.9-rc1/include/linux/ata.h	2004-08-30 18:42:41.000000000 +0400
@@ -218,6 +218,7 @@
 };
 
 #define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
+#define ata_id_is_sata(dev)	((dev)->id[93] == 0)
 #define ata_id_rahead_enabled(dev) ((dev)->id[85] & (1 << 6))
 #define ata_id_wcache_enabled(dev) ((dev)->id[85] & (1 << 5))
 #define ata_id_has_flush(dev) ((dev)->id[83] & (1 << 12))

--=_wasp.net.au-21256-1093877811-0001-2--
