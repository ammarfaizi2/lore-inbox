Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWAUKlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWAUKlh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 05:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWAUKlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 05:41:37 -0500
Received: from tornado.reub.net ([202.89.145.182]:38567 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932123AbWAUKlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 05:41:35 -0500
Message-ID: <43D20FDE.8070700@reub.net>
Date: Sat, 21 Jan 2006 23:41:34 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060119)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       linux-kernel@vger.kernel.org, greg@kroah.com,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       neilb@cse.unsw.edu.au, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt
 bug]
References: <Pine.LNX.4.44L0.0601152243330.1929-100000@netrider.rowland.org>	<43D1C4E9.7030901@reub.net> <20060120214723.79111715.akpm@osdl.org> <43D1E9A4.8090504@reub.net> <43D1F192.3060406@pobox.com>
In-Reply-To: <43D1F192.3060406@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/01/2006 9:32 p.m., Jeff Garzik wrote:
> 
> On the libata side of things, does this patch produce any useful results?
> 
>     Jeff
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 46c4cdb..4691f8d 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -4794,7 +4794,14 @@ ata_pci_init_native_mode(struct pci_dev 
>  			pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
>  		probe_ent->port[p].bmdma_addr = pci_resource_start(pdev, 4);
>  		ata_std_ports(&probe_ent->port[p]);
> -		p++;

I've patched 2.6.15-mm4 with this, and yes, this patch changed the behaviour:

OK TIMEOUT OK OK TIMEOUT TIMEOUT TIMEOUT TIMEOUT OK TIMEOUT TIMEOUT OK TIMEOUT 
TIMEOUT TIMEOUT

OK was when we got through to completion of single user mode, TIMEOUT - see below.

So no oopsing with that patch applied, which is a definite improvement. 
Previously to this I was seeing the OOPSing most of the time and the TIMEOUTS 
more occasionally.

---

Now, looking at the timeouts, here's the log from a boot:

ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led slum part
ata1: SATA max UDMA/133 cmd 0xF8804D00 ctl 0x0 bmdma 0x0 irq 50
ata2: SATA max UDMA/133 cmd 0xF8804D80 ctl 0x0 bmdma 0x0 irq 50
ata3: SATA max UDMA/133 cmd 0xF8804E00 ctl 0x0 bmdma 0x0 irq 50
ata4: SATA max UDMA/133 cmd 0xF8804E80 ctl 0x0 bmdma 0x0 irq 50
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1 is slow to respond, please be patient
ata1 failed to respond (30 secs)
scsi0 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2 is slow to respond, please be patient
ata2 failed to respond (30 secs)
scsi1 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3 is slow to respond, please be patient
ata3 failed to respond (30 secs)
scsi2 : ahci
ata4: SATA link down (SStatus 0)
scsi3 : ahci

When there is no timeout it looks like this:

ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led slum part
ata1: SATA max UDMA/133 cmd 0xF8804D00 ctl 0x0 bmdma 0x0 irq 193
ata2: SATA max UDMA/133 cmd 0xF8804D80 ctl 0x0 bmdma 0x0 irq 193
ata3: SATA max UDMA/133 cmd 0xF8804E00 ctl 0x0 bmdma 0x0 irq 193
ata4: SATA max UDMA/133 cmd 0xF8804E80 ctl 0x0 bmdma 0x0 irq 193
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 ATA-6, max UDMA/133, 156299375 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : ahci
ata4: SATA link down (SStatus 0)
scsi3 : ahci

Note the different IRQ numbers (50, 193) and how when it breaks, the ATA 
interfaces have a different IRQ to the AHCI controller.

There's a full log up at http://lkml.org/lkml/2006/1/11/492 from when I posted 
on lkml and at http://www.reub.net/files/kernel/ when the box isn't down for 
testing ;-)

This may be a separate but related problem to the oops, I guess.

reuben


