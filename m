Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTJ3JsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 04:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTJ3JsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 04:48:05 -0500
Received: from [195.49.175.48] ([195.49.175.48]:38021 "HELO rewtbox.de")
	by vger.kernel.org with SMTP id S261606AbTJ3JsA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 04:48:00 -0500
From: "Michael Labuschke" <michael@labuschke.de>
To: <linux-kernel@vger.kernel.org>
Subject: WG:  EIO DM-8401H ATA133 IDE Controller Card ( Silicon Image Chip ?!?)
Date: Thu, 30 Oct 2003 10:47:52 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
thread-index: AcOeykxrWfPHLGTNR265CMx7RSRCHwAAFqHw
Message-Id: <S261606AbTJ3JsA/20031030094800Z+24028@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I bought an IDE Controller the other day ( non RAID version)
See  http://www.ivmm.com/eio/products_dm8401h.html
As ist stated there should be linux support.
No the problem is
(output from  cat /proc/pci

  Bus  0, device  17, function  0:
    Unknown mass storage controller: PCI device 1283:8212 (Integrated
Technology Express, Inc.) (rev 17).
      IRQ 11.
      Master Capable.  No bursts.  Min Gnt=8.Max Lat=8.
      I/O at 0xd800 [0xd807].
      I/O at 0xdc00 [0xdc03].
      I/O at 0xe000 [0xe007].
      I/O at 0xe400 [0xe403].
      I/O at 0xe800 [0xe80f].

The device is unknown
So i have patched the kernel and changed the old silicon image device number
to match my 
„unknown“ device.

--- linux-2.4.22/include/linux/pci_ids.h        2003-10-30
01:09:21.000000000 +0100
+++ linux-2.4.22-org/include/linux/pci_ids.h    2003-08-25
13:44:44.000000000 +0200
@@ -811,7 +811,7 @@
 #define PCI_DEVICE_ID_SUN_SABRE                0xa000
 #define PCI_DEVICE_ID_SUN_HUMMINGBIRD  0xa001

-#define PCI_VENDOR_ID_CMD              0x1283
+#define PCI_VENDOR_ID_CMD              0x1095
 #define PCI_DEVICE_ID_SII_1210SA       0x0240

 #define PCI_DEVICE_ID_CMD_640          0x0640
@@ -822,7 +822,7 @@
 #define PCI_DEVICE_ID_CMD_649          0x0649
 #define PCI_DEVICE_ID_CMD_670          0x0670

-#define PCI_DEVICE_ID_SII_680          0x8212
+#define PCI_DEVICE_ID_SII_680          0x0680
 #define PCI_DEVICE_ID_SII_3112         0x3112

 #define PCI_VENDOR_ID_VISION           0x1098


Dmesg gives me now
SiI680: IDE controller at PCI slot 00:11.0
SiI680: chipset revision 17
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 100
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio

and it finds both die drives connected to the controller
ide2 at 0xd800-0xd807,0xdc02 on irq 11
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
UDMA(33)
hdf: attached ide-disk driver.
hdf: host protected area => 1
hdf: 195711264 sectors (100204 MB) w/2048KiB Cache, CHS=194158/16/63,
UDMA(33)

hdparm –dt /dev/hde /dev/hdf

/dev/hde:
 using_dma    =  1 (on)
 Timing buffered disk reads:   86 MB in  3.04 seconds =  28.29 MB/sec

/dev/hdf:
 using_dma    =  1 (on)
 Timing buffered disk reads:   90 MB in  3.03 seconds =  29.70 MB/sec

So it works.. kinda..
As you see there is only UDMA 33 enabled ( both drive can do at least udma
100)
The driver seems right but the hack is REALLY bad ( works for me) 
You guys know much more about that stuff than i do.. maybe i could help.

Michael
PS: please CC to me since i’m not subscribed ;)



