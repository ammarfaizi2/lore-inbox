Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTEZPgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 11:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTEZPgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 11:36:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25761 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261568AbTEZPf4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 11:35:56 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: alan@redhat.com
Subject: [PATCH] IDE: save ide boot parameters in __initdata structs
Date: Mon, 26 May 2003 17:49:06 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305261749.06112.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan, can you please check this one?
I really don't want to break ide boot parameters.

Incremental to "probe legacy chipsets in ide_init()" patch.
--
Bartlomiej

IDE: save ide boot parameters in __initdata structs.

Instead of applying boot parameters directly to hwifs/drives in ide_setup()
save them in temporary buffers and apply them later to real hwifs/drives
in ide_init(). I think I've covered all corner cases and there is no change
in functionality.

This change allows dynamic hwifs/drives allocation and killing init_ide_data().

 drivers/ide/ide.c |  230 +++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 168 insertions(+), 62 deletions(-)

diff -puN drivers/ide/ide.c~ide_setup_params drivers/ide/ide.c
--- linux-2.5.69-bk17/drivers/ide/ide.c~ide_setup_params	Mon May 26 13:38:12 2003
+++ linux-2.5.69-bk17-root/drivers/ide/ide.c	Mon May 26 15:59:38 2003
@@ -1722,6 +1722,111 @@ extern void init_qd65xx(void);
 
 static int __initdata is_chipset_set[MAX_HWIFS];
 
+typedef struct drive_params_s {
+	unsigned nobios		: 1;
+	unsigned noprobe	: 1;
+	unsigned present	: 1;
+	unsigned slow		: 1;
+	unsigned bswap		: 1;
+	unsigned nowerr		: 1;
+	unsigned remap_0_to_1	: 2;
+	unsigned forced_geom	: 1;
+	unsigned forced_lun	: 1;
+	unsigned scsi		: 1;
+	unsigned ata_flash	: 1;
+	unsigned autotune	: 3;
+	u8 media;
+	char driver_req[10];
+	int last_lun;
+	int head, sect, cyl;	/* valid iff forced_geom=1 */
+} drive_params_t;
+
+typedef struct hwif_params_s {
+	unsigned noprobe	: 1;
+	unsigned noprobe_valid	: 1;
+	unsigned four		: 1;
+	unsigned generic	: 1;
+	unsigned serialize	: 1;
+	unsigned reset		: 1;
+	unsigned autodma	: 1;
+	unsigned udma_four	: 1;
+	int base, ctl, irq;	/* valid iff generic=1 */
+	drive_params_t dp[MAX_DRIVES];
+} hwif_params_t;
+
+static __initdata hwif_params_t hwifs_params[MAX_HWIFS];
+
+static void __init drive_apply_params(ide_drive_t *drive, drive_params_t *dp)
+{
+	if (dp->nobios)
+		drive->nobios = 1;
+	if (dp->noprobe)
+		drive->noprobe = 1;
+	if (dp->present) {
+		drive->present = 1;
+		drive->media = dp->media;
+	}
+	if (dp->slow)
+		drive->slow = 1;
+	if (dp->bswap)
+		drive->bswap = 1;
+	if (dp->nowerr)
+		drive->bad_wstat = BAD_R_STAT;
+	if (dp->remap_0_to_1)
+		drive->remap_0_to_1 = dp->remap_0_to_1;
+	if (dp->forced_geom) {
+		drive->cyl = drive->bios_cyl = dp->cyl;
+		drive->head = drive->bios_head = dp->head;
+		drive->sect = drive->bios_sect = dp->sect;
+	}
+	if (dp->forced_lun)
+		drive->last_lun = dp->last_lun;
+	if (dp->scsi)
+		drive->scsi = 1;
+	if (dp->ata_flash)
+		drive->ata_flash = 1;
+	drive->autotune = dp->autotune;
+	if (dp->driver_req[0])
+		strncpy(drive->driver_req, dp->driver_req, 9);
+}
+
+static void __init hwif_apply_params(ide_hwif_t *hwif, hwif_params_t *hp)
+{
+	ide_hwif_t *mate = &ide_hwifs[hwif->index^1];
+	unsigned int i = 0;
+
+	if (hp->noprobe_valid)
+		hwif->noprobe = hp->noprobe;
+	if (hp->four) {
+		mate->drives[0].select.all ^= 0x20;
+		mate->drives[1].select.all ^= 0x20;
+		hwif->chipset = mate->chipset = ide_4drives;
+		mate->irq = hwif->irq;
+		memcpy(mate->io_ports, hwif->io_ports, sizeof(hwif->io_ports));
+	} else if (hp->generic) {
+		hwif->hw.irq = hp->irq;
+		ide_init_hwif_ports(&hwif->hw, (unsigned long) hp->base,
+				    (unsigned long) hp->ctl, &hwif->irq);
+		memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
+		hwif->irq = hp->irq;
+		hwif->chipset = ide_generic;
+	}
+	if (hp->serialize) {
+		hwif->mate = mate;
+		mate->mate = hwif;
+		hwif->serialized = hwif->mate->serialized = 1;
+	}
+	if (hp->reset)
+		hwif->reset = 1;
+	if (hp->autodma)
+		hwif->autodma = 1;
+	if (hp->udma_four)
+		hwif->udma_four = 1;
+
+	for (i = 0; i < MAX_DRIVES; i++)
+		drive_apply_params(&hwif->drives[i], &hp->dp[i]);
+}
+
 /*
  * ide_setup() gets called VERY EARLY during initialization,
  * to handle kernel "command line" strings beginning with "hdx="
@@ -1808,8 +1913,8 @@ static int __initdata is_chipset_set[MAX
 int __init ide_setup (char *s)
 {
 	int i, vals[3];
-	ide_hwif_t *hwif;
-	ide_drive_t *drive;
+	hwif_params_t *hp;
+	drive_params_t *dp;
 	unsigned int hw, unit;
 	const char max_drive = 'a' + ((MAX_HWIFS * MAX_DRIVES) - 1);
 	const char max_hwif  = '0' + (MAX_HWIFS - 1);
@@ -1862,10 +1967,10 @@ int __init ide_setup (char *s)
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
-		hwif = &ide_hwifs[hw];
-		drive = &hwif->drives[unit];
+		hp = &hwifs_params[hw];
+		dp = &hp->dp[unit];
 		if (strncmp(s + 4, "ide-", 4) == 0) {
-			strncpy(drive->driver_req, s + 4, 9);
+			strncpy(dp->driver_req, s+4, 9);
 			goto done;
 		}
 		/*
@@ -1875,71 +1980,75 @@ int __init ide_setup (char *s)
 			if (match_parm(&s[6], NULL, vals, 1) != 1)
 				goto bad_option;
 			if (vals[0] >= 0 && vals[0] <= 7) {
-				drive->last_lun = vals[0];
-				drive->forced_lun = 1;
+				dp->last_lun = vals[0];
+				dp->forced_lun = 1;
 			} else
 				printk(" -- BAD LAST LUN! Expected value from 0 to 7");
 			goto done;
 		}
 		switch (match_parm(&s[3], hd_words, vals, 3)) {
 			case -1: /* "none" */
-				drive->nobios = 1;  /* drop into "noprobe" */
+				dp->nobios = 1; /* drop into "noprobe" */
 			case -2: /* "noprobe" */
-				drive->noprobe = 1;
+				dp->noprobe = 1;
 				goto done;
 			case -3: /* "nowerr" */
-				drive->bad_wstat = BAD_R_STAT;
-				hwif->noprobe = 0;
+				dp->nowerr = 1;
+				hp->noprobe = 0;
+				hp->noprobe_valid = 1;
 				goto done;
 			case -4: /* "cdrom" */
-				drive->present = 1;
-				drive->media = ide_cdrom;
-				hwif->noprobe = 0;
+				dp->present = 1;
+				dp->media = ide_cdrom;
+				hp->noprobe = 0;
+				hp->noprobe_valid = 1;
 				goto done;
 			case -5: /* "serialize" */
 				printk(" -- USE \"ide%d=serialize\" INSTEAD", hw);
-				goto do_serialize;
+				hp->serialize = 1;
+				goto done;
 			case -6: /* "autotune" */
-				drive->autotune = IDE_TUNE_AUTO;
+				dp->autotune = IDE_TUNE_AUTO;
 				goto done;
 			case -7: /* "noautotune" */
-				drive->autotune = IDE_TUNE_NOAUTO;
+				dp->autotune = IDE_TUNE_NOAUTO;
 				goto done;
 			case -8: /* "slow" */
-				drive->slow = 1;
+				dp->slow = 1;
 				goto done;
 			case -9: /* "swapdata" or "bswap" */
 			case -10:
-				drive->bswap = 1;
+				dp->bswap = 1;
 				goto done;
 			case -11: /* "flash" */
-				drive->ata_flash = 1;
+				dp->ata_flash = 1;
 				goto done;
 			case -12: /* "remap" */
-				drive->remap_0_to_1 = 1;
+				dp->remap_0_to_1 = 1;
 				goto done;
 			case -13: /* "noremap" */
-				drive->remap_0_to_1 = 2;
+				dp->remap_0_to_1 = 2;
 				goto done;
 			case -14: /* "scsi" */
 #if defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI)
-				drive->scsi = 1;
+				dp->scsi = 1;
 				goto done;
 #else
-				drive->scsi = 0;
+				dp->scsi = 0;
 				goto bad_option;
 #endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
 			case -15: /* "biostimings" */
-				drive->autotune = IDE_TUNE_BIOS;
+				dp->autotune = IDE_TUNE_BIOS;
 				goto done;
 			case 3: /* cyl,head,sect */
-				drive->media	= ide_disk;
-				drive->cyl	= drive->bios_cyl  = vals[0];
-				drive->head	= drive->bios_head = vals[1];
-				drive->sect	= drive->bios_sect = vals[2];
-				drive->present	= 1;
-				drive->forced_geom = 1;
-				hwif->noprobe = 0;
+				dp->present = 1;
+				dp->media = ide_disk;
+				dp->forced_geom = 1;
+				dp->cyl = vals[0];
+				dp->head = vals[1];
+				dp->sect = vals[2];
+				hp->noprobe = 0;
+				hp->noprobe_valid = 1;
 				goto done;
 			default:
 				goto bad_option;
@@ -1974,7 +2083,7 @@ int __init ide_setup (char *s)
 			"minus10", "four", "qd65xx", "ht6560b", "cmd640_vlb",
 			"dtc2278", "umc8672", "ali14xx", "dc4030", NULL };
 		hw = s[3] - '0';
-		hwif = &ide_hwifs[hw];
+		hp = &hwifs_params[hw];
 		i = match_parm(&s[4], ide_words, vals, 3);
 
 		/*
@@ -2039,53 +2148,46 @@ int __init ide_setup (char *s)
 #ifdef CONFIG_BLK_DEV_4DRIVES
 			case -11: /* "four" drives on one set of ports */
 			{
-				ide_hwif_t *mate = &ide_hwifs[hw^1];
-				mate->drives[0].select.all ^= 0x20;
-				mate->drives[1].select.all ^= 0x20;
-				hwif->chipset = mate->chipset = ide_4drives;
-				mate->irq = hwif->irq;
-				memcpy(mate->io_ports, hwif->io_ports, sizeof(hwif->io_ports));
-				goto do_serialize;
+				hp->four;
+				hp->serialize;
+				goto done;
 			}
 #endif /* CONFIG_BLK_DEV_4DRIVES */
 			case -10: /* minus10 */
 			case -9: /* minus9 */
 				goto bad_option;
 			case -8: /* "biostimings" */
-				hwif->drives[0].autotune = IDE_TUNE_BIOS;
-				hwif->drives[1].autotune = IDE_TUNE_BIOS;
+				hp->dp[0].autotune = IDE_TUNE_BIOS;
+				hp->dp[1].autotune = IDE_TUNE_BIOS;
 				goto done;
 			case -7: /* ata66 */
 #ifdef CONFIG_BLK_DEV_IDEPCI
-				hwif->udma_four = 1;
+				hp->udma_four = 1;
 				goto done;
 #else /* !CONFIG_BLK_DEV_IDEPCI */
-				hwif->udma_four = 0;
+				hp->udma_four = 0;
 				goto bad_hwif;
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 			case -6: /* dma */
-				hwif->autodma = 1;
+				hp->autodma = 1;
 				goto done;
 			case -5: /* "reset" */
-				hwif->reset = 1;
+				hp->reset = 1;
 				goto done;
 			case -4: /* "noautotune" */
-				hwif->drives[0].autotune = IDE_TUNE_NOAUTO;
-				hwif->drives[1].autotune = IDE_TUNE_NOAUTO;
+				hp->dp[0].autotune = IDE_TUNE_NOAUTO;
+				hp->dp[1].autotune = IDE_TUNE_NOAUTO;
 				goto done;
 			case -3: /* "autotune" */
-				hwif->drives[0].autotune = IDE_TUNE_AUTO;
-				hwif->drives[1].autotune = IDE_TUNE_AUTO;
+				hp->dp[0].autotune = IDE_TUNE_AUTO;
+				hp->dp[1].autotune = IDE_TUNE_AUTO;
 				goto done;
 			case -2: /* "serialize" */
-			do_serialize:
-				hwif->mate = &ide_hwifs[hw^1];
-				hwif->mate->mate = hwif;
-				hwif->serialized = hwif->mate->serialized = 1;
+				hp->serialize = 1;
 				goto done;
-
 			case -1: /* "noprobe" */
-				hwif->noprobe = 1;
+				hp->noprobe = 1;
+				hp->noprobe_valid = 1;
 				goto done;
 
 			case 1:	/* base */
@@ -2093,12 +2195,12 @@ int __init ide_setup (char *s)
 			case 2: /* base,ctl */
 				vals[2] = 0;	/* default irq = probe for it */
 			case 3: /* base,ctl,irq */
-				hwif->hw.irq = vals[2];
-				ide_init_hwif_ports(&hwif->hw, (unsigned long) vals[0], (unsigned long) vals[1], &hwif->irq);
-				memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
-				hwif->irq      = vals[2];
-				hwif->noprobe  = 0;
-				hwif->chipset  = ide_generic;
+				hp->base = vals[0];
+				hp->ctl = vals[1];
+				hp->irq = vals[2];
+				hp->noprobe = 0;
+				hp->noprobe_valid = 1;
+				hp->generic = 1;
 				goto done;
 
 			case 0: goto bad_option;
@@ -2481,6 +2583,7 @@ struct bus_type ide_bus_type = {
  */
 int __init ide_init (void)
 {
+	unsigned int i;
 	static char banner_printed;
 	if (!banner_printed) {
 		printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
@@ -2493,6 +2596,9 @@ int __init ide_init (void)
 
 	init_ide_data();
 
+	for (i = 0; i < MAX_HWIFS; i++)
+		hwif_apply_params(&ide_hwifs[i], &hwifs_params[i]);
+
 #ifdef CONFIG_BLK_DEV_PDC4030
 	if (probe_pdc4030)
 		init_pdc4030();

_

