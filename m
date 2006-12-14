Return-Path: <linux-kernel-owner+w=401wt.eu-S1751940AbWLNB01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbWLNB01 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWLNB01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:26:27 -0500
Received: from web50113.mail.yahoo.com ([206.190.39.150]:29157 "HELO
	web50113.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751940AbWLNB00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:26:26 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 20:26:25 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=B/X3T+ej+qSp31jfQzckLoBeEDOEEDafN7aexZwffsKIgON3gOepCgfm8fqgfFeygy+FVtKxbpvaIlZqPonyTlGSDnum1IE1iGEHXU9lTLiRFAOYY3krxvk4qB8WP4BiDoSzBsH5V1cZSoNRRcbpxUwG/jF67BeP7heRZMxKK7U=;
X-YMail-OSG: Sk2bfu4VM1k8DPt0SghWxCGyd0ZkTeDGMRSdAj17aQ_JP7RQRzsQQ3QE0Lj06.TQWYdcx90VQ_5fSB3zBB0kn9NjI0GBJGW7FA9RWwagOlUngY7ZUU2IgeGBasmc0hU.v6dYWZ6slHY-
Date: Wed, 13 Dec 2006 17:19:43 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 3/3] EDAC: Add Fully-Buffered DIMM APIs to core
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <236399.13106.qm@web50113.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: eric wollesen <ericw@xmtp.net>

Eric Wollesen ported the Bluesmoke Memory Controller driver for the
Intel
5000X/V/P (Blackford/Greencreek) chipset to the in kernel EDAC model.

This patch incorporates those required changes to the edac_mc.c and
edac_mc.h
core files by added new Fully Buffered DIMM interface to the EDAC Core
module.


Signed-off-by:		eric wollesen <ericw@xmtp.net>
Signed-off-by:		doug thompson <norsk5@xmission.com>

 edac_mc.c    |  120 ++++
 edac_mc.h    |   16


Index: linux-2.6.19/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.19.orig/drivers/edac/edac_mc.c
+++ linux-2.6.19/drivers/edac/edac_mc.c
@@ -1441,11 +1441,11 @@ int edac_mc_add_mc(struct mem_ctl_info *
 	/* set load time so that error rate can be tracked */
 	mci->start_time = jiffies;
 
-        if (edac_create_sysfs_mci_device(mci)) {
-                edac_mc_printk(mci, KERN_WARNING,
+	if (edac_create_sysfs_mci_device(mci)) {
+		edac_mc_printk(mci, KERN_WARNING,
 			"failed to create sysfs device\n");
-                goto fail1;
-        }
+		goto fail1;
+	}
 
 	/* Report action taken */
 	edac_mc_printk(mci, KERN_INFO, "Giving out device to %s %s: DEV
%s\n",
@@ -1702,6 +1702,116 @@ void edac_mc_handle_ue_no_info(struct me
 EXPORT_SYMBOL_GPL(edac_mc_handle_ue_no_info);
 
 
+/*************************************************************
+ * On Fully Buffered DIMM modules, this help function is
+ * called to process UE events
+ */
+void edac_mc_handle_fbd_ue(struct mem_ctl_info *mci,
+				unsigned int csrow,
+				unsigned int channela,
+				unsigned int channelb,
+				char *msg)
+{
+	int len = EDAC_MC_LABEL_LEN * 4;
+	char labels[len + 1];
+	char *pos = labels;
+	int chars;
+
+	if (csrow >= mci->nr_csrows) {
+		/* something is wrong */
+		edac_mc_printk(mci, KERN_ERR,
+			"INTERNAL ERROR: row out of range (%d >= %d)\n",
+			csrow, mci->nr_csrows);
+		edac_mc_handle_ue_no_info(mci, "INTERNAL ERROR");
+		return;
+	}
+
+	if (channela >= mci->csrows[csrow].nr_channels) {
+		/* something is wrong */
+		edac_mc_printk(mci, KERN_ERR,
+			"INTERNAL ERROR: channel-a out of range "
+			"(%d >= %d)\n",
+			channela, mci->csrows[csrow].nr_channels);
+		edac_mc_handle_ue_no_info(mci, "INTERNAL ERROR");
+		return;
+	}
+
+	if (channelb >= mci->csrows[csrow].nr_channels) {
+		/* something is wrong */
+		edac_mc_printk(mci, KERN_ERR,
+			"INTERNAL ERROR: channel-b out of range "
+			"(%d >= %d)\n",
+			channelb, mci->csrows[csrow].nr_channels);
+		edac_mc_handle_ue_no_info(mci, "INTERNAL ERROR");
+		return;
+	}
+
+	mci->ue_count++;
+	mci->csrows[csrow].ue_count++;
+
+	/* Generate the DIMM labels from the specified channels */
+	chars = snprintf(pos, len + 1, "%s",
+			 mci->csrows[csrow].channels[channela].label);
+	len -= chars; pos += chars;
+	chars = snprintf(pos, len + 1, "-%s",
+			 mci->csrows[csrow].channels[channelb].label);
+
+	if (log_ue)
+		edac_mc_printk(mci, KERN_EMERG,
+			"UE row %d, channel-a= %d channel-b= %d "
+			"labels \"%s\": %s\n", csrow, channela, channelb,
+			labels, msg);
+
+	if (panic_on_ue)
+		panic("UE row %d, channel-a= %d channel-b= %d "
+				"labels \"%s\": %s\n", csrow, channela,
+				channelb, labels, msg);
+}
+EXPORT_SYMBOL(edac_mc_handle_fbd_ue);
+
+/*************************************************************
+ * On Fully Buffered DIMM modules, this help function is
+ * called to process CE events
+ */
+void edac_mc_handle_fbd_ce(struct mem_ctl_info *mci,
+			   unsigned int csrow,
+			   unsigned int channel,
+			   char *msg)
+{
+
+	/* Ensure boundary values */
+	if (csrow >= mci->nr_csrows) {
+		/* something is wrong */
+		edac_mc_printk(mci, KERN_ERR,
+			"INTERNAL ERROR: row out of range (%d >= %d)\n",
+			csrow, mci->nr_csrows);
+		edac_mc_handle_ce_no_info(mci, "INTERNAL ERROR");
+		return;
+	}
+	if (channel >= mci->csrows[csrow].nr_channels) {
+		/* something is wrong */
+		edac_mc_printk(mci, KERN_ERR,
+			"INTERNAL ERROR: channel out of range (%d >= %d)\n",
+			channel, mci->csrows[csrow].nr_channels);
+		edac_mc_handle_ce_no_info(mci, "INTERNAL ERROR");
+		return;
+	}
+
+	if (log_ce)
+		/* FIXME - put in DIMM location */
+		edac_mc_printk(mci, KERN_WARNING,
+			"CE row %d, channel %d, label \"%s\": %s\n",
+			csrow, channel,
+			mci->csrows[csrow].channels[channel].label,
+			msg);
+
+	mci->ce_count++;
+	mci->csrows[csrow].ce_count++;
+	mci->csrows[csrow].channels[channel].ce_count++;
+}
+EXPORT_SYMBOL(edac_mc_handle_fbd_ce);
+
+
 /*
  * Iterate over all MC instances and check for ECC, et al, errors
  */
@@ -1805,7 +1915,7 @@ static void __exit edac_mc_exit(void)
 	debugf0("%s()\n", __func__);
 	kthread_stop(edac_thread);
 
-        /* tear down the sysfs device */
+	/* tear down the sysfs device */
 	edac_sysfs_memctrl_teardown();
 	edac_sysfs_pci_teardown();
 }
Index: linux-2.6.19/drivers/edac/edac_mc.h
===================================================================
--- linux-2.6.19.orig/drivers/edac/edac_mc.h
+++ linux-2.6.19/drivers/edac/edac_mc.h
@@ -123,7 +123,9 @@ enum mem_type {
 	MEM_RDR,		/* Registered single data rate SDRAM */
 	MEM_DDR,		/* Double data rate SDRAM */
 	MEM_RDDR,		/* Registered Double data rate SDRAM */
-	MEM_RMBS		/* Rambus DRAM */
+	MEM_RMBS,		/* Rambus DRAM */
+	MEM_DDR2,               /* DDR2 RAM */
+	MEM_FB_DDR2,            /* fully buffered DDR2 */
 };
 
 #define MEM_FLAG_EMPTY		BIT(MEM_EMPTY)
@@ -137,6 +139,8 @@ enum mem_type {
 #define MEM_FLAG_DDR		BIT(MEM_DDR)
 #define MEM_FLAG_RDDR		BIT(MEM_RDDR)
 #define MEM_FLAG_RMBS		BIT(MEM_RMBS)
+#define MEM_FLAG_DDR2           BIT(MEM_DDR2)
+#define MEM_FLAG_FB_DDR2        BIT(MEM_FB_DDR2)
 
 /* chipset Error Detection and Correction capabilities and mode */
 enum edac_type {
@@ -317,6 +321,7 @@ struct mem_ctl_info {
 
 	/* pointer to edac checking routine */
 	void (*edac_check) (struct mem_ctl_info * mci);
+
 	/*
 	 * Remaps memory pages: controller pages to physical pages.
 	 * For most MC's, this will be NULL.
@@ -441,6 +446,15 @@ extern void edac_mc_handle_ue(struct mem
 		int row, const char *msg);
 extern void edac_mc_handle_ue_no_info(struct mem_ctl_info *mci,
 		const char *msg);
+extern void edac_mc_handle_fbd_ue(struct mem_ctl_info *mci,
+		unsigned int csrow,
+		unsigned int channel0,
+		unsigned int channel1,
+		char *msg);
+extern void edac_mc_handle_fbd_ce(struct mem_ctl_info *mci,
+		unsigned int csrow,
+		unsigned int channel,
+		char *msg);
 
 /*
  * This kmalloc's and initializes all the structures.

