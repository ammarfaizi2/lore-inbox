Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSHDMVQ>; Sun, 4 Aug 2002 08:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSHDMVQ>; Sun, 4 Aug 2002 08:21:16 -0400
Received: from babsi.intermeta.de ([212.34.181.3]:62470 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP
	id <S316491AbSHDMVP>; Sun, 4 Aug 2002 08:21:15 -0400
Date: Sun, 4 Aug 2002 14:24:27 +0200
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc5-ac1 and Intel SCB2 (OSB5) trouble
Message-ID: <20020804142427.A11755@forge.intermeta.de>
Reply-To: hps@intermeta.de
References: <aih3v2$11l$1@forge.intermeta.de> <1028402593.1760.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1028402593.1760.16.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> I am curious why the -ac PCI fixups didn't resolve this problem. Out of
> interest edit pci-i386.c and remove the IDE test in
> pcibios_assign_resources.

doing this:

  /* (class == PCI_CLASS_STORAGE_IDE && idx < 4) || */
if ((class == PCI_CLASS_DISPLAY_VGA && (r->flags & IORESOURCE_IO)))

in arch/i386/kernel/pci-i386.c

fixed the OSB5 IDE Controller:

SvrWks CSB5: IDE controller on PCI bus 00 dev 79
SvrWks CSB5: chipset revision 146
SvrWks CSB5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x03a0-0x03a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x03a8-0x03af, BIOS settings: hdc:pio, hdd:pio

The lspci -vvx for the IDE south bridge now shows:

--- cut ---
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 3410
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Region 0: I/O ports at 1418 [size=8]
	Region 1: I/O ports at 1420 [size=4]
	Region 2: I/O ports at 1428 [size=8]
	Region 3: I/O ports at 1424 [size=4]
	Region 4: I/O ports at 03a0 [size=16]
	Region 5: I/O ports at 0410 [size=4]
00: 66 11 12 02 05 01 00 02 92 8a 01 01 08 40 80 00
10: 19 14 00 00 21 14 00 00 29 14 00 00 25 14 00 00
20: a1 03 00 00 11 04 00 00 00 00 00 00 86 80 10 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
--- cut ---

I did add some debugging to pci-i386.c, and it showed up nicely:

--- cut ---
hps -- We're checking Device ServerWorks CSB5 IDE Controller, Class is 257
hps -- Checking Resource # 0, c1e3145c (0 -> 7)
hps -- Assigning a Resource for Device ServerWorks CSB5 IDE Controller, Resource 0
hps -- Checking Resource # 1, c1e31478 (0 -> 3)
hps -- Assigning a Resource for Device ServerWorks CSB5 IDE Controller, Resource 1
hps -- Checking Resource # 2, c1e31494 (0 -> 7)
hps -- Assigning a Resource for Device ServerWorks CSB5 IDE Controller, Resource 2
hps -- Checking Resource # 3, c1e314b0 (0 -> 3)
hps -- Assigning a Resource for Device ServerWorks CSB5 IDE Controller, Resource 3
hps -- Checking Resource # 4, c1e314cc (3a0 -> 943)
hps -- Checking Resource # 5, c1e314e8 (410 -> 1043)
--- cut ---

So, you're correct, I'd have to spank my vendor. Can we get a
workaround for this device, though? The OSB5 seems to be common on
Intel OEM boards and lots of people will want to run linux on it.

How about the attached patch? This does the trick for me.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-alan

--- linux-2.4.19-ac1/drivers/pci/quirks.c.orig	Sat Aug  3 02:39:44 2002
+++ linux-2.4.19-ac1/drivers/pci/quirks.c	Sun Aug  4 14:19:45 2002
@@ -472,6 +472,28 @@
 }
 
 /*
+ * Fix up IDE region of the ServerWorks OSB5 Chipset
+ * The Intel OEM SCB2 Board and the SR1200 Server seem
+ * to need this, else you will get only PIO on the builtin
+ * IDE interface.             -- hps 20020804
+ */
+
+static void __init quirk_osb5 (struct pci_dev * dev )
+{
+	struct resource *r;
+	int idx;
+	
+	printk(KERN_INFO "Checking ServerWorks OSB5 IDE BIOS Setup\n");
+
+	for(idx=0; idx<6; idx++) {
+		r = &dev->resource[idx];
+
+		if(!r->start && r->end)
+			pci_assign_resource(dev, idx);
+	}
+}
+
+/*
  *  The main table of quirks.
  */
 
@@ -525,6 +547,7 @@
 
 	{ PCI_FIXUP_FINAL, 	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering },
+	{ PCI_FIXUP_FINAL,     PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_osb5 },
 
 	{ 0 }
 };

--5vNYLRcllDrimb99--
