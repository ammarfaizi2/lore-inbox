Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263762AbSJHUm6>; Tue, 8 Oct 2002 16:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263759AbSJHUmS>; Tue, 8 Oct 2002 16:42:18 -0400
Received: from va.cs.wm.edu ([128.239.2.31]:24584 "EHLO va.cs.wm.edu")
	by vger.kernel.org with ESMTP id <S263143AbSJHUlS>;
	Tue, 8 Oct 2002 16:41:18 -0400
Date: Tue, 08 Oct 2002 16:46:58 -0400
From: Bruce Lowekamp <lowekamp@CS.WM.EDU>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] fix for pdc20265 for 2.4.19 on
Message-ID: <23290000.1034110018@chorus.cs.wm.edu>
In-Reply-To: <21460000.1034108893@chorus.cs.wm.edu>
References: <21460000.1034108893@chorus.cs.wm.edu>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I made a mistake when producing the two different patches.  Here is a 
replacement for the first patch that has all of the parameters it should.

this version does:

PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
*PDC20265: interface bases at 0xb400 & 0xa800
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio

diff -u linux-2.4.20-pre9/drivers/ide/ide-pci.c.orig 
linux-2.4.20-pre9/drivers/ide/ide-pci.c
--- linux-2.4.20-pre9/drivers/ide/ide-pci.c.orig	Mon Oct  7 21:41:54 
2002+++ linux-2.4.20-pre9/drivers/ide/ide-pci.c	Tue Oct  8 16:44:59 2002
@@ -405,7 +405,7 @@
 #ifndef CONFIG_PDC202XX_FORCE
         {DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX, 
	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	
16 },
         {DEVID_PDC20262,"PDC20262",	PCI_PDC202XX,	ATA66_PDC202XX, 
	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	
48 },
-        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX, 
	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	
48 },
+        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX, 
	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	
48 },
         {DEVID_PDC20267,"PDC20267",	PCI_PDC202XX,	ATA66_PDC202XX, 
	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	
48 },
 #else /* !CONFIG_PDC202XX_FORCE */
 	{DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL, 
	{{0x50,0x02,0x02}, {0x50,0x04,0x04}}, 	OFF_BOARD,	
16 },
@@ -744,6 +744,10 @@
 				continue;
 #endif
 			}
+			if(port==0)
+			  printk("%s: first interface base=0x%04lx, second interface 
base=0x%04lx\n",
+				 d->name, dev->resource[2*0].start,
+				 dev->resource[2*1].start);
 		}
 		if ((ctl && !base) || (base && !ctl)) {
 			printk("%s: inconsistent baseregs (BIOS) for port %d, skipping\n", 
d->name, port);
@@ -751,8 +755,11 @@
 		}
 		if (!ctl)
 			ctl = port ? 0x374 : 0x3f4;	/* use default value */
-		if (!base)
+		if (!base){
 			base = port ? 0x170 : 0x1f0;	/* use default value */
+			if(port==0)
+			  printk("%s: default first interface base=0x01f0, second interface 
base=0x170\n", d->name);
+		}
 		if ((hwif = ide_match_hwif(base, d->bootable, d->name)) == NULL) 
	continue;	/* no room in ide_hwifs[] */
 		if (hwif->io_ports[IDE_DATA_OFFSET] != base) {

