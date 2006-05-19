Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWESBOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWESBOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWESBOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:14:10 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:40056 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932167AbWESBOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:14:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=JrUGuBxDjwL3JfkmJcilIz6Nx8w477VoBE4vNQeUb45J+dtOaOu1ljpxoJUlXyosPF0oH6s3XZ0q/2rvr6tzP52UUayjTSNG8IJUFWstVRUTw8hH3iPLsqMChvVvMyD0rg8UVXQ6GsxSgNDgenqdNbhAByX+H8G/HPD5bXkneXU=
Date: Fri, 19 May 2006 10:14:00 +0900
From: Tejun Heo <htejun@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [RFT] major libata update
Message-ID: <20060519011400.GA10058@htj.dyndns.org>
References: <20060515170006.GA29555@havoc.gtf.org> <20060516190507.35c1260f.akpm@osdl.org> <446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org> <446AB12C.10001@gmail.com> <446AC418.4070704@gmail.com> <20060518160758.5911e4b7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518160758.5911e4b7.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 04:07:58PM -0700, Andrew Morton wrote:
> 
> Yes it does.  I dropped it and got
> 
> SCSI subsystem initialized
> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> ACPI (acpi_bus-0191): Device is not power manageable [20060310]
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
> ata1: SATA max UDMA/133 cmd 0x2148 ctl 0x217E bmdma 0x2110 irq 19
> ata2: SATA max UDMA/133 cmd 0x2140 ctl 0x217A bmdma 0x2118 irq 19
> ata1: SATA port has no device.
> 
> Then I undropped it and got
> 
> SCSI subsystem initialized
> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> ACPI (acpi_bus-0191): Device is not power manageable [20060310]
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
> ata1: SATA max UDMA/133 cmd 0x2148 ctl 0x217E bmdma 0x2110 irq 19
> ata2: SATA max UDMA/133 cmd 0x2140 ctl 0x217A bmdma 0x2118 irq 19
> ata1.00: ATA-7, max UDMA/133, 321672960 sectors: LBA48 NCQ (depth 0/32)
> ata1.00: configured for UDMA/133
> scsi0 : ata_piix
> 
> and a computer which boots.
> 
> Look closer, please ;)

Hello, Andrew.

I see.  It seems that you're reporting two separate problems - your
PCS register doesn't report presence properly && the TF registers
report ghost device if the first device is ATAPI.  I can reproduce the
second here, but AFAIK the only controller which had problem with PCS
persence bits was ESB6300 until now.

Can you post the result of 'lspci -n' and ata_piix boot probing
messages with the following patch applied?  It would be helpful if you
tell us how devices are actually connected.  Also, where did the patch
come from?  With what comment?

Thanks.

diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index e3184a7..4ba943e 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -523,7 +523,7 @@ static unsigned int piix_sata_probe (str
 	u8 pcs;
 
 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
-	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
+	printk("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
 
 	/* enable all ports on this ap and wait for them to settle */
 	for (i = 0; i < 2; i++) {
@@ -552,7 +552,7 @@ static unsigned int piix_sata_probe (str
 	if (!(ap->flags & PIIX_FLAG_AHCI))
 		pci_write_config_byte(pdev, ICH5_PCS, pcs);
 
-	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
+	printk("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
 		ap->id, pcs, present_mask);
 
 	return present_mask;
