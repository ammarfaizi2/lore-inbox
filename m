Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933342AbWFZWrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933342AbWFZWrA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933335AbWFZWlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:41:51 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:39095 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933332AbWFZWl1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:27 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/28] [Suspend2] Try to parse resume2= for swapwriter.
Date: Tue, 27 Jun 2006 08:41:26 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224124.4975.57117.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether resume2= is a swapwriter target (swap: prefix or swapwriter
is the only writer), whether we can access the device, and whether we find
a valid signature.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 13ad8d7..66bb556 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -196,3 +196,40 @@ static int disable_swapfile(void)
 	return result;
 }
 
+static int try_to_parse_resume_device(char *commandline)
+{
+	struct kstat stat;
+	int error;
+
+	resume_dev_t = name_to_dev_t(commandline);
+
+	if (!resume_dev_t) {
+		error = vfs_stat(commandline, &stat);
+		if (!error)
+			resume_dev_t = stat.rdev;
+	}
+
+	if (!resume_dev_t) {
+		if (test_suspend_state(SUSPEND_TRYING_TO_RESUME))
+			suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+			  "Failed to translate \"%s\" into a device id.\n",
+			  commandline);
+		else
+			printk(name_suspend
+			  "Can't translate \"%s\" into a device id yet.\n",
+			  commandline);
+		return 1;
+	}
+
+	if (IS_ERR(resume_block_device =
+	     open_bdev(MAX_SWAPFILES, resume_dev_t))) {
+		suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+			"Failed to get access to \"%s\", where"
+			" the swap header should be found.",
+			commandline);
+		return 1;
+	}
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
