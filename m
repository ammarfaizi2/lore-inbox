Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269542AbTHJOMk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269555AbTHJOMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:12:40 -0400
Received: from Mix-Lyon-116-4-14.w80-9.abo.wanadoo.fr ([80.9.173.14]:15744
	"EHLO gaston") by vger.kernel.org with ESMTP id S269542AbTHJOMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:12:36 -0400
Subject: [PATCH] IDE (& PowerMac): Let an hwif have a real parent
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060524726.595.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Aug 2003 16:12:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus & Bart !

This patch allows an IDE hwif to be set a "parent" field so it
can really descend from any struct device, typically the macio_device
I use on pmac, and not only a PCI device or the legacy stuff.

This should work fine as long as hwif->gendev.parent doesn't
contain junk, but so far, it seems it really only contains
NULL unless specifically set by the host driver.

Without that, the pmac driver will not appear in it's proper
location in the device tree, which is a real problem for power
management as it won't be ordered properly with it's hosting
asic (and mediabay if any), thus breaking suspend/resume.

Please apply,
Ben.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1138  -> 1.1139 
#	drivers/ide/ide-probe.c	1.56    -> 1.57   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/10	benh@kernel.crashing.org	1.1139
# Allow an ide controller to have a parent that isn't the pci_dev nor
the legacy stuff
# --------------------------------------------
#
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Sun Aug 10 16:07:40 2003
+++ b/drivers/ide/ide-probe.c	Sun Aug 10 16:07:40 2003
@@ -650,10 +650,12 @@
 	strlcpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
 	snprintf(hwif->gendev.name,DEVICE_NAME_SIZE,"IDE Controller");
 	hwif->gendev.driver_data = hwif;
+	if (hwif->gendev.parent == NULL) {
 	if (hwif->pci_dev)
 		hwif->gendev.parent = &hwif->pci_dev->dev;
 	else
 		hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
+	}
 	device_register(&hwif->gendev);
 }
 

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
