Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271105AbRHYG4d>; Sat, 25 Aug 2001 02:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271106AbRHYG4Y>; Sat, 25 Aug 2001 02:56:24 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:2318 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S271105AbRHYG4N>; Sat, 25 Aug 2001 02:56:13 -0400
Date: Sat, 25 Aug 2001 02:56:20 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] make ide-scsi more selective
In-Reply-To: <E15ZfNZ-0002J3-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108250249060.23271-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Alan Cox wrote:

> The real problem is that the drivers are claiming resources on load not
> on open. Why shouldnt I be able to load ide-cd and ide-scsi and open either
> /dev/hda or /dev/sr0 but not both together ?

Mostly because sr_open() does not make any calls into the host driver, 
which makes it impossible to claim any resources on open.

I've concocted another patch, which includes my previous one and
implements Mikael's idea somewhat more consistently. It adds another
option, "noscsi", so that by saying hdX=noscsi on the kernel command line
the user can prevent the ide-scsi driver from ever claiming that drive.

So:
- by default it's first come, first served
- hdX=scsi means only the ide-scsi driver can claim hdX
- hdX=noscsi means the ide-scsi driver must not claim hdX ever

Sounds good? If so, please apply, it makes many CDR users' lives easier.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-----------------------------------
diff -ur ../linux-2.4-ac/drivers/ide/ide-cd.c linux-2.4.8-ac7/drivers/ide/ide-cd.c
--- ../linux-2.4-ac/drivers/ide/ide-cd.c	Sat Aug 18 06:03:21 2001
+++ linux-2.4.8-ac7/drivers/ide/ide-cd.c	Sat Aug 25 02:30:03 2001
@@ -3026,7 +3026,7 @@
 				continue;
 			}
 		}
-		if (drive->scsi) {
+		if (drive->scsi == 1) {
 			printk("ide-cd: passing drive %s to ide-scsi emulation.\n", drive->name);
 			continue;
 		}
diff -ur ../linux-2.4-ac/drivers/ide/ide-floppy.c linux-2.4.8-ac7/drivers/ide/ide-floppy.c
--- ../linux-2.4-ac/drivers/ide/ide-floppy.c	Sat Aug 18 06:03:21 2001
+++ linux-2.4.8-ac7/drivers/ide/ide-floppy.c	Sat Aug 25 02:29:51 2001
@@ -2018,7 +2018,7 @@
 			printk (KERN_ERR "ide-floppy: %s: not supported by this version of ide-floppy\n", drive->name);
 			continue;
 		}
-		if (drive->scsi) {
+		if (drive->scsi == 1) {
 			printk("ide-floppy: passing drive %s to ide-scsi emulation.\n", drive->name);
 			continue;
 		}
diff -ur ../linux-2.4-ac/drivers/ide/ide-tape.c linux-2.4.8-ac7/drivers/ide/ide-tape.c
--- ../linux-2.4-ac/drivers/ide/ide-tape.c	Sat Aug 18 06:03:21 2001
+++ linux-2.4.8-ac7/drivers/ide/ide-tape.c	Sat Aug 25 02:29:39 2001
@@ -6235,7 +6235,7 @@
 			printk (KERN_ERR "ide-tape: %s: not supported by this version of ide-tape\n", drive->name);
 			continue;
 		}
-		if (drive->scsi) {
+		if (drive->scsi == 1) {
 			if (strstr(drive->id->model, "OnStream DI-")) {
 				printk("ide-tape: ide-scsi emulation is not supported for %s.\n", drive->id->model);
 			} else {
diff -ur ../linux-2.4-ac/drivers/ide/ide.c linux-2.4.8-ac7/drivers/ide/ide.c
--- ../linux-2.4-ac/drivers/ide/ide.c	Sat Aug 18 06:03:21 2001
+++ linux-2.4.8-ac7/drivers/ide/ide.c	Sat Aug 25 02:29:24 2001
@@ -3045,7 +3045,7 @@
 		const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
 				"serialize", "autotune", "noautotune",
 				"slow", "swapdata", "bswap", "flash",
-				"remap", "noremap", "scsi", NULL};
+				"remap", "noremap", "scsi", "noscsi", NULL};
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
@@ -3109,13 +3109,15 @@
 				drive->remap_0_to_1 = 2;
 				goto done;
 			case -14: /* "scsi" */
-#if defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI)
+#if defined(CONFIG_BLK_DEV_IDESCSI) || defined(CONFIG_BLK_DEV_IDESCSI_MODULE)
 				drive->scsi = 1;
-				goto done;
 #else
-				drive->scsi = 0;
-				goto bad_option;
-#endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
+				printk(" -- ide-scsi support unavailable, ignoring.\n");
+#endif /* defined(CONFIG_BLK_DEV_IDESCSI) || defined(CONFIG_BLK_DEV_IDESCSI_MODULE) */
+				goto done;
+			case -15: /* "noscsi" */
+				drive->scsi = 2;
+				goto done;
 			case 3: /* cyl,head,sect */
 				drive->media	= ide_disk;
 				drive->cyl	= drive->bios_cyl  = vals[0];
--- ../linux-2.4-ac/drivers/scsi/ide-scsi.c	Fri Feb  9 14:30:23 2001
+++ linux-2.4.8-ac7/drivers/scsi/ide-scsi.c	Sat Aug 25 02:29:04 2001
@@ -580,7 +580,10 @@
 	for (i = 0; media[i] != 255; i++) {
 		failed = 0;
 		while ((drive = ide_scan_devices (media[i], idescsi_driver.name, NULL, failed++)) != NULL) {
-
+			if (drive->scsi == 2) {
+				printk ("ide-scsi: skipping reserved drive %s.\n", drive->name);
+				continue;
+			}
 			if ((scsi = (idescsi_scsi_t *) kmalloc (sizeof (idescsi_scsi_t), GFP_KERNEL)) == NULL) {
 				printk (KERN_ERR "ide-scsi: %s: Can't allocate a scsi structure\n", drive->name);
 				continue;

