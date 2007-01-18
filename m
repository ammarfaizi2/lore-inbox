Return-Path: <linux-kernel-owner+w=401wt.eu-S932587AbXARUR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbXARUR5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 15:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbXARUR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 15:17:57 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:52797 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932587AbXARUR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 15:17:56 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       Eric Van Hensbergen <ericvh@gmail.com>
Subject: [RESEND][PATCH] 9p: fix bogus return code checks during initialization
Date: Thu, 18 Jan 2007 14:14:59 -0600
Message-Id: <11691512994-git-send-email-ericvh@gmail.com>
X-Mailer: git-send-email 1.5.0.rc1.gdf1b-dirty
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a simple logic error in init_v9fs - the return code checks are
reversed.  This patch fixes the return code and adds some messages to
prevent module initialization from failing silently.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
---
 fs/9p/mux.c  |    4 +++-
 fs/9p/v9fs.c |   11 ++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/9p/mux.c b/fs/9p/mux.c
index 944273c..147ceef 100644
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -132,8 +132,10 @@ int v9fs_mux_global_init(void)
 		v9fs_mux_poll_tasks[i].task = NULL;
 
 	v9fs_mux_wq = create_workqueue("v9fs");
-	if (!v9fs_mux_wq)
+	if (!v9fs_mux_wq) {
+		printk(KERN_WARNING "v9fs: mux: creating workqueue failed\n");
 		return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 0b96fae..d9b561b 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -457,14 +457,19 @@ static int __init init_v9fs(void)
 
 	v9fs_error_init();
 
-	printk(KERN_INFO "Installing v9fs 9P2000 file system support\n");
+	printk(KERN_INFO "Installing v9fs 9p2000 file system support\n");
 
 	ret = v9fs_mux_global_init();
-	if (!ret)
+	if (ret) {
+		printk(KERN_WARNING "v9fs: starting mux failed\n");
 		return ret;
+	}
 	ret = register_filesystem(&v9fs_fs_type);
-	if (!ret)
+	if (ret) {
+		printk(KERN_WARNING "v9fs: registering file system failed\n");
 		v9fs_mux_global_exit();
+	}
+
 	return ret;
 }
 
-- 
1.5.0.rc1.gdf1b-dirty

