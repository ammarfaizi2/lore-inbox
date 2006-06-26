Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933346AbWFZWmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933346AbWFZWmr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933341AbWFZWmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:42:46 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:54967 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933353AbWFZWmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:44 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 28/28] [Suspend2] Swapwriter load and unload routines.
Date: Tue, 27 Jun 2006 08:42:42 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224241.4975.32854.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines invoked with the swapwriter is loaded or unloaded.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index b04e2f3..7939ad2 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -1204,3 +1204,46 @@ static struct suspend_module_ops swapwri
 	.parse_sig_location	= swapwriter_parse_sig_location,
 };
        
+/* ---- Registration ---- */
+static __init int swapwriter_load(void)
+{
+	int result;
+	int i, numfiles = sizeof(swapwriter_proc_data) / sizeof(struct suspend_proc_data);
+	
+	printk("Suspend2 Swap Writer loading.\n");
+
+	swapwriterops.rw_init = suspend_bio_ops.rw_init;
+	swapwriterops.rw_cleanup = suspend_bio_ops.rw_cleanup;
+	swapwriterops.read_chunk = suspend_bio_ops.read_chunk;
+	swapwriterops.write_chunk = suspend_bio_ops.write_chunk;
+	swapwriterops.rw_header_chunk = suspend_bio_ops.rw_header_chunk;
+
+	if (!(result = suspend_register_module(&swapwriterops))) {
+
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&swapwriter_proc_data[i]);
+	} else
+		printk("Suspend2 Swap Writer unable to register!\n");
+	return result;
+}
+
+#ifdef MODULE
+static __exit void swapwriter_unload(void)
+{
+	int i, numfiles = sizeof(swapwriter_proc_data) / sizeof(struct suspend_proc_data);
+
+	printk("Suspend2 Swap Writer unloading.\n");
+
+	for (i=0; i< numfiles; i++)
+		suspend_unregister_procfile(&swapwriter_proc_data[i]);
+	suspend_unregister_module(&swapwriterops);
+}
+
+module_init(swapwriter_load);
+module_exit(swapwriter_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Suspend2 swap writer");
+#else
+late_initcall(swapwriter_load);
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
