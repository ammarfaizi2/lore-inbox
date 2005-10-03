Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbVJCTpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbVJCTpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVJCTpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:45:31 -0400
Received: from mail.dvmed.net ([216.237.124.58]:38814 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932393AbVJCTpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:45:30 -0400
Message-ID: <43418A54.8080709@pobox.com>
Date: Mon, 03 Oct 2005 15:45:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] libata: improve device scan
Content-Type: multipart/mixed;
 boundary="------------090501050800040601080002"
X-Spam-Score: 0.5 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  The attached patch changes libata device scanning from
	using the legacy "bang at the door" method of probing devices, to one
	that calls scsi_scan_target() for each target (ATA device) that the
	libata transport layer found. [...] 
	Content analysis details:   (0.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501050800040601080002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


The attached patch changes libata device scanning from using the legacy 
"bang at the door" method of probing devices, to one that calls 
scsi_scan_target() for each target (ATA device) that the libata 
transport layer found.

Completely untested, feedback welcome.  This should improve the speed of 
SATA probing a tad, and certainly makes it quite a bit less ugly.

This might get moved, eventually, into an ATA transport class, depending 
on how things shape up in the future.

	Jeff




--------------090501050800040601080002
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4113,7 +4113,7 @@ int ata_device_add(struct ata_probe_ent 
 	for (i = 0; i < count; i++) {
 		struct ata_port *ap = host_set->ports[i];
 
-		scsi_scan_host(ap->host);
+		ata_scsi_scan_host(ap);
 	}
 
 	dev_set_drvdata(dev, host_set);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1678,3 +1678,15 @@ void ata_scsi_simulate(u16 *id,
 	}
 }
 
+void ata_scsi_scan_host(struct ata_port *ap)
+{
+	unsigned int i;
+
+	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+		return;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (ata_dev_present(&ap->device[i]))
+			scsi_scan_target(&ap->host->shost_gendev, 0, i, ~0, 0);
+}
+
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -51,6 +51,7 @@ extern void swap_buf_le16(u16 *buf, unsi
 
 
 /* libata-scsi.c */
+extern void ata_scsi_scan_host(struct ata_port *ap);
 extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,

--------------090501050800040601080002--
