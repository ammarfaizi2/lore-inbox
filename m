Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUH3Oph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUH3Oph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268458AbUH3Onw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:43:52 -0400
Received: from wasp.net.au ([203.190.192.17]:48835 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268340AbUH3OmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:42:03 -0400
Message-ID: <41333CDC.5040106@wasp.net.au>
Date: Mon, 30 Aug 2004 18:42:36 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_wasp.net.au-17753-1093876919-0001-2"
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] libata ATA vs SATA detection and workaround.
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com> <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com> <41321F7F.7050300@pobox.com>
In-Reply-To: <41321F7F.7050300@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_wasp.net.au-17753-1093876919-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Jeff Garzik wrote:
> 
>> me either, unless I can figure out a way to detect that a disk is PATA 
>> not SATA.  Nothing is obvious from the specs on www.t13.org, but who 
>> knows.
> 
> 
> According to the Serial ATA docs, IDENTIFY DEVICE word 93 will be zero 
> if it's Serial ATA.  Who knows if that's true, given the wierd wild 
> world of ATA devices.
> 

I'm assuming here that if the driver uses sata_phy_reset in libata-core then it's actually a SATA 
controller.

Patch attached, tested and verified.
SATA drives (of which I only have one brand) report IDENTIFY DEVICE word 93 as zero, ATA devices 
behind the bridge (Of which I only have one brand) report at a minimum bit 13 to report an 80 
conductor cable.

Like I said before, my assumptions are

A) IDENTIFY DEVICE and the associated Word 93 register have been *Mandatory* at least since ATA-5

B) ATA-5 maxed out at < udma/100 and did not contain lba48

C) The SATA->PATA bridge looks like an 80 conductor cable and thus on any drive that supports lba48 
will always present a non-zero value in IDENTIFY DEVICE Word 93.

It works here anyway.
Patch against vanilla 2.6.9-rc1 attached (including your ata.h patch)

Thanks again for all the help. I'll see if I can get some other older ATA drives to test with (I 
might have to gut all the machines in the office for the weekend)

Regards,
Brad

--=_wasp.net.au-17753-1093876919-0001-2
Content-Type: text/plain; name=diff; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff -ur orig/linux-2.6.0/drivers/scsi/libata-core.c linux-2.6.9-rc1/drivers/scsi/libata-core.c
--- orig/linux-2.6.0/drivers/scsi/libata-core.c	2004-08-30 18:31:31.000000000 +0400
+++ linux-2.6.9-rc1/drivers/scsi/libata-core.c	2004-08-30 18:22:05.000000000 +0400
@@ -1152,6 +1152,16 @@
 			found = 1;
 			if (ap->ops->dev_config)
 				ap->ops->dev_config(ap, &ap->device[i]);
+			/* limit bridge transfers to udma5, 200 sectors */
+			printk("Value is %u\n",ap->cbl==ATA_CBL_SATA);
+			if ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device))) {
+				printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
+					ap->id, ap->device->devno);
+				ap->udma_mask &= ATA_UDMA5;
+				ap->host->max_sectors = ATA_MAX_SECTORS;
+				ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
+				ap->device->flags |= ATA_DFLAG_LOCK_SECTORS;
+			}
 		}
 	}
 
@@ -1226,7 +1236,7 @@
 		ata_port_disable(ap);
 		return;
 	}
-
+	ap->cbl = ATA_CBL_SATA;
 	ata_bus_reset(ap);
 }
 
diff -ur orig/linux-2.6.0/include/linux/ata.h linux-2.6.9-rc1/include/linux/ata.h
--- orig/linux-2.6.0/include/linux/ata.h	2004-08-30 18:31:32.000000000 +0400
+++ linux-2.6.9-rc1/include/linux/ata.h	2004-08-30 17:56:53.000000000 +0400
@@ -218,6 +218,7 @@
 };
 
 #define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
+#define ata_id_is_sata(dev)	((dev)->id[93] == 0)
 #define ata_id_rahead_enabled(dev) ((dev)->id[85] & (1 << 6))
 #define ata_id_wcache_enabled(dev) ((dev)->id[85] & (1 << 5))
 #define ata_id_has_flush(dev) ((dev)->id[83] & (1 << 12))

--=_wasp.net.au-17753-1093876919-0001-2--
