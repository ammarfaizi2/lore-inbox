Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752153AbWKFLGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbWKFLGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 06:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbWKFLGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 06:06:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22222 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751850AbWKFLGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 06:06:10 -0500
Subject: [DLM] fix oops in kref_put when removing a lockspace [5/5]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Patrick Caulfield <pcaulfie@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 06 Nov 2006 11:08:17 +0000
Message-Id: <1162811297.18219.36.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From e2de7f565521a76fbbb927f701c5a1d381c71a93 Mon Sep 17 00:00:00 2001
From: Patrick Caulfield <pcaulfie@redhat.com>
Date: Mon, 6 Nov 2006 08:53:28 +0000
Subject: [PATCH] [DLM] fix oops in kref_put when removing a lockspace

Now that the lockspace struct is freed when the last sysfs object is released
this patch prevents use of that lockspace by sysfs. We attempt to re-get the
lockspace from the lockspace list and fail the request if it has been removed.

Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/lockspace.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 499ee11..f8842ca 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -43,6 +43,10 @@ static ssize_t dlm_control_store(struct 
 	ssize_t ret = len;
 	int n = simple_strtol(buf, NULL, 0);
 
+	ls = dlm_find_lockspace_local(ls->ls_local_handle);
+	if (!ls)
+		return -EINVAL;
+
 	switch (n) {
 	case 0:
 		dlm_ls_stop(ls);
@@ -53,6 +57,7 @@ static ssize_t dlm_control_store(struct 
 	default:
 		ret = -EINVAL;
 	}
+	dlm_put_lockspace(ls);
 	return ret;
 }
 
-- 
1.4.1



