Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTEODYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbTEODW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:22:56 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:21228 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263808AbTEODSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:25 -0400
Date: Thu, 15 May 2003 04:31:11 +0100
Message-Id: <200305150331.h4F3VBVS000687@deviant.impure.org.uk>
To: james.bottomley@steeleye.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: AM53C974 request region.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Request port before using it.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/AM53C974.c linux-2.5/drivers/scsi/AM53C974.c
--- bk-linus/drivers/scsi/AM53C974.c	2003-05-13 11:51:12.000000000 +0100
+++ linux-2.5/drivers/scsi/AM53C974.c	2003-05-13 11:59:32.000000000 +0100
@@ -732,6 +732,12 @@ static int __init  AM53C974_init(Scsi_Ho
 	hostdata->disconnecting = 0;
 	hostdata->dma_busy = 0;
 
+	if (!request_region (instance->io_port, 128, "AM53C974")) {
+		printk ("AM53C974 (scsi%d): Could not get IO region %04lx.\n",
+			instance->host_no, instance->io_port);
+		scsi_unregister(instance);
+		return 0;
+	}
 /* Set up an interrupt handler if we aren't already sharing an IRQ with another board */
 	for (search = first_host;
 	     search && (((the_template != NULL) && (search->hostt != the_template)) ||
@@ -2442,6 +2448,7 @@ static int AM53C974_reset(Scsi_Cmnd * cm
 static int AM53C974_release(struct Scsi_Host *shp)
 {
 	free_irq(shp->irq, shp);
+	release_region(shp->io_port, 128);
 	scsi_unregister(shp);
 	return 0;
 }
