Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264772AbTFBAbY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 20:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbTFBAbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 20:31:23 -0400
Received: from h-64-105-35-138.SNVACAID.covad.net ([64.105.35.138]:18304 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S264774AbTFBAbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 20:31:20 -0400
Date: Sun, 1 Jun 2003 17:45:09 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200306020045.h520j9v15291@freya.yggdrasil.com>
To: linux-ide@vger.kernel.org
Subject: Re: 2.5.70-bk[56] breaks disk partitioning with multiple IDE disks
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	To add to my own posting, here is a patch to 2.5.70-bk6
that reverts only the changes that replaced ata_unused with
idedeault_driver.drives.  This change makes bk6 work for me with
multiple IDE disk drives present.

	I have tried a number of smaller changes to stock
2.5.70-bk6/drivers/ide/ide.c, but, I have not yet found a change
simpler than this that works.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.70-bk6/drivers/ide/ide.c	2003-06-01 12:01:28.000000000 -0700
+++ linux/drivers/ide/ide.c	2003-06-01 16:52:28.000000000 -0700
@@ -462,6 +462,7 @@
 	return -ENXIO;
 }
 
+static LIST_HEAD(ata_unused);
 static spinlock_t drives_lock = SPIN_LOCK_UNLOCKED;
 static spinlock_t drivers_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(drivers);
@@ -1436,6 +1437,9 @@
 	spin_unlock(&drivers_lock);
 	if(idedefault_driver.attach(drive) != 0)
 		panic("ide: default attach failed");
+	spin_lock(&drives_lock);
+	list_add_tail(&drive->list, &ata_unused);
+	spin_unlock(&drives_lock);
 	return 1;
 }
 
@@ -2379,8 +2383,8 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 	spin_lock(&drives_lock);
 	list_del_init(&drive->list);
+	list_add(&drive->list, &drive->driver->drives);
 	spin_unlock(&drives_lock);
-	/* drive will be added to &idedefault_driver->drives in ata_attach() */
 	return 0;
 }
 
@@ -2403,9 +2407,9 @@
 	list_add(&driver->drivers, &drivers);
 	spin_unlock(&drivers_lock);
 
-	INIT_LIST_HEAD(&list);
 	spin_lock(&drives_lock);
-	list_splice_init(&idedefault_driver.drives, &list);
+	INIT_LIST_HEAD(&list);
+	list_splice_init(&ata_unused, &list);
 	spin_unlock(&drives_lock);
 
 	list_for_each_safe(list_loop, tmp_storage, &list) {
