Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933334AbWFZWmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933334AbWFZWmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933332AbWFZWlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:41:53 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:38583 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933273AbWFZWlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:24 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/28] [Suspend2] Enable/disable swapfile.
Date: Tue, 27 Jun 2006 08:41:22 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224121.4975.19075.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines to enable and disable a swap file specifically for suspending. The
swapon is called after userspace is frozen and the swapoff is done prior to
restarting userspace. We can't completely remove the possibility of it
being used by the vm. We're just doing the best we can.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   45 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 212555f..13ad8d7 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -151,3 +151,48 @@ static struct block_device *open_bdev(in
 	return bdev;
 }
 
+/* Must be silent - might be called from cat /proc/suspend/debug_info
+ * Returns 0 if was off, -EBUSY if was on, error value otherwise.
+ */
+static int enable_swapfile(void)
+{
+	int activateswapresult = -EINVAL;
+
+	if (suspend_swapon_status)
+		return 0;
+
+	if (swapfilename[0]) {
+		/* Attempt to swap on with maximum priority */
+		activateswapresult = sys_swapon(swapfilename, 0xFFFF);
+		if ((activateswapresult) && (activateswapresult != -EBUSY))
+			printk(name_suspend
+				"The swapfile/partition specified by "
+				"/proc/suspend/swapfile (%s) could not"
+				" be turned on (error %d). Attempting "
+				"to continue.\n",
+				swapfilename, activateswapresult);
+		if (!activateswapresult)
+			suspend_swapon_status = 1;
+	}
+	return activateswapresult;
+}
+
+/* Returns 0 if was on, -EINVAL if was off, error value otherwise */
+static int disable_swapfile(void)
+{
+	int result = -EINVAL;
+	
+	if (!suspend_swapon_status)
+		return 0;
+
+	if (swapfilename[0]) {
+		result = sys_swapoff(swapfilename);
+		if (result == -EINVAL)
+	 		return 0;	/* Wasn't on */
+		if (!result)
+			suspend_swapon_status = 0;
+	}
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
