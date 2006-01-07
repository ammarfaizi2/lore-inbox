Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030512AbWAGRHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030512AbWAGRHP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 12:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWAGRHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 12:07:15 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:2994 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1030512AbWAGRHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 12:07:13 -0500
X-IronPort-AV: i="3.99,342,1131350400"; 
   d="scan'208"; a="1764550291:sNHT31897166"
Subject: [git patch review 1/2] IB/uverbs: Release event file reference on
	ib_uverbs_create_cq() error
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 07 Jan 2006 17:07:08 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136653628658-9dad0e46bb1d8cba@cisco.com>
X-OriginalArrivalTime: 07 Jan 2006 17:07:10.0782 (UTC) FILETIME=[CC32C5E0:01C613AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ib_uverbs_create_cq() should release the completion channel event file
if an error occurs after it looks it up.  Also, if userspace asks for
a completion channel and we don't find it, an error should be returned
instead of silently creating a CQ without a completion channel.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/uverbs_cmd.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

ac4e7b35579de55db50d602a472858867808a9c3
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 12d6cc0..a02c5a0 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -594,13 +594,18 @@ ssize_t ib_uverbs_create_cq(struct ib_uv
 	if (cmd.comp_vector >= file->device->num_comp_vectors)
 		return -EINVAL;
 
-	if (cmd.comp_channel >= 0)
-		ev_file = ib_uverbs_lookup_comp_file(cmd.comp_channel);
-
 	uobj = kmalloc(sizeof *uobj, GFP_KERNEL);
 	if (!uobj)
 		return -ENOMEM;
 
+	if (cmd.comp_channel >= 0) {
+		ev_file = ib_uverbs_lookup_comp_file(cmd.comp_channel);
+		if (!ev_file) {
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
 	uobj->uobject.user_handle   = cmd.user_handle;
 	uobj->uobject.context       = file->ucontext;
 	uobj->uverbs_file	    = file;
@@ -664,6 +669,8 @@ err_up:
 	ib_destroy_cq(cq);
 
 err:
+	if (ev_file)
+		ib_uverbs_release_ucq(file, ev_file, uobj);
 	kfree(uobj);
 	return ret;
 }
-- 
0.99.9n
