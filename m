Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265810AbRGJG5L>; Tue, 10 Jul 2001 02:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265841AbRGJG5C>; Tue, 10 Jul 2001 02:57:02 -0400
Received: from patan.Sun.COM ([192.18.98.43]:7916 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S265810AbRGJG4r>;
	Tue, 10 Jul 2001 02:56:47 -0400
Message-ID: <3B4AA8EB.D1F6947C@sun.com>
Date: Tue, 10 Jul 2001 00:04:11 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org, alan@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  IDE configurable max failures
Content-Type: multipart/mixed;
 boundary="------------27993A3F6111B6579ABDDCB4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------27993A3F6111B6579ABDDCB4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre et al,

Attached is a small patch to add a configurable maximum failure count for
IDE drives.  It has been very useful for us.

Please let me know if there is any reason this can not be included in the
mainline kernel.

Thanks

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------27993A3F6111B6579ABDDCB4
Content-Type: text/plain; charset=us-ascii;
 name="ide_failures.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_failures.diff"

diff -ruN dist-2.4.6/drivers/ide/ide.c cobalt-2.4.6/drivers/ide/ide.c
--- dist-2.4.6/drivers/ide/ide.c	Tue May  1 16:05:00 2001
+++ cobalt-2.4.6/drivers/ide/ide.c	Thu Jun 21 15:32:31 2001
@@ -161,6 +162,9 @@
 #include <linux/kmod.h>
 #endif /* CONFIG_KMOD */
 
+/* default maximum number of failures */
+#define IDE_DEFAULT_MAX_FAILURES 	1
+
 static const byte ide_hwif_to_major[] = { IDE0_MAJOR, IDE1_MAJOR, IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR, IDE5_MAJOR, IDE6_MAJOR, IDE7_MAJOR, IDE8_MAJOR, IDE9_MAJOR };
 
 static int	idebus_parameter; /* holds the "idebus=" parameter */
@@ -262,6 +267,7 @@
 		drive->name[0]			= 'h';
 		drive->name[1]			= 'd';
 		drive->name[2]			= 'a' + (index * MAX_DRIVES) + unit;
+		drive->max_failures		= IDE_DEFAULT_MAX_FAILURES;
 		init_waitqueue_head(&drive->wqueue);
 	}
 }
@@ -636,11 +642,14 @@
 			return ide_started;	/* continue polling */
 		}
 		printk("%s: reset timed-out, status=0x%02x\n", hwif->name, tmp);
+		drive->failures++;
 	} else  {
 		printk("%s: reset: ", hwif->name);
-		if ((tmp = GET_ERR()) == 1)
+		if ((tmp = GET_ERR()) == 1) {
 			printk("success\n");
-		else {
+			drive->failures = 0;
+		} else {
+			drive->failures++;
 #if FANCY_STATUS_DUMPS
 			printk("master: ");
 			switch (tmp & 0x7f) {
@@ -1048,6 +1057,12 @@
 	int i;
 	unsigned long flags;
  
+	/* bail early if we've exceeded max_failures */
+	if (drive->max_failures && (drive->failures > drive->max_failures)) {
+		*startstop = ide_stopped;
+		return 1;
+	}
+
 	udelay(1);	/* spec allows drive 400ns to assert "BUSY" */
 	if ((stat = GET_STAT()) & BUSY_STAT) {
 		__save_flags(flags);	/* local CPU only */
@@ -1144,6 +1159,11 @@
 #ifdef DEBUG
 	printk("%s: start_request: current=0x%08lx\n", hwif->name, (unsigned long) rq);
 #endif
+	/* bail early if we've exceeded max_failures */
+	if (drive->max_failures && (drive->failures > drive->max_failures)) {
+		goto kill_rq;
+	}
+
 	if (unit >= MAX_DRIVES) {
 		printk("%s: bad device number: %s\n", hwif->name, kdevname(rq->rq_dev));
 		goto kill_rq;
diff -ruN dist-2.4.6/drivers/ide/ide-disk.c cobalt-2.4.6/drivers/ide/ide-disk.c
--- dist-2.4.6/drivers/ide/ide-disk.c	Fri Feb  9 11:30:23 2001
+++ cobalt-2.4.6/drivers/ide/ide-disk.c	Tue Jun 26 14:29:44 2001
@@ -692,6 +692,8 @@
 	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	INT_MAX,			1,	1024,	&max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"max_kb_per_request",	SETTING_RW,					BLKSECTGET,		BLKSECTSET,		TYPE_INTA,	1,	255,				1,	2,	&max_sectors[major][minor],	NULL);
 	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
+	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
+	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }
 
 /*
diff -ruN dist-2.4.6/include/linux/ide.h cobalt-2.4.6/include/linux/ide.h
--- dist-2.4.6/include/linux/ide.h	Tue Jul  3 15:44:16 2001
+++ cobalt-2.4.6/include/linux/ide.h	Mon Jul  9 15:56:19 2001
@@ -349,6 +350,8 @@
 	byte		init_speed;	/* transfer rate set at boot */
 	byte		current_speed;	/* current transfer rate set */
 	byte		dn;		/* now wide spread use */
+	unsigned int	failures;	/* current failure count */
+	unsigned int	max_failures;	/* maximum allowed failure count */
 } ide_drive_t;
 
 /*

--------------27993A3F6111B6579ABDDCB4--

