Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbVIATFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVIATFU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVIATFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:05:20 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:42643 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030313AbVIATFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:05:20 -0400
Subject: [PATCH] Add hacks for IPMI chassis poweroff for certain Dell
	servers
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-MnJQ5zsG71TK+/V1a4n0"
Date: Thu, 01 Sep 2005 14:05:14 -0500
Message-Id: <1125601514.25115.10.camel@i2.minyard.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MnJQ5zsG71TK+/V1a4n0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-MnJQ5zsG71TK+/V1a4n0
Content-Disposition: attachment; filename=ipmi-dell-poweroff-hack.patch
Content-Type: text/x-patch; name=ipmi-dell-poweroff-hack.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit


This patch allows Dell servers with IPMI controllers that predate IPMI
1.5 to use the standard poweroff or powercycle commands.  These
systems firmware don't set the chassis capability bit in the Get
Device ID, but they do implement the standard poweroff and powercycle
commands.

Tested on RHEL3 kernel 2.4.21-20.ELsmp on a PowerEdge 2600.  The
standard ipmi_poweroff driver cannot drive these systems.  With this
patch, they power off or powercycle as expected.

 drivers/char/ipmi/ipmi_poweroff.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.13/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.13.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.13/drivers/char/ipmi/ipmi_poweroff.c
@@ -64,6 +64,7 @@ MODULE_PARM_DESC(poweroff_control, " Set
 static unsigned int mfg_id;
 static unsigned int prod_id;
 static unsigned char capabilities;
+static unsigned char ipmi_version;
 
 /* We use our own messages for this operation, we don't let the system
    allocate them, since we may be in a panic situation.  The whole
@@ -339,6 +340,25 @@ static void ipmi_poweroff_cpi1 (ipmi_use
 }
 
 /*
+ * ipmi_dell_chassis_detect()
+ * Dell systems with IPMI < 1.5 don't set the chassis capability bit
+ * but they can handle a chassis poweroff or powercycle command.
+ */
+
+#define DELL_IANA_MFR_ID {0xA2, 0x02, 0x00}
+static int ipmi_dell_chassis_detect (ipmi_user_t user)
+{
+	const char ipmi_version_major = ipmi_version & 0xF;
+	const char ipmi_version_minor = (ipmi_version >> 4) & 0xF;
+	const char mfr[3]=DELL_IANA_MFR_ID;
+	if (!memcmp(mfr, &mfg_id, sizeof(mfr)) &&
+	    ipmi_version_major <= 1 &&
+	    ipmi_version_minor < 5)
+		return 1;
+	return 0;
+}
+
+/*
  * Standard chassis support
  */
 
@@ -415,6 +435,9 @@ static struct poweroff_function poweroff
 	{ .platform_type	= "CPI1",
 	  .detect		= ipmi_cpi1_detect,
 	  .poweroff_func	= ipmi_poweroff_cpi1 },
+	{ .platform_type	= "chassis",
+	  .detect		= ipmi_dell_chassis_detect,
+	  .poweroff_func	= ipmi_poweroff_chassis },
 	/* Chassis should generally be last, other things should override
 	   it. */
 	{ .platform_type	= "chassis",
@@ -500,6 +523,7 @@ static void ipmi_po_new_smi(int if_num)
 	prod_id = (halt_recv_msg.msg.data[10]
 		   | (halt_recv_msg.msg.data[11] << 8));
 	capabilities = halt_recv_msg.msg.data[6];
+	ipmi_version = halt_recv_msg.msg.data[5];
 
 
 	/* Scan for a poweroff method */

--=-MnJQ5zsG71TK+/V1a4n0--

