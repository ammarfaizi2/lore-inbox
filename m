Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267969AbTAMX2M>; Mon, 13 Jan 2003 18:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268393AbTAMX2M>; Mon, 13 Jan 2003 18:28:12 -0500
Received: from web12902.mail.yahoo.com ([216.136.174.69]:24898 "HELO
	web12902.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267969AbTAMX2J>; Mon, 13 Jan 2003 18:28:09 -0500
Message-ID: <20030113233701.58147.qmail@web12902.mail.yahoo.com>
Date: Mon, 13 Jan 2003 15:37:01 -0800 (PST)
From: r k <oceanofjoy@yahoo.com>
Subject: 48 bit lba questions
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Cc: andre@linux-ide.org, andre@aslab.com, andre@suse.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi all !
  I was wondering if anyone can give me some insight on the IDE driver
regarding 48 bit LBA addressing. I would like to know:

  1. What is different in 48 bit lba implementation as opposed to 28
bit LBA ? What extra steps are needed in order to perform 48 bit lba
for DMA and PIO modes ? This is what I know so far:
    - the READ/WRITE commands have to be replaced with their _EXT
counterparts for 48 bit lba; also the sector # and the lba low/mid/high
registers have to be written twice with the appropriate values
    - I noticed that there are extra steps required for 48 bit lba dma
transfers but I don't fully understand them

  2. Why do we need to perform extra steps with the promise chips when
using 48 bit lba ?

  3. Where can I get a spec for the promise chips ?

  4. Given the following code from ide_dmaproc(...) function from
ide-dma.c I would appreciate any explanation (or pointers to sources
that explain it).

----------
  unsigned long high_16 = pci_resource_start(hwif->pci_dev, 4);
  byte clock		  =inb(high_16+0x11);
  unsigned long atapi_port	=high_16+ 0x20 + (hwif->channel ? 0x04 :
0x00);
----------

  - what is 'high_16' ? is it the base address for the promise chip ?
  - what is the '0x11' offset from 'high_16' ? is that the offset to
    the udma ctl register ? Why do we need to read this register and
    how is this register used ?
  - what is the 'atapi_port' used for ?  
  - I would very much appreciate any explanation on the following code:

-----------
case ide_dma_begin:
	/* Note that this is done *after* the cmd has
	 * been issued to the drive, as per the BM-IDE spec. */
	/* Enable ATAPI UDMA port for 48bit data on PDC20267 */
	if (lba48 && hwif->pci_devid.vid==PCI_VENDOR_ID_PROMISE &&
	   (hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20267 || 
	    hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20265 ||
	    hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20262))
	{
		outb(clock|(hwif->channel ? 0x08:0x02), high_16 + 0x11);
		word_count=(rq->nr_sectors << 8);
		word_count=reading ? word_count | 0x05000000 : word_count |
0x06000000;
		outl(word_count, atapi_port);
	}  
	outb(inb(dma_base)|1, dma_base);	/* start DMA */

	return 0;

case ide_dma_end: /* returns 1 on error, 0 otherwise */
	drive->waiting_for_dma = 0;
	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
	/* Disable ATAPI UDMA port for 48bit data on PDC20267 */
	if (lba48 && hwif->pci_devid.vid==PCI_VENDOR_ID_PROMISE &&
	    (hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20267 || 
	     hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20265 ||
	     hwif->pci_devid.did == PCI_DEVICE_ID_PROMISE_20262))
	{
	    	outl(0, atapi_port);
		clock=inb(high_16+0x11);
		outb(clock & ~(hwif->channel ? 0x08:0x02), high_16+0x11);
	}
	dma_stat = inb(dma_base+2);		/* get DMA status */
	outb(dma_stat|6, dma_base+2);	/* clear the INTR & ERROR bits */
	ide_destroy_dmatable(drive);	/* purge DMA mappings */
	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA
status */
--------------

  Thanks in advance, 

    remus

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
