Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbUBHWnU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 17:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbUBHWnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 17:43:20 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:36790 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264245AbUBHWmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 17:42:50 -0500
Date: Sun, 8 Feb 2004 17:42:48 -0500
From: Willem Riede <wrlk@riede.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Selective attach for ide-scsi
Message-ID: <20040208224248.GA28026@serve.riede.org>
Reply-To: wrlk@riede.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today, if you boot 2.6.x with hdd=ide-scsi, ide-scsi will attach to
all your Atapi drives, not just hdd, unless you explicitely specified
another driver for those.

Given that we don't want people to use ide-scsi for cdroms and cd-writers,
that behavior is IMHO suboptimal.

The patch below makes ide-scsi attach ONLY to those drives that you tell
it to. So if you want it to handle hdb and hdd, but not hdc, you boot
with hdb=ide-scsi hdd=ide-scsi.

Regards, Willem Riede.

--- p0/drivers/scsi/ide-scsi.c	2004-01-31 10:29:11.000000000 -0500
+++ a1/drivers/scsi/ide-scsi.c	2004-02-08 16:40:19.000000000 -0500
@@ -955,17 +955,18 @@
 	static int warned;
 	int err;
 
-	if (!warned && drive->media == ide_cdrom) {
-		printk(KERN_WARNING "ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device\n");
-		warned = 1;
-	}
-
-	if (!strstr("ide-scsi", drive->driver_req) ||
+	if (!drive->driver_req ||
+	    !strstr(drive->driver_req, "ide-scsi") ||
 	    !drive->present ||
 	    drive->media == ide_disk ||
 	    !(host = scsi_host_alloc(&idescsi_template,sizeof(idescsi_scsi_t))))
 		return 1;
 
+	if (!warned && drive->media == ide_cdrom) {
+		printk(KERN_WARNING "ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device\n");
+		warned = 1;
+	}
+
 	host->max_id = 1;
 	host->max_lun = 1;
 	drive->driver_data = host;
