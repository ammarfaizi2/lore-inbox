Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272386AbTHBImX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 04:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272414AbTHBImW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 04:42:22 -0400
Received: from codepoet.org ([166.70.99.138]:50893 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S272386AbTHBImJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 04:42:09 -0400
Date: Sat, 2 Aug 2003 02:42:05 -0600
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Message-ID: <20030802084205.GA2033@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About 5 months ago, a patch to ide-disk.c was applied creating
revision 1.13 with the comment "PATCH: resync IDE with -ac".

    http://linux.bkbits.net:8080/linux-2.4/diffs/drivers/ide/ide-disk.c@1.13?nav=index.html|src/|src/drivers|src/drivers/ide|hist/drivers/ide/ide-disk.c

The linked patch added the IDE_STROKE_LIMIT macro and uses this
macro in a couple of tests.  Anybody know what the intent of this
IDE_STROKE_LIMIT macro is?  I ask since it completely breaks
CONFIG_IDEDISK_STROKE and I can't see any reason for it being
there.  It looks to me like it just needs to be ripped right back
out.  Am I missing something?

I have created the following patch which makes this option work
as expected once again in 2.4.x.  It also removes the irrelevant
idedisk_supports_host_protected_area() and makes the HPA
detection actually display useful information for a change, i.e.,
when CONFIG_IDEDISK_STROKE is disabled you get something like:

    hdb: Host Protected Area detected.
	    current capacity is 30001 sectors (15 MB)
	    native  capacity is 234441648 sectors (120034 MB)
    hdb: 30001 sectors (15 MB) w/2048KiB Cache, CHS=29/16/63, UDMA(100)

and when CONFIG_IDEDISK_STROKE is enabled you get:

    hdb: Host Protected Area detected.
	    current capacity is 30001 sectors (15 MB)
	    native  capacity is 234441648 sectors (120034 MB)
    hdb: Host Protected Area Disabled
    hdb: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)

Thanks,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--- linux/drivers/ide/ide-disk.c.orig
+++ linux/drivers/ide/ide-disk.c
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
@@ -1156,7 +1145,6 @@
  * in above order (i.e., if value of higher priority is available,
  * reset will be ignored).
  */
-#define IDE_STROKE_LIMIT	(32000*1024*2)
 static void init_idedisk_capacity (ide_drive_t  *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -1168,8 +1156,6 @@
 	drive->capacity48 = 0;
 	drive->select.b.lba = 0;
 
-	(void) idedisk_supports_host_protected_area(drive);
-
 	if (id->cfs_enable_2 & 0x0400) {
 		capacity_2 = id->lba_capacity_2;
 		drive->head		= drive->bios_head = 255;
@@ -1177,7 +1163,19 @@
 		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
 		drive->select.b.lba	= 1;
 		set_max_ext = idedisk_read_native_max_address_ext(drive);
-		if (set_max_ext > capacity_2 && capacity_2 > IDE_STROKE_LIMIT) {
+		if (set_max_ext > capacity_2)
+		{
+		    /* Sigh.  We can not just divide unsigned long longs... */
+		    unsigned long long nativeMb, currentMb;
+		    nativeMb = set_max_ext * 512;
+		    currentMb = capacity_2 * 512;
+		    /* do_div is a macro so we can not safely combine steps */
+		    nativeMb = do_div(nativeMb, 1000000);
+		    currentMb = do_div(currentMb, 1000000);
+		    printk(KERN_INFO "%s: Host Protected Area detected.\n"
+			    "    current capacity is %lld sectors (%lld MB)\n"
+			    "    native  capacity is %lld sectors (%lld MB)\n",
+			    drive->name, capacity_2, currentMb, set_max_ext, nativeMb);
 #ifdef CONFIG_IDEDISK_STROKE
 			set_max_ext = idedisk_read_native_max_address_ext(drive);
 			set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
@@ -1186,13 +1184,10 @@
 				drive->cyl = (unsigned int) set_max_ext / (drive->head * drive->sect);
 				drive->select.b.lba = 1;
 				drive->id->lba_capacity_2 = capacity_2;
+				printk(KERN_INFO "%s: Host Protected Area Disabled\n", drive->name);
                         }
-#else /* !CONFIG_IDEDISK_STROKE */
-			printk(KERN_INFO "%s: setmax_ext LBA %llu, native  %llu\n",
-				drive->name, set_max_ext, capacity_2);
 #endif /* CONFIG_IDEDISK_STROKE */
 		}
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
 		drive->bios_cyl		= drive->cyl;
 		drive->capacity48	= capacity_2;
 		drive->capacity		= (unsigned long) capacity_2;
@@ -1204,7 +1199,14 @@
 		drive->select.b.lba = 1;
 	}
 
-	if (set_max > capacity && capacity > IDE_STROKE_LIMIT) {
+	if (set_max > capacity)
+	{
+	    printk(KERN_INFO "%s: Host Protected Area detected.\n"
+		    "    current capacity is %ld sectors (%ld MB)\n"
+		    "    native  capacity is %ld sectors (%ld MB)\n",
+		    drive->name, capacity, 
+		    (capacity - capacity/625 + 974)/1950,
+		    set_max, (set_max - set_max/625 + 974)/1950);
 #ifdef CONFIG_IDEDISK_STROKE
 		set_max = idedisk_read_native_max_address(drive);
 		set_max = idedisk_set_max_address(drive, set_max);
@@ -1213,10 +1215,8 @@
 			drive->cyl = set_max / (drive->head * drive->sect);
 			drive->select.b.lba = 1;
 			drive->id->lba_capacity = capacity;
+			printk(KERN_INFO "%s: Host Protected Area Disabled\n", drive->name);
 		}
-#else /* !CONFIG_IDEDISK_STROKE */
-		printk(KERN_INFO "%s: setmax LBA %lu, native  %lu\n",
-			drive->name, set_max, capacity);
 #endif /* CONFIG_IDEDISK_STROKE */
 	}
 
