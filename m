Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbTDPNUV (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTDPNUV 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:20:21 -0400
Received: from [195.204.127.218] ([195.204.127.218]:23953 "EHLO linuxpc")
	by vger.kernel.org with ESMTP id S264370AbTDPNUO 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 09:20:14 -0400
Message-ID: <3E9D776A.5030107@yahoo.no>
Date: Wed, 16 Apr 2003 15:31:54 +0000
From: =?ISO-8859-1?Q?Tord_=D8ygard?= <torden88@yahoo.no>
Reply-To: torden88@yahoo.no
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [Bug 588] New: 2.5.67 won't get the real partition table for
 hdb
References: <UTC200304161304.h3GD45t18903.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200304161304.h3GD45t18903.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

>>So if you could send me that patch, I would be glad.
>>    
>>
>
>Below a patch of 2.5.67. It removes the file ide-geometry.c
>and adds the boot option "hdb=remap63" that shifts all of hdb
>by 63 sectors. (This is what the old code would do in case it 
>detected OnTrack disk manager.)
>
>Please report.
>
>Andries
>
>-------------------------------------------------------------
>diff -u --recursive --new-file -X /linux/dontdiff a/Documentation/ide.txt b/Documentation/ide.txt
>--- a/Documentation/ide.txt	Tue Mar 18 11:48:10 2003
>+++ b/Documentation/ide.txt	Wed Apr 16 14:50:15 2003
>@@ -230,6 +230,10 @@
>  "hdx=cdrom"		: drive is present, and is a cdrom drive
>  
>  "hdx=cyl,head,sect"	: disk drive is present, with specified geometry
>+
>+ "hdx=remap"		: remap access of sector 0 to sector 1 (for EZD)
>+
>+ "hdx=remap63"		: remap the drive: shift all by 63 sectors (for DM)
>  
>  "hdx=autotune"		: driver will attempt to tune interface speed
> 			  to the fastest PIO mode supported,
>diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/Makefile b/drivers/ide/Makefile
>--- a/drivers/ide/Makefile	Tue Mar 25 04:54:31 2003
>+++ b/drivers/ide/Makefile	Wed Apr 16 14:46:25 2003
>@@ -12,7 +12,7 @@
> 
> # Core IDE code - must come before legacy
> 
>-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-io.o ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-default.o
>+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-io.o ide-probe.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-default.o
> obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
> obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
> obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
>diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-geometry.c b/drivers/ide/ide-geometry.c
>--- a/drivers/ide/ide-geometry.c	Tue Mar 25 04:54:31 2003
>+++ b/drivers/ide/ide-geometry.c	Thu Jan  1 01:00:00 1970
>@@ -1,135 +0,0 @@
>-/*
>- * linux/drivers/ide/ide-geometry.c
>- */
>-#include <linux/config.h>
>-#include <linux/ide.h>
>-#include <linux/mc146818rtc.h>
>-#include <asm/io.h>
>-
>-extern unsigned long current_capacity (ide_drive_t *);
>-
>-/*
>- * If heads is nonzero: find a translation with this many heads and S=63.
>- * Otherwise: find out how OnTrack Disk Manager would translate the disk.
>- */
>-
>-static void ontrack(ide_drive_t *drive, int heads, unsigned int *c, int *h, int *s) 
>-{
>-	static const u8 dm_head_vals[] = {4, 8, 16, 32, 64, 128, 255, 0};
>-	const u8 *headp = dm_head_vals;
>-	unsigned long total;
>-
>-	/*
>-	 * The specs say: take geometry as obtained from Identify,
>-	 * compute total capacity C*H*S from that, and truncate to
>-	 * 1024*255*63. Now take S=63, H the first in the sequence
>-	 * 4, 8, 16, 32, 64, 128, 255 such that 63*H*1024 >= total.
>-	 * [Please tell aeb@cwi.nl in case this computes a
>-	 * geometry different from what OnTrack uses.]
>-	 */
>-	total = DRIVER(drive)->capacity(drive);
>-
>-	*s = 63;
>-
>-	if (heads) {
>-		*h = heads;
>-		*c = total / (63 * heads);
>-		return;
>-	}
>-
>-	while (63 * headp[0] * 1024 < total && headp[1] != 0)
>-		 headp++;
>-	*h = headp[0];
>-	*c = total / (63 * headp[0]);
>-}
>-
>-/*
>- * This routine is called from the partition-table code in pt/msdos.c.
>- * It has two tasks:
>- * (i) to handle Ontrack DiskManager by offsetting everything by 63 sectors,
>- *  or to handle EZdrive by remapping sector 0 to sector 1.
>- * (ii) to invent a translated geometry.
>- * Part (i) is suppressed if the user specifies the "noremap" option
>- * on the command line.
>- * Part (ii) is suppressed if the user specifies an explicit geometry.
>- *
>- * The ptheads parameter is either 0 or tells about the number of
>- * heads shown by the end of the first nonempty partition.
>- * If this is either 16, 32, 64, 128, 240 or 255 we'll believe it.
>- *
>- * The xparm parameter has the following meaning:
>- *	 0 = convert to CHS with fewer than 1024 cyls
>- *	     using the same method as Ontrack DiskManager.
>- *	 1 = same as "0", plus offset everything by 63 sectors.
>- *	-1 = similar to "0", plus redirect sector 0 to sector 1.
>- *	 2 = convert to a CHS geometry with "ptheads" heads.
>- *
>- * Returns 0 if the translation was not possible, if the device was not 
>- * an IDE disk drive, or if a geometry was "forced" on the commandline.
>- * Returns 1 if the geometry translation was successful.
>- */
>-
>-int ide_xlate_1024 (struct block_device *bdev, int xparm, int ptheads, const char *msg)
>-{
>-	ide_drive_t *drive = bdev->bd_disk->private_data;
>-	const char *msg1 = "";
>-	int heads = 0;
>-	int c, h, s;
>-	int transl = 1;		/* try translation */
>-	int ret = 0;
>-
>-	/* remap? */
>-	if (drive->remap_0_to_1 != 2) {
>-		if (xparm == 1) {		/* DM */
>-			drive->sect0 = 63;
>-			msg1 = " [remap +63]";
>-			ret = 1;
>-		} else if (xparm == -1) {	/* EZ-Drive */
>-			if (drive->remap_0_to_1 == 0) {
>-				drive->remap_0_to_1 = 1;
>-				msg1 = " [remap 0->1]";
>-				ret = 1;
>-			}
>-		}
>-	}
>-
>-	/* There used to be code here that assigned drive->id->CHS
>-	   to drive->CHS and that to drive->bios_CHS. However,
>-	   some disks have id->C/H/S = 4092/16/63 but are larger than 2.1 GB.
>-	   In such cases that code was wrong.  Moreover,
>-	   there seems to be no reason to do any of these things. */
>-
>-	/* translate? */
>-	if (drive->forced_geom)
>-		transl = 0;
>-
>-	/* does ptheads look reasonable? */
>-	if (ptheads == 32 || ptheads == 64 || ptheads == 128 ||
>-	    ptheads == 240 || ptheads == 255)
>-		heads = ptheads;
>-
>-	if (xparm == 2) {
>-		if (!heads ||
>-		   (drive->bios_head >= heads && drive->bios_sect == 63))
>-			transl = 0;
>-	}
>-	if (xparm == -1) {
>-		if (drive->bios_head > 16)
>-			transl = 0;     /* we already have a translation */
>-	}
>-
>-	if (transl) {
>-		ontrack(drive, heads, &c, &h, &s);
>-		drive->bios_cyl = c;
>-		drive->bios_head = h;
>-		drive->bios_sect = s;
>-		ret = 1;
>-	}
>-
>-	set_capacity(drive->disk, current_capacity(drive));
>-
>-	if (ret)
>-		printk("%s%s [%d/%d/%d]", msg, msg1,
>-		       drive->bios_cyl, drive->bios_head, drive->bios_sect);
>-	return ret;
>-}
>diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
>--- a/drivers/ide/ide-probe.c	Tue Mar 25 04:54:31 2003
>+++ b/drivers/ide/ide-probe.c	Wed Apr 16 14:46:25 2003
>@@ -1442,8 +1442,6 @@
> }
> 
> #ifdef MODULE
>-extern int (*ide_xlate_1024_hook)(struct block_device *, int, int, const char *);
>-
> int init_module (void)
> {
> 	unsigned int index;
>@@ -1452,14 +1450,12 @@
> 		ide_unregister(index);
> 	ideprobe_init();
> 	create_proc_ide_interfaces();
>-	ide_xlate_1024_hook = ide_xlate_1024;
> 	return 0;
> }
> 
> void cleanup_module (void)
> {
> 	ide_probe = NULL;
>-	ide_xlate_1024_hook = 0;
> }
> MODULE_LICENSE("GPL");
> #endif /* MODULE */
>diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide.c b/drivers/ide/ide.c
>--- a/drivers/ide/ide.c	Tue Apr  8 09:36:37 2003
>+++ b/drivers/ide/ide.c	Wed Apr 16 14:46:25 2003
>@@ -1711,6 +1711,8 @@
>  * "hdx=nowerr"		: ignore the WRERR_STAT bit on this drive
>  * "hdx=cdrom"		: drive is present, and is a cdrom drive
>  * "hdx=cyl,head,sect"	: disk drive is present, with specified geometry
>+ * "hdx=remap63"	: add 63 to all sector numbers (for OnTrack DM)
>+ * "hdx=remap"		: remap 0->1 (for EZDrive)
>  * "hdx=noremap"	: do not remap 0->1 even though EZD was detected
>  * "hdx=autotune"	: driver will attempt to tune interface speed
>  *				to the fastest PIO mode supported,
>@@ -1830,11 +1832,11 @@
> 	 * Look for drive options:  "hdx="
> 	 */
> 	if (s[0] == 'h' && s[1] == 'd' && s[2] >= 'a' && s[2] <= max_drive) {
>-		const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
>-				"serialize", "autotune", "noautotune",
>-				"slow", "swapdata", "bswap", "flash",
>-				"remap", "noremap", "scsi", "biostimings",
>-				NULL};
>+		const char *hd_words[] = {
>+			"none", "noprobe", "nowerr", "cdrom", "serialize",
>+			"autotune", "noautotune", "slow", "swapdata", "bswap",
>+			"flash", "remap", "noremap", "scsi", "biostimings",
>+			"remap63", NULL };
> 		unit = s[2] - 'a';
> 		hw   = unit / MAX_DRIVES;
> 		unit = unit % MAX_DRIVES;
>@@ -1884,8 +1886,8 @@
> 			case -8: /* "slow" */
> 				drive->slow = 1;
> 				goto done;
>-			case -9: /* "swapdata" or "bswap" */
>-			case -10:
>+			case -9: /* "swapdata" */
>+			case -10: /* "bswap" */
> 				drive->bswap = 1;
> 				goto done;
> 			case -11: /* "flash" */
>@@ -1908,6 +1910,9 @@
> 			case -15: /* "biostimings" */
> 				drive->autotune = IDE_TUNE_BIOS;
> 				goto done;
>+			case -16: /* "remap63" */
>+				drive->sect0 = 63;
>+				goto done;
> 			case 3: /* cyl,head,sect */
> 				drive->media	= ide_disk;
> 				drive->cyl	= drive->bios_cyl  = vals[0];
>diff -u --recursive --new-file -X /linux/dontdiff a/fs/partitions/msdos.c b/fs/partitions/msdos.c
>--- a/fs/partitions/msdos.c	Mon Feb 24 23:02:56 2003
>+++ b/fs/partitions/msdos.c	Wed Apr 16 14:46:25 2003
>@@ -20,27 +20,15 @@
>  */
> 
> #include <linux/config.h>
>-#include <linux/buffer_head.h>		/* for invalidate_bdev() */
>-
>-#ifdef CONFIG_BLK_DEV_IDE
>-#include <linux/hdreg.h>
>-#include <linux/ide.h>	/* IDE xlate */
>-#elif defined(CONFIG_BLK_DEV_IDE_MODULE)
>-#include <linux/module.h>
>-
>-int (*ide_xlate_1024_hook)(struct block_device *, int, int, const char *);
>-EXPORT_SYMBOL(ide_xlate_1024_hook);
>-#define ide_xlate_1024 ide_xlate_1024_hook
>-#endif
> 
> #include "check.h"
> #include "msdos.h"
> #include "efi.h"
> 
> /*
>- * Many architectures don't like unaligned accesses, which is
>- * frequently the case with the nr_sects and start_sect partition
>- * table entries.
>+ * Many architectures don't like unaligned accesses, while
>+ * the nr_sects and start_sect partition table entries are
>+ * at a 2 (mod 4) address.
>  */
> #include <asm/unaligned.h>
> 
>diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/ide.h b/include/linux/ide.h
>--- a/include/linux/ide.h	Tue Mar 25 04:54:45 2003
>+++ b/include/linux/ide.h	Wed Apr 16 14:46:25 2003
>@@ -1317,12 +1317,6 @@
> extern int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned long);
> 
> /*
>- * This routine is called from the partition-table code in genhd.c
>- * to "convert" a drive to a logical geometry with fewer than 1024 cyls.
>- */
>-extern int ide_xlate_1024(struct block_device *, int, int, const char *);
>-
>-/*
>  * Return the current idea about the total capacity of this drive.
>  */
> extern unsigned long current_capacity (ide_drive_t *drive);
>  
>





That patch worked just fine ;)

Now it booted, and averything is nice.

But one thing:
Do I have to upgrade my modutils?
It did not want to load modules...
It said something about QM_MODULES or something...


But the patch worked fine:)
Thanks.

I will report more bugs if I find some!

Tord

>
>
>  
>


