Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293088AbSCJQnO>; Sun, 10 Mar 2002 11:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293089AbSCJQnF>; Sun, 10 Mar 2002 11:43:05 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:47562 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S293088AbSCJQmr>;
	Sun, 10 Mar 2002 11:42:47 -0500
Date: Sun, 10 Mar 2002 17:42:30 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203101642.RAA02290@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.6 IDE configuration breakage
Cc: andre@linux-ide.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel patch 2.5.6 moved some stuff (types, variables, and functions)
from drivers/ide/ide_modes.h to drivers/ide/ide.c. It did so without
preserving the #ifdef CONFIG_BLK_DEV_IDE_MODES, so 2.5.6 vanilla
doesn't build on my ISA/VLB no-chipset-in-sight '92 vintage 486.

The patch below reintroduces the necessary #ifdef:s. It would be
a bit cleaner if the affected declarations were in a single chunk.

The old HD driver is not an option on this machine. I've tried it in
the past and the IDE driver is much more reliable.

(cc:d to Andre to keep him informed. I know he didn't do the damage.)

/Mikael

--- linux-2.5.6/drivers/ide/ide.c.~1~	Sat Mar  9 12:53:12 2002
+++ linux-2.5.6/drivers/ide/ide.c	Sun Mar 10 14:32:09 2002
@@ -197,6 +197,7 @@
 /*
  * Constant tables for PIO mode programming:
  */
+#ifdef CONFIG_BLK_DEV_IDE_MODES
 const ide_pio_timings_t ide_pio_timings[6] = {
 	{ 70,	165,	600 },	/* PIO Mode 0 */
 	{ 50,	125,	383 },	/* PIO Mode 1 */
@@ -205,11 +206,13 @@
 	{ 25,	70,	120 },	/* PIO Mode 4 with IORDY */
 	{ 20,	50,	100 }	/* PIO Mode 5 with IORDY (nonstandard) */
 };
+#endif
 
 /*
  * Black list. Some drives incorrectly report their maximal PIO mode,
  * at least in respect to CMD640. Here we keep info on some known drives.
  */
+#ifdef CONFIG_BLK_DEV_IDE_MODES
 static struct ide_pio_info {
 	const char	*name;
 	int		pio;
@@ -282,6 +285,7 @@
         { "QUANTUM FIREBALL_1280", 3 },
 	{ NULL,	0 }
 };
+#endif /* CONFIG_BLK_DEV_IDE_MODES */
 
 /* default maximum number of failures */
 #define IDE_DEFAULT_MAX_FAILURES	1
@@ -322,6 +326,7 @@
  * Returns -1 if no match found.
  * Otherwise returns the recommended PIO mode from ide_pio_blacklist[].
  */
+#ifdef CONFIG_BLK_DEV_IDE_MODES
 int ide_scan_pio_blacklist (char *model)
 {
 	struct ide_pio_info *p;
@@ -332,6 +337,7 @@
 	}
 	return -1;
 }
+#endif
 
 /*
  * This routine returns the recommended PIO settings for a given drive,
@@ -342,6 +348,7 @@
 /*
  * Drive PIO mode auto selection
  */
+#ifdef CONFIG_BLK_DEV_IDE_MODES
 byte ide_get_best_pio_mode (ide_drive_t *drive, byte mode_wanted, byte max_mode, ide_pio_data_t *d)
 {
 	int pio_mode;
@@ -413,6 +420,7 @@
 	}
 	return pio_mode;
 }
+#endif /* CONFIG_BLK_DEV_IDE_MODES */
 
 #if (DISK_RECOVERY_TIME > 0)
 /*
