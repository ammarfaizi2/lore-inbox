Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161407AbWHJQpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161407AbWHJQpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWHJQpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:45:46 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:8427 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1161407AbWHJQpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:45:45 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Thu, 10 Aug 2006 18:45:16 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.16.27] ieee1394: sbp2: enable auto spin-up for Maxtor
 disks
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <44DB1F19.8000504@s5r6.in-berlin.de>
Message-ID: <tkrat.0cdc5b6163736033@s5r6.in-berlin.de>
References: <200608091749_MC3-1-C796-5E8D@compuserve.com>
 <20060809220048.GE3691@stusta.de> <44DB1F19.8000504@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least Maxtor OneTouch III require a "start stop unit" command after
auto spin-down before the next access can proceed.  This patch activates
the responsible code in scsi_mod for all Maxtor SBP-2 disks.
https://bugzilla.novell.com/show_bug.cgi?id=183011

Maybe that should be done for all SBP-2 disks, but better be cautious.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
This patch also appeared in 2.6.17.8 and 2.6.18.

Index: linux-2.6.16.27/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.16.27.orig/drivers/ieee1394/sbp2.c	2006-08-10 18:10:13.000000000 +0200
+++ linux-2.6.16.27/drivers/ieee1394/sbp2.c	2006-08-10 18:18:54.000000000 +0200
@@ -2505,6 +2505,9 @@ static int sbp2scsi_slave_configure(stru
 		SBP2_INFO("enabling iPod workaround: decrement disk capacity");
 		sdev->fix_capacity = 1;
 	}
+	if (scsi_id->ne->guid_vendor_id == 0x0010b9 && /* Maxtor's OUI */
+	    (sdev->type == TYPE_DISK || sdev->type == TYPE_RBC))
+		sdev->allow_restart = 1;
 	return 0;
 }
 


