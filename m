Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWBWBEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWBWBEE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 20:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWBWBEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 20:04:00 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:18860 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750983AbWBWBD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 20:03:58 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Thu, 23 Feb 2006 02:03:16 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2/2] sd, scsi_lib: fix recognition of cache type of Initio
 SBP-2 bridges
To: stable@kernel.org, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Jody McIntyre <scjody@modernduck.com>
Message-ID: <tkrat.3b935cb9beaadbb7@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.691) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sd, scsi_lib: fix recognition of cache type of Initio SBP-2 bridges

Regardless what mode page was asked for, Initio INIC-14x0 and INIC-2430
always return page 6 without mode page headers. Check for this breakage in
scsi_mode_sense().

Taken from a patch by Al Viro <viro@ftp.linux.org.uk>.
http://marc.theaimsgroup.com/?l=linux-scsi&m=114055884611429

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Depends on patch "sd: fix memory corruption by sd_read_cache_type".

This cache type fix is applicable to 2.6.14, 2.6.15, and 2.6.16 as well
but is definitely of less importance than the memory corruption patch.

Index: linux-2.6.16-rc4/drivers/scsi/scsi_lib.c
===================================================================
--- linux-2.6.16-rc4.orig/drivers/scsi/scsi_lib.c	2006-02-22 22:27:42.000000000 +0100
+++ linux-2.6.16-rc4/drivers/scsi/scsi_lib.c	2006-02-22 22:40:50.000000000 +0100
@@ -1893,8 +1893,16 @@ scsi_mode_sense(struct scsi_device *sdev
 	}
 
 	if(scsi_status_is_good(result)) {
-		data->header_length = header_length;
-		if(use_10_for_ms) {
+		if (unlikely(buffer[0] == 0x86 && buffer[1] == 0x0b &&
+			     (modepage == 6 || modepage == 8))) {
+			/* Initio breakage? */
+			header_length = 0;
+			data->length = 13;
+			data->medium_type = 0;
+			data->device_specific = 0;
+			data->longlba = 0;
+			data->block_descriptor_length = 0;
+		} else if(use_10_for_ms) {
 			data->length = buffer[0]*256 + buffer[1] + 2;
 			data->medium_type = buffer[2];
 			data->device_specific = buffer[3];
@@ -1907,6 +1915,7 @@ scsi_mode_sense(struct scsi_device *sdev
 			data->device_specific = buffer[2];
 			data->block_descriptor_length = buffer[3];
 		}
+		data->header_length = header_length;
 	}
 
 	return result;
Index: linux-2.6.16-rc4/drivers/scsi/sd.c
===================================================================
--- linux-2.6.16-rc4.orig/drivers/scsi/sd.c	2006-02-22 22:29:10.000000000 +0100
+++ linux-2.6.16-rc4/drivers/scsi/sd.c	2006-02-22 22:40:50.000000000 +0100
@@ -1328,6 +1328,12 @@ sd_read_cache_type(struct scsi_disk *sdk
 	if (!scsi_status_is_good(res))
 		goto bad_sense;
 
+	if (!data.header_length) {
+		modepage = 6;
+		printk(KERN_ERR "%s: missing header in MODE_SENSE response\n",
+		       diskname);
+	}
+
 	/* that went OK, now ask for the proper length */
 	len = data.length;
 


