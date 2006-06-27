Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWF0E7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWF0E7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933405AbWF0EkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:40:15 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:31195 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933391AbWF0EkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:05 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/13] [Suspend2] Start a userspace helper.
Date: Tue, 27 Jun 2006 14:40:04 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044003.14630.52995.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to start a userspace helper and set up the netlink socket
connection to it.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
index d7a3a90..0a379c3 100644
--- a/kernel/power/netlink.c
+++ b/kernel/power/netlink.c
@@ -344,3 +344,29 @@ int suspend2_launch_userspace_program(ch
 	return retval;
 }
 
+int suspend_netlink_setup(struct user_helper_data *uhd)
+{
+	if (netlink_prepare(uhd) < 0) {
+		printk("Netlink prepare failed.\n");
+		return 1;
+	}
+
+	if (suspend2_launch_userspace_program(uhd->program, uhd->netlink_id) < 0) {
+		printk("Launch userspace program failed.\n");
+		suspend_netlink_close(uhd);
+		return 1;
+	}
+
+	/* Wait 2 seconds for the userspace process to make contact */
+	wait_for_completion_timeout(&uhd->wait_for_process, 2*HZ);
+
+	if (uhd->pid == -1) {
+		printk("%s: Failed to contact userspace process.\n",
+				uhd->name);
+		suspend_netlink_close(uhd);
+		return 1;
+	}
+
+	return 0;
+}
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
