Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130846AbRABP1Y>; Tue, 2 Jan 2001 10:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131148AbRABP1O>; Tue, 2 Jan 2001 10:27:14 -0500
Received: from smtp2.mail.yahoo.com ([128.11.68.32]:58640 "HELO
	smtp2.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130846AbRABP1E>; Tue, 2 Jan 2001 10:27:04 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A51DD27.5AD9D9C3@yahoo.com>
Date: Tue, 02 Jan 2001 08:52:39 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Chris Wedgwood <cw@f00f.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] CMOS locking for 2.4 (was: /proc/apm slows system time)
In-Reply-To: <E14Ciaz-00080c-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> >     Is there at least away we can recover the proper system time
> >     after these stalls?
> >
> > re-read the RTC -- but that's pretty slow and ugly
> 
> Be very careful doing that in 2.4test. The 2.2 CMOS locking patches are not yet
> in so there is already a window for CMOS problems as far as I can tell. Don't
> make it bigger

This should cover CMOS locking for 2400-prerel.

Paul.

diff -ur linux-orig/Documentation/rtc.txt linux/Documentation/rtc.txt
--- linux-orig/Documentation/rtc.txt	Fri May 26 16:03:14 2000
+++ linux/Documentation/rtc.txt	Tue Jan  2 05:48:03 2001
@@ -56,7 +56,7 @@
 exclusive access to the device for your applications.
 
 The alarm and/or interrupt frequency are programmed into the RTC via
-various ioctl(2) calls as listed in ./include/linux/mc146818rtc.h
+various ioctl(2) calls as listed in ./include/linux/rtc.h
 Rather than write 50 pages describing the ioctl() and so on, it is
 perhaps more useful to include a small test program that demonstrates
 how to use them, and demonstrates the features of the driver. This is
@@ -81,7 +81,7 @@
  */
 
 #include <stdio.h>
-#include <linux/mc146818rtc.h>
+#include <linux/rtc.h>
 #include <sys/ioctl.h>
 #include <sys/time.h>
 #include <sys/types.h>
diff -ur linux-orig/arch/i386/kernel/process.c linux/arch/i386/kernel/process.c
--- linux-orig/arch/i386/kernel/process.c	Mon Jan  1 04:36:51 2001
+++ linux/arch/i386/kernel/process.c	Tue Jan  2 08:58:50 2001
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/mc146818rtc.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -257,6 +258,8 @@
  */
 void machine_real_restart(unsigned char *code, int length)
 {
+	unsigned long flags;
+
 	cli();
 
 	/* Write zero to CMOS register number 0x0f, which the BIOS POST
@@ -266,10 +269,12 @@
 	   disable NMIs by setting the top bit in the CMOS address register,
 	   as we're about to do peculiar things to the CPU.  I'm not sure if
 	   `outb_p' is needed instead of just `outb'.  Use it to be on the
-	   safe side. */
+	   safe side.  (Yes, CMOS_WRITE does outb_p's. -  Paul G.)
+	 */
 
-	outb_p (0x8f, 0x70);
-	outb_p (0x00, 0x71);
+	spin_lock_irqsave(&rtc_lock, flags);
+	CMOS_WRITE(0x00, 0x8f);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	/* Remap the kernel at virtual address zero, as well as offset zero
 	   from the kernel segment.  This assumes the kernel segment starts at
diff -ur linux-orig/drivers/char/nvram.c linux/drivers/char/nvram.c
--- linux-orig/drivers/char/nvram.c	Mon Nov 20 04:12:31 2000
+++ linux/drivers/char/nvram.c	Tue Jan  2 05:50:36 2001
@@ -107,8 +107,6 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-extern spinlock_t rtc_lock;
-
 static int nvram_open_cnt;	/* #times opened */
 static int nvram_open_mode;		/* special open modes */
 #define	NVRAM_WRITE		1		/* opened for writing (exclusive) */
diff -ur linux-orig/drivers/char/rtc.c linux/drivers/char/rtc.c
--- linux-orig/drivers/char/rtc.c	Mon Nov 20 04:19:54 2000
+++ linux/drivers/char/rtc.c	Tue Jan  2 05:50:29 2001
@@ -89,8 +89,6 @@
 
 static DECLARE_WAIT_QUEUE_HEAD(rtc_wait);
 
-extern spinlock_t rtc_lock;
-
 static struct timer_list rtc_irq_timer;
 
 static loff_t rtc_llseek(struct file *file, loff_t offset, int origin);
diff -ur linux-orig/drivers/ide/hd.c linux/drivers/ide/hd.c
--- linux-orig/drivers/ide/hd.c	Mon Nov 20 04:19:58 2000
+++ linux/drivers/ide/hd.c	Tue Jan  2 08:05:44 2001
@@ -738,6 +738,7 @@
 	if (!NR_HD) {
 		extern struct drive_info drive_info;
 		unsigned char *BIOS = (unsigned char *) &drive_info;
+		unsigned long flags;
 		int cmos_disks;
 
 		for (drive=0 ; drive<2 ; drive++) {
@@ -773,10 +774,15 @@
 		Needless to say, a non-zero value means we have 
 		an AT controller hard disk for that drive.
 
-		
+		Currently the rtc_lock is a bit academic since this
+		driver is non-modular, but someday... ?         Paul G.
 	*/
 
-		if ((cmos_disks = CMOS_READ(0x12)) & 0xf0) {
+		spin_lock_irqsave(&rtc_lock, flags);
+		cmos_disks = CMOS_READ(0x12);
+		spin_unlock_irqrestore(&rtc_lock, flags);
+
+		if (cmos_disks & 0xf0) {
 			if (cmos_disks & 0x0f)
 				NR_HD = 2;
 			else
diff -ur linux-orig/drivers/ide/ide-geometry.c linux/drivers/ide/ide-geometry.c
--- linux-orig/drivers/ide/ide-geometry.c	Tue Aug  8 03:56:16 2000
+++ linux/drivers/ide/ide-geometry.c	Tue Jan  2 07:25:10 2001
@@ -3,6 +3,7 @@
  */
 #include <linux/config.h>
 #include <linux/ide.h>
+#include <linux/mc146818rtc.h>
 #include <asm/io.h>
 
 /*
@@ -46,13 +47,15 @@
 	extern struct drive_info_struct drive_info;
 	byte cmos_disks, *BIOS = (byte *) &drive_info;
 	int unit;
+	unsigned long flags;
 
 #ifdef CONFIG_BLK_DEV_PDC4030
 	if (hwif->chipset == ide_pdc4030 && hwif->channel != 0)
 		return;
 #endif /* CONFIG_BLK_DEV_PDC4030 */
-	outb_p(0x12,0x70);		/* specify CMOS address 0x12 */
-	cmos_disks = inb_p(0x71);	/* read the data from 0x12 */
+	spin_lock_irqsave(&rtc_lock, flags);
+	cmos_disks = CMOS_READ(0x12);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 	/* Extract drive geometry from CMOS+BIOS if not already setup */
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
diff -ur linux-orig/include/asm-i386/floppy.h linux/include/asm-i386/floppy.h
--- linux-orig/include/asm-i386/floppy.h	Mon Nov 20 04:17:40 2000
+++ linux/include/asm-i386/floppy.h	Tue Jan  2 06:19:09 2001
@@ -285,8 +285,28 @@
 static int FDC1 = 0x3f0;
 static int FDC2 = -1;
 
-#define FLOPPY0_TYPE	((CMOS_READ(0x10) >> 4) & 15)
-#define FLOPPY1_TYPE	(CMOS_READ(0x10) & 15)
+/*
+ * Floppy types are stored in the rtc's CMOS RAM and so rtc_lock
+ * is needed to prevent corrupted CMOS RAM in case "insmod floppy"
+ * coincides with another rtc CMOS user.		Paul G.
+ */
+#define FLOPPY0_TYPE	({				\
+	unsigned long flags;				\
+	unsigned char val;				\
+	spin_lock_irqsave(&rtc_lock, flags);		\
+	val = (CMOS_READ(0x10) >> 4) & 15;		\
+	spin_unlock_irqrestore(&rtc_lock, flags);	\
+	val;						\
+})
+
+#define FLOPPY1_TYPE	({				\
+	unsigned long flags;				\
+	unsigned char val;				\
+	spin_lock_irqsave(&rtc_lock, flags);		\
+	val = CMOS_READ(0x10) & 15;			\
+	spin_unlock_irqrestore(&rtc_lock, flags);	\
+	val;						\
+})
 
 #define N_FDC 2
 #define N_DRIVE 8
diff -ur linux-orig/include/linux/mc146818rtc.h linux/include/linux/mc146818rtc.h
--- linux-orig/include/linux/mc146818rtc.h	Wed Jun 28 11:39:35 2000
+++ linux/include/linux/mc146818rtc.h	Tue Jan  2 05:21:51 2001
@@ -15,6 +15,8 @@
 #include <linux/rtc.h>			/* get the user-level API */
 #include <asm/mc146818rtc.h>		/* register access macros */
 
+extern spinlock_t rtc_lock;		/* serialize CMOS RAM access */
+
 /**********************************************************************
  * register summary
  **********************************************************************/
diff -ur linux-orig/include/linux/rtc.h linux/include/linux/rtc.h
--- linux-orig/include/linux/rtc.h	Wed Jul 12 04:18:51 2000
+++ linux/include/linux/rtc.h	Tue Jan  2 05:37:04 2001
@@ -2,6 +2,8 @@
  * Generic RTC interface.
  * This version contains the part of the user interface to the Real Time Clock
  * service. It is used with both the legacy mc146818 and also  EFI
+ * Struct rtc_time and first 12 ioctl by Paul Gortmaker, 1996 - separated out
+ * from <linux/mc146818rtc.h> to this file for 2.4 kernels.
  * 
  * Copyright (C) 1999 Hewlett-Packard Co.
  * Copyright (C) 1999 Stephane Eranian <eranian@hpl.hp.com>



__________________________________________________
Do You Yahoo!?
Talk to your friends online with Yahoo! Messenger.
http://im.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
