Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSHCPeE>; Sat, 3 Aug 2002 11:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSHCPeE>; Sat, 3 Aug 2002 11:34:04 -0400
Received: from ool-182fa350.dyn.optonline.net ([24.47.163.80]:10368 "EHLO
	nikolas.hn.org") by vger.kernel.org with ESMTP id <S317590AbSHCPeD>;
	Sat, 3 Aug 2002 11:34:03 -0400
Date: Sat, 3 Aug 2002 11:37:34 -0400
From: Nick Orlov <nick.orlov@mail.ru>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: [PATCH] pdc20265 problem.
Message-ID: <20020803153734.GA9789@nikolas.hn.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.SOL.4.30.0208030241540.18115-100000@mion.elka.pw.edu.pl> <Pine.LNX.4.44.0208022107560.3863-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208022107560.3863-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On Fri, Aug 02, 2002 at 09:08:15PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Sat, 3 Aug 2002, Bartlomiej Zolnierkiewicz wrote:
> 
> >
> > On Fri, 2 Aug 2002, Marcelo Tosatti wrote:
> > > On Fri, 2 Aug 2002, Bartlomiej Zolnierkiewicz wrote:
> > > > > Just FYI,
> > > > >
> > > > > before these "#ifdef" fixes it was treated as OFF_BOARD unless
> > > > > CONFIG_PDC202XX_FORCE is set. (now it's inverted)
> > > >
> > > > This should be fixed.
> > >
> > > If we change the #ifdef on ide-pci.c it will skip some controllers which
> > > worked before _without_ CONFIG_PDC202XX_FORCE set.
> >
> > I was thinking about changing it globally to do what its name suggest.
> >
> > Main problem is that before introducing skipping Promises, FORCE
> > controlled overriding BIOS only (?) and now it is also used to control
> > 'skipping'. (FORCE should be by default on of course)
> > Probably 'skipping' should be separated to another config option...
> 
> Indeed. I appreciate patches ;)
> 

New config option added (CONFIG_PDC20265_ONBOARD).
Comments / suggestions highly appreciated :)

-- 
With best wishes,
	Nick Orlov.


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="pdc.patch"

--- linux/Documentation/Configure.help.orig	2002-08-03 11:26:50.000000000 -0400
+++ linux/Documentation/Configure.help	2002-08-03 11:23:39.000000000 -0400
@@ -1193,6 +1193,13 @@
 
   If unsure, say N.
 
+Promise 20265 is on-board
+CONFIG_PDC20265_ONBOARD
+  Say Y here if you have motherboard with Promise 20265 primary IDE
+  controller.
+
+  Otherwise, say N.
+
 Special UDMA Feature
 CONFIG_PDC202XX_BURST
   This option causes the pdc202xx driver to enable UDMA modes on the
--- linux/drivers/ide/Config.in.orig	2002-08-03 11:27:25.000000000 -0400
+++ linux/drivers/ide/Config.in	2002-08-03 10:49:26.000000000 -0400
@@ -84,6 +84,7 @@
 	    dep_bool '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
 #	    dep_mbool '   Pacific Digital A-DMA support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC_ADMA $CONFIG_BLK_DEV_ADMA $CONFIG_IDEDMA_PCI_WIP $CONFIG_EXPERIMENTAL
 	    dep_bool '    PROMISE PDC202{46|62|65|67|68|69|70} support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '      Promise 20265 is on-board' CONFIG_PDC20265_ONBOARD $CONFIG_BLK_DEV_PDC202XX
 	    dep_bool '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
 	    dep_bool '      Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX
 	    dep_bool '    ServerWorks OSB4/CSB5 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
--- linux/drivers/ide/ide-pci.c.orig	2002-08-03 11:27:43.000000000 -0400
+++ linux/drivers/ide/ide-pci.c	2002-08-03 10:59:45.000000000 -0400
@@ -382,6 +382,12 @@
 	unsigned int		extra;
 } ide_pci_device_t;
 
+#ifdef CONFIG_PDC20265_ONBOARD
+# define PDC20265_BOARD ON_BOARD
+#else /* !CONFIG_PDC20265_ONBOARD */
+# define PDC20265_BOARD OFF_BOARD
+#endif /* CONFIG_PDC20265_ONBOARD */
+
 static ide_pci_device_t ide_pci_chipsets[] __initdata = {
 	{DEVID_PIIXa,	"PIIX",		NULL,		NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}}, 	ON_BOARD,	0 },
 	{DEVID_PIIXb,	"PIIX",		NULL,		NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}}, 	ON_BOARD,	0 },
@@ -405,12 +411,12 @@
 #ifndef CONFIG_PDC202XX_FORCE
         {DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	16 },
         {DEVID_PDC20262,"PDC20262",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
-        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	48 },
+        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	PDC20265_BOARD,	48 },
         {DEVID_PDC20267,"PDC20267",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
 #else /* !CONFIG_PDC202XX_FORCE */
 	{DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}}, 	OFF_BOARD,	16 },
 	{DEVID_PDC20262,"PDC20262",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}},	OFF_BOARD,	48 },
-	{DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}},	OFF_BOARD,	48 },
+	{DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}},	PDC20265_BOARD,	48 },
 	{DEVID_PDC20267,"PDC20267",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}},	OFF_BOARD,	48 },
 #endif
 	{DEVID_PDC20268,"PDC20268",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },

--bp/iNruPH9dso1Pn--
