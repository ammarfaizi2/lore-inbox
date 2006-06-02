Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWFBUM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWFBUM6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWFBUM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:12:58 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:2514 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932554AbWFBUM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:12:57 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 22:11:17 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 10/18] sbp2: log number of supported concurrent
 logins
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
Message-ID: <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
 <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
 <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.261) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is useful information, promote it from a debug macro to
a regular log message.  The message appears only if the user set
exclusive_login=0, therefore won't clutter the logs in normal use.
Also update the comment on exclusive_login.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Jody McIntyre <scjody@modernduck.com>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/sbp2.c	2006-06-01 20:55:43.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c	2006-06-01 20:55:44.000000000 +0200
@@ -127,10 +127,12 @@ MODULE_PARM_DESC(max_sectors, "Change ma
  * talking to a single sbp2 device at the same time (filesystem coherency,
  * etc.). If you're running an sbp2 device that supports multiple logins,
  * and you're either running read-only filesystems or some sort of special
- * filesystem supporting multiple hosts (one such filesystem is OpenGFS,
- * see opengfs.sourceforge.net for more info), then set exclusive_login
- * to zero. Note: The Oxsemi OXFW911 sbp2 chipset supports up to four
- * concurrent logins.
+ * filesystem supporting multiple hosts, e.g. OpenGFS, Oracle Cluster
+ * File System, or Lustre, then set exclusive_login to zero.
+ *
+ * So far only bridges from Oxford Semiconductor are known to support
+ * concurrent logins. Depending on firmware, four or two concurrent logins
+ * are possible on OXFW911 and newer Oxsemi bridges.
  */
 static int exclusive_login = 1;
 module_param(exclusive_login, int, 0644);
@@ -1214,13 +1216,11 @@ static int sbp2_query_logins(struct scsi
 	SBP2_DEBUG("length_max_logins = %x",
 		   (unsigned int)scsi_id->query_logins_response->length_max_logins);
 
-	SBP2_DEBUG("Query logins to SBP-2 device successful");
-
 	max_logins = RESPONSE_GET_MAX_LOGINS(scsi_id->query_logins_response->length_max_logins);
-	SBP2_DEBUG("Maximum concurrent logins supported: %d", max_logins);
+	SBP2_INFO("Maximum concurrent logins supported: %d", max_logins);
 
 	active_logins = RESPONSE_GET_ACTIVE_LOGINS(scsi_id->query_logins_response->length_max_logins);
-	SBP2_DEBUG("Number of active logins: %d", active_logins);
+	SBP2_INFO("Number of active logins: %d", active_logins);
 
 	if (active_logins >= max_logins) {
 		return -EIO;


