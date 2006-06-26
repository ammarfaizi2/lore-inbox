Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWFZXFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWFZXFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933271AbWFZWju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:50 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:21175 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933272AbWFZWj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:29 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/35] [Suspend2] Filewriter cleanup.
Date: Tue, 27 Jun 2006 08:39:27 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223925.4685.93323.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup when returning control to userspace.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 97f97be..e2ad8dc 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -235,3 +235,27 @@ static void populate_block_list(void)
 			 	devinfo.blocks_per_page - 1);
 }
 
+static void filewriter_cleanup(int finishing_cycle)
+{
+	if (filewriter_target_bdev) {
+		if (target_claim) {
+			bd_release(filewriter_target_bdev);
+			target_claim = 0;
+		}
+
+		if (used_devt) {
+			blkdev_put(filewriter_target_bdev);
+			used_devt = 0;
+		}
+		filewriter_target_bdev = NULL;
+		target_inode = NULL;
+		set_devinfo(NULL, 0);
+		target_storage_available = 0;
+	}
+
+	if (target_file > 0) {
+		filp_close(target_file, NULL);
+		target_file = NULL;
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
