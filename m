Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752145AbWIXS6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbWIXS6F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 14:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbWIXS6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 14:58:05 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:10407 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1752145AbWIXS6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 14:58:02 -0400
Date: Sun, 24 Sep 2006 12:59:56 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [BUG 2.6.18] sata_promise unaligned PCI accesses on sparc64
In-reply-to: <fa.nt4PNdEsdpbothPH+luJpNOdcI4@ifi.uio.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4516D5AC.20606@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.nt4PNdEsdpbothPH+luJpNOdcI4@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> The 2.6.18 kernel's sata_promise driver causes alignment
> traps in my Ultra5 sparc64 machine. dmesg shows:
> 
> SCSI subsystem initialized
> libata version 2.00 loaded.
> sata_promise 0000:02:03.0: version 1.04
> Kernel unaligned access at TPC[100a8cbc] pdc_ata_init_one+0x284/0x308 [sata_promise]
> Kernel unaligned access at TPC[100a8cd0] pdc_ata_init_one+0x298/0x308 [sata_promise]
> Kernel unaligned access at TPC[100a8cd4] pdc_ata_init_one+0x29c/0x308 [sata_promise]
> ata1: SATA max UDMA/133 cmd 0x1FF00008200 ctl 0x1FF00008238 bmdma 0x0 irq 18
> ata2: SATA max UDMA/133 cmd 0x1FF00008280 ctl 0x1FF000082B8 bmdma 0x0 irq 18
> scsi0 : sata_promise
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 0/32)
> ata1.00: configured for UDMA/133
> scsi1 : sata_promise
> ata2: SATA link down (SStatus 0 SControl 300)
>   Vendor: ATA       Model: ST3160827AS       Rev: 3.42
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> 
> Using debug printk:s I've traced this to the three PDC_TBG_MODE
> accesses in sata_promise.c:pdc_host_init():
> 
> 	/* reduce TBG clock to 133 Mhz. */
> 	tmp = readl(mmio + PDC_TBG_MODE);
> 	tmp &= ~0x30000; /* clear bit 17, 16*/
> 	tmp |= 0x10000;  /* set bit 17:16 = 0:1 */
> 	writel(tmp, mmio + PDC_TBG_MODE);
> 
> 	readl(mmio + PDC_TBG_MODE);	/* flush */
> 
> The debugging printk:s also showed that mmio points to
> 0x000001ff00008000 and that PDC_TBG_MODE is 65, so mmio+PDC_TBG_MODE
> cannot possibly be 32-bit aligned.
> 
> From reading sata_promise.c it appears that PDC_TBG_MODE also
> intersects both PDC_INT_SEQMASK and PDC_FLASH_CTL, which I find weird.

Hmm.. Unaligned access to MMIO space doesn't seem like it would be a 
great idea on any platform.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

