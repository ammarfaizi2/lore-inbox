Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUD3Qph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUD3Qph (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUD3Qph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:45:37 -0400
Received: from bern.wildisoft.net ([66.80.62.108]:14867 "EHLO
	bern.wildisoft.net") by vger.kernel.org with ESMTP id S264727AbUD3Qoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:44:44 -0400
Date: Fri, 30 Apr 2004 09:44:53 -0700 (PDT)
From: Patrick Wildi <patrick@wildi.com>
X-X-Sender: patrick@bern.wildisoft.net
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [RFC][PATCH] 2.4 IDE Serverworks OSB4 DMA patch
In-Reply-To: <200404300037.10054.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.58.0404300940490.23611@bern.wildisoft.net>
References: <Pine.LNX.4.58.0404291130420.19527@bern.wildisoft.net>
 <200404292132.26039.bzolnier@elka.pw.edu.pl> <Pine.LNX.4.58.0404291455480.13881@bern.wildisoft.net>
 <200404300037.10054.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Bartlomiej Zolnierkiewicz wrote:
> On Friday 30 of April 2004 00:09, Patrick Wildi wrote:
> > On Thu, 29 Apr 2004, Bartlomiej Zolnierkiewicz wrote:
> > > On Thursday 29 of April 2004 21:04, Patrick Wildi wrote:
> > > > I have been using a OSB4 chipset based system with a CompactFlash
> > > > that supports PIO only and a laptop IBM/Hitachi Travelstar HDD
> > > > that supports UDMA.
> > > > For both drives, the serverworks code misconfigures the drives:
> > > >
> > > > - for the CF (hooked up as /dev/hda), svwks_config_drive_xfer_rate()
> > > >   will not match any tests (drive->autodma = 0, id->capability = 2,
> > > >   id->field_valid = 1), but the function will then call
> > > >   hwif->ide_dma_on(drive), which it should not do for this drive.
> > > >   This patch moves the enabling of DMA up into the DMA section of
> > > >   the code.
> > >
> > > Yep, known bug, it is fixed in 2.6.
> > >
> > > It is present in many other drivers, my 2.6 patch needs to be backported.
> >
> > Are you the maintainer for 2.4 or to whom should I send the changes?
>
> Send them to me.
>
> > > > - for the Travelstart HDD, the settings coming into
> > > >   svwks_config_drive_xfer_rate() are: drive->autodma = 32,
> > > >   id->capability = 15, id->field_valid = 7, id->dma_ultra = 0x43f.
> > > >   But as this is an OSB4, the hwif->ultra_mask is set to not support
> > > >   UDMA. Unfortunately in that case svwks_config_drive_xfer_rate()
> > > >   falls through to the end of the function, instead of trying
> > > >   other DMA modes.
> > >
> > > Good catch.
> > >
> > > It seems the same bug can be present in other drivers too (hint, hint).
> > > ;)
> >
> > I noticed that the piix driver uses the exact same logic. I could
> > replicate this part of the patch for other 2.4 drivers. I have no
> > way of testing them.
> > I can send you a combined patch for 2.4. I am not yet using 2.6.
>
> No problem. :)

Below is the 2.4 patch. I believe I updated all drivers that use
similar code.

Patrick


> Thanks!
> Bartlomiej

diff -u linux-2.4.26/drivers/ide/pci/aec62xx.c linux-2.4.26-pat/drivers/ide/pci/aec62xx.c
--- linux-2.4.26/drivers/ide/pci/aec62xx.c	2003-06-19 12:37:40.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/aec62xx.c	2004-04-29 17:33:08.000000000 -0700
@@ -339,7 +339,9 @@
 				int dma = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -356,13 +358,14 @@
 		} else {
 			goto fast_ata_pio;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
 		aec62xx_tune_drive(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 static int aec62xx_irq_timeout (ide_drive_t *drive)
diff -u linux-2.4.26/drivers/ide/pci/alim15x3.c linux-2.4.26-pat/drivers/ide/pci/alim15x3.c
--- linux-2.4.26/drivers/ide/pci/alim15x3.c	2003-08-26 13:51:43.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/alim15x3.c	2004-04-29 17:05:41.000000000 -0700
@@ -539,7 +539,9 @@
 				int dma = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -556,11 +558,12 @@
 		} else {
 			goto no_dma_set;
 		}
+		return hwif->ide_dma_on(drive);
 	} else {
 no_dma_set:
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 /**
diff -u linux-2.4.26/drivers/ide/pci/atiixp.c linux-2.4.26-pat/drivers/ide/pci/atiixp.c
--- linux-2.4.26/drivers/ide/pci/atiixp.c	2004-04-29 16:08:20.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/atiixp.c	2004-04-29 17:06:08.000000000 -0700
@@ -374,7 +374,9 @@
 				if ((id->field_valid & 2) &&
 				    (!atiixp_config_drive_for_dma(drive)))
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
diff -u linux-2.4.26/drivers/ide/pci/cmd64x.c linux-2.4.26-pat/drivers/ide/pci/cmd64x.c
--- linux-2.4.26/drivers/ide/pci/cmd64x.c	2003-06-19 12:37:40.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/cmd64x.c	2004-04-29 17:07:06.000000000 -0700
@@ -468,7 +468,9 @@
 				int dma = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -485,13 +487,14 @@
 		} else {
 			goto fast_ata_pio;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
 		config_chipset_for_pio(drive, 1);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 static int cmd64x_alt_dma_status (struct pci_dev *dev)
diff -u linux-2.4.26/drivers/ide/pci/hpt34x.c linux-2.4.26-pat/drivers/ide/pci/hpt34x.c
--- linux-2.4.26/drivers/ide/pci/hpt34x.c	2003-06-19 12:37:40.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/hpt34x.c	2004-04-29 17:08:00.000000000 -0700
@@ -199,7 +199,9 @@
 				int dma = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -216,6 +218,10 @@
 		} else {
 			goto fast_ata_pio;
 		}
+#ifndef CONFIG_HPT34X_AUTODMA
+		return hwif->ide_dma_off_quietly(drive);
+#endif /* CONFIG_HPT34X_AUTODMA */
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
@@ -223,10 +229,7 @@
 		return hwif->ide_dma_off_quietly(drive);
 	}

-#ifndef CONFIG_HPT34X_AUTODMA
-	return hwif->ide_dma_off_quietly(drive);
-#endif /* CONFIG_HPT34X_AUTODMA */
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 /*
diff -u linux-2.4.26/drivers/ide/pci/hpt366.c linux-2.4.26-pat/drivers/ide/pci/hpt366.c
--- linux-2.4.26/drivers/ide/pci/hpt366.c	2004-04-29 16:08:20.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/hpt366.c	2004-04-29 17:08:37.000000000 -0700
@@ -551,7 +551,9 @@
 				int dma = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if (id->dma_mword & hwif->mwdma_mask) {
@@ -567,13 +569,14 @@
 		} else {
 			goto fast_ata_pio;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
 		hpt3xx_tune_drive(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 /*
diff -u linux-2.4.26/drivers/ide/pci/it8172.c linux-2.4.26-pat/drivers/ide/pci/it8172.c
--- linux-2.4.26/drivers/ide/pci/it8172.c	2003-06-19 12:37:40.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/it8172.c	2004-04-29 17:09:26.000000000 -0700
@@ -211,7 +211,9 @@
 				int dma = it8172_config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -228,13 +230,14 @@
 		} else {
 			goto fast_ata_pio;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
 		it8172_tune_drive(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 static unsigned int __init init_chipset_it8172 (struct pci_dev *dev, const char *name)
diff -u linux-2.4.26/drivers/ide/pci/pdc202xx_new.c linux-2.4.26-pat/drivers/ide/pci/pdc202xx_new.c
--- linux-2.4.26/drivers/ide/pci/pdc202xx_new.c	2003-06-19 12:37:40.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/pdc202xx_new.c	2004-04-29 16:21:30.000000000 -0700
@@ -397,7 +397,9 @@
 				int dma = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -415,13 +417,14 @@
 		} else {
 			goto fast_ata_pio;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
 		hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 static int pdcnew_quirkproc (ide_drive_t *drive)
diff -u linux-2.4.26/drivers/ide/pci/pdc202xx_old.c linux-2.4.26-pat/drivers/ide/pci/pdc202xx_old.c
--- linux-2.4.26/drivers/ide/pci/pdc202xx_old.c	2003-12-04 15:52:57.000000000 -0800
+++ linux-2.4.26-pat/drivers/ide/pci/pdc202xx_old.c	2004-04-29 17:10:14.000000000 -0700
@@ -498,7 +498,9 @@
 				int dma = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -516,13 +518,14 @@
 		} else {
 			goto fast_ata_pio;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
 		hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 static int pdc202xx_quirkproc (ide_drive_t *drive)
diff -u linux-2.4.26/drivers/ide/pci/piix.c linux-2.4.26-pat/drivers/ide/pci/piix.c
--- linux-2.4.26/drivers/ide/pci/piix.c	2004-04-29 16:08:20.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/piix.c	2004-04-29 16:23:13.000000000 -0700
@@ -576,7 +576,9 @@
 				if ((id->field_valid & 2) &&
 				    (!piix_config_drive_for_dma(drive)))
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -593,13 +595,14 @@
 		} else {
 			goto fast_ata_pio;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
 		hwif->tuneproc(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 /**
diff -u linux-2.4.26/drivers/ide/pci/serverworks.c linux-2.4.26-pat/drivers/ide/pci/serverworks.c
--- linux-2.4.26/drivers/ide/pci/serverworks.c	2003-12-04 15:52:57.000000000 -0800
+++ linux-2.4.26-pat/drivers/ide/pci/serverworks.c	2004-04-29 16:08:57.000000000 -0700
@@ -473,7 +473,9 @@
 				int dma = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -490,6 +492,7 @@
 		} else {
 			goto no_dma_set;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
@@ -497,7 +500,7 @@
 		//	hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 /* This can go soon */
diff -u linux-2.4.26/drivers/ide/pci/siimage.c linux-2.4.26-pat/drivers/ide/pci/siimage.c
--- linux-2.4.26/drivers/ide/pci/siimage.c	2004-04-29 16:08:20.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/siimage.c	2004-04-29 17:10:53.000000000 -0700
@@ -499,7 +499,9 @@
 				int dma = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -516,13 +518,14 @@
 		} else {
 			goto fast_ata_pio;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
 		config_chipset_for_pio(drive, 1);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 /* returns 1 if dma irq issued, 0 otherwise */
diff -u linux-2.4.26/drivers/ide/pci/sis5513.c linux-2.4.26-pat/drivers/ide/pci/sis5513.c
--- linux-2.4.26/drivers/ide/pci/sis5513.c	2003-08-26 13:51:43.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/sis5513.c	2004-04-29 16:25:07.000000000 -0700
@@ -680,7 +680,9 @@
 				int dma = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -697,13 +699,14 @@
 		} else {
 			goto fast_ata_pio;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
 		sis5513_tune_drive(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }

 /* initiates/aborts (U)DMA read/write operations on a drive. */
diff -u linux-2.4.26/drivers/ide/pci/slc90e66.c linux-2.4.26-pat/drivers/ide/pci/slc90e66.c
--- linux-2.4.26/drivers/ide/pci/slc90e66.c	2003-06-19 12:37:40.000000000 -0700
+++ linux-2.4.26-pat/drivers/ide/pci/slc90e66.c	2004-04-29 17:11:29.000000000 -0700
@@ -285,7 +285,9 @@
 				int dma = slc90e66_config_drive_for_dma(drive);
 				if ((id->field_valid & 2) && !dma)
 					goto try_dma_modes;
-			}
+			} else
+				/* UDMA disabled by mask, try other DMA modes */
+				goto try_dma_modes;
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if ((id->dma_mword & hwif->mwdma_mask) ||
@@ -302,13 +304,14 @@
 		} else {
 			goto fast_ata_pio;
 		}
+		return hwif->ide_dma_on(drive);
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 no_dma_set:
 		hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return 0;
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */

