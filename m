Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933421AbWF0EyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933421AbWF0EyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933391AbWF0EkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:40:18 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:29147 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030688AbWF0Ejw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:52 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/13] [Suspend2] Userspace is ready!
Date: Tue, 27 Jun 2006 14:39:50 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043949.14630.97377.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routine called when we are waiting for a userspace helper to start, and
receive a netlink message from it, saying it's ready to go. We check the
version for compatability, and if all looks good, call the completion
handler on the waiting code. If not, we complain bitterly and try to
continue without it.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
index 7f06f7c..9094c92 100644
--- a/kernel/power/netlink.c
+++ b/kernel/power/netlink.c
@@ -152,3 +152,22 @@ static int nl_set_nofreeze(struct user_h
 	return 0;
 }
 
+/*
+ * Called when the userspace process has informed us that it's ready to roll.
+ */
+static int nl_ready(struct user_helper_data *uhd, int version)
+{
+	if (version != uhd->interface_version) {
+		printk("%s userspace process using invalid interface version."
+				" Trying to continue without it.\n",
+				uhd->name);
+		if (uhd->not_ready)
+			uhd->not_ready();
+		return 1;
+	}
+
+	complete(&uhd->wait_for_process);
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
