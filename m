Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030678AbWF0EjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030678AbWF0EjU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030662AbWF0EjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:00 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:18907 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030649AbWF0Eip
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:45 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/12] [Suspend2] Load and unload routines.
Date: Tue, 27 Jun 2006 14:38:43 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043843.14437.3439.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add routines to register and deregister the encryption support and proc
entries on load and unload.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
index 8f544ff..4d9091c 100644
--- a/kernel/power/encryption.c
+++ b/kernel/power/encryption.c
@@ -503,3 +503,36 @@ static struct suspend_module_ops suspend
 	.read_chunk		= suspend_encrypt_read_chunk,
 };
 
+/* ---- Registration ---- */
+
+static __init int suspend_encrypt_load(void)
+{
+	int result;
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	printk("Suspend2 Encryption Driver loading.\n");
+	if (!(result = suspend_register_module(&suspend_encryption_ops))) {
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&proc_params[i]);
+	} else
+		printk("Suspend2 Encryption Driver unable to register!\n");
+	return result;
+}
+
+#ifdef MODULE
+static __exit void suspend_compress_unload(void)
+{
+	printk("Suspend2 Encryption Driver unloading.\n");
+	for (i=0; i< numfiles; i++)
+		suspend_unregister_procfile(&proc_params[i]);
+	suspend_unregister_module(&suspend_encryption_ops);
+}
+
+module_init(suspend_encrypt_load);
+module_exit(suspend_encrypt_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Encryption Support for Suspend2");
+#else
+late_initcall(suspend_encrypt_load);
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
