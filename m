Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288930AbSBEGLX>; Tue, 5 Feb 2002 01:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288958AbSBEGLN>; Tue, 5 Feb 2002 01:11:13 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:11454 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S288930AbSBEGK6>; Tue, 5 Feb 2002 01:10:58 -0500
Date: Tue, 5 Feb 2002 08:04:20 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Jens Axboe <axboe@suse.de>
Cc: Manuel McLure <manuel@mclure.org>, <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, Dave Jones <davej@suse.de>
Subject: [PATCH] Re: 2.4.17 Oops when trying to mount ATAPI CDROM
In-Reply-To: <20020204085929.P29553@suse.de>
Message-ID: <Pine.LNX.4.44.0202050759060.2739-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to fix the oops as encountered by Manuel McLure

Quick browse of the trace...

<snip>
Code;  c0193030 <config_drive_xfer_rate+d0/110>
    0:   8a 15 63 00 00 00         mov    0x63,%dl <== Oops happens here
Code;  c0193036 <config_drive_xfer_rate+d6/110>
    6:   83 e2 08                  and    $0x8,%edx <== [1]
<snip>

specific_chipset_driver.c:
config_drive_xfer_rate (ide_drive_t *drive)
{
	struct hd_driveid *id	= drive->id;
[...]
	if (id && (id->capability & 1) && HWIF(drive)->autodma) { <== [1]
[...]
	} else if ((id->capability & 8) \ <== 2
	|| (id->field_valid & 2)) {
<snip>

[1] In this case we get to 2 because we failed the if (id) check, but then we don't check again...

Patch diffed against 2.4.18-pre7 and applies to 2.5.3-pre6 with offsets.

--- linux-2.4.18-pre7/drivers/ide/aec62xx.c.orig	Mon Feb  4 22:35:54 2002
+++ linux-2.4.18-pre7/drivers/ide/aec62xx.c	Mon Feb  4 23:00:19 2002
@@ -445,7 +445,10 @@
 	struct hd_driveid *id = drive->id;
 	ide_dma_action_t dma_func = ide_dma_on;
 
-	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
+	if (id == NULL)
+		goto done;
+
+	if ((id->capability & 1) && HWIF(drive)->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
 			dma_func = ide_dma_off;
@@ -486,6 +489,7 @@
 no_dma_set:
 		aec62xx_tune_drive(drive, 5);
 	}
+done:
 	return HWIF(drive)->dmaproc(dma_func, drive);
 }
 
--- linux-2.4.18-pre7/drivers/ide/amd74xx.c.orig	Mon Feb  4 22:36:29 2002
+++ linux-2.4.18-pre7/drivers/ide/amd74xx.c	Mon Feb  4 23:00:30 2002
@@ -344,7 +344,10 @@
 	struct hd_driveid *id = drive->id;
 	ide_dma_action_t dma_func = ide_dma_on;
 
-	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
+	if (id == NULL)
+		goto done;
+
+	if ((id->capability & 1) && HWIF(drive)->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
 			dma_func = ide_dma_off;
@@ -388,6 +391,7 @@
 
 		config_chipset_for_pio(drive);
 	}
+done:
 	return HWIF(drive)->dmaproc(dma_func, drive);
 }
 
--- linux-2.4.18-pre7/drivers/ide/hpt34x.c.orig	Mon Feb  4 22:36:51 2002
+++ linux-2.4.18-pre7/drivers/ide/hpt34x.c	Mon Feb  4 22:56:37 2002
@@ -255,7 +255,10 @@
 	struct hd_driveid *id = drive->id;
 	ide_dma_action_t dma_func = ide_dma_on;
 
-	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
+	if (id == NULL)
+		goto done;
+
+	if ((id->capability & 1) && HWIF(drive)->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
 			dma_func = ide_dma_off;
@@ -302,6 +305,7 @@
 		dma_func = ide_dma_off;
 #endif /* CONFIG_HPT34X_AUTODMA */
 
+done:
 	return HWIF(drive)->dmaproc(dma_func, drive);
 }
 
--- linux-2.4.18-pre7/drivers/ide/hpt366.c.orig	Mon Feb  4 22:37:18 2002
+++ linux-2.4.18-pre7/drivers/ide/hpt366.c	Mon Feb  4 23:00:03 2002
@@ -553,7 +553,10 @@
 	struct hd_driveid *id = drive->id;
 	ide_dma_action_t dma_func = ide_dma_on;
 
-	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
+	if (id == NULL)
+		goto done;
+
+	if ((id->capability & 1) && HWIF(drive)->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
 			dma_func = ide_dma_off;
@@ -594,6 +597,7 @@
 
 		config_chipset_for_pio(drive);
 	}
+done:
 	return HWIF(drive)->dmaproc(dma_func, drive);
 }
 
--- linux-2.4.18-pre7/drivers/ide/pdc202xx.c.orig	Mon Feb  4 22:37:39 2002
+++ linux-2.4.18-pre7/drivers/ide/pdc202xx.c	Mon Feb  4 23:04:00 2002
@@ -677,7 +677,10 @@
 	ide_hwif_t *hwif = HWIF(drive);
 	ide_dma_action_t dma_func = ide_dma_off_quietly;
 
-	if (id && (id->capability & 1) && hwif->autodma) {
+	if (id == NULL)
+		goto done;
+
+	if ((id->capability & 1) && hwif->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
 			dma_func = ide_dma_off;
@@ -718,7 +721,7 @@
 no_dma_set:
 		(void) config_chipset_for_pio(drive, 5);
 	}
-
+done:
 	return HWIF(drive)->dmaproc(dma_func, drive);
 }
 
--- linux-2.4.18-pre7/drivers/ide/piix.c.orig	Mon Feb  4 22:37:57 2002
+++ linux-2.4.18-pre7/drivers/ide/piix.c	Tue Feb  5 01:00:26 2002
@@ -417,7 +417,10 @@
 	struct hd_driveid *id = drive->id;
 	ide_dma_action_t dma_func = ide_dma_on;
 
-	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
+	if (id == NULL)
+		goto done;
+
+	if ((id->capability & 1) && HWIF(drive)->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
 			dma_func = ide_dma_off;
@@ -458,6 +461,7 @@
 no_dma_set:
 		config_chipset_for_pio(drive);
 	}
+done:
 	return HWIF(drive)->dmaproc(dma_func, drive);
 }
 
--- linux-2.4.18-pre7/drivers/ide/serverworks.c.orig	Mon Feb  4 22:38:16 2002
+++ linux-2.4.18-pre7/drivers/ide/serverworks.c	Mon Feb  4 23:05:07 2002
@@ -450,7 +450,10 @@
 	struct hd_driveid *id = drive->id;
 	ide_dma_action_t dma_func = ide_dma_on;
 
-	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
+	if (id == NULL)
+		goto done;
+
+	if ((id->capability & 1) && HWIF(drive)->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
 			dma_func = ide_dma_off;
@@ -491,6 +494,7 @@
 no_dma_set:
 		config_chipset_for_pio(drive);
 	}
+done:
 	return HWIF(drive)->dmaproc(dma_func, drive);
 }
 
--- linux-2.4.18-pre7/drivers/ide/sis5513.c.orig	Mon Feb  4 22:22:42 2002
+++ linux-2.4.18-pre7/drivers/ide/sis5513.c	Tue Feb  5 00:59:43 2002
@@ -506,8 +506,11 @@
 {
 	struct hd_driveid *id		= drive->id;
 	ide_dma_action_t dma_func	= ide_dma_off_quietly;
+	
+	if (id == NULL)
+		goto done;
 
-	if (id && (id->capability & 1) && HWIF(drive)->autodma) {
+	if ((id->capability & 1) && HWIF(drive)->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
 			dma_func = ide_dma_off;
@@ -546,7 +549,7 @@
 no_dma_set:
 		(void) config_chipset_for_pio(drive, 5);
 	}
-
+done:
 	return HWIF(drive)->dmaproc(dma_func, drive);
 }
 

