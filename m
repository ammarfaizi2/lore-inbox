Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283001AbRL1AGx>; Thu, 27 Dec 2001 19:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283311AbRL1AGn>; Thu, 27 Dec 2001 19:06:43 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:62438 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S283310AbRL1AG1>;
	Thu, 27 Dec 2001 19:06:27 -0500
Date: Fri, 28 Dec 2001 01:06:25 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: axboe@suse.de, Stephan von Krawczynski <skraw@ithnet.com>
cc: Guest section DW <dwguest@win.tue.nl>, James Stevenson <mistral@stev.org>,
        <jlladono@pie.xtec.es>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: 2.4.x kernels, big ide disks and old bios
In-Reply-To: <200112272304.AAA05151@webserver.ithnet.com>
Message-ID: <Pine.LNX.4.43.0112280017540.5550-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Dec 2001, Stephan von Krawczynski wrote:
> I must admit I have still not had a look at it, but on the other hand:
> if it makes big IDE drives work on old mobo & bios, it may be a good
> idea to include its intelligence into the kernel, or not?

I cleaned up the patch a bit (see below). It now performs the
SET_MAX command only when needed, and is far less verbose (only
prints 1 line when unclipping). It applies against 2.4.18pre1 and
2.5.2pre2.

I've tested it with a Maxtor 96147U8 (60Gb), Maxtor 98196H8 (80Gb)
and WDC WD300BB (30Gb) (the last one just for testing, and I had to
use ibmsetmax instead of setmax to make the drive remember it).
It also worked with some 2.5" IBM hdd a while back (don't remember
the exact model).

Jens, please consider this patch for inclusion into 2.4 and/or 2.5.
(or should I talk to someone else?)

Eric


--- linux/drivers/ide/ide-disk.c.orig	Thu Dec 27 22:19:11 2001
+++ linux/drivers/ide/ide-disk.c	Fri Dec 28 00:37:36 2001
@@ -500,6 +500,78 @@
 			current_capacity(drive));
 }

+
+/*
+ * Queries for true maximum capacity of the drive and (if needed) sets
+ * maximum virtual LBA address accordingly. Also updates drive->*
+ * settings.
+ */
+static void idedisk_unclip(ide_drive_t *drive)
+{
+	byte args[7];
+	unsigned long addr = 0;
+
+	if(!(drive->id->command_set_1 & 0x0400)) {
+		/* drive does not support Host Protected Area feature. */
+		return;
+	}
+
+	/* create IDE/ATA command request structure */
+	args[0] = 0xf8; /* READ_NATIVE_MAX - see ATA spec */
+	args[IDE_FEATURE_OFFSET] = 0x00;
+	args[IDE_NSECTOR_OFFSET] = 0x00;
+	args[IDE_SECTOR_OFFSET] = 0x00;
+	args[IDE_LCYL_OFFSET] = 0x00;
+	args[IDE_HCYL_OFFSET] = 0x00;
+	args[IDE_SELECT_OFFSET] = 0x40;
+
+	if(ide_wait_cmd_task(drive, args) != 0 || (args[0] & 0x01) != 0) {
+		/* silently ignore failed command */
+		return;
+	}
+
+	/* read max LBA value */
+	addr = ((args[IDE_SELECT_OFFSET] & 0x0f) << 24) |
+	       (args[IDE_HCYL_OFFSET] << 16) |
+	       (args[IDE_LCYL_OFFSET] << 8) |
+	       (args[IDE_SECTOR_OFFSET]);
+
+	/* sanity check */
+	if(addr == 0) return;
+
+	if(drive->capacity == (addr + 1)) {
+		/* no unclipping needed */
+		return;
+	}
+
+	printk("%s: unclipping drive from %lu sectors to %lu sectors\n",
+		drive->name, drive->capacity, addr + 1);
+
+	/* create IDE/ATA command request structure */
+	args[0] = 0xf9; /* SET_MAX - see ATA spec */
+	args[IDE_FEATURE_OFFSET] = 0x00;
+	args[IDE_NSECTOR_OFFSET] = 0x00;
+	args[IDE_SECTOR_OFFSET] = addr & 0xff;
+	args[IDE_LCYL_OFFSET] = (addr >> 8) & 0xff;
+	args[IDE_HCYL_OFFSET] = (addr >> 16) & 0xff;
+	args[IDE_SELECT_OFFSET] = ((addr >> 24) & 0x0f) | 0x40;
+
+	/* submit command request - if OK, read new max LBA value */
+	if(ide_wait_cmd_task(drive, args) == 0 && (args[0] & 0x01) == 0) {
+		addr = ((args[IDE_SELECT_OFFSET] & 0x0f) << 24) |
+		       (args[IDE_HCYL_OFFSET] << 16) |
+		       (args[IDE_LCYL_OFFSET] << 8) |
+		       (args[IDE_SECTOR_OFFSET]);
+
+		drive->select.b.lba = 1;
+		drive->capacity = addr + 1;
+		drive->cyl = drive->capacity / (drive->head * drive->sect);
+	} else {
+		printk("%s: unclipping drive failed\n", drive->name);
+	}
+}
+
+
 /*
  * Compute drive->capacity, the full capacity of the drive
  * Called with drive->id != NULL.
@@ -518,6 +590,8 @@
 		drive->select.b.lba = 1;
 	}
 	drive->capacity = capacity;
+
+	idedisk_unclip(drive);
 }

 static unsigned long idedisk_capacity (ide_drive_t  *drive)

