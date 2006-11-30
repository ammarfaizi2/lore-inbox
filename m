Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936314AbWK3MUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936314AbWK3MUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936322AbWK3MT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:19:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21900 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936336AbWK3MTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:19:47 -0500
Subject: [DLM] fix aborted recovery during node removal [42/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:19:47 +0000
Message-Id: <1164889187.3752.389.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 91c0dc93a1a6bbdd79707ed311e48b4397df177f Mon Sep 17 00:00:00 2001
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



