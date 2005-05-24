Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVEXJwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVEXJwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVEXJvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:51:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:60871 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262045AbVEXJjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:39:10 -0400
Message-ID: <4292F631.9090300@suse.de>
Date: Tue, 24 May 2005 11:38:57 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix reference counting for failed SCSI devices
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060606080201000100040007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060606080201000100040007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi James,

whenever the scsi-ml tries to scan non-existent devices the reference
count in scsi_alloc_sdev() and scsi_probe_and_add_lun() is not adjusted
properly. Every call to XXX_initialize in the driver core sets the
reference count to 1, so for a proper deallocation an explicit XXX_put()
has to be done.

Please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------060606080201000100040007
Content-Type: text/plain;
 name="linux-2.6.12-rc4-scsi-scan-fix-refcount-on-fail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.12-rc4-scsi-scan-fix-refcount-on-fail"

From: Hannes Reinecke <hare@suse.de>
Subject: Fix refcount for failed devices

When a non-present device is scanned it is not properly deregistered
from the driver core. Calling XXX_initialize() functions from the driver
core sets the reference count to 1, so for proper deallocation a
XXX_put() has to be issued.

--- linux-2.6.12-rc4/drivers/scsi/scsi_scan.c.orig	2005-05-24 10:26:46.000000000 +0200
+++ linux-2.6.12-rc4/drivers/scsi/scsi_scan.c	2005-05-24 10:55:52.000000000 +0200
@@ -273,6 +273,7 @@ static struct scsi_device *scsi_alloc_sd
 			 */
 			if (ret == -ENXIO)
 				display_failure_msg = 0;
+			put_device(&starget->dev);
 			goto out_device_destroy;
 		}
 	}
@@ -282,6 +283,7 @@ static struct scsi_device *scsi_alloc_sd
 out_device_destroy:
 	transport_destroy_device(&sdev->sdev_gendev);
 	scsi_free_queue(sdev->request_queue);
+	class_device_put(&sdev->sdev_classdev);
 	put_device(&sdev->sdev_gendev);
 out:
 	if (display_failure_msg)
@@ -855,6 +857,8 @@ static int scsi_probe_and_add_lun(struct
 		if (sdev->host->hostt->slave_destroy)
 			sdev->host->hostt->slave_destroy(sdev);
 		transport_destroy_device(&sdev->sdev_gendev);
+		class_device_put(&sdev->sdev_classdev);
+		put_device(sdev->sdev_gendev.parent);
 		put_device(&sdev->sdev_gendev);
 	}
  out:

--------------060606080201000100040007--
