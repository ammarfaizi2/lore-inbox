Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWIGXpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWIGXpl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWIGXpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:45:41 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52629 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751887AbWIGXpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:45:38 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 8 Sep 2006 01:44:21 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2/2 update] ieee1394: sbp2: enable auto spin-up for all SBP-2
 devices
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <tkrat.9abbd263c892fb65@s5r6.in-berlin.de>
Message-ID: <tkrat.9c13b9c231f12b4f@s5r6.in-berlin.de>
References: <tkrat.9abbd263c892fb65@s5r6.in-berlin.de>
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
Patch updated (refreshed) to be applicable without the obsolete patch
"ieee1394: sbp2: workaround for write protect bit of Initio firmware".

Intendend to be dropped into the same place in -mm's order of patches as
before. It's not hard to resolve it manually though.

Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-09-06 23:43:34.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-09-06 23:46:47.000000000 +0200
@@ -2441,6 +2441,7 @@ static int sbp2scsi_slave_alloc(struct s
 		(struct scsi_id_instance_data *)sdev->host->hostdata[0];
 
 	scsi_id->sdev = sdev;
+	sdev->allow_restart = 1;
 
 	if (scsi_id->workarounds & SBP2_WORKAROUND_INQUIRY_36)
 		sdev->inquiry_len = 36;
@@ -2461,9 +2462,6 @@ static int sbp2scsi_slave_configure(stru
 		sdev->skip_ms_page_8 = 1;
 	if (scsi_id->workarounds & SBP2_WORKAROUND_FIX_CAPACITY)
 		sdev->fix_capacity = 1;
-	if (scsi_id->ne->guid_vendor_id == 0x0010b9 && /* Maxtor's OUI */
-	    (sdev->type == TYPE_DISK || sdev->type == TYPE_RBC))
-		sdev->allow_restart = 1;
 	return 0;
 }
 


