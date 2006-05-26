Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWEZVkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWEZVkE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWEZVkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:40:04 -0400
Received: from rtr.ca ([64.26.128.89]:12703 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751625AbWEZVkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:40:01 -0400
Message-ID: <447775B0.3000006@rtr.ca>
Date: Fri, 26 May 2006 17:40:00 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Brannon Klopfer <bklopfer@stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't resume with recent kernel
References: <4477737C.6020708@stanford.edu>
In-Reply-To: <4477737C.6020708@stanford.edu>
Content-Type: multipart/mixed;
 boundary="------------080409040106030303080807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080409040106030303080807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Brannon Klopfer wrote:
> Hello,
> 
> I have an IBM ThinkPad 600E. It runs perfectly with 2.6.15.1: namely, I 
> can suspend (apm -s) and resume without trouble.
> 
> I just upgraded to 2.6.16.18. Suspending works fine, but resuming just 
> locks it up completely: terminal cursor doesn't blink, caps lock won't 
> respond, can't VT switch, etc. As far as I know, my .config was the same 
> for each.

Which disk driver does the machine use?

If it uses libata::ata_piix, then apply the attached patch and try again.

Cheers

--------------080409040106030303080807
Content-Type: text/x-patch;
 name="01_ata_piix_resume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01_ata_piix_resume.patch"

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

--------------080409040106030303080807--
