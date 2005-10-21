Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVJUOxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVJUOxo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVJUOxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:53:43 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:16594 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964967AbVJUOxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:53:42 -0400
Date: Fri, 21 Oct 2005 09:53:40 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: Matt_Domsch@dell.com
Subject: [PATCH 5/9] ipmi: more dell fixes
Message-ID: <20051021145340.GE19532@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make SMIC driver ignore EVT_AVAIL and SMS_ATN bits in flags register,
as they're used by systems management interrupts, not the host OS.

Make the OEM0 Data Available handler work for pre-IPMI 1.5 systems
from Dell too.

Without these two fixes, PowerEdge 2650 and other similar systems with
SMIC may hang a process (modprobe or anything using /dev/ipmi0).

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.14-rc2/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.14-rc2/drivers/char/ipmi/ipmi_si_intf.c
@@ -2052,6 +2052,9 @@ static int oem_data_avail_to_receive_msg
  * IPMI Version = 0x51             IPMI 1.5
  * Manufacturer ID = A2 02 00      Dell IANA
  *
+ * Additionally, PowerEdge systems with IPMI < 1.5 may also assert
+ * OEM0_DATA_AVAIL and needs to be treated as RECEIVE_MSG_AVAIL.
+ *
  */
 #define DELL_POWEREDGE_8G_BMC_DEVICE_ID  0x20
 #define DELL_POWEREDGE_8G_BMC_DEVICE_REV 0x80
@@ -2061,13 +2064,19 @@ static void setup_dell_poweredge_oem_dat
 {
 	struct ipmi_device_id *id = &smi_info->device_id;
 	const char mfr[3]=DELL_IANA_MFR_ID;
-	if (! memcmp(mfr, id->manufacturer_id, sizeof(mfr))
-	    && (id->device_id       == DELL_POWEREDGE_8G_BMC_DEVICE_ID)
-	    && (id->device_revision == DELL_POWEREDGE_8G_BMC_DEVICE_REV)
-	    && (id->ipmi_version    == DELL_POWEREDGE_8G_BMC_IPMI_VERSION))
-	{
-		smi_info->oem_data_avail_handler =
-			oem_data_avail_to_receive_msg_avail;
+	if (! memcmp(mfr, id->manufacturer_id, sizeof(mfr))) {
+		if (id->device_id       == DELL_POWEREDGE_8G_BMC_DEVICE_ID  &&
+		    id->device_revision == DELL_POWEREDGE_8G_BMC_DEVICE_REV &&
+		    id->ipmi_version    == DELL_POWEREDGE_8G_BMC_IPMI_VERSION) {
+			smi_info->oem_data_avail_handler =
+				oem_data_avail_to_receive_msg_avail;
+		}
+		else if (ipmi_version_major(id) < 1 ||
+			 (ipmi_version_major(id) == 1 &&
+			  ipmi_version_minor(id) < 5)) {
+			smi_info->oem_data_avail_handler =
+				oem_data_avail_to_receive_msg_avail;
+		}
 	}
 }
 
Index: linux-2.6.14-rc2/drivers/char/ipmi/ipmi_smic_sm.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/char/ipmi/ipmi_smic_sm.c
+++ linux-2.6.14-rc2/drivers/char/ipmi/ipmi_smic_sm.c
@@ -81,6 +81,12 @@ enum smic_states {
 /* SMIC Flags Register Bits */
 #define SMIC_RX_DATA_READY	0x80
 #define SMIC_TX_DATA_READY	0x40
+/*
+ * SMIC_SMI and SMIC_EVM_DATA_AVAIL are only used by
+ * a few systems, and then only by Systems Management
+ * Interrupts, not by the OS.  Always ignore these bits.
+ *
+ */
 #define SMIC_SMI		0x10
 #define SMIC_EVM_DATA_AVAIL	0x08
 #define SMIC_SMS_DATA_AVAIL	0x04
@@ -364,8 +370,7 @@ static enum si_sm_result smic_event (str
 	switch (smic->state) {
 	case SMIC_IDLE:
 		/* in IDLE we check for available messages */
-		if (flags & (SMIC_SMI |
-			     SMIC_EVM_DATA_AVAIL | SMIC_SMS_DATA_AVAIL))
+		if (flags & SMIC_SMS_DATA_AVAIL)
 		{
 			return SI_SM_ATTN;
 		}
