Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVJUOzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVJUOzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVJUOzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:55:04 -0400
Received: from sccrmhc13.comcast.net ([63.240.77.83]:30361 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964967AbVJUOzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:55:01 -0400
Date: Fri, 21 Oct 2005 09:54:59 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: Matt_Domsch@dell.com
Subject: [PATCH 6/9] ipmi: si start transaction hook
Message-ID: <20051021145459.GF19532@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some commands, on some system BMCs, don't respond at at all.  This is
seen on Dell PowerEdge x6xx and x7xx systems with IPMI 1.0 BT
controllers when a "Get SDR" command is issued, with a length field of
0x3A, which happens to be the length of about SDR entries.  If another
length is passed, this command succeeds.

This patch adds general infrastructure for receiving commands before
they're passed down to the low-level drivers, such that they can be
completed immediately, or modified, prior to being sent to
->start_transaction().

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.ipmi/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.ipmi.orig/drivers/char/ipmi/ipmi_si_intf.c	2005-10-06 08:12:36.%N -0500
+++ linux-2.6.ipmi/drivers/char/ipmi/ipmi_si_intf.c	2005-10-07 15:47:27.%N -0500
@@ -51,6 +51,7 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
+#include <linux/notifier.h>
 #include <asm/irq.h>
 #ifdef CONFIG_HIGH_RES_TIMERS
 #include <linux/hrtime.h>
@@ -222,6 +223,12 @@
 	unsigned long incoming_messages;
 };
 
+static struct notifier_block *xaction_notifier_list;
+static int register_xaction_notifier(struct notifier_block * nb)
+{
+	return notifier_chain_register(&xaction_notifier_list, nb);
+}
+
 static void si_restart_short_timer(struct smi_info *smi_info);
 
 static void deliver_recv_msg(struct smi_info *smi_info,
@@ -281,6 +288,11 @@
 		do_gettimeofday(&t);
 		printk("**Start2: %d.%9.9d\n", t.tv_sec, t.tv_usec);
 #endif
+		err = notifier_call_chain(&xaction_notifier_list, 0, smi_info);
+		if (err & NOTIFY_STOP_MASK) {
+			rv = SI_SM_CALL_WITHOUT_DELAY;
+			goto out;
+		}
 		err = smi_info->handlers->start_transaction(
 			smi_info->si_sm,
 			smi_info->curr_msg->data,
@@ -291,6 +303,7 @@
 
 		rv = SI_SM_CALL_WITHOUT_DELAY;
 	}
+	out:
 	spin_unlock(&(smi_info->msg_lock));
 
 	return rv;
@@ -2080,6 +2093,71 @@
 	}
 }
 
+#define CANNOT_RETURN_REQUESTED_LENGTH 0xCA
+static void return_hosed_msg_badsize(struct smi_info *smi_info)
+{
+	struct ipmi_smi_msg *msg = smi_info->curr_msg;
+
+	/* Make it a reponse */
+	msg->rsp[0] = msg->data[0] | 4;
+	msg->rsp[1] = msg->data[1];
+	msg->rsp[2] = CANNOT_RETURN_REQUESTED_LENGTH;
+	msg->rsp_size = 3;
+	smi_info->curr_msg = NULL;
+	deliver_recv_msg(smi_info, msg);
+}
+
+/*
+ * dell_poweredge_bt_xaction_handler
+ * @info - smi_info.device_id must be populated
+ *
+ * Dell PowerEdge servers with the BT interface (x6xx and 1750) will
+ * not respond to a Get SDR command if the length of the data
+ * requested is exactly 0x3A, which leads to command timeouts and no
+ * data returned.  This intercepts such commands, and causes userspace
+ * callers to try again with a different-sized buffer, which succeeds.
+ */
+
+#define STORAGE_NETFN 0x0A
+#define STORAGE_CMD_GET_SDR 0x23
+static int dell_poweredge_bt_xaction_handler(struct notifier_block *self,
+					     unsigned long unused,
+					     void *in)
+{
+	struct smi_info *smi_info = in;
+	unsigned char *data = smi_info->curr_msg->data;
+	unsigned int size   = smi_info->curr_msg->data_size;
+	if (size >= 8 &&
+	    (data[0]>>2) == STORAGE_NETFN &&
+	    data[1] == STORAGE_CMD_GET_SDR &&
+	    data[7] == 0x3A) {
+		return_hosed_msg_badsize(smi_info);
+		return NOTIFY_STOP;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block dell_poweredge_bt_xaction_notifier = {
+	.notifier_call	= dell_poweredge_bt_xaction_handler,
+};
+
+/*
+ * setup_dell_poweredge_bt_xaction_handler
+ * @info - smi_info.device_id must be filled in already
+ *
+ * Fills in smi_info.device_id.start_transaction_pre_hook
+ * when we know what function to use there.
+ */
+static void
+setup_dell_poweredge_bt_xaction_handler(struct smi_info *smi_info)
+{
+	struct ipmi_device_id *id = &smi_info->device_id;
+	const char mfr[3]=DELL_IANA_MFR_ID;
+ 	if (! memcmp(mfr, id->manufacturer_id, sizeof(mfr)) &&
+	    smi_info->si_type == SI_BT)
+		register_xaction_notifier(&dell_poweredge_bt_xaction_notifier);
+}
+
 /*
  * setup_oem_data_handler
  * @info - smi_info.device_id must be filled in already
@@ -2093,6 +2171,11 @@
 	setup_dell_poweredge_oem_data_handler(smi_info);
 }
 
+static void setup_xaction_handlers(struct smi_info *smi_info)
+{
+	setup_dell_poweredge_bt_xaction_handler(smi_info);
+}
+
 /* Returns 0 if initialized, or negative on an error. */
 static int init_one_smi(int intf_num, struct smi_info **smi)
 {
@@ -2188,6 +2271,7 @@
 		goto out_err;
 
 	setup_oem_data_handler(new_smi);
+	setup_xaction_handlers(new_smi);
 
 	/* Try to claim any interrupts. */
 	new_smi->irq_setup(new_smi);
