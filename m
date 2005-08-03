Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVHCXIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVHCXIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVHCXGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:06:11 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:55763 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261537AbVHCXFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:05:31 -0400
Message-ID: <42F14DB7.6010000@acm.org>
Date: Wed, 03 Aug 2005 18:05:27 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] IPMI driver update part 5, OEM flag handling and hacks for
 some Dell machines
Content-Type: multipart/mixed;
 boundary="------------070901090704060408030407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070901090704060408030407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------070901090704060408030407
Content-Type: unknown/unknown;
 name="ipmi-add-per-OEM-data-available-handlers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-add-per-OEM-data-available-handlers.patch"

The ipmi driver does not have a way to handle firmware-generated
events which have the OEM[012] Data Available flags set.  In such a
case, the SMS_ATN bit may never get cleared by firmware, leaving the
driver looping infinitely but never able to make any progress.

This patch first simplifies storage and use of the data returned from
an IPMI Get Device ID command.

It then creates a new per-OEM handler hook, which should know how to
handle events with the OEM[012] Data Available flags set.  It then
uses this to implement a workaround for IPMI 1.5-capable Dell
PowerEdge servers which are susceptable to setting the OEM[012] Data
Available flags when the driver can't handle it.


Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_si_intf.c
@@ -109,6 +109,21 @@
     SI_KCS, SI_SMIC, SI_BT
 };
 
+struct ipmi_device_id {
+	unsigned char device_id;
+	unsigned char device_revision;
+	unsigned char firmware_revision_1;
+	unsigned char firmware_revision_2;
+	unsigned char ipmi_version;
+	unsigned char additional_device_support;
+	unsigned char manufacturer_id[3];
+	unsigned char product_id[2];
+	unsigned char aux_firmware_revision[4];
+} __attribute__((packed));
+
+#define ipmi_version_major(v) ((v)->ipmi_version & 0xf)
+#define ipmi_version_minor(v) ((v)->ipmi_version >> 4)
+
 struct smi_info
 {
 	ipmi_smi_t             intf;
@@ -131,12 +146,24 @@
 	void (*irq_cleanup)(struct smi_info *info);
 	unsigned int io_size;
 
+	/* Per-OEM handler, called from handle_flags().
+	   Returns 1 when handle_flags() needs to be re-run
+	   or 0 indicating it set si_state itself.
+	*/
+	int (*oem_data_avail_handler)(struct smi_info *smi_info);
+
 	/* Flags from the last GET_MSG_FLAGS command, used when an ATTN
 	   is set to hold the flags until we are done handling everything
 	   from the flags. */
 #define RECEIVE_MSG_AVAIL	0x01
 #define EVENT_MSG_BUFFER_FULL	0x02
 #define WDT_PRE_TIMEOUT_INT	0x08
+#define OEM0_DATA_AVAIL     0x20
+#define OEM1_DATA_AVAIL     0x40
+#define OEM2_DATA_AVAIL     0x80
+#define OEM_DATA_AVAIL      (OEM0_DATA_AVAIL | \
+                             OEM1_DATA_AVAIL | \
+                             OEM2_DATA_AVAIL)
 	unsigned char       msg_flags;
 
 	/* If set to true, this will request events the next time the
@@ -175,11 +202,7 @@
 	   interrupts. */
 	int interrupt_disabled;
 
-	unsigned char ipmi_si_dev_rev;
-	unsigned char ipmi_si_fw_rev_major;
-	unsigned char ipmi_si_fw_rev_minor;
-	unsigned char ipmi_version_major;
-	unsigned char ipmi_version_minor;
+	struct ipmi_device_id device_id;
 
 	/* Slave address, could be reported from DMI. */
 	unsigned char slave_addr;
@@ -322,6 +345,7 @@
 
 static void handle_flags(struct smi_info *smi_info)
 {
+ retry:
 	if (smi_info->msg_flags & WDT_PRE_TIMEOUT_INT) {
 		/* Watchdog pre-timeout */
 		spin_lock(&smi_info->count_lock);
@@ -371,6 +395,10 @@
 			smi_info->curr_msg->data,
 			smi_info->curr_msg->data_size);
 		smi_info->si_state = SI_GETTING_EVENTS;
+	} else if (smi_info->msg_flags & OEM_DATA_AVAIL) {
+		if (smi_info->oem_data_avail_handler)
+			if (smi_info->oem_data_avail_handler(smi_info))
+				goto retry;
 	} else {
 		smi_info->si_state = SI_NORMAL;
 	}
@@ -1998,11 +2026,8 @@
 	}
 
 	/* Record info from the get device id, in case we need it. */
-	smi_info->ipmi_si_dev_rev = resp[4] & 0xf;
-	smi_info->ipmi_si_fw_rev_major = resp[5] & 0x7f;
-	smi_info->ipmi_si_fw_rev_minor = resp[6];
-	smi_info->ipmi_version_major = resp[7] & 0xf;
-	smi_info->ipmi_version_minor = resp[7] >> 4;
+	memcpy(&smi_info->device_id, &resp[3],
+	       min_t(unsigned long, resp_len-3, sizeof(smi_info->device_id)));
 
  out:
 	kfree(resp);
@@ -2063,6 +2088,72 @@
 	return (out - ((char *) page));
 }
 
+/*
+ * oem_data_avail_to_receive_msg_avail
+ * @info - smi_info structure with msg_flags set
+ *
+ * Converts flags from OEM_DATA_AVAIL to RECEIVE_MSG_AVAIL
+ * Returns 1 indicating need to re-run handle_flags().
+ */
+static int oem_data_avail_to_receive_msg_avail(struct smi_info *smi_info)
+{
+	smi_info->msg_flags = (smi_info->msg_flags & ~OEM_DATA_AVAIL) |
+		RECEIVE_MSG_AVAIL;
+	return 1;
+}
+
+/*
+ * setup_dell_poweredge_oem_data_handler
+ * @info - smi_info.device_id must be populated
+ *
+ * Systems that match, but have firmware version < 1.40 may assert
+ * OEM0_DATA_AVAIL on their own, without being told via Set Flags that
+ * it's safe to do so.  Such systems will de-assert OEM1_DATA_AVAIL
+ * upon receipt of IPMI_GET_MSG_CMD, so we should treat these flags
+ * as RECEIVE_MSG_AVAIL instead.
+ *
+ * As Dell has no plans to release IPMI 1.5 firmware that *ever*
+ * assert the OEM[012] bits, and if it did, the driver would have to
+ * change to handle that properly, we don't actually check for the
+ * firmware version.
+ * Device ID = 0x20                BMC on PowerEdge 8G servers
+ * Device Revision = 0x80
+ * Firmware Revision1 = 0x01       BMC version 1.40
+ * Firmware Revision2 = 0x40       BCD encoded
+ * IPMI Version = 0x51             IPMI 1.5
+ * Manufacturer ID = A2 02 00      Dell IANA
+ *
+ */
+#define DELL_POWEREDGE_8G_BMC_DEVICE_ID  0x20
+#define DELL_POWEREDGE_8G_BMC_DEVICE_REV 0x80
+#define DELL_POWEREDGE_8G_BMC_IPMI_VERSION 0x51
+#define DELL_IANA_MFR_ID {0xA2, 0x02, 0x00}
+static void setup_dell_poweredge_oem_data_handler(struct smi_info *smi_info)
+{
+	struct ipmi_device_id *id = &smi_info->device_id;
+	const char mfr[3]=DELL_IANA_MFR_ID;
+	if (!memcmp(mfr, id->manufacturer_id, sizeof(mfr)) &&
+	    id->device_id       == DELL_POWEREDGE_8G_BMC_DEVICE_ID &&
+	    id->device_revision == DELL_POWEREDGE_8G_BMC_DEVICE_REV &&
+	    id->ipmi_version    == DELL_POWEREDGE_8G_BMC_IPMI_VERSION) {
+		smi_info->oem_data_avail_handler =
+			oem_data_avail_to_receive_msg_avail;
+	}
+}
+
+/*
+ * setup_oem_data_handler
+ * @info - smi_info.device_id must be filled in already
+ *
+ * Fills in smi_info.device_id.oem_data_available_handler
+ * when we know what function to use there.
+ */
+
+static void setup_oem_data_handler(struct smi_info *smi_info)
+{
+	setup_dell_poweredge_oem_data_handler(smi_info);
+}
+
 /* Returns 0 if initialized, or negative on an error. */
 static int init_one_smi(int intf_num, struct smi_info **smi)
 {
@@ -2161,6 +2252,8 @@
 	if (rv)
 		goto out_err;
 
+	setup_oem_data_handler(new_smi);
+
 	/* Try to claim any interrupts. */
 	new_smi->irq_setup(new_smi);
 
@@ -2194,8 +2287,8 @@
 
 	rv = ipmi_register_smi(&handlers,
 			       new_smi,
-			       new_smi->ipmi_version_major,
-			       new_smi->ipmi_version_minor,
+			       ipmi_version_major(&new_smi->device_id),
+			       ipmi_version_minor(&new_smi->device_id),
 			       new_smi->slave_addr,
 			       &(new_smi->intf));
 	if (rv) {

--------------070901090704060408030407--
