Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757545AbWKXJbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545AbWKXJbt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757651AbWKXJbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:31:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37588 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757545AbWKXJbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:31:32 -0500
Subject: [DLM] fix aborted recovery during node removal [4/9]
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Nov 2006 09:34:19 +0000
Message-Id: <1164360859.3392.140.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 186493c8764c3943943112cfbbbb305bac85ad60 Mon Sep 17 00:00:00 2001
From: David Teigland <teigland@redhat.com>
Date: Tue, 31 Oct 2006 11:56:01 -0600
Subject: [PATCH] [DLM] fix aborted recovery during node removal

Red Hat BZ 211914

With the new cluster infrastructure, dlm recovery for a node removal can
be aborted and restarted for a node addition.  When this happens, the
restarted recovery isn't aware that it's doing recovery for the earlier
removal as well as the addition.  So, it then skips the recovery steps
only required when nodes are removed.  This can result in locks not being
purged for failed/removed nodes.  The fix is to check for removed nodes
for which recovery has not been completed at the start of a new recovery
sequence.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/member.c   |    8 ++++++++
 fs/dlm/recoverd.c |    7 +++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index a3f7de7..85e2897 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -186,6 +186,14 @@ int dlm_recover_members(struct dlm_ls *l
 	struct dlm_member *memb, *safe;
 	int i, error, found, pos = 0, neg = 0, low = -1;
 
+	/* previously removed members that we've not finished removing need to
+	   count as a negative change so the "neg" recovery steps will happen */
+
+	list_for_each_entry(memb, &ls->ls_nodes_gone, list) {
+		log_debug(ls, "prev removed member %d", memb->nodeid);
+		neg++;
+	}
+
 	/* move departed members from ls_nodes to ls_nodes_gone */
 
 	list_for_each_entry_safe(memb, safe, &ls->ls_nodes, list) {
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 362e3ef..4a1d602 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -164,6 +164,13 @@ static int ls_recover(struct dlm_ls *ls,
 		 */
 
 		dlm_recover_rsbs(ls);
+	} else {
+		/*
+		 * Other lockspace members may be going through the "neg" steps
+		 * while also adding us to the lockspace, in which case they'll
+		 * be looking for this status bit during dlm_recover_locks().
+		 */
+		dlm_set_recover_status(ls, DLM_RS_LOCKS);
 	}
 
 	dlm_release_root_list(ls);
-- 
1.4.1



