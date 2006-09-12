Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWILPfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWILPfz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWILPfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:35:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8394 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751328AbWILPfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:35:54 -0400
Subject: [PATCH] libata: improve handling of diagostic fail (and hardware
	that misreports it)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 16:55:12 +0100
Message-Id: <1158076512.6780.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Our ATA probe code checks that a device is not reporting a diagnostic
failure during start up. Unfortunately at least one device seems to like
doing this - the Gigabyte iRAM.

This is only done for the master right now (which is fine for the iRAM
as it is SATA), as with PATA some combinations of ATAPI device seem to
fool the check into seeing a drive that isn't there if it is applied to
the slave.

Please review

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ata/libata-core.c linux-2.6.18-rc6-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/ata/libata-core.c	2006-09-11 17:00:08.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/ata/libata-core.c	2006-09-12 11:18:34.000000000 +0100
@@ -616,8 +616,11 @@
 	if (r_err)
 		*r_err = err;
 
-	/* see if device passed diags */
-	if (err == 1)
+	/* see if device passed diags: if master then continue and warn later */
+	if (err == 0 && device == 0)
+		/* diagnostic fail : do nothing _YET_ */
+		ap->device[device].horkage |= ATA_HORKAGE_DIAGNOSTIC;
+	else if(err == 1)
 		/* do nothing */ ;
 	else if ((device == 0) && (err == 0x81))
 		/* do nothing */ ;
@@ -1523,6 +1526,18 @@
 				       cdb_intr_string);
 	}
 
+	if (dev->horkage & ATA_HORKAGE_DIAGNOSTIC) {
+		/* Let the user know. We don't want to disallow opens for
+		   rescue purposes, or in case the vendor is just a blithering
+		   idiot */
+                if (print_info) {
+			ata_dev_printk(dev, KERN_WARNING,
+"Drive reports diagnostics failure. This may indicate a drive\n");
+			ata_dev_printk(dev, KERN_WARNING,
+"fault or invalid emulation. Contact drive vendor for information.\n");
+		}
+	}
+
 	ata_set_port_max_cmd_len(ap);
 
 	/* limit bridge transfers to udma5, 200 sectors */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/include/linux/libata.h linux-2.6.18-rc6-mm1/include/linux/libata.h
--- linux.vanilla-2.6.18-rc6-mm1/include/linux/libata.h	2006-09-11 17:00:24.000000000 +0100
+++ linux-2.6.18-rc6-mm1/include/linux/libata.h	2006-09-11 17:21:16.000000000 +0100
@@ -289,6 +289,11 @@
 	 * most devices.
 	 */
 	ATA_SPINUP_WAIT		= 8000,
+	
+	/* Horkage types. May be set by libata or controller on drives
+	   (some horkage may be drive/controller pair dependant */
+
+	ATA_HORKAGE_DIAGNOSTIC	= 1,		/* Failed boot diag */
 };
 
 enum hsm_task_states {
@@ -469,6 +474,7 @@
 
 	/* error history */
 	struct ata_ering	ering;
+	unsigned int		horkage;	/* List of broken features */
 };
 
 /* Offset into struct ata_device.  Fields above it are maintained

