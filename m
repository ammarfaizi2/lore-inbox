Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933318AbWFZWlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318AbWFZWlQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933316AbWFZWlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:41:13 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:35511 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933312AbWFZWlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:05 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 35/35] [Suspend2] Filewriter load/unload routines.
Date: Tue, 27 Jun 2006 08:41:03 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224102.4685.78601.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Load and unload procedures for the filewriter. Set fields in the ops
structure from the block writer, register with the core and register proc
entries. Do the reverse on unload.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   44 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 56c7a76..1d8b296 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -1095,3 +1095,47 @@ static struct suspend_module_ops filewri
 	.parse_sig_location	= filewriter_parse_sig_location,
 };
 
+/* ---- Registration ---- */
+static __init int filewriter_load(void)
+{
+	int result;
+	int i, numfiles = sizeof(filewriter_proc_data) / sizeof(struct suspend_proc_data);
+	
+	printk("Suspend2 FileWriter loading.\n");
+
+	filewriterops.read_chunk = suspend_bio_ops.read_chunk;
+	filewriterops.write_chunk = suspend_bio_ops.write_chunk;
+	filewriterops.rw_init = suspend_bio_ops.rw_init;
+	filewriterops.rw_cleanup = suspend_bio_ops.rw_cleanup;
+	filewriterops.rw_header_chunk =
+		suspend_bio_ops.rw_header_chunk;
+
+	if (!(result = suspend_register_module(&filewriterops))) {
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&filewriter_proc_data[i]);
+	} else
+		printk("Suspend2 FileWriter unable to register!\n");
+
+	return result;
+}
+
+#ifdef MODULE
+static __exit void filewriter_unload(void)
+{
+	int i, numfiles = sizeof(filewriter_proc_data) / sizeof(struct suspend_proc_data);
+
+	printk("Suspend2 FileWriter unloading.\n");
+
+	for (i=0; i< numfiles; i++)
+		suspend_unregister_procfile(&filewriter_proc_data[i]);
+	suspend_unregister_module(&filewriterops);
+}
+
+module_init(filewriter_load);
+module_exit(filewriter_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Suspend2 filewriter");
+#else
+late_initcall(filewriter_load);
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
