Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265797AbSK1Qkm>; Thu, 28 Nov 2002 11:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbSK1Qkl>; Thu, 28 Nov 2002 11:40:41 -0500
Received: from hera.cwi.nl ([192.16.191.8]:1482 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265736AbSK1Qkj>;
	Thu, 28 Nov 2002 11:40:39 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 28 Nov 2002 17:47:53 +0100 (MET)
Message-Id: <UTC200211281647.gASGlrq03953.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] scsi/hosts.c device_register fix
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many scsi hosts do scsi_register, and when the corresponding
host is not found or fails to work, do scsi_unregister again.
Thus, actions in scsi_unregister should be the inverses of those
in scsi_register, just like actions in scsi_remove_host should be
the inverses of those in scsi_add_host.

However, device_register() is done in scsi_add_host() while the
corresponding device_unregister() is done in scsi_unregister().

This causes crashes at boot (in 2.5.49 and 2.5.50).

Below a fix. This patch was first given by James Bottomley.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
--- a/drivers/scsi/hosts.c	Thu Nov 28 15:28:19 2002
+++ b/drivers/scsi/hosts.c	Thu Nov 28 17:22:02 2002
@@ -309,7 +309,6 @@
 	printk(KERN_INFO "scsi%d : %s\n", shost->host_no,
 			sht->info ? sht->info(shost) : sht->name);
 
-	device_register(&shost->host_driverfs_dev);
 	scsi_scan_host(shost);
 			
 	list_for_each_entry (sdev, &shost->my_devices, siblings) {
@@ -358,11 +357,6 @@
  * @shost_tp:	pointer to scsi host template
  * @xtr_bytes:	extra bytes to allocate for driver
  *
- * Note:
- * 	We call this when we come across a new host adapter. We only do
- * 	this once we are 100% sure that we want to use this host adapter -
- * 	it is a pain to reverse this, so we try to avoid it 
- *
  * Return value:
  * 	Pointer to a new Scsi_Host
  **/
@@ -478,6 +472,8 @@
 
 	shost->hostt->present++;
 
+	device_register(&shost->host_driverfs_dev);
+
 	return shost;
 }
 
