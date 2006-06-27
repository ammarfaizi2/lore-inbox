Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030708AbWF0E5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030708AbWF0E5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933422AbWF0EyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:54:02 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:40923 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933413AbWF0ElI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:08 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/13] [Suspend2] Initialisation of the storage manager on load.
Date: Tue, 27 Jun 2006 14:41:06 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044105.14778.59187.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register the proc entries for the storage manager and set up the netlink
data structure when loaded.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
index 885501b..bdb2993 100644
--- a/kernel/power/storage.c
+++ b/kernel/power/storage.c
@@ -294,3 +294,30 @@ static struct suspend_module_ops usm_ops
 	.memory_needed			= usm_memory_needed,
 };
        
+/* suspend_usm_proc_init
+ * Description: Boot time initialisation for user interface.
+ */
+static __init int suspend_usm_proc_init(void)
+{
+	int result, i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	if (!(result = suspend_register_module(&usm_ops)))
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&proc_params[i]);
+
+	usm_helper_data.nl = NULL;
+	usm_helper_data.program[0] = '\0';
+	usm_helper_data.pid = -1;
+	usm_helper_data.skb_size = 0;
+	usm_helper_data.pool_limit = 6;
+	usm_helper_data.netlink_id = NETLINK_SUSPEND2_USM;
+	usm_helper_data.name = "userspace storage manager";
+	usm_helper_data.rcv_msg = usm_user_rcv_msg;
+	usm_helper_data.interface_version = 1;
+	usm_helper_data.must_init = 0;
+	init_completion(&usm_helper_data.wait_for_process);
+
+	return result;
+}
+
+late_initcall(suspend_usm_proc_init);

--
Nigel Cunningham		nigel at suspend2 dot net
