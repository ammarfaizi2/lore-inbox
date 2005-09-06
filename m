Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVIFXhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVIFXhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVIFXhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:37:38 -0400
Received: from serv01.siteground.net ([70.85.91.68]:39110 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751059AbVIFXhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:37:37 -0400
Date: Tue, 6 Sep 2005 16:37:37 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: [patch 1/4] ide: Break ide_lock -- Move hwif tuning code after hwif_init
Message-ID: <20050906233737.GB3642@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906233322.GA3642@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch moves the hwif tuning code from probe_hwif to ideprobe_init
after ideprobe_init calls hwif_init so that all hwif's have associated
hwgroups.  With this patch, we should always have hwgroups for hwifs during
calls the drive tune routines.


Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.13/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide-probe.c	2005-09-06 11:22:29.000000000 -0700
+++ linux-2.6.13/drivers/ide/ide-probe.c	2005-09-06 15:12:58.000000000 -0700
@@ -852,8 +852,15 @@
 
 	if (!hwif->present) {
 		ide_hwif_release_regions(hwif);
-		return;
 	}
+}
+
+static void ide_tune_drives(ide_hwif_t * hwif)
+{
+	unsigned int unit;
+
+	if (!hwif->present)
+		return;
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
@@ -1443,9 +1450,12 @@
 	for (index = 0; index < MAX_HWIFS; ++index)
 		if (probe[index])
 			probe_hwif(&ide_hwifs[index]);
-	for (index = 0; index < MAX_HWIFS; ++index)
-		if (probe[index])
+	for (index = 0; index < MAX_HWIFS; ++index) {
+		if (probe[index]) {
 			hwif_init(&ide_hwifs[index]);
+			ide_tune_drives(&ide_hwifs[index]);
+		}
+	}
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		if (probe[index]) {
 			ide_hwif_t *hwif = &ide_hwifs[index];
