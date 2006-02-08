Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030605AbWBHUb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030605AbWBHUb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbWBHUb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:31:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36541 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030605AbWBHUb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:31:28 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] don't mangle INQUIRY if cmddt or evpd bits are set
Cc: linux1394-devel@lists.sourceforge.net
Message-Id: <E1F6vyJ-00009k-3Z@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 20:31:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1139425740 -0500

sbp2.c mangles INQUIRY response in a way that only applies to standard
inquiry data (i.e. when both cmddt and evpd bits are 0).  Leave other cases
alone; e.g. when asking for VPD the length of reply is in byte 3, not 4
and byte 4 is the first byte of device serial number.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/ieee1394/sbp2.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

91d2006e216b5205a4fd076b73985a2f643c33e3
diff --git a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
index 18d7eda..c2c776f 100644
--- a/drivers/ieee1394/sbp2.c
+++ b/drivers/ieee1394/sbp2.c
@@ -2082,9 +2082,7 @@ static void sbp2_check_sbp2_response(str
 
 	SBP2_DEBUG("sbp2_check_sbp2_response");
 
-	switch (SCpnt->cmnd[0]) {
-
-	case INQUIRY:
+	if (SCpnt->cmnd[0] == INQUIRY && (SCpnt->cmnd[1] & 3) == 0) {
 		/*
 		 * Make sure data length is ok. Minimum length is 36 bytes
 		 */
@@ -2097,13 +2095,7 @@ static void sbp2_check_sbp2_response(str
 		 */
 		scsi_buf[2] |= 2;
 		scsi_buf[3] = (scsi_buf[3] & 0xf0) | 2;
-
-		break;
-
-	default:
-		break;
 	}
-	return;
 }
 
 /*
-- 
0.99.9.GIT

