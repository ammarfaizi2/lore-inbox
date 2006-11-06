Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWKFLGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWKFLGG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 06:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWKFLGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 06:06:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14286 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751893AbWKFLGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 06:06:03 -0500
Subject: [DLM] Fix kref_put oops [4/5]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Patrick Caulfield <pcaulfie@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 06 Nov 2006 11:08:15 +0000
Message-Id: <1162811295.18219.35.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From ba542e3b92f9ea7c482ae56b68b9122eebc53a39 Mon Sep 17 00:00:00 2001
From: Patrick Caulfield <pcaulfie@redhat.com>
Date: Thu, 2 Nov 2006 14:41:23 +0000
Subject: [PATCH] [DLM] Fix kref_put oops

This patch fixes the recounting on the lockspace kobject. Previously the lockspace was freed while userspace could have had a
reference to one of its sysfs files, causing an oops in kref_put.

Now the lockspace kfree is moved into the kobject release() function

Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/lockspace.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 109333c..499ee11 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -143,6 +143,12 @@ static ssize_t dlm_attr_store(struct kob
 	return a->store ? a->store(ls, buf, len) : len;
 }
 
+static void lockspace_kobj_release(struct kobject *k)
+{
+	struct dlm_ls *ls  = container_of(k, struct dlm_ls, ls_kobj);
+	kfree(ls);
+}
+
 static struct sysfs_ops dlm_attr_ops = {
 	.show  = dlm_attr_show,
 	.store = dlm_attr_store,
@@ -151,6 +157,7 @@ static struct sysfs_ops dlm_attr_ops = {
 static struct kobj_type dlm_ktype = {
 	.default_attrs = dlm_attrs,
 	.sysfs_ops     = &dlm_attr_ops,
+	.release       = lockspace_kobj_release,
 };
 
 static struct kset dlm_kset = {
@@ -678,7 +685,7 @@ static int release_lockspace(struct dlm_
 	dlm_clear_members_gone(ls);
 	kfree(ls->ls_node_array);
 	kobject_unregister(&ls->ls_kobj);
-	kfree(ls);
+        /* The ls structure will be freed when the kobject is done with */
 
 	mutex_lock(&ls_lock);
 	ls_count--;
-- 
1.4.1



