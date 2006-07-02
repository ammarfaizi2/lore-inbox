Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWGBWyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWGBWyv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 18:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWGBWyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 18:54:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:17365 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751053AbWGBWyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 18:54:51 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 00:54:38 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 01/19] ieee1394: sbp2: enable auto spin-up for Maxtor disks
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.257693ae9d8cf587@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.903) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least Maxtor OneTouch III require a "start stop unit" command after
auto spin-down before the next access can proceed.  This patch activates
the responsible code in scsi_mod for all Maxtor SBP-2 disks.
https://bugzilla.novell.com/show_bug.cgi?id=183011

Maybe that should be done for all SBP-2 disks, but better be cautious.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-07-01 09:37:55.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-07-01 09:41:33.000000000 +0200
@@ -2515,6 +2515,9 @@ static int sbp2scsi_slave_configure(stru
 		sdev->skip_ms_page_8 = 1;
 	if (scsi_id->workarounds & SBP2_WORKAROUND_FIX_CAPACITY)
 		sdev->fix_capacity = 1;
+	if (scsi_id->ne->guid_vendor_id == 0x0010b9 && /* Maxtor's OUI */
+	    (sdev->type == TYPE_DISK || sdev->type == TYPE_RBC))
+		sdev->allow_restart = 1;
 	return 0;
 }
 


