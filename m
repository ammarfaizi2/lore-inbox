Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSD1Lhn>; Sun, 28 Apr 2002 07:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293337AbSD1Lhm>; Sun, 28 Apr 2002 07:37:42 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:2285 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S293203AbSD1Lhj>;
	Sun, 28 Apr 2002 07:37:39 -0400
Date: Sun, 28 Apr 2002 13:37:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: [bk+patch] Support for Intel C-ICH and ICH4 (including UDMA133).
Message-ID: <20020428133721.A10276@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

These two patches (the second being a fix for the first) add support for
the C-ICH and ICH4 chips to the piix.c driver. Patches against latest
2.5 kernel.

-- 
Vojtech Pavlik
SuSE Labs

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="piix-ich4.bkdiff"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.568, 2002-04-28 13:27:51+02:00, vojtech@twilight.ucw.cz
  This patch adds support for the new Intel C-ICH and ICH4 IDE controllers.


 drivers/ide/ide-pci.c   |    2 ++
 drivers/ide/piix.c      |   38 +++++++++++++++++++++-----------------
 drivers/pci/pci.ids     |    2 ++
 include/linux/pci_ids.h |   20 +++++++++++---------
 4 files changed, 36 insertions(+), 26 deletions(-)


diff -Nru a/drivers/ide/ide-pci.c b/drivers/ide/ide-pci.c
--- a/drivers/ide/ide-pci.c	Sun Apr 28 13:28:24 2002
+++ b/drivers/ide/ide-pci.c	Sun Apr 28 13:28:24 2002
@@ -201,8 +201,10 @@
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_1, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_8, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_9, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_11, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_9, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
 #endif
 #ifdef CONFIG_BLK_DEV_VIA82CXXX
diff -Nru a/drivers/ide/piix.c b/drivers/ide/piix.c
--- a/drivers/ide/piix.c	Sun Apr 28 13:28:24 2002
+++ b/drivers/ide/piix.c	Sun Apr 28 13:28:24 2002
@@ -61,8 +61,8 @@
 #define PIIX_UDMA_NONE		0x00
 #define PIIX_UDMA_33		0x01
 #define PIIX_UDMA_66		0x02
-#define PIIX_UDMA_V66		0x03
-#define PIIX_UDMA_100		0x04
+#define PIIX_UDMA_100		0x03
+#define PIIX_UDMA_133		0x04
 #define PIIX_NO_SITRE		0x08	/* Chip doesn't have separate slave timing */
 #define PIIX_PINGPONG		0x10	/* Enable ping-pong buffers */
 #define PIIX_VICTORY		0x20	/* Efar Victory66 has a different UDMA setup */
@@ -77,8 +77,10 @@
 	unsigned short id;
 	unsigned char flags;
 } piix_ide_chips[] = {
+	{ PCI_DEVICE_ID_INTEL_82801DB_9,	PIIX_UDMA_133 | PIIX_PINGPONG },                    /* Intel 82801DB ICH4 */
 	{ PCI_DEVICE_ID_INTEL_82801CA_11,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CA ICH3 */
 	{ PCI_DEVICE_ID_INTEL_82801CA_10,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CAM ICH3-M */
+	{ PCI_DEVICE_ID_INTEL_82801E_9,		PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801E C-ICH */
 	{ PCI_DEVICE_ID_INTEL_82801BA_9,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BA ICH2 */
 	{ PCI_DEVICE_ID_INTEL_82801BA_8,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BAM ICH2-M */
 	{ PCI_DEVICE_ID_INTEL_82801AB_1,	PIIX_UDMA_33  | PIIX_PINGPONG },                    /* Intel 82801AB ICH0 */
@@ -88,7 +90,7 @@
 	{ PCI_DEVICE_ID_INTEL_82371AB,		PIIX_UDMA_33 },                                     /* Intel 82371AB/EB PIIX4/4E */
 	{ PCI_DEVICE_ID_INTEL_82371SB_1,	PIIX_UDMA_NONE },                                   /* Intel 82371SB PIIX3 */
 	{ PCI_DEVICE_ID_INTEL_82371FB_1,	PIIX_UDMA_NONE | PIIX_NO_SITRE | PIIX_CHECK_REV },  /* Intel 82371FB PIIX */
-	{ PCI_DEVICE_ID_EFAR_SLC90E66_1,	PIIX_UDMA_V66 | PIIX_VICTORY },                     /* Efar Victory66 */
+	{ PCI_DEVICE_ID_EFAR_SLC90E66_1,	PIIX_UDMA_66 | PIIX_VICTORY },                      /* Efar Victory66 */
 	{ 0 }
 };
 
@@ -97,7 +99,7 @@
 static unsigned int piix_80w;
 static unsigned int piix_clock;
 
-static char *piix_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA66", "UDMA100" };
+static char *piix_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA133" };
 
 /*
  * PIIX/ICH /proc entry.
@@ -318,20 +320,19 @@
 {
 	ide_drive_t *peer = drive->channel->drives + (~drive->dn & 1);
 	struct ata_timing t, p;
-	int err, T, UT, umul;
+	int err, T, UT, umul = 1;
 
 	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
 		if ((err = ide_config_drive_speed(drive, speed)))
 			return err;
 
-	umul =  min((speed > XFER_UDMA_4) ? 4 : ((speed > XFER_UDMA_2) ? 2 : 1),
-		piix_config->flags & PIIX_UDMA);
-
-	if (piix_config->flags & PIIX_VICTORY)
+	if (speed > XFER_UDMA_2 && (piix_config->flags & PIIX_UDMA >= PIIX_UDMA_66))
 		umul = 2;
-
+	if (speed > XFER_UDMA_4 && (piix_config->flags & PIIX_UDMA >= PIIX_UDMA_100))
+		umul = 4;
+	
 	T = 1000000000 / piix_clock;
-	UT = umul ? (T / umul) : 0;
+	UT = T / umul;
 
 	ata_timing_compute(drive, speed, &t, T, UT);
 
@@ -388,7 +389,8 @@
 			(piix_config->flags & PIIX_NODMA ? 0 : (XFER_SWDMA | XFER_MWDMA |
 			(piix_config->flags & PIIX_UDMA ? XFER_UDMA : 0) |
 			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66 ? XFER_UDMA_66 : 0) |
-			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100 ? XFER_UDMA_100 : 0))));
+			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100 ? XFER_UDMA_100 : 0) |
+			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_133 ? XFER_UDMA_133 : 0))));
 
 		piix_set_drive(drive, speed);
 
@@ -458,14 +460,16 @@
 	switch (piix_config->flags & PIIX_UDMA) {
 
 		case PIIX_UDMA_66:
+			if (piix->config && PIIX_VICTORY) {
+				pci_read_config_byte(dev, PIIX_IDESTAT, &t);
+				piix_80w = ((t & 2) ? 1 : 0) | ((t & 1) ? 2 : 0);
+				break;
+			}
+
 		case PIIX_UDMA_100:
+		case PIIX_UDMA_133:
 			pci_read_config_dword(dev, PIIX_IDECFG, &u);
 			piix_80w = ((u & 0x30) ? 1 : 0) | ((u & 0xc0) ? 2 : 0);
-			break;
-
-		case PIIX_UDMA_V66:
-			pci_read_config_byte(dev, PIIX_IDESTAT, &t);
-			piix_80w = ((t & 2) ? 1 : 0) | ((t & 1) ? 2 : 0);
 			break;
 	}
 
diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Sun Apr 28 13:28:24 2002
+++ b/drivers/pci/pci.ids	Sun Apr 28 13:28:24 2002
@@ -5097,9 +5097,11 @@
 	244b  82820 820 (Camino 2) Chipset IDE U100
 	244c  82820 820 (Camino 2) Chipset ISA Bridge (ICH2-M)
 	244e  82820 820 (Camino 2) Chipset PCI
+	245b  82801E C-ICH IDE
 	2485  AC'97 Audio Controller
 	248a  82801CAM ICH3-M IDE
 	248b  82801CA ICH3 IDE
+	24cb  82801DB ICH4 IDE
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
 	2501  82820 820 (Camino) Chipset Host Bridge (MCH)
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Sun Apr 28 13:28:24 2002
+++ b/include/linux/pci_ids.h	Sun Apr 28 13:28:24 2002
@@ -1631,15 +1631,6 @@
 #define PCI_DEVICE_ID_INTEL_82380FB	0x124b
 #define PCI_DEVICE_ID_INTEL_82439	0x1250
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
-#define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
-#define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
-#define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
-#define PCI_DEVICE_ID_INTEL_82437VX	0x7030
-#define PCI_DEVICE_ID_INTEL_82439TX	0x7100
-#define PCI_DEVICE_ID_INTEL_82371AB_0	0x7110
-#define PCI_DEVICE_ID_INTEL_82371AB	0x7111
-#define PCI_DEVICE_ID_INTEL_82371AB_2	0x7112
-#define PCI_DEVICE_ID_INTEL_82371AB_3	0x7113
 #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
 #define PCI_DEVICE_ID_INTEL_82801AA_1	0x2411
 #define PCI_DEVICE_ID_INTEL_82801AA_2	0x2412
@@ -1666,6 +1657,7 @@
 #define PCI_DEVICE_ID_INTEL_82801BA_9	0x244b
 #define PCI_DEVICE_ID_INTEL_82801BA_10	0x244c
 #define PCI_DEVICE_ID_INTEL_82801BA_11	0x244e
+#define PCI_DEVICE_ID_INTEL_82801E_9	0x245b
 #define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
 #define PCI_DEVICE_ID_INTEL_82801CA_2	0x2482
 #define PCI_DEVICE_ID_INTEL_82801CA_3	0x2483
@@ -1676,7 +1668,17 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_10	0x248a
 #define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
 #define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
+#define PCI_DEVICE_ID_INTEL_82801DB_9	0x24cb
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
+#define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
+#define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
+#define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
+#define PCI_DEVICE_ID_INTEL_82437VX	0x7030
+#define PCI_DEVICE_ID_INTEL_82439TX	0x7100
+#define PCI_DEVICE_ID_INTEL_82371AB_0	0x7110
+#define PCI_DEVICE_ID_INTEL_82371AB	0x7111
+#define PCI_DEVICE_ID_INTEL_82371AB_2	0x7112
+#define PCI_DEVICE_ID_INTEL_82371AB_3	0x7113
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121
 #define PCI_DEVICE_ID_INTEL_82810_MC3	0x7122

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch10131
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
A8K82,2^)^=T7U6$/;P+Y:+`3<N5[(6+O'R-ZMR`-%P``
`
end

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="piix-ich4-2.bkdiff"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.569, 2002-04-28 13:30:56+02:00, vojtech@twilight.ucw.cz
  Add a missing "UDMA100" entry in udma name table.


 piix.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/ide/piix.c b/drivers/ide/piix.c
--- a/drivers/ide/piix.c	Sun Apr 28 13:31:33 2002
+++ b/drivers/ide/piix.c	Sun Apr 28 13:31:33 2002
@@ -99,7 +99,7 @@
 static unsigned int piix_80w;
 static unsigned int piix_clock;
 
-static char *piix_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA133" };
+static char *piix_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 
 /*
  * PIIX/ICH /proc entry.

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch10260
M'XL(`)7=RSP``\V4;V_3,!#&7]>?XM2]8S3Q.;;S!P6MK`C0F*B**EX@A#S'
M;<*:9$K<EHWPW4G:K4,;93#Q`B=23I?3Z7GN?O(!3&M31;U5^<4:G9(#>%W6
M-NK9=;;(YJEUEGKMZ*LV/RG+-N^F96[<ZVKW[-S-$C-@CB!MQ5A9G<+*5'74
M0\?;9>SEA8EZDY>OIF^'$T+B&(Y35<S->V,ACHDMJY5:)/61LNFB+!Q;J:+.
MC56.+O-F5]HP2EG["/0]*F2#DG*_T9@@*HXFH8P'DI-K:4=W#-SMPUF`R'R!
M#><A"C("=(0,@3*7<I<%@%[DT4C(0\HB2F%/6SA$&%#R`OZMB6.B89@DH"#/
MZCHKYM"?CDZ'2&D?3&&K2\@*6":Y@D+E!JPZ6QB'G`#G01B2\>U\R>`O#R%4
M4?+\`3])E75K[I;O7F395T?_9(Q3;(U1CX7-3,Y0^\)3OD+I4[9OC'L;;M;4
M3HHW3`J!&WCNUSY,T6,%[\7IMX*9ST7#1"C]#5?,NX<5_P.L\+_!:CO[=S"H
MUINWQ63\BS4\`K81ME`@>;/]U%;93(-.505/NIZ?6RT?/T$,WZ!_^J&3*OM/
IMZ(][R:2NUQGY"9L_\/W9[?7DDZ-/J^7>8RS,!`^#<@/(UX\G/L$````
`
end

--SLDf9lqlvOQaIe6s--
