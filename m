Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263686AbSJHUZn>; Tue, 8 Oct 2002 16:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263660AbSJHUZa>; Tue, 8 Oct 2002 16:25:30 -0400
Received: from va.cs.wm.edu ([128.239.2.31]:15116 "EHLO va.cs.wm.edu")
	by vger.kernel.org with ESMTP id <S263267AbSJHUWk>;
	Tue, 8 Oct 2002 16:22:40 -0400
Date: Tue, 08 Oct 2002 16:28:13 -0400
From: Bruce Lowekamp <lowekamp@CS.WM.EDU>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Nick Orlov <nick.orlov@mail.ru>
Subject: [PATCH] fix for pdc20265 for 2.4.19 on
Message-ID: <21460000.1034108893@chorus.cs.wm.edu>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; FORMAT=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is intended to fix the "pdc20265 secondary controller 
misidentified as primary" problem that occurs on motherboards including the 
20265 as an onboard raid controller.  The patch is based on one suggested 
by Nick Orlov in August, but adds an additional printk to make the 
alternatives more palatable.

The fix in the patch is to switch the PDC20265 from ON_BOARD to OFF_BOARD 
when CONFIG_PDC202XX_FORCE is not set.  Since this was proposed before, I 
will try to address the two main objections raised and explain why I think 
the new printk solves them.

1: This fixes some MBs, but break others:
	First, more MBs seem to use the pdc20265 as a secondary controller than a 
primary
	Second, of those that do use the pdc20265 as the primary controller 
(others have asserted this is a non-empty set, I have no knowledge of one), 
if the BIOS sets it up to use the standard I/O port 0x01f0 	for ide0, then 
the first loop of ide-pci.c:ide-match-hwif() will notice the ioport and set 
it as primary regardless of the ON_BOARD or OFF_BOARD setting, so these MBs 
should work fine.
	So the only case where there is a problem is a MB with a pdc20265 as 
primary that doesn't set it up at the normal 0x01f0/0x0170 ioports.  The 
question in my mind is how many MBs are we talking about here.  My 
understanding is this set must be extremely small, if it is not non-empty. 
So I believe that such a small percentage of MBs is not worth making the 
default very painful for the vast majority of properly configured MBs.  But 
for those that are misconfigured, we still need a solution, which motivates 
the new printk:
	The right way, IMHO, to select the appropriate controller when it is a 
problem is with ideX=base.  The problem with suggesting this is that there 
is no easy way to identify which value to use for base---the 20265, for 
instance, gets 8 entries in /proc/ioports, and the VIA primary on the 
A7V266-E gets 6.  Unless you pick the right one, ide_match_hwif won't put 
the controller where you request it.  The solution I propose is to add a 
printk to the bootup messages that will identify the base associated with 
each interface on the controller, as seen by ide-match-hwif.  This way a 
quick look at the bootup screen will give the information needed to 
rearrange the controllers.
	This solution requires a kernel boot parameter to be added for the 
(hopefully very small set of) MBs that have a 20265 as the primary 
controller, but not at the standard address.  Most MBs will continue to 
work without a problem.

2: Won't fly with the non-sysadmin crowd
	Right now, linux up to 2.4.18 would DTRT on most MBs and have the 20265 as 
secondary.  2.5.41 also has the 20265 as OFF_BOARD, so it also identifies 
it as secondary.  If we want to make life easiest for the 
non-kernel-hacker, the 20265 goes back to being OFF_BOARD.  If this isn't 
fixed, non-sysadmins (and sysadmins who have to support the machines) will 
be very unhappy as their hard disks move from hda to hde and back to hda. 
Sysadmins will be able to figure out the appropriate ideX=base parameter 
and it should (hopefully) continue to work.  Or controllers will continue 
to be recognized on ide2, but at least it will be the same. This change 
should be made just to ensure version-to-version compatibility.


FTR, I suspect doing this right (perfectly) would require a major reworking 
of the ide probe code to do something like pre-scan all IDE devices to 
check their ioports and then assigning them to ideX devices according to 
ioport, known on-board controller, and pci order.  But I don't think that 
kind of effort is appropriate in a 2.4 kernel.  We have a good boot 
parameter solution of ideX=base, but it's hard to find the right number to 
plug in for base.  I think the best way to solve this problem is to add 
additional information to the bootup messages.  Then people who have a real 
problem with IDE device ordering can solve it easily with ideX=base, rather 
than relying on ide=reverse, which really seems like a hack (what if I want 
the middle controller?).

In the case of my A7N266-E MBs, I have verified that the boot flags "ro 
root=/dev/hde1 ide0=0xb400 ide1=0xa800 ide2=0x1f0 ide3=0x170" allows me to 
boot with the 20265 on ide0 and ide1, should I want to.


There are two patches below.  They both have the change ON_BOARD to 
OFF_BOARD fix, but with different printk solutions.  The first adds a line 
like the one below (marked with *).  Unfortunately, this printk occurs 
before the interfaces are named, and even before the code has checked that 
the second interface is enabled.  But it puts all the information on one 
line.
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
*PDC20265: interface bases at 0xb400 & 0xa800
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio

The second adds lines like this, which solve the probem of naming and 
making sure they're enabled, but I think it's somewhat uglier:
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
*    ide2: located at 0xb400
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
*    ide3: located at 0xa800
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio

I think the best fix might be something like changing those last two lines 
to:
    ide2@0xb400: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3@0xa800: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
but that involves changing all of the calls to ide_setup_dma in about 10 
source files in the ide directory.  I am willing to come up with that 
patch, but only if there is positive feedback on this that makes it seem 
likely the work would be worthwhile.

Comments are appreciated.  Getting this solved in a reasonable manner is 
important for those of us trying to maintain several machines with these 
MBs.  If there is a reason to believe that there is a significant number of 
MBs with a primary onboard 20265 that doesn't live at 0x01f0, is there a 
better solution?

Bruce Lowekamp

first patch that produces just one more line:
diff -u linux-2.4.20-pre9/drivers/ide/ide-pci.c.orig 
linux-2.4.20-pre9/drivers/ide/ide-pci.c
--- linux-2.4.20-pre9/drivers/ide/ide-pci.c.orig	Mon Oct  7 21:41:54 
2002+++ linux-2.4.20-pre9/drivers/ide/ide-pci.c	Tue Oct  8 16:20:57 2002
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
base=0x170\n");
+		}
 		if ((hwif = ide_match_hwif(base, d->bootable, d->name)) == NULL) 
	continue;	/* no room in ide_hwifs[] */
 		if (hwif->io_ports[IDE_DATA_OFFSET] != base) {



second option that produces multiple lines, but more accurate:
diff -u linux-2.4.20-pre9/drivers/ide/ide-pci.c.orig 
linux-2.4.20-pre9/drivers/ide/ide-pci.c
--- linux-2.4.20-pre9/drivers/ide/ide-pci.c.orig	Mon Oct  7 21:41:54 
2002+++ linux-2.4.20-pre9/drivers/ide/ide-pci.c	Tue Oct  8 16:23:24 2002
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
@@ -755,6 +755,7 @@
 			base = port ? 0x170 : 0x1f0;	/* use default value */
 		if ((hwif = ide_match_hwif(base, d->bootable, d->name)) == NULL) 
	continue;	/* no room in ide_hwifs[] */
+		printk("    %s: located at 0x%04lx\n", hwif->name, base);
 		if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
 			ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);
 			memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));

