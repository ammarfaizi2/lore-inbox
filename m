Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265829AbSKAX5Q>; Fri, 1 Nov 2002 18:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265827AbSKAX5P>; Fri, 1 Nov 2002 18:57:15 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:47627 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S265826AbSKAX4g>; Fri, 1 Nov 2002 18:56:36 -0500
Date: Sat, 2 Nov 2002 01:02:19 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org;, marcelo@conectiva.com.br
Subject: [PATCH] IDE BIOS timings, autotune cleanup
Message-ID: <20021102000219.GM1669@tmathiasen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.20-pre11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The attached patch cleans up the 'autotune' concept used in the current 2.4
IDE driver. It also adds support for using pure BIOS IDE timings with DMA/PIO.
On some systems the BIOS has a far better overview on how things are connected
(some chipsets don't support >ata66 speed detection, etc).

The patch introduces 2 new boot parameters in addtion to the current two
autotune options (autotune vs. noautotune):

ide0=autotune		-> kernel IDE timing setup
ide0=noautotune		-> BIOS IDE timing setup (PIO only)
ide0=noautotune_dma 	-> BIOS IDE timing setup (DMA/PIO)
ide0=noautotune_force	-> BIOS IDE (DMA/PIO), chipset *cannot* override.

Default is autotune (as always) and chipsets can override the other options
unless *_force is used.

All chipset drivers updated. Tested with PIIX and Serverworks.

Regards,
Torben Mathiasen

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide_bios-2.4.20rc1-2.diff"

--- linux-2.4.20-rc1-clean/include/linux/ide.h	2002-11-01 14:30:08.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/include/linux/ide.h	2002-11-02 00:37:33.000000000 +0100
@@ -88,6 +88,14 @@
 #define ERROR_RECAL	1	/* Recalibrate every 2nd retry */
 
 /*
+ * Chipset autotune defines
+ */
+#define BIOS_IDE_ON_FORCED	4   /* BIOS IDE setup forced (DMA/PIO) */
+#define BIOS_IDE_ON_DMA 	3   /* BIOS IDE setup supporting DMA/PIO */
+#define BIOS_IDE_ON		2   /* BIOS IDE setup supporting PIO */
+#define BIOS_IDE_OFF		1   /* Let kernel tune IDE timings */
+#define BIOS_IDE_DEFAULT	BIOS_IDE_OFF
+/*
  * state flags
  */
 #define DMA_PIO_RETRY	1	/* retrying in PIO */
@@ -378,7 +386,7 @@
 	unsigned nice0		: 1;	/* flag: give obvious excess bandwidth */
 	unsigned nice2		: 1;	/* flag: give a share in our own bandwidth */
 	unsigned doorlocking	: 1;	/* flag: for removable only: door lock/unlock works */
-	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
+	unsigned autotune	: 4;	/* 1=autotune, 2=noautotune, 3=noautotune_dma, 4=noautotune_force */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned	addressing;	/* : 2; 0=28-bit, 1=48-bit, 2=64-bit */
diff -u linux-2.4.20-rc1-clean/drivers/ide/aec62xx.c linux-2.4.20-rc1-idepatch/drivers/ide/aec62xx.c
--- linux-2.4.20-rc1-clean/drivers/ide/aec62xx.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/aec62xx.c	2002-11-02 00:36:37.000000000 +0100
@@ -558,8 +558,8 @@
 	if (hwif->dma_base)
 		hwif->dmaproc = &aec62xx_dmaproc;
 #else /* !CONFIG_BLK_DEV_IDEDMA */
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = BIOS_IDE_OFF;
+	hwif->drives[1].autotune = BIOS_IDE_OFF;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 #endif /* CONFIG_AEC62XX_TUNING */
 }
diff -u linux-2.4.20-rc1-clean/drivers/ide/alim15x3.c linux-2.4.20-rc1-idepatch/drivers/ide/alim15x3.c
--- linux-2.4.20-rc1-clean/drivers/ide/alim15x3.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/alim15x3.c	2002-11-02 00:36:37.000000000 +0100
@@ -676,8 +676,8 @@
 #endif /* CONFIG_SPARC64 */
 
 	hwif->tuneproc = &ali15x3_tune_drive;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = BIOS_IDE_OFF;
+	hwif->drives[1].autotune = BIOS_IDE_OFF;
 	hwif->speedproc = &ali15x3_tune_chipset;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
diff -u linux-2.4.20-rc1-clean/drivers/ide/amd74xx.c linux-2.4.20-rc1-idepatch/drivers/ide/amd74xx.c
--- linux-2.4.20-rc1-clean/drivers/ide/amd74xx.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/amd74xx.c	2002-11-02 00:36:37.000000000 +0100
@@ -489,8 +489,8 @@
 	hwif->speedproc = &amd74xx_tune_chipset;
 
 #ifndef CONFIG_BLK_DEV_IDEDMA
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = BIOS_IDE_OFF;
+	hwif->drives[1].autotune = BIOS_IDE_OFF;
 	hwif->autodma = 0;
 	return;
 #else
@@ -501,8 +501,8 @@
 			hwif->autodma = 1;
 	} else {
 		hwif->autodma = 0;
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+		hwif->drives[0].autotune = BIOS_IDE_OFF;
+		hwif->drives[1].autotune = BIOS_IDE_OFF;
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
diff -u linux-2.4.20-rc1-clean/drivers/ide/cmd640.c linux-2.4.20-rc1-idepatch/drivers/ide/cmd640.c
--- linux-2.4.20-rc1-clean/drivers/ide/cmd640.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/cmd640.c	2002-11-02 00:36:37.000000000 +0100
@@ -816,7 +816,7 @@
 	for (index = 0; index < (2 + (second_port_cmd640 << 1)); index++) {
 		ide_drive_t *drive = cmd_drives[index];
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-		if (drive->autotune || ((index > 1) && second_port_toggled)) {
+		if ((drive->autotune == BIOS_IDE_OFF) || ((index > 1) && second_port_toggled)) {
 	 		/*
 	 		 * Reset timing to the slowest speed and turn off prefetch.
 			 * This way, the drive identify code has a better chance.
diff -u linux-2.4.20-rc1-clean/drivers/ide/cmd64x.c linux-2.4.20-rc1-idepatch/drivers/ide/cmd64x.c
--- linux-2.4.20-rc1-clean/drivers/ide/cmd64x.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/cmd64x.c	2002-11-02 00:36:37.000000000 +0100
@@ -1124,8 +1124,8 @@
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = BIOS_IDE_OFF;
+	hwif->drives[1].autotune = BIOS_IDE_OFF;
 
 	if (!hwif->dma_base)
 		return;
diff -u linux-2.4.20-rc1-clean/drivers/ide/cs5530.c linux-2.4.20-rc1-idepatch/drivers/ide/cs5530.c
--- linux-2.4.20-rc1-clean/drivers/ide/cs5530.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/cs5530.c	2002-11-02 00:36:37.000000000 +0100
@@ -363,12 +363,12 @@
 		if (CS5530_BAD_PIO(d0_timings)) {	/* PIO timings not initialized? */
 			outl(cs5530_pio_timings[(d0_timings>>31)&1][0], basereg+0);
 			if (!hwif->drives[0].autotune)
-				hwif->drives[0].autotune = 1;	/* needs autotuning later */
+				hwif->drives[0].autotune = BIOS_IDE_OFF;    /* needs autotuning later */
 		}
 		if (CS5530_BAD_PIO(inl(basereg+8))) {	/* PIO timings not initialized? */
 			outl(cs5530_pio_timings[(d0_timings>>31)&1][0], basereg+8);
 			if (!hwif->drives[1].autotune)
-				hwif->drives[1].autotune = 1;	/* needs autotuning later */
+				hwif->drives[1].autotune = BIOS_IDE_OFF;	/* needs autotuning later */
 		}
 	}
 }
diff -u linux-2.4.20-rc1-clean/drivers/ide/cy82c693.c linux-2.4.20-rc1-idepatch/drivers/ide/cy82c693.c
--- linux-2.4.20-rc1-clean/drivers/ide/cy82c693.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/cy82c693.c	2002-11-02 00:36:37.000000000 +0100
@@ -435,8 +435,8 @@
 {
 	hwif->chipset = ide_cy82c693;
 	hwif->tuneproc = &cy82c693_tune_drive;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = BIOS_IDE_OFF;
+	hwif->drives[1].autotune = BIOS_IDE_OFF;
 	hwif->autodma = 0;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
diff -u linux-2.4.20-rc1-clean/drivers/ide/hpt34x.c linux-2.4.20-rc1-idepatch/drivers/ide/hpt34x.c
--- linux-2.4.20-rc1-clean/drivers/ide/hpt34x.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/hpt34x.c	2002-11-02 00:36:37.000000000 +0100
@@ -426,12 +426,12 @@
 
 		hwif->dmaproc = &hpt34x_dmaproc;
 	} else {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+		hwif->drives[0].autotune = BIOS_IDE_OFF;
+		hwif->drives[1].autotune = BIOS_IDE_OFF;
 	}
 #else /* !CONFIG_BLK_DEV_IDEDMA */
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = BIOS_IDE_OFF;
+	hwif->drives[1].autotune = BIOS_IDE_OFF;
 	hwif->autodma = 0;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
diff -u linux-2.4.20-rc1-clean/drivers/ide/hpt366.c linux-2.4.20-rc1-idepatch/drivers/ide/hpt366.c
--- linux-2.4.20-rc1-clean/drivers/ide/hpt366.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/hpt366.c	2002-11-02 00:36:37.000000000 +0100
@@ -1198,12 +1198,12 @@
 			hwif->autodma = 0;
 	} else {
 		hwif->autodma = 0;
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+		hwif->drives[0].autotune = BIOS_IDE_OFF;
+		hwif->drives[1].autotune = BIOS_IDE_OFF;
 	}
 #else /* !CONFIG_BLK_DEV_IDEDMA */
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = BIOS_IDE_OFF;
+	hwif->drives[1].autotune = BIOS_IDE_OFF;
 	hwif->autodma = 0;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
diff -u linux-2.4.20-rc1-clean/drivers/ide/ide-dma.c linux-2.4.20-rc1-idepatch/drivers/ide/ide-dma.c
--- linux-2.4.20-rc1-clean/drivers/ide/ide-dma.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/ide-dma.c	2002-11-02 00:36:37.000000000 +0100
@@ -814,9 +814,22 @@
 
 	if (hwif->chipset != ide_trm290) {
 		byte dma_stat = inb(dma_base+2);
-		printk(", BIOS settings: %s:%s, %s:%s",
-		       hwif->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
-		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
+		
+		printk(", BIOS settings: %s:%s%s, %s:%s%s",
+			hwif->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
+			hwif->drives[0].autotune == BIOS_IDE_ON_FORCED 
+				? " (forced)" : "",
+            		hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio",
+			hwif->drives[1].autotune == BIOS_IDE_ON_FORCED ? 
+				" (forced)" : "");
+	
+	/* If BIOS_IDE_ON_DMA or BIOS_IDE_ON_FORCED is set we just check 
+	 * whether DMA was enabled by the BIOS or not.
+	 */
+        if (hwif->drives[0].autotune >= BIOS_IDE_ON_DMA)
+		hwif->drives[0].using_dma = (dma_stat & 0x20);
+        if (hwif->drives[1].autotune >= BIOS_IDE_ON_DMA)
+		hwif->drives[1].using_dma = (dma_stat & 0x40);
 	}
 	printk("\n");
 	return;
diff -u linux-2.4.20-rc1-clean/drivers/ide/ide-pci.c linux-2.4.20-rc1-idepatch/drivers/ide/ide-pci.c
--- linux-2.4.20-rc1-clean/drivers/ide/ide-pci.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/ide-pci.c	2002-11-02 00:36:37.000000000 +0100
@@ -611,6 +611,7 @@
 	ide_hwif_t *hwif, *mate = NULL;
 	unsigned int class_rev;
 	static int secondpdc = 0;
+    int drive0_tune = 0, drive1_tune = 0;
 
 #ifdef CONFIG_IDEDMA_AUTO
 	if (!noautodma)
@@ -859,8 +860,19 @@
 bypass_legacy_dma:
 bypass_piix_dma:
 bypass_umc_dma:
+        /* Record drive tune value as some chipset will try to override */
+        drive0_tune = hwif->drives[0].autotune;
+        drive1_tune = hwif->drives[1].autotune;
+        
 		if (d->init_hwif)  /* Call chipset-specific routine for each enabled hwif */
 			d->init_hwif(hwif);
+        
+        if (drive0_tune == BIOS_IDE_ON_FORCED) /* drive 0 forced BIOS settings */
+            hwif->drives[0].autotune = drive0_tune;
+
+        if (drive1_tune == BIOS_IDE_ON_FORCED) /* drive 1 forced BIOS settings */
+            hwif->drives[1].autotune = drive1_tune;
+
 		mate = hwif;
 		at_least_one_hwif_enabled = 1;
 	}
diff -u linux-2.4.20-rc1-clean/drivers/ide/ide-probe.c linux-2.4.20-rc1-idepatch/drivers/ide/ide-probe.c
--- linux-2.4.20-rc1-clean/drivers/ide/ide-probe.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/ide-probe.c	2002-11-02 00:36:37.000000000 +0100
@@ -340,7 +340,8 @@
 	{
 		if ((rc = try_to_identify(drive,cmd)))   /* send cmd and wait */
 			rc = try_to_identify(drive,cmd); /* failed: try again */
-		if (rc == 1 && cmd == WIN_PIDENTIFY && drive->autotune != 2) {
+		if (rc == 1 && cmd == WIN_PIDENTIFY && 
+                drive->autotune <= BIOS_IDE_OFF)  {
 			unsigned long timeout;
 			printk("%s: no response (status = 0x%02x), resetting drive\n", drive->name, GET_STAT());
 			ide_delay_50ms();
@@ -565,7 +566,7 @@
 		ide_drive_t *drive = &hwif->drives[unit];
 		if (drive->present) {
 			ide_tuneproc_t *tuneproc = HWIF(drive)->tuneproc;
-			if (tuneproc != NULL && drive->autotune == 1)
+			if (tuneproc != NULL && drive->autotune == BIOS_IDE_OFF)
 				tuneproc(drive, 255);	/* auto-tune PIO mode */
 		}
 	}
diff -u linux-2.4.20-rc1-clean/drivers/ide/ide.c linux-2.4.20-rc1-idepatch/drivers/ide/ide.c
--- linux-2.4.20-rc1-clean/drivers/ide/ide.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/ide.c	2002-11-02 00:36:37.000000000 +0100
@@ -279,6 +279,7 @@
 		drive->name[1]			= 'd';
 		drive->name[2]			= 'a' + (index * MAX_DRIVES) + unit;
 		drive->max_failures		= IDE_DEFAULT_MAX_FAILURES;
+		drive->autotune			= BIOS_IDE_DEFAULT; 
 		init_waitqueue_head(&drive->wqueue);
 	}
 }
@@ -3196,10 +3197,20 @@
  *				Not fully supported by all chipset types,
  *				and quite likely to cause trouble with
  *				older/odd IDE drives.
- *
+ * "hdx=noautotune"	: driver will NOT attempt to tune interface speed.
+ * 				This mode supports PIO only.
+ *				This is the default for most chipsets,
+ *				except the cmd640.
+ * "hdx=noautotune_dma	: driver will NOT attempt to tune interface speed, 
+ * 				but always use BIOS settings. This mode
+ * 				supports DMA/PIO. Chipset drivers may 
+ * 				override this option.
+ * "hdx=noautotune_force: driver will NOT attempt to tune interface speed,
+ * 				but always use BIOS settings. This mode
+ * 				supports DMA/PIO. Chipset drivers may NOT 
+ * 				override this option.
  * "hdx=slow"		: insert a huge pause after each access to the data
  *				port. Should be used only as a last resort.
- *
  * "hdx=swapdata"	: when the drive is a disk, byte swap all data
  * "hdx=bswap"		: same as above..........
  * "hdxlun=xx"          : set the drive last logical unit.
@@ -3230,9 +3241,18 @@
  *				Not fully supported by all chipset types,
  *				and quite likely to cause trouble with
  *				older/odd IDE drives.
- * "idex=noautotune"	: driver will NOT attempt to tune interface speed
+ * "idex=noautotune"	: driver will NOT attempt to tune interface speed.
+ * 				This mode supports PIO only.
  *				This is the default for most chipsets,
  *				except the cmd640.
+ * "hdx=noautotune_dma	: driver will NOT attempt to tune interface speed, 
+ * 				but always use BIOS settings. This mode
+ * 				supports DMA/PIO. Chipset drivers may 
+ * 				override this option.
+ * "hdx=noautotune_force: driver will NOT attempt to tune interface speed,
+ * 				but always use BIOS settings. This mode
+ * 				supports DMA/PIO. Chipset drivers may NOT 
+ * 				override this option.
  * "idex=serialize"	: do not overlap operations on idex and ide(x^1)
  * "idex=four"		: four drives on idex and ide(x^1) share same ports
  * "idex=reset"		: reset interface before first use
@@ -3308,7 +3328,9 @@
 		const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
 				"serialize", "autotune", "noautotune",
 				"slow", "swapdata", "bswap", "flash",
-				"remap", "noremap", "scsi", NULL};
+				"remap", "noremap", "scsi", "noautotune_dma", 
+				"noautotune_force", NULL};
+
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
@@ -3350,10 +3372,10 @@
 				printk(" -- USE \"ide%d=serialize\" INSTEAD", hw);
 				goto do_serialize;
 			case -6: /* "autotune" */
-				drive->autotune = 1;
+				drive->autotune = BIOS_IDE_OFF;
 				goto done;
 			case -7: /* "noautotune" */
-				drive->autotune = 2;
+				drive->autotune = BIOS_IDE_ON;
 				goto done;
 			case -8: /* "slow" */
 				drive->slow = 1;
@@ -3388,6 +3410,12 @@
 				drive->forced_geom = 1;
 				hwif->noprobe = 0;
 				goto done;
+			case -15: /* "noautotune_dma" */
+				drive->autotune = BIOS_IDE_ON_DMA;
+				goto done;
+			case -16: /* "noautotune_force" */
+				drive->autotune = BIOS_IDE_ON_FORCED;
+                goto done;
 			default:
 				goto bad_option;
 		}
@@ -3417,7 +3445,7 @@
 		 */
 		const char *ide_words[] = {
 			"noprobe", "serialize", "autotune", "noautotune", "reset", "dma", "ata66",
-			"minus8", "minus9", "minus10",
+			"noautotune_dma", "noautotune_force", "minus10",
 			"four", "qd65xx", "ht6560b", "cmd640_vlb", "dtc2278", "umc8672", "ali14xx", "dc4030", "nohighio", NULL };
 		hw = s[3] - '0';
 		hwif = &ide_hwifs[hw];
@@ -3510,9 +3538,14 @@
 			}
 #endif /* CONFIG_BLK_DEV_4DRIVES */
 			case -10: /* minus10 */
-			case -9: /* minus9 */
-			case -8: /* minus8 */
-				goto bad_option;
+			case -9: /* "noautotune_force */
+				hwif->drives[0].autotune = BIOS_IDE_ON_FORCED;
+				hwif->drives[1].autotune = BIOS_IDE_ON_FORCED;
+				goto done;
+			case -8: /* "noautotune_dma" */
+				hwif->drives[0].autotune = BIOS_IDE_ON_DMA;
+				hwif->drives[1].autotune = BIOS_IDE_ON_DMA;
+				goto done;
 			case -7: /* ata66 */
 #ifdef CONFIG_BLK_DEV_IDEPCI
 				hwif->udma_four = 1;
@@ -3528,12 +3561,12 @@
 				hwif->reset = 1;
 				goto done;
 			case -4: /* "noautotune" */
-				hwif->drives[0].autotune = 2;
-				hwif->drives[1].autotune = 2;
+				hwif->drives[0].autotune = BIOS_IDE_ON;
+				hwif->drives[1].autotune = BIOS_IDE_ON;
 				goto done;
 			case -3: /* "autotune" */
-				hwif->drives[0].autotune = 1;
-				hwif->drives[1].autotune = 1;
+				hwif->drives[0].autotune = BIOS_IDE_OFF;
+				hwif->drives[1].autotune = BIOS_IDE_OFF;
 				goto done;
 			case -2: /* "serialize" */
 			do_serialize:
@@ -3854,7 +3887,13 @@
 	drive->driver = driver;
 	setup_driver_defaults(drive);
 	restore_flags(flags);		/* all CPUs */
-	if (drive->autotune != 2) {
+
+	/* If user has requested BIOS IDE timings we skip DMA setup and instead
+	 * just probe the chipset later whether DMA was turned on/off by the
+	 * BIOS. Some chipsets may override the BIOS_IDE_ON flag but never the
+	 * BIOS_IDE_FORCED flag set by the 'biostimings' boot parameter.
+	 */
+	if (drive->autotune <= BIOS_IDE_OFF) {	/* Autotune */
 		if (driver->supports_dma && HWIF(drive)->dmaproc != NULL) {
 			/*
 			 * Force DMAing for the beginning of the check.
@@ -3868,6 +3907,7 @@
 		drive->dsc_overlap = (drive->next != drive && driver->supports_dsc_overlap);
 		drive->nice1 = 1;
 	}
+	
 	drive->revalidate = 1;
 	drive->suspend_reset = 0;
 #ifdef CONFIG_PROC_FS
diff -u linux-2.4.20-rc1-clean/drivers/ide/it8172.c linux-2.4.20-rc1-idepatch/drivers/ide/it8172.c
--- linux-2.4.20-rc1-clean/drivers/ide/it8172.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/it8172.c	2002-11-02 00:36:37.000000000 +0100
@@ -261,8 +261,8 @@
     unsigned long cmdBase, ctrlBase;
     
     hwif->tuneproc = &it8172_tune_drive;
-    hwif->drives[0].autotune = 1;
-    hwif->drives[1].autotune = 1;
+    hwif->drives[0].autotune = BIOS_IDE_OFF;
+    hwif->drives[1].autotune = BIOS_IDE_OFF;
 
     if (!hwif->dma_base)
 	return;
diff -u linux-2.4.20-rc1-clean/drivers/ide/pdc202xx.c linux-2.4.20-rc1-idepatch/drivers/ide/pdc202xx.c
--- linux-2.4.20-rc1-clean/drivers/ide/pdc202xx.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/pdc202xx.c	2002-11-02 00:36:37.000000000 +0100
@@ -1176,13 +1176,13 @@
 		if (!noautodma)
 			hwif->autodma = 1;
 	} else {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+		hwif->drives[0].autotune = BIOS_IDE_OFF;
+		hwif->drives[1].autotune = BIOS_IDE_OFF;
 		hwif->autodma = 0;
 	}
 #else /* !CONFIG_BLK_DEV_IDEDMA */
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = BIOS_IDE_OFF;
+	hwif->drives[1].autotune = BIOS_IDE_OFF;
 	hwif->autodma = 0;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
diff -u linux-2.4.20-rc1-clean/drivers/ide/piix.c linux-2.4.20-rc1-idepatch/drivers/ide/piix.c
--- linux-2.4.20-rc1-clean/drivers/ide/piix.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/piix.c	2002-11-02 00:36:37.000000000 +0100
@@ -521,11 +521,11 @@
 		/* This is a painful system best to let it self tune for now */
 		return;
 	}
-
-	hwif->tuneproc = &piix_tune_drive;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
+    
+    hwif->tuneproc = &piix_tune_drive;
+    hwif->drives[0].autotune = BIOS_IDE_OFF;
+    hwif->drives[1].autotune = BIOS_IDE_OFF;
+	
 	if (!hwif->dma_base)
 		return;
 
diff -u linux-2.4.20-rc1-clean/drivers/ide/serverworks.c linux-2.4.20-rc1-idepatch/drivers/ide/serverworks.c
--- linux-2.4.20-rc1-clean/drivers/ide/serverworks.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/serverworks.c	2002-11-02 00:36:37.000000000 +0100
@@ -656,8 +656,8 @@
 	hwif->speedproc = &svwks_tune_chipset;
 
 #ifndef CONFIG_BLK_DEV_IDEDMA
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = BIOS_IDE_OFF;
+	hwif->drives[1].autotune = BIOS_IDE_OFF;
 	hwif->autodma = 0;
 #else /* CONFIG_BLK_DEV_IDEDMA */
 	if (hwif->dma_base) {
@@ -668,8 +668,8 @@
 		hwif->dmaproc = &svwks_dmaproc;
 	} else {
 		hwif->autodma = 0;
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+		hwif->drives[0].autotune = BIOS_IDE_OFF;
+		hwif->drives[1].autotune = BIOS_IDE_OFF;
 	}
 #endif /* !CONFIG_BLK_DEV_IDEDMA */
 }
diff -u linux-2.4.20-rc1-clean/drivers/ide/sl82c105.c linux-2.4.20-rc1-idepatch/drivers/ide/sl82c105.c
--- linux-2.4.20-rc1-clean/drivers/ide/sl82c105.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/sl82c105.c	2002-11-02 00:36:37.000000000 +0100
@@ -247,8 +247,8 @@
 	rev = sl82c105_bridge_revision(hwif->pci_dev);
 	if (rev <= 5) {
 		hwif->autodma = 0;
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+		hwif->drives[0].autotune = BIOS_IDE_OFF;
+		hwif->drives[1].autotune = BIOS_IDE_OFF;
 		printk("    %s: Winbond 553 bridge revision %d, BM-DMA disabled\n",
 		       hwif->name, rev);
 		dma_state &= ~0x60;
diff -u linux-2.4.20-rc1-clean/drivers/ide/slc90e66.c linux-2.4.20-rc1-idepatch/drivers/ide/slc90e66.c
--- linux-2.4.20-rc1-clean/drivers/ide/slc90e66.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/slc90e66.c	2002-11-02 00:36:37.000000000 +0100
@@ -380,8 +380,8 @@
 		hwif->irq = hwif->channel ? 15 : 14;
 
 	hwif->tuneproc = &slc90e66_tune_drive;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = BIOS_IDE_OFF;
+	hwif->drives[1].autotune = BIOS_IDE_OFF;
 
 	if (!hwif->dma_base)
 		return;
diff -u linux-2.4.20-rc1-clean/drivers/ide/via82cxxx.c linux-2.4.20-rc1-idepatch/drivers/ide/via82cxxx.c
--- linux-2.4.20-rc1-clean/drivers/ide/via82cxxx.c	2002-11-01 14:29:28.000000000 +0100
+++ linux-2.4.20-rc1-idepatch/drivers/ide/via82cxxx.c	2002-11-02 00:36:37.000000000 +0100
@@ -539,7 +539,7 @@
 	for (i = 0; i < 2; i++) {
 		hwif->drives[i].io_32bit = 1;
 		hwif->drives[i].unmask = (via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
-		hwif->drives[i].autotune = 1;
+		hwif->drives[i].autotune = BIOS_IDE_OFF;
 		hwif->drives[i].dn = hwif->channel * 2 + i;
 	}
 

--LZvS9be/3tNcYl/X--
