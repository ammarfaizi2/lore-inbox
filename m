Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030654AbWF0Ejt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030654AbWF0Ejt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030635AbWF0EiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:14 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:27094 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030619AbWF0EiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:02 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 13/13] [Suspend2] Compression (un)load routines.
Date: Tue, 27 Jun 2006 14:38:01 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043800.14320.97798.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add routines to register the compression support and proc file entries on
load.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index 4f0f82e..726518c 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -540,3 +540,36 @@ static struct suspend_module_ops suspend
 	.read_chunk		= suspend_compress_read_chunk,
 };
 
+/* ---- Registration ---- */
+
+static __init int suspend_compress_load(void)
+{
+	int result;
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	printk("Suspend2 Compression Driver loading.\n");
+	if (!(result = suspend_register_module(&suspend_compression_ops))) {
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&proc_params[i]);
+	} else
+		printk("Suspend2 Compression Driver unable to register!\n");
+	return result;
+}
+
+#ifdef MODULE
+static __exit void suspend_compress_unload(void)
+{
+	printk("Suspend2 Compression Driver unloading.\n");
+	for (i=0; i< numfiles; i++)
+		suspend_unregister_procfile(&proc_params[i]);
+	suspend_unregister_module(&suspend_compression_ops);
+}
+
+module_init(suspend_compress_load);
+module_exit(suspend_compress_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Compression Support for Suspend2");
+#else
+late_initcall(suspend_compress_load);
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
