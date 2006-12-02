Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162778AbWLBEhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162778AbWLBEhu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162780AbWLBEht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:37:49 -0500
Received: from mta13.mail.adelphia.net ([68.168.78.44]:32152 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S1162778AbWLBEhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:37:48 -0500
Date: Fri, 1 Dec 2006 22:37:46 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Joseph Barnett <jbarnett@motorola.com>
Subject: [PATCH 9/12] IPMI: add pigeonpoint poweroff
Message-ID: <20061202043746.GE30531@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


X86 boards generally use ACPI for the power management interactions
with the BMC.  However, non-x86 boards need some help.  This patch
adds the help for the Motorola PigeonPoint-based IPMCs.

Signed-off-by: Joseph Barnett <jbarnett@motorola.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_poweroff.c
@@ -176,6 +176,42 @@ static int ipmi_request_in_rc_mode(ipmi_
 #define IPMI_ATCA_GET_ADDR_INFO_CMD	0x01
 #define IPMI_PICMG_ID			0
 
+#define IPMI_NETFN_OEM				0x2e
+#define IPMI_ATCA_PPS_GRACEFUL_RESTART		0x11
+#define IPMI_ATCA_PPS_IANA			"\x00\x40\x0A"
+#define IPMI_MOTOROLA_MANUFACTURER_ID		0x0000A1
+#define IPMI_MOTOROLA_PPS_IPMC_PRODUCT_ID	0x0051
+
+static void (*atca_oem_poweroff_hook)(ipmi_user_t user) = NULL;
+
+static void pps_poweroff_atca (ipmi_user_t user)
+{
+        struct ipmi_system_interface_addr smi_addr;
+        struct kernel_ipmi_msg            send_msg;
+        int                               rv;
+        /*
+         * Configure IPMI address for local access
+         */
+        smi_addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+        smi_addr.channel = IPMI_BMC_CHANNEL;
+        smi_addr.lun = 0;
+
+        printk(KERN_INFO PFX "PPS powerdown hook used");
+
+        send_msg.netfn = IPMI_NETFN_OEM;
+        send_msg.cmd = IPMI_ATCA_PPS_GRACEFUL_RESTART;
+        send_msg.data = IPMI_ATCA_PPS_IANA;
+        send_msg.data_len = 3;
+        rv = ipmi_request_in_rc_mode(user,
+                                  (struct ipmi_addr *) &smi_addr,
+                                   &send_msg);
+        if (rv && rv != IPMI_UNKNOWN_ERR_COMPLETION_CODE) {
+                printk(KERN_ERR PFX "Unable to send ATCA ,"
+                       " IPMI error 0x%x\n", rv);
+        }
+	return;
+}
+
 static int ipmi_atca_detect (ipmi_user_t user)
 {
 	struct ipmi_system_interface_addr smi_addr;
@@ -201,6 +237,13 @@ static int ipmi_atca_detect (ipmi_user_t
 	rv = ipmi_request_wait_for_response(user,
 					    (struct ipmi_addr *) &smi_addr,
 					    &send_msg);
+
+        printk(KERN_INFO PFX "ATCA Detect mfg 0x%X prod 0x%X\n", mfg_id, prod_id);
+        if((mfg_id == IPMI_MOTOROLA_MANUFACTURER_ID)
+            && (prod_id == IPMI_MOTOROLA_PPS_IPMC_PRODUCT_ID)) {
+		printk(KERN_INFO PFX "Installing Pigeon Point Systems Poweroff Hook\n");
+		atca_oem_poweroff_hook = pps_poweroff_atca;
+	}
 	return !rv;
 }
 
@@ -234,12 +277,19 @@ static void ipmi_poweroff_atca (ipmi_use
 	rv = ipmi_request_in_rc_mode(user,
 				     (struct ipmi_addr *) &smi_addr,
 				     &send_msg);
-	if (rv) {
+        /** At this point, the system may be shutting down, and most
+         ** serial drivers (if used) will have interrupts turned off
+         ** it may be better to ignore IPMI_UNKNOWN_ERR_COMPLETION_CODE
+         ** return code
+         **/
+        if (rv && rv != IPMI_UNKNOWN_ERR_COMPLETION_CODE) {
 		printk(KERN_ERR PFX "Unable to send ATCA powerdown message,"
 		       " IPMI error 0x%x\n", rv);
 		goto out;
 	}
 
+	if(atca_oem_poweroff_hook)
+		return atca_oem_poweroff_hook(user);
  out:
 	return;
 }
