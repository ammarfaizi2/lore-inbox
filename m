Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWJLGOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWJLGOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161535AbWJLGOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:14:10 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:15559 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S932492AbWJLGOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:14:08 -0400
Date: Thu, 12 Oct 2006 15:13:48 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Generic platform device IDE driver
Message-ID: <20061012061348.GA7844@linux-sh.org>
References: <20061004074535.GA7180@localhost.hsdv.com> <1159972725.25772.26.camel@localhost.localdomain> <20061005091631.GA8631@localhost.hsdv.com> <200610111450.41909.matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610111450.41909.matthias.fuchs@esd-electronics.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Wed, Oct 11, 2006 at 02:50:41PM +0200, Matthias Fuchs wrote:
> I tried you patch on our CPCI405 PowerPC board 
> (arch/ppc/platforms/4xx/cpci405.c). 
> It seems to work fine together with our onboard CompactFlash slot.
> 
> Because our IDE registers are memory mapped, I had to patch the 
> resource .start and .end address by subtracting _IO_BASE, 
> so that the pata code can use the IO way to talk to the 
> IDE registers.
> 
> Perhaps it is a good idea to update the pata platform driver to be able to 
> handle both _IO and _MEM resources. The _IO resources be be handled 
> as it is already done by your code and for _MEM resources the pata platform
> driver can do the ioremapping as I currently do in my board setup.
> 
Yes, that's one thing I was thinking of as well.. Here's a patch that
makes an attempt at that, can you give it a try and see if it works for
you? This applies on top of the earlier patch. None of the ARM, SH, or
H8300 cases need to do the remapping at least.

Hopefully this will clean up your setup mess a bit.. If this works for
you, I'll tidy it up a bit and submit the entire patch again.

 drivers/ata/pata_platform.c |  103 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 13 deletions(-)

--

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 5d98332..a716e63 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -21,7 +21,7 @@ #include <linux/libata.h>
 #include <linux/platform_device.h>
 
 #define DRV_NAME "pata_platform"
-#define DRV_VERSION "0.1.0"
+#define DRV_VERSION "0.1.1"
 
 static int pio_mask = 1;
 
@@ -45,6 +45,23 @@ static void pata_platform_set_mode(struc
 	}
 }
 
+static void pata_platform_host_stop(struct ata_host *host)
+{
+	int i;
+
+	/*
+	 * Unmap the bases for MMIO
+	 */
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (ap->flags & ATA_FLAG_MMIO) {
+			iounmap((void __iomem *)ap->ioaddr.ctl_addr);
+			iounmap((void __iomem *)ap->ioaddr.cmd_addr);
+		}
+	}
+}
+
 static struct scsi_host_template pata_platform_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -88,7 +105,7 @@ static struct ata_port_operations pata_p
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop
+	.host_stop		= pata_platform_host_stop
 };
 
 /**
@@ -100,14 +117,20 @@ static struct ata_port_operations pata_p
  *
  *	Platform devices are expected to contain 3 resources per port:
  *
- *		- I/O Base (IORESOURCE_IO)
- *		- CTL Base (IORESOURCE_IO)
+ *		- I/O Base (IORESOURCE_IO or IORESOURCE_MEM)
+ *		- CTL Base (IORESOURCE_IO or IORESOURCE_MEM)
  *		- IRQ	   (IORESOURCE_IRQ)
+ *
+ * 	If the base resources are both mem types, the ioremap() is handled
+ * 	here. For IORESOURCE_IO, it's assumed that there's no remapping
+ * 	necessary.
  */
 static int __devinit pata_platform_probe(struct platform_device *pdev)
 {
 	struct resource *io_res, *ctl_res;
 	struct ata_probe_ent ae;
+	unsigned int mmio;
+	int ret;
 
 	/*
 	 * Simple resource validation ..
@@ -117,13 +140,31 @@ static int __devinit pata_platform_probe
 		return -EINVAL;
 	}
 
+	/*
+	 * Get the I/O base first
+	 */
 	io_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (unlikely(io_res == NULL))
-		return -EINVAL;
+	if (io_res == NULL) {
+		io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (unlikely(io_res == NULL))
+			return -EINVAL;
+	}
 
+	/*
+	 * Then the CTL base
+	 */
 	ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 1);
-	if (unlikely(ctl_res == NULL))
-		return -EINVAL;
+	if (ctl_res == NULL) {
+		ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (unlikely(ctl_res == NULL))
+			return -EINVAL;
+	}
+
+	/*
+	 * Check for MMIO
+	 */
+	mmio = (( io_res->flags == IORESOURCE_MEM) &&
+		(ctl_res->flags == IORESOURCE_MEM));
 
 	/*
 	 * Now that that's out of the way, wire up the port..
@@ -138,15 +179,51 @@ static int __devinit pata_platform_probe
 	ae.irq = platform_get_irq(pdev, 0);
 	ae.irq_flags = 0;
 	ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
-	ae.port[0].cmd_addr = io_res->start;
-	ae.port[0].altstatus_addr = ctl_res->start;
-	ae.port[0].ctl_addr = ctl_res->start;
+
+	/*
+	 * Handle the MMIO case
+	 */
+	if (mmio) {
+		ae.port_flags |= ATA_FLAG_MMIO;
+
+		ae.port[0].cmd_addr = (unsigned long)ioremap(io_res->start,
+				io_res->end - io_res->start + 1);
+		if (unlikely(!ae.port[0].cmd_addr)) {
+			dev_err(&pdev->dev, "failed to remap IO base\n");
+			return -ENXIO;
+		}
+
+		ae.port[0].ctl_addr = (unsigned long)ioremap(ctl_res->start,
+				ctl_res->end - ctl_res->start + 1);
+		if (unlikely(!ae.port[0].ctl_addr)) {
+			dev_err(&pdev->dev, "failed to remap CTL base\n");
+			ret = -ENXIO;
+			goto bad_remap;
+		}
+	} else {
+		ae.port[0].cmd_addr = io_res->start;
+		ae.port[0].ctl_addr = ctl_res->start;
+	}
+
+	ae.port[0].altstatus_addr = ae.port[0].ctl_addr;
+
 	ata_std_ports(&ae.port[0]);
 
-	if (unlikely(ata_device_add(&ae) == 0))
-		return -ENODEV;
+	if (unlikely(ata_device_add(&ae) == 0)) {
+		ret = -ENODEV;
+		goto add_failed;
+	}
 
 	return 0;
+
+add_failed:
+	if (ae.port[0].ctl_addr && mmio)
+		iounmap((void __iomem *)ae.port[0].ctl_addr);
+bad_remap:
+	if (ae.port[0].cmd_addr && mmio)
+		iounmap((void __iomem *)ae.port[0].cmd_addr);
+
+	return ret;
 }
 
 /**
