Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbTFUKSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 06:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265120AbTFUKSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 06:18:08 -0400
Received: from oxmail3.ox.ac.uk ([129.67.1.3]:48627 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id S265117AbTFUKSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 06:18:04 -0400
Date: Sat, 21 Jun 2003 11:31:51 +0100
From: Glyn Kennington <glyn.kennington@hertford.oxford.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 82371FB PIIX IDE problem with multi-function mode
Message-ID: <20030621103151.GB2986@corrosive.hertford.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems accessing the IDE controller on my Thinkpad (760ED)'s
82371FB bridge.  This has the effect that I get an error (HDIO_SET_DMA) when
trying to enable DMA modes on it.

The boot messages are 

PCI: PCI BIOS revision 2.10 entry at 0xfd930, last bus=6
PCI: Using configuration type 1
PCI: Probing PCI hardware
...
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIXa: IDE controller at PCI slot 00:01.0
PIIXa: chipset revision 2
PIIXa: not 100% native mode: will probe irqs later
PIIXa: neither IDE port enabled (BIOS)
hda: TOSHIBA MK4006MAV, ATA DISK drive
hdb: SANYO CRD-S58P, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

which suggests that there is no busmaster support.

After searching for some help on this, I found
http://www001.upp.so-net.ne.jp/kterada/pc_memo.html
which, although in Japanese, contained some snippets of code and dmesg
output that I was able to understand.  It is for a slightly different model
of Thinkpad that still contains the 82731FB.  I tried the given setpci
command (setpci -s 0:1.0 6a.w=04) with the result that lspci could then find
the IDE interface:

00:00.0 Host bridge: Intel Corp. 430MX - 82437MX Mob. System Ctrlr (MTSC) &
82438MX Data Path (MTDP) (rev 02)
00:01.0 ISA bridge: Intel Corp. 82371FB PIIX ISA [Triton I] (rev 02)
00:01.1 IDE interface: Intel Corp. 82371FB PIIX IDE [Triton I] (rev 02)
00:02.0 CardBus bridge: Texas Instruments PCI1130 (rev 04)
...

The page also includes a trivial patch against 2.2.20 to perform this
operation before the IDE devices are registered.  I adapted this patch to
2.4.21 as follows:

--- linux-2.4.21/drivers/pci/pci.c.orig	Fri Jun 20 16:06:17 2003
+++ linux-2.4.21/drivers/pci/pci.c	Sat Jun 21 11:03:27 2003
@@ -1470,10 +1470,16 @@
 	int func = 0;
 	int is_multi = 0;
 	u8 hdr_type;
+	unsigned int l;
 
 	for (func = 0; func < 8; func++, temp->devfn++) {
 		if (func && !is_multi)		/* not a multi-function device */
 			continue;
+		pci_read_config_dword(temp, PCI_VENDOR_ID, &l);
+		if (l == 0x122e8086) {
+			pci_write_config_word(temp,0x6a,0x0004);
+			printk("PCI: PIIXa set to multi-function mode\n");
+		}
 		if (pci_read_config_byte(temp, PCI_HEADER_TYPE, &hdr_type))
 			continue;
 		temp->hdr_type = hdr_type & 0x7f;


On booting, the output is now

PCI: PCI BIOS revision 2.10 entry at 0xfd930, last bus=6
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: PIIXa set to multi-function mode
...
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIXa: IDE controller at PCI slot 00:01.0
PIIXa: chipset revision 2
PIIXa: not 100% native mode: will probe irqs later
PIIXa: neither IDE port enabled (BIOS)
PIIXb: IDE controller at PCI slot 00:01.1
PIIXb: chipset revision 2
PIIXb: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
hda: TOSHIBA MK4006MAV, ATA DISK drive
hdb: SANYO CRD-S58P, ATAPI CD/DVD-ROM drive
blk: queue c02763e0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.

I can now set the drive to use DMA, although hdparm -tT shows that it's
faster without, and the UDMA modes cause lots of `irq timeout' errors.

I checked the documentation for the 82371FB, which says that the register
being written is the MSTAT register, and writing a value of 4 to it does
indeed put the device into multi-function mode.  However, it also states
that this bit defaults to 1 anyway.

>From this, I reason that somehow this bit is being set to 0 earlier in
bootup.  This might be happening either in the Thinkpad BIOS (in which case
the above patch is necessary) or earlier in the kernel's boot routine (which
means that the problem lies elsewhere).

Any suggestions?

Glyn
