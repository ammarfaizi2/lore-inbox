Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWERXIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWERXIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWERXIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:08:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28343 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751143AbWERXIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:08:20 -0400
Date: Thu, 18 May 2006 16:07:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [RFT] major libata update
Message-Id: <20060518160758.5911e4b7.akpm@osdl.org>
In-Reply-To: <446AC418.4070704@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org>
	<20060516190507.35c1260f.akpm@osdl.org>
	<446AAB3C.6050303@gmail.com>
	<20060516215610.2b822c00.akpm@osdl.org>
	<446AB12C.10001@gmail.com>
	<446AC418.4070704@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:
>
> Tejun Heo wrote:
>  > Andrew Morton wrote:
>  >> No.  In fact, it doesn't even work with the 2.6.17-rc4-mm1 lineup plus 
>  >> the
>  >> latest git-libata-all.  It needs this tweak:
>  >>
>  >> --- devel/drivers/scsi/ata_piix.c~2.6.17-rc4-mm1-ich8-fix    
>  >> 2006-05-16 18:36:12.000000000 -0700
>  >> +++ devel-akpm/drivers/scsi/ata_piix.c    2006-05-16 
>  >> 18:36:12.000000000 -0700
>  >> @@ -542,6 +542,14 @@ static unsigned int piix_sata_probe (str
>  >>          port = map[base + i];
>  >>          if (port < 0)
>  >>              continue;
>  >> +        if (ap->flags & PIIX_FLAG_AHCI) {
>  >> +            /* FIXME: Port status of AHCI controllers
>  >> +             * should be accessed in AHCI memory space.  */
>  >> +            if (pcs & 1 << port)
>  >> +                present_mask |= 1 << i;
>  >> +            else
>  >> +                pcs &= ~(1 << port);
>  >> +        }
>  >>          if (ap->flags & PIIX_FLAG_IGNORE_PCS || pcs & 1 << (4 + port))
>  >>              present_mask |= 1 << i;
>  >>          else
> 
>  The above patch doesn't do anything.

Yes it does.  I dropped it and got

SCSI subsystem initialized
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI (acpi_bus-0191): Device is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
ata1: SATA max UDMA/133 cmd 0x2148 ctl 0x217E bmdma 0x2110 irq 19
ata2: SATA max UDMA/133 cmd 0x2140 ctl 0x217A bmdma 0x2118 irq 19
ata1: SATA port has no device.

Then I undropped it and got

SCSI subsystem initialized
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI (acpi_bus-0191): Device is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
ata1: SATA max UDMA/133 cmd 0x2148 ctl 0x217E bmdma 0x2110 irq 19
ata2: SATA max UDMA/133 cmd 0x2140 ctl 0x217A bmdma 0x2118 irq 19
ata1.00: ATA-7, max UDMA/133, 321672960 sectors: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
scsi0 : ata_piix

and a computer which boots.

Look closer, please ;)
