Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966389AbWK2Iz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966389AbWK2Iz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966403AbWK2Iz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:55:59 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:22052 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S966387AbWK2Iz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:55:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=YUCL+X5L4IFNSX2dt59GbTRH+JFOiWcCuQ88/sgdwbVRbN0vizNiatLXAYepk5e84yOCNvmmO9wOccSVuG5iGX+eFMenVRhyygJubl0M+hzfvlM5YIff0h04j59Ye9x1ciijrHarbOtPDRTkW+N0+M6PFFWf+IfYAF8pAEEPrSM=
Message-ID: <456D4B17.4080503@gmail.com>
Date: Wed, 29 Nov 2006 17:55:51 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: "Berck E. Nash" <flyboy@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
References: <4557B7D2.2050004@gmail.com> <455B0BD7.20108@gmail.com> <455B5ADF.2040503@gmail.com> <20061127033550.GB11250@htj.dyndns.org> <456AA89C.909@gmail.com>
In-Reply-To: <456AA89C.909@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------080406080106090206090004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080406080106090206090004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Berck E. Nash wrote:
> Tejun Heo wrote:
> 
>> Yeah, I did and forgot about this thread too.  Sorry.  This is on the
>> top of my to-do list now.  I'm attaching the patch.  TIA.
> 
> That didn't fix the problem, but did change the messages.  I've attached 
> the entire log, including the weird errors on power-off from the same 
> device that gives problems on boot, which I suspect are related.

Hmm... this is difficult.  The problem is that everything looks normal 
until command is issued.  My primary suspect still is ahci powering down 
phy during initialization.  Can you please test the attached patch again?

[--snip--]
> Mounting root filesystem read-only...done.
> Will now halt.
> [ 9371.896444] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [ 9371.903036] ata2.00: (irq_stat 0x40000001)
> [ 9371.907228] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
> [ 9371.907229]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
> [ 9371.931688] ata2.00: configured for UDMA/133
> [ 9371.936073] ata2: EH complete

Weird, the drive is failing STANDBY IMMEDIATE.

[--snip--]
> [ 9372.152310] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [ 9372.158882] ata2.00: (irq_stat 0x40000001)
> [ 9372.163079] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
> [ 9372.163080]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
> [ 9372.187505] ata2.00: configured for UDMA/133

Then, a series of obsolete STANDBY failures.  Who's issuing these 
commands?  It's not libata, libata uses STANDBY (0xe2).  Is it some kind 
of gentoo thing?  Anyways, doesn't really matter although it's 
surprising that the drive fails STANDBY IMMEDIATE.

Thanks.

-- 
tejun

--------------080406080106090206090004
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8f75c60..6100cbc 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -612,9 +612,6 @@ static void ahci_power_down(void __iomem
 static void ahci_init_port(void __iomem *port_mmio, u32 cap,
 			   dma_addr_t cmd_slot_dma, dma_addr_t rx_fis_dma)
 {
-	/* power up */
-	ahci_power_up(port_mmio, cap);
-
 	/* enable FIS reception */
 	ahci_start_fis_rx(port_mmio, cap, cmd_slot_dma, rx_fis_dma);
 
@@ -640,9 +637,6 @@ static int ahci_deinit_port(void __iomem
 		return rc;
 	}
 
-	/* put device into slumber mode */
-	ahci_power_down(port_mmio, cap);
-
 	return 0;
 }
 
@@ -1321,7 +1315,9 @@ static int ahci_port_suspend(struct ata_
 	int rc;
 
 	rc = ahci_deinit_port(port_mmio, hpriv->cap, &emsg);
-	if (rc) {
+	if (rc == 0)
+		ahci_power_down(port_mmio, hpriv->cap);
+	else {
 		ata_port_printk(ap, KERN_ERR, "%s (%d)\n", emsg, rc);
 		ahci_init_port(port_mmio, hpriv->cap,
 			       pp->cmd_slot_dma, pp->rx_fis_dma);
@@ -1337,6 +1333,7 @@ static int ahci_port_resume(struct ata_p
 	void __iomem *mmio = ap->host->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 
+	ahci_power_up(port_mmio, hpriv->cap);
 	ahci_init_port(port_mmio, hpriv->cap, pp->cmd_slot_dma, pp->rx_fis_dma);
 
 	return 0;
@@ -1443,6 +1440,9 @@ static int ahci_port_start(struct ata_po
 
 	ap->private_data = pp;
 
+	/* power up port */
+	ahci_power_up(port_mmio, hpriv->cap);
+
 	/* initialize port */
 	ahci_init_port(port_mmio, hpriv->cap, pp->cmd_slot_dma, pp->rx_fis_dma);
 

--------------080406080106090206090004--
