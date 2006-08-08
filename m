Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWHHT0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWHHT0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWHHT0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:26:21 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:31667 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030229AbWHHT0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:26:21 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Tue, 8 Aug 2006 21:25:22 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 4/4] ieee1394: sbp2: enable auto spin-up for all SBP-2 devices
To: linux-kernel@vger.kernel.org
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.57bb8cb1b7c97d1e@s5r6.in-berlin.de>
Message-ID: <tkrat.24bcdb35a499bac0@s5r6.in-berlin.de>
References: <tkrat.57bb8cb1b7c97d1e@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to patch "ieee1394: sbp2: enable auto spin-up for
Maxtor disks".  When I 'ejected' an OXUF922 based HDD from a Mac OS X
box, it was spun down by the Mac and did not spin up by itself when
attached to a Linux box right after that.  The first SCSI command that
required the bridge to access the drive ended in
sda:<6>sd 18:0:0:0: Device not ready: <6>: Current: sense key: Not Ready
    Additional sense: Logical unit not ready, initializing cmd. required

Therefore the flag which instructs scsi_mod to send START STOP UNIT with
START=1 ("make medium ready") after such a condition is now enabled
unconditionally for all FireWire storage devices.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-08-05 16:58:30.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-08-07 20:13:59.000000000 +0200
@@ -2451,6 +2451,7 @@ static int sbp2scsi_slave_alloc(struct s
 		(struct scsi_id_instance_data *)sdev->host->hostdata[0];
 
 	scsi_id->sdev = sdev;
+	sdev->allow_restart = 1;
 
 	if (scsi_id->workarounds & SBP2_WORKAROUND_INQUIRY_36)
 		sdev->inquiry_len = 36;
@@ -2473,9 +2474,6 @@ static int sbp2scsi_slave_configure(stru
 		sdev->fix_capacity = 1;
 	if (scsi_id->workarounds & SBP2_WORKAROUND_MODE_SENSE_6)
 		sdev->use_10_for_ms = 0;
-	if (scsi_id->ne->guid_vendor_id == 0x0010b9 && /* Maxtor's OUI */
-	    (sdev->type == TYPE_DISK || sdev->type == TYPE_RBC))
-		sdev->allow_restart = 1;
 	return 0;
 }
 


