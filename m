Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270352AbTHBXes (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 19:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270448AbTHBXes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 19:34:48 -0400
Received: from codepoet.org ([166.70.99.138]:42203 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S270352AbTHBXei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 19:34:38 -0400
Date: Sat, 2 Aug 2003 17:34:38 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Message-ID: <20030802233438.GA7652@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	axboe@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030802124536.GB3689@win.tue.nl> <Pine.SOL.4.30.0308021506550.7779-100000@mion.elka.pw.edu.pl> <20030802174229.GA3741@win.tue.nl> <1059858379.20305.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <1059858379.20305.23.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat Aug 02, 2003 at 10:06:19PM +0100, Alan Cox wrote:
> On Sad, 2003-08-02 at 18:42, Andries Brouwer wrote:
> > OK, so we have to investigate. This strange test was inserted
> > in 2.4 and 2.5 via Alan, and google gives me Alan's changelog:
> > 
> > Linux 2.5.66-ac1
> > o Don't issue WIN_SET_MAX on older drivers (Jens Axboe)
> >   (Breaks some Samsung)
> 
> Some older Samsung drives don't abort WIN_SET_MAX but the firmware
> hangs hence the check.

Ok, I think I can actually test that one.

    <rummages in ye olde box of hardware>

Cool, found it, I have an ancient Samsung SHD-3212A (426MB)
drive that will hopefully show the problem.

    <sound of testing in the distance>

Ok, found the problem.  The current code (in addition to being
badly written) does not even bother to test if the drive supports
the HPA feature set before issuing a WIN_SET_MAX call.  In my
case, it didn't crash my Samsung drive, but it certainly did make
it complain rather loudly.

I have rewritten the init_idedisk_capacity() function and taught
it to behave itself.  It is now much cleaner IMHO, and will only
issues SET_MAX* calls to drives that claim they support such
things.  I've tested this patch with a 200GB drive, a 120GB
drive, an 80GB drive and my ancient Samsung drive and in each
case (48bit LBA, 28bit LBA, 28bit CHS w/o support for HPA), my
new version appears to the Right Thing(tm).

Attached is a patch vs 2.4.22-pre10, and a patch vs 2.6.0-pre2. 
Please apply,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fixup-ide-hpa-2.4.patch"

--- linux/drivers/ide/ide-disk.c.orig	2003-08-02 15:58:32.000000000 -0600
+++ linux/drivers/ide/ide-disk.c	2003-08-02 16:54:17.000000000 -0600
@@ -69,6 +69,7 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/div64.h>
 
 /* FIXME: some day we shouldnt need to look in here! */
 
@@ -1131,18 +1132,6 @@
 #endif /* CONFIG_IDEDISK_STROKE */
 
 /*
- * Tests if the drive supports Host Protected Area feature.
- * Returns true if supported, false otherwise.
- */
-static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
-{
-	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
-	if (flag)
-		printk("%s: host protected area => %d\n", drive->name, flag);
-	return flag;
-}
-
-/*
  * Compute drive->capacity, the full capacity of the drive
  * Called with drive->id != NULL.
  *
@@ -1156,77 +1145,103 @@
  * in above order (i.e., if value of higher priority is available,
  * reset will be ignored).
  */
-#define IDE_STROKE_LIMIT	(32000*1024*2)
 static void init_idedisk_capacity (ide_drive_t  *drive)
 {
-	struct hd_driveid *id = drive->id;
-	unsigned long capacity = drive->cyl * drive->head * drive->sect;
-	unsigned long set_max = idedisk_read_native_max_address(drive);
-	unsigned long long capacity_2 = capacity;
-	unsigned long long set_max_ext;
-
-	drive->capacity48 = 0;
-	drive->select.b.lba = 0;
-
-	(void) idedisk_supports_host_protected_area(drive);
-
-	if (id->cfs_enable_2 & 0x0400) {
-		capacity_2 = id->lba_capacity_2;
-		drive->head		= drive->bios_head = 255;
-		drive->sect		= drive->bios_sect = 63;
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
-		drive->select.b.lba	= 1;
-		set_max_ext = idedisk_read_native_max_address_ext(drive);
-		if (set_max_ext > capacity_2 && capacity_2 > IDE_STROKE_LIMIT) {
-#ifdef CONFIG_IDEDISK_STROKE
-			set_max_ext = idedisk_read_native_max_address_ext(drive);
-			set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
-			if (set_max_ext) {
-				drive->capacity48 = capacity_2 = set_max_ext;
-				drive->cyl = (unsigned int) set_max_ext / (drive->head * drive->sect);
-				drive->select.b.lba = 1;
-				drive->id->lba_capacity_2 = capacity_2;
-                        }
-#else /* !CONFIG_IDEDISK_STROKE */
-			printk(KERN_INFO "%s: setmax_ext LBA %llu, native  %llu\n",
-				drive->name, set_max_ext, capacity_2);
-#endif /* CONFIG_IDEDISK_STROKE */
-		}
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
-		drive->bios_cyl		= drive->cyl;
-		drive->capacity48	= capacity_2;
-		drive->capacity		= (unsigned long) capacity_2;
-		return;
-	/* Determine capacity, and use LBA if the drive properly supports it */
+	struct hd_driveid *id;
+	unsigned long capacity;
+	unsigned long long capacity_2;
+
+	id = drive->id;
+	capacity = drive->cyl * drive->head * drive->sect;
+	capacity_2 = capacity;
+
+
+	/* Does this drive support the 48-bit Address Feature Set
+	 * and does it have that enabled at the moment? */
+	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
+		//drive speaks 48-bit LBA
+		drive->capacity = (unsigned long) capacity_2 = id->lba_capacity_2;
+		drive->capacity48 = capacity_2;
+		drive->head = drive->bios_head = 255;
+		drive->sect = drive->bios_sect = 63;
+		drive->cyl  = (unsigned int) capacity_2 / (drive->head * drive->sect);
+		drive->bios_cyl	= drive->cyl;
+		drive->select.b.lba = 1;
 	} else if ((id->capability & 2) && lba_capacity_is_ok(id)) {
-		capacity = id->lba_capacity;
+		// drive speaks 28-bit LBA
+		drive->capacity = capacity = id->lba_capacity;
+		drive->capacity48 = 0;
 		drive->cyl = capacity / (drive->head * drive->sect);
 		drive->select.b.lba = 1;
+	} else {
+		// drive speaks boring old 28-bit CHS
+		drive->capacity = capacity;
+		drive->capacity48 = 0;
+		drive->select.b.lba = 0;
 	}
 
-	if (set_max > capacity && capacity > IDE_STROKE_LIMIT) {
+
+	/* If this drive supports the Host Protected Area feature set, 
+	 * then we may need to change our opinion about the drive's size... */
+	if (id->command_set_1 & 0x0400 && id->cfs_enable_1 & 0x0400) 
+	{
+		/* Does this drive support the 48-bit Address Feature Set
+		 * and does it have that enabled as well? */
+		if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) 
+		{
+			unsigned long long set_max_ext;
+			set_max_ext = idedisk_read_native_max_address_ext(drive);
+
+			/* If our capacity is smaller than the native capacity, 
+			 * we have an HPA created using SET MAX ADDRESS EXT... */
+			if (set_max_ext > capacity_2)
+			{
+				/* Sigh.  We have to jump through extra hoops to 
+				 * divide unsigned long longs within the kernel */
+				unsigned long long nativeMb, currentMb;
+				nativeMb = set_max_ext * 512;
+				currentMb = capacity_2 * 512;
+				/* do_div is a macro so we can not safely combine steps */
+				nativeMb = do_div(nativeMb, 1000000);
+				currentMb = do_div(currentMb, 1000000);
+				printk(KERN_INFO "%s: Host Protected Area detected.\n"
+					"    current capacity is %lld sectors (%lld MB)\n"
+					"    native  capacity is %lld sectors (%lld MB)\n",
+					drive->name, capacity_2, currentMb, set_max_ext, nativeMb);
 #ifdef CONFIG_IDEDISK_STROKE
-		set_max = idedisk_read_native_max_address(drive);
-		set_max = idedisk_set_max_address(drive, set_max);
-		if (set_max) {
-			drive->capacity = capacity = set_max;
-			drive->cyl = set_max / (drive->head * drive->sect);
-			drive->select.b.lba = 1;
-			drive->id->lba_capacity = capacity;
-		}
-#else /* !CONFIG_IDEDISK_STROKE */
-		printk(KERN_INFO "%s: setmax LBA %lu, native  %lu\n",
-			drive->name, set_max, capacity);
+				set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
+				if (set_max_ext) {
+					drive->capacity48 = drive->id->lba_capacity_2 = set_max_ext;
+					drive->cyl = (unsigned int) set_max_ext / (drive->head * drive->sect);
+					drive->select.b.lba = 1;
+					printk(KERN_INFO "%s: Host Protected Area Disabled\n", drive->name);
+				}
 #endif /* CONFIG_IDEDISK_STROKE */
-	}
+			}
+		} else {
+			unsigned long set_max;
+			set_max = idedisk_read_native_max_address(drive);
 
-	drive->capacity = capacity;
+			if (set_max > capacity)
+			{
+				printk(KERN_INFO "%s: Host Protected Area detected.\n"
+					"    current capacity is %ld sectors (%ld MB)\n"
+					"    native  capacity is %ld sectors (%ld MB)\n",
+					drive->name, capacity, 
+					(capacity - capacity/625 + 974)/1950,
+					set_max, (set_max - set_max/625 + 974)/1950);
+#ifdef CONFIG_IDEDISK_STROKE
+				set_max = idedisk_set_max_address(drive, set_max);
+				if (set_max) {
+					drive->capacity = drive->id->lba_capacity = set_max;
+					drive->cyl = set_max / (drive->head * drive->sect);
+					drive->select.b.lba = 1;
+					printk(KERN_INFO "%s: Host Protected Area Disabled\n", drive->name);
+				}
+#endif /* CONFIG_IDEDISK_STROKE */
+			}
 
-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
-		drive->capacity48 = id->lba_capacity_2;
-		drive->head = 255;
-		drive->sect = 63;
-		drive->cyl = (unsigned long)(drive->capacity48) / (drive->head * drive->sect);
+		}
 	}
 }
 

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fixup-ide-hpa-2.6.patch"

--- linux-2.6.0-test2/drivers/ide/ide-disk.c.orig	2003-07-27 11:01:09.000000000 -0600
+++ linux-2.6.0-test2/drivers/ide/ide-disk.c	2003-08-02 17:17:27.000000000 -0600
@@ -67,6 +67,7 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/div64.h>
 
 /* FIXME: some day we shouldn't need to look in here! */
 
@@ -1066,18 +1067,6 @@
 #endif /* CONFIG_IDEDISK_STROKE */
 
 /*
- * Tests if the drive supports Host Protected Area feature.
- * Returns true if supported, false otherwise.
- */
-static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
-{
-	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
-	if (flag)
-		printk(KERN_INFO "%s: host protected area => %d\n", drive->name, flag);
-	return flag;
-}
-
-/*
  * Compute drive->capacity, the full capacity of the drive
  * Called with drive->id != NULL.
  *
@@ -1091,77 +1080,103 @@
  * in above order (i.e., if value of higher priority is available,
  * reset will be ignored).
  */
-#define IDE_STROKE_LIMIT	(32000*1024*2)
 static void init_idedisk_capacity (ide_drive_t  *drive)
 {
-	struct hd_driveid *id = drive->id;
-	unsigned long capacity = drive->cyl * drive->head * drive->sect;
-	unsigned long set_max = idedisk_read_native_max_address(drive);
-	unsigned long long capacity_2 = capacity;
-	unsigned long long set_max_ext;
-
-	drive->capacity48 = 0;
-	drive->select.b.lba = 0;
-
-	(void) idedisk_supports_host_protected_area(drive);
-
-	if (id->cfs_enable_2 & 0x0400) {
-		capacity_2 = id->lba_capacity_2;
-		drive->head		= drive->bios_head = 255;
-		drive->sect		= drive->bios_sect = 63;
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
-		drive->select.b.lba	= 1;
-		set_max_ext = idedisk_read_native_max_address_ext(drive);
-		if (set_max_ext > capacity_2 && capacity_2 > IDE_STROKE_LIMIT) {
-#ifdef CONFIG_IDEDISK_STROKE
-			set_max_ext = idedisk_read_native_max_address_ext(drive);
-			set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
-			if (set_max_ext) {
-				drive->capacity48 = capacity_2 = set_max_ext;
-				drive->cyl = (unsigned int) set_max_ext / (drive->head * drive->sect);
-				drive->select.b.lba = 1;
-				drive->id->lba_capacity_2 = capacity_2;
-                        }
-#else /* !CONFIG_IDEDISK_STROKE */
-			printk(KERN_INFO "%s: setmax_ext LBA %llu, native  %llu\n",
-				drive->name, set_max_ext, capacity_2);
-#endif /* CONFIG_IDEDISK_STROKE */
-		}
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
-		drive->bios_cyl		= drive->cyl;
-		drive->capacity48	= capacity_2;
-		drive->capacity		= (unsigned long) capacity_2;
-		return;
-	/* Determine capacity, and use LBA if the drive properly supports it */
+	struct hd_driveid *id;
+	unsigned long capacity;
+	unsigned long long capacity_2;
+
+	id = drive->id;
+	capacity = drive->cyl * drive->head * drive->sect;
+	capacity_2 = capacity;
+
+
+	/* Does this drive support the 48-bit Address Feature Set
+	 * and does it have that enabled at the moment? */
+	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
+		//drive speaks 48-bit LBA
+		drive->capacity = (unsigned long) capacity_2 = id->lba_capacity_2;
+		drive->capacity48 = capacity_2;
+		drive->head = drive->bios_head = 255;
+		drive->sect = drive->bios_sect = 63;
+		drive->cyl  = (unsigned int) capacity_2 / (drive->head * drive->sect);
+		drive->bios_cyl	= drive->cyl;
+		drive->select.b.lba = 1;
 	} else if ((id->capability & 2) && lba_capacity_is_ok(id)) {
-		capacity = id->lba_capacity;
+		// drive speaks 28-bit LBA
+		drive->capacity = capacity = id->lba_capacity;
+		drive->capacity48 = 0;
 		drive->cyl = capacity / (drive->head * drive->sect);
 		drive->select.b.lba = 1;
+	} else {
+		// drive speaks boring old 28-bit CHS
+		drive->capacity = capacity;
+		drive->capacity48 = 0;
+		drive->select.b.lba = 0;
 	}
 
-	if (set_max > capacity && capacity > IDE_STROKE_LIMIT) {
+
+	/* If this drive supports the Host Protected Area feature set, 
+	 * then we may need to change our opinion about the drive's size... */
+	if (id->command_set_1 & 0x0400 && id->cfs_enable_1 & 0x0400) 
+	{
+		/* Does this drive support the 48-bit Address Feature Set
+		 * and does it have that enabled as well? */
+		if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) 
+		{
+			unsigned long long set_max_ext;
+			set_max_ext = idedisk_read_native_max_address_ext(drive);
+
+			/* If our capacity is smaller than the native capacity, 
+			 * we have an HPA created using SET MAX ADDRESS EXT... */
+			if (set_max_ext > capacity_2)
+			{
+				/* Sigh.  We have to jump through extra hoops to 
+				 * divide unsigned long longs within the kernel */
+				unsigned long long nativeMb, currentMb;
+				nativeMb = set_max_ext * 512;
+				currentMb = capacity_2 * 512;
+				/* do_div is a macro so we can not safely combine steps */
+				nativeMb = do_div(nativeMb, 1000000);
+				currentMb = do_div(currentMb, 1000000);
+				printk(KERN_INFO "%s: Host Protected Area detected.\n"
+					"    current capacity is %lld sectors (%lld MB)\n"
+					"    native  capacity is %lld sectors (%lld MB)\n",
+					drive->name, capacity_2, currentMb, set_max_ext, nativeMb);
 #ifdef CONFIG_IDEDISK_STROKE
-		set_max = idedisk_read_native_max_address(drive);
-		set_max = idedisk_set_max_address(drive, set_max);
-		if (set_max) {
-			drive->capacity = capacity = set_max;
-			drive->cyl = set_max / (drive->head * drive->sect);
-			drive->select.b.lba = 1;
-			drive->id->lba_capacity = capacity;
-		}
-#else /* !CONFIG_IDEDISK_STROKE */
-		printk(KERN_INFO "%s: setmax LBA %lu, native  %lu\n",
-			drive->name, set_max, capacity);
+				set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
+				if (set_max_ext) {
+					drive->capacity48 = drive->id->lba_capacity_2 = set_max_ext;
+					drive->cyl = (unsigned int) set_max_ext / (drive->head * drive->sect);
+					drive->select.b.lba = 1;
+					printk(KERN_INFO "%s: Host Protected Area Disabled\n", drive->name);
+				}
 #endif /* CONFIG_IDEDISK_STROKE */
-	}
+			}
+		} else {
+			unsigned long set_max;
+			set_max = idedisk_read_native_max_address(drive);
 
-	drive->capacity = capacity;
+			if (set_max > capacity)
+			{
+				printk(KERN_INFO "%s: Host Protected Area detected.\n"
+					"    current capacity is %ld sectors (%ld MB)\n"
+					"    native  capacity is %ld sectors (%ld MB)\n",
+					drive->name, capacity, 
+					(capacity - capacity/625 + 974)/1950,
+					set_max, (set_max - set_max/625 + 974)/1950);
+#ifdef CONFIG_IDEDISK_STROKE
+				set_max = idedisk_set_max_address(drive, set_max);
+				if (set_max) {
+					drive->capacity = drive->id->lba_capacity = set_max;
+					drive->cyl = set_max / (drive->head * drive->sect);
+					drive->select.b.lba = 1;
+					printk(KERN_INFO "%s: Host Protected Area Disabled\n", drive->name);
+				}
+#endif /* CONFIG_IDEDISK_STROKE */
+			}
 
-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
-		drive->capacity48 = id->lba_capacity_2;
-		drive->head = 255;
-		drive->sect = 63;
-		drive->cyl = (unsigned long)(drive->capacity48) / (drive->head * drive->sect);
+		}
 	}
 }
 

--SUOF0GtieIMvvwua--
