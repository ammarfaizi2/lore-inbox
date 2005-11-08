Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVKHCBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVKHCBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbVKHCBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:24269 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965182AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 3/18] allow callers of seq_open do allocation themselves
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001Eh-9T@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1131401734 -0500

Allows caller of seq_open() to kmalloc() seq_file + whatever else they want
and set ->private_data to it.  seq_open() will then abstain from doing
allocation itself.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/seq_file.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

57865a0565080cc56de9aa5369ea1fc2b6477398
diff --git a/fs/seq_file.c b/fs/seq_file.c
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -28,13 +28,17 @@
  */
 int seq_open(struct file *file, struct seq_operations *op)
 {
-	struct seq_file *p = kmalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
+	struct seq_file *p = file->private_data;
+
+	if (!p) {
+		p = kmalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+		file->private_data = p;
+	}
 	memset(p, 0, sizeof(*p));
 	sema_init(&p->sem, 1);
 	p->op = op;
-	file->private_data = p;
 
 	/*
 	 * Wrappers around seq_open(e.g. swaps_open) need to be
