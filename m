Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUHPPlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUHPPlZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267806AbUHPPk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:40:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30188 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267743AbUHPPci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:32:38 -0400
Date: Mon, 16 Aug 2004 11:31:39 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: deal with further ITE funny, fix a couple of ite8212 errors
Message-ID: <20040816153139.GA14715@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Further stuff c/o Bryce the wondertester


--- drivers/ide/ide-probe.c~	2004-08-16 16:19:05.830364888 +0100
+++ drivers/ide/ide-probe.c	2004-08-16 16:19:05.831364736 +0100
@@ -784,6 +784,8 @@
 			if(strcmp(hwif->drives[0].id->model, drive->id->model) == 0 &&
 			   /* Don't do this for noprobe or non ATA */
 			   strcmp(drive->id->model, "UNKNOWN") &&
+			   /* ITE haven't got this figured out either (see the quirk code too) */
+			   !strstr(drive->id->model, "Integrated Technology Express") &&
 			   /* And beware of confused Maxtor drives that go "M0000000000" 
 			      "The SN# is garbage in the ID block..." [Eric] */
 			   strncmp(drive->id->serial_no, "M0000000000000000000", 20) && 
--- drivers/ide/pci/it8212.c~	2004-08-16 16:22:09.545435952 +0100
+++ drivers/ide/pci/it8212.c	2004-08-16 16:14:23.251323432 +0100
@@ -78,7 +78,7 @@
 
 struct it8212_dev
 {
-	int smart:1,			/* Are we in smart raid mode */
+	unsigned int smart:1,		/* Are we in smart raid mode */
 		timing10:1;		/* Rev 0x10 */
 	u8	clock_mode;		/* 0, ATA_50 or ATA_66 */
 	u8	want[2][2];		/* Mode/Pri log for master slave */
@@ -652,7 +652,7 @@
 		printk(KERN_ERR "it8212: out of memory, falling back to legacy behaviour.\n");
 		goto fallback;
 	}
-	memset(idev, 0, sizeof(*idev));
+	memset(idev, 0, sizeof(struct it8212_dev));
 	ide_set_hwifdata(hwif, idev);
 
 	hwif->remove = it8212_memfree;
