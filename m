Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287879AbSAMFsF>; Sun, 13 Jan 2002 00:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287881AbSAMFry>; Sun, 13 Jan 2002 00:47:54 -0500
Received: from mercury.Sun.COM ([192.9.25.1]:43727 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S287879AbSAMFrt>;
	Sun, 13 Jan 2002 00:47:49 -0500
Date: Sat, 12 Jan 2002 21:47:05 -0800
From: Duncan Laurie <void@sun.com>
To: linux-kernel@vger.kernel.org
Cc: Oliver Feiler <kiza@gmxpro.net>, Andre Hedrick <andre@linuxdiskcert.org>
Subject: Re: HPT370 controller set wrong udma mode
Message-ID: <20020113054705.GA2160@sun.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Oliver Feiler <kiza@gmxpro.net>,
	Andre Hedrick <andre@linuxdiskcert.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: Sun Cobalt Server Appliances
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10 2002, Oliver Feiler wrote:
>
> Alan Cox wrote:
> > Make sure you use the Andre Hedrick ide patches with the HPT 370. That fixed
> > all my problems with them at least
> > 	(http://www.linux-ide.org)
> 
> Didn't solve my problem unfortunately.
> 
> With the patch applied, the kernel still says it uses UDMA(66) on boot 
> and hdparm also says the drive is in udma4 mode. Writing data to it results in 
> BadCRC.
> 
> However, /proc/ide/hpt366 with the patch applied shows ATA-33 mode. 
> Something's wrong here.
> 
> CC'ing this to Andre Hedrick. Maybe he knows what's wrong?
>

Try this patch... apply it after the latest patch from Andre becuase that 
includes several other crucial highpoint fixes.  It looks like the cable
detect pins are also used as address lines and so must be configured as
inputs to read valid cable detect state.

-duncan


--- linux/drivers/ide/hpt366.c~	Thu Jan 10 17:08:01 2002
+++ linux/drivers/ide/hpt366.c	Thu Jan 10 17:10:17 2002
@@ -1140,7 +1140,21 @@
 	byte ata66	= 0;
 	byte regmask	= (hwif->channel) ? 0x01 : 0x02;
 
-	pci_read_config_byte(hwif->pci_dev, 0x5a, &ata66);
+	if (pci_rev_check_hpt3xx(hwif->pci_dev)) {
+		byte scr2;
+		/*
+		 * The HPT370 uses the CBLID pin outputs as MA15/MA16
+		 * address lines to access an external eeprom.  To
+		 * read cable detect state the pins must be enabled
+		 * as inputs by clearing bit 0 of reg 0x5b.
+		 */
+		pci_read_config_byte(hwif->pci_dev, 0x5b, &scr2);
+		pci_write_config_byte(hwif->pci_dev, 0x5b, scr2 & ~1);
+		pci_read_config_byte(hwif->pci_dev, 0x5a, &ata66);
+		pci_write_config_byte(hwif->pci_dev, 0x5b, scr2 | 1);
+	} else {
+		pci_read_config_byte(hwif->pci_dev, 0x5a, &ata66);
+	}
 #ifdef DEBUG
 	printk("HPT366: reg5ah=0x%02x ATA-%s Cable Port%d\n",
 		ata66, (ata66 & regmask) ? "33" : "66",

