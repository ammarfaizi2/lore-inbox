Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270280AbRH1GzR>; Tue, 28 Aug 2001 02:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270299AbRH1GzH>; Tue, 28 Aug 2001 02:55:07 -0400
Received: from gaia.votek.com ([212.86.21.2]:19874 "EHLO gaia.votek.com")
	by vger.kernel.org with ESMTP id <S270280AbRH1Gy5>;
	Tue, 28 Aug 2001 02:54:57 -0400
Message-ID: <3B8B4050.7778F59A@votek.com>
Date: Tue, 28 Aug 2001 09:55:12 +0300
From: Timo Teras <timo.teras@votek.com>
Organization: Votek Oy
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mihaim@profm.ro, stepan@srnet.cz
Subject: Workaround for VIA chipset+ATAPI ZIP 100 problem
Content-Type: multipart/mixed;
 boundary="------------1C0F00C2679EE15C8F0D32FA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1C0F00C2679EE15C8F0D32FA
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi, all.

I've seen a couple of mails telling about the probelem with
some via chipsets and atapa floppy disks.
I experienced the same problem lately and decided to investigate this
matter a bit.

The problem symtops were ide bus lockup and the following messages:
hdd: lost interrupt 
ide-floppy: CoD != 0 in idefloppy_pc_intr 
hdd: ATAPI reset complete 

After extensive tracing the look seemed to change from 100% sure
to random ones and they only followed after a large write packet
command. I decided to try a small delay before every command
(the hardware might busy after the write and ignoring new requests).
This seemed to cure my atapi zip floppy.

I'm not a kernel or an ide expert, but I created a little patch
which works on my system quite stably. Any feedback on the solution
appreciated: eg. if it works for others or not and is the chipset
stuff I added okay. Also I'm not sure which versions of the via
chipset are the buggy ones so it enables the workaround whenever
a via chipset is found.

Regards,
  Timo Teräs

PS. Please send mails directly or Cc me, since I haven't subscribed
to this list.
--------------1C0F00C2679EE15C8F0D32FA
Content-Type: text/plain; charset=us-ascii;
 name="via-ide-floppy-kludge.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-ide-floppy-kludge.patch"

diff -u -r linux.orig/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux.orig/drivers/ide/ide-floppy.c	Fri Feb  9 21:30:23 2001
+++ linux/drivers/ide/ide-floppy.c	Tue Aug 28 00:26:12 2001
@@ -238,6 +238,8 @@
 	int wp;							/* Write protect */
 
 	unsigned int flags;			/* Status/Action flags */
+
+        unsigned long via_kludge;
 } idefloppy_floppy_t;
 
 /*
@@ -1034,11 +1036,19 @@
 
 static void idefloppy_rw_callback (ide_drive_t *drive)
 {
+	idefloppy_floppy_t *floppy = drive->driver_data;
+
 #if IDEFLOPPY_DEBUG_LOG	
 	printk (KERN_INFO "ide-floppy: Reached idefloppy_rw_callback\n");
 #endif /* IDEFLOPPY_DEBUG_LOG */
 
 	idefloppy_end_request(1, HWGROUP(drive));
+
+	if (HWIF(drive)->chipset == ide_via82cxxx &&
+	    (floppy->pc->c[0] == IDEFLOPPY_WRITE10_CMD ||
+	     floppy->pc->c[0] == IDEFLOPPY_WRITE12_CMD)) {
+                floppy->via_kludge = jiffies + HZ/40;
+	}
 	return;
 }
 
@@ -1153,6 +1163,13 @@
 		idefloppy_end_request (0, HWGROUP(drive));
 		return ide_stopped;
 	}
+	if (floppy->via_kludge) {
+		long wait = floppy->via_kludge - jiffies;
+		if (wait > 0) {
+                        mdelay(wait*1000/HZ);
+		}
+                floppy->via_kludge = 0;
+	}
 	switch (rq->cmd) {
 		case READ:
 		case WRITE:
@@ -1541,6 +1558,7 @@
 	memset (floppy, 0, sizeof (idefloppy_floppy_t));
 	floppy->drive = drive;
 	floppy->pc = floppy->pc_stack;
+        floppy->via_kludge = 0;
 	if (gcw.drq_type == 1)
 		set_bit (IDEFLOPPY_DRQ_INTERRUPT, &floppy->flags);
 	/*
diff -u -r linux.orig/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux.orig/drivers/ide/via82cxxx.c	Sat Feb  3 21:27:43 2001
+++ linux/drivers/ide/via82cxxx.c	Mon Aug 27 23:45:04 2001
@@ -494,6 +494,7 @@
 	hwif->tuneproc = &via82cxxx_tune_drive;
 	hwif->speedproc = &via_set_drive;
 	hwif->autodma = 0;
+        hwif->chipset = ide_via82cxxx;
 
 	for (i = 0; i < 2; i++) {
 		hwif->drives[i].io_32bit = 1;
diff -u -r linux.orig/include/linux/ide.h linux/include/linux/ide.h
--- linux.orig/include/linux/ide.h	Sat May 26 04:02:42 2001
+++ linux/include/linux/ide.h	Mon Aug 27 23:44:50 2001
@@ -405,7 +405,7 @@
 		ide_qd6580,	ide_umc8672,	ide_ht6560b,
 		ide_pdc4030,	ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
-		ide_pmac
+		ide_pmac,       ide_via82cxxx
 } hwif_chipset_t;
 
 #ifdef CONFIG_BLK_DEV_IDEPCI

--------------1C0F00C2679EE15C8F0D32FA--

