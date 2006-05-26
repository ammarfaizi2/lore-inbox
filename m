Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWEZTot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWEZTot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWEZTot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:44:49 -0400
Received: from rtr.ca ([64.26.128.89]:55957 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750809AbWEZTos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:44:48 -0400
From: Mark Lord <liml@rtr.ca>
Organization: Real-Time Remedies Inc.
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM) fails: libata issue
Date: Fri, 26 May 2006 15:44:46 -0400
User-Agent: KMail/1.9.1
Cc: linux-ide-owner@vger.kernel.org, Tejun Heo <htejun@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>
References: <44775614.5000401@rtr.ca>
In-Reply-To: <44775614.5000401@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261544.46992.liml@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> My ata_piix based Notebook (Dell i9300) suspends/resumes perfectly (RAM 
> or disk)
> with 2.6.16.xx kernels, but fails resume on 2.6.17-rc5-git1 (the first 
> 2.6.17-*
> I've attempted on this machine).
> 
> On resume from RAM, after a 30-second-ish timeout, the screen comes on
> but the hard disk is NOT accessible.  "dmesg" in an already-open window
> shows this (typed in from handwritten notes):
> 
> sd 0:0:0:0: SCSI error: return code = 0x40000
> end_request: I/O error, /dev/sda, sector nnnnnnn
...

Ahh.. the fix for this was posted earlier today by Forrest Zhao.
But his patch is for libata-dev, and doesn't apply as-is on 2.6.17-rc*

Here is a modified version of Forrest's original patch, for 2.6.17-rc5-git1.
It seems to have fixed the resume issue on my machine here,
so that things are now working as they were in the unpatched 2.6.16 kernels.

Can we get (something like) this into 2.6.17, pretty please?

Signed-off-by: Mark Lord <lkml@rtr.ca>
---
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -90,6 +90,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
@@ -151,6 +152,7 @@ static int piix_pata_probe_reset(struct 
 static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
+static int piix_scsi_device_resume(struct scsi_device *sdev);
 
 static unsigned int in_module_init = 1;
 
@@ -220,7 +222,7 @@ static struct scsi_host_template piix_sh
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.resume			= ata_scsi_device_resume,
+	.resume			= piix_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
 };
 
@@ -710,6 +712,21 @@ static void piix_set_dmamode (struct ata
 	}
 }
 
+int piix_scsi_device_resume(struct scsi_device *sdev)
+{
+	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev = &ap->device[sdev->id];
+	u8 status;
+
+	status = ata_busy_wait(ap, ATA_BUSY, 200000);
+	if (status & ATA_BUSY) {
+		printk(KERN_ERR "libata port failed to resume "
+				"in 2 secs)\n");
+		return 1;
+	}
+	return ata_device_resume(ap, dev);
+}
+
 #define AHCI_PCI_BAR 5
 #define AHCI_GLOBAL_CTL 0x04
 #define AHCI_ENABLE (1 << 31)
