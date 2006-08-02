Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWHBRnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWHBRnv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWHBRnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:43:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:21440 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932110AbWHBRnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:43:50 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 2 Aug 2006 19:40:06 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc3, 2.6.17.7] ieee1394: sbp2: enable auto spin-up for
 Maxtor disks
To: Linus Torvalds <torvalds@osdl.org>, stable@kernel.org
cc: linux-kernel@vger.kernel.org, Ben Collins <bcollins@ubuntu.com>
Message-ID: <tkrat.f5b216d7ca35e7f2@s5r6.in-berlin.de>
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
This patch is also available from the ieee1394 git tree:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/linux1394-2.6.git;a=commitdiff;h=31a379e1067834868b8f1ce3e409392c42dc0f2b

Fixes loss of connection if an external Maxtor disk automatically went
into power saving mode.

Enthusiasts may pick up a variant of this patch for 2.6.16.y at
https://bugzilla.novell.com/show_bug.cgi?id=183011#c6

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
 


