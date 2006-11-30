Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936377AbWK3MYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936377AbWK3MYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936368AbWK3MXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:23:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61582 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936386AbWK3MWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:22:54 -0500
Subject: [DLM] fix add_requestqueue checking nodes list [61/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:22:32 +0000
Message-Id: <1164889352.3752.427.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 2896ee37ccc1f9acb244c9b02becb74a43661009 Mon Sep 17 00:00:00 2001
From: David Teigland <teigland@redhat.com>
Date: Mon, 27 Nov 2006 11:31:22 -0600
Subject: [PATCH] [DLM] fix add_requestqueue checking nodes list

Requests that arrive after recovery has started are saved in the
requestqueue and processed after recovery is done.  Some of these requests
are purged during recovery if they are from nodes that have been removed.
We move the purging of the requests (dlm_purge_requestqueue) to later in
the recovery sequence which allows the routine saving requests
(dlm_add_requestqueue) to avoid filtering out requests by nodeid since the
same will be done by the purge.  The current code has add_requestqueue
filtering by nodeid but doesn't hold any locks when accessing the list of
current nodes.  This also means that we need to call the purge routine
when the lockspace is being shut down since the add routine will not be
rejecting requests itself any more.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/lockspace.c    |    2 ++
 fs/dlm/recoverd.c     |   16 ++++++++--------
 fs/dlm/requestqueue.c |    7 ++++---
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index f8842ca..791388b 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -22,6 +22,7 @@ #include "config.h"
 #include "memory.h"
 #include "lock.h"
 #include "recover.h"
+#include "requestqueue.h"
 
 #ifdef CONFIG_DLM_DEBUG
 int dlm_create_debug_file(struct dlm_ls *ls);
@@ -684,6 +685,7 @@ static int release_lockspace(struct dlm_
 	 * Free structures on any other lists
 	 */
 
+	dlm_purge_requestqueue(ls);
 	kfree(ls->ls_recover_args);
 	dlm_clear_free_entries(ls);
 	dlm_clear_members(ls);
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 8bb895f..9dc2f91 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -94,14 +94,6 @@ static int ls_recover(struct dlm_ls *ls,
 	}
 
 	/*
-	 * Purge directory-related requests that are saved in requestqueue.
-	 * All dir requests from before recovery are invalid now due to the dir
-	 * rebuild and will be resent by the requesting nodes.
-	 */
-
-	dlm_purge_requestqueue(ls);
-
-	/*
 	 * Wait for all nodes to complete directory rebuild.
 	 */
 
@@ -181,6 +173,14 @@ static int ls_recover(struct dlm_ls *ls,
 
 	dlm_release_root_list(ls);
 
+	/*
+	 * Purge directory-related requests that are saved in requestqueue.
+	 * All dir requests from before recovery are invalid now due to the dir
+	 * rebuild and will be resent by the requesting nodes.
+	 */
+
+	dlm_purge_requestqueue(ls);
+
 	dlm_set_recover_status(ls, DLM_RS_DONE);
 	error = dlm_recover_done_wait(ls);
 	if (error) {
diff --git a/fs/dlm/requestqueue.c b/fs/dlm/requestqueue.c
index 0226d2a..65008d7 100644
--- a/fs/dlm/requestqueue.c
+++ b/fs/dlm/requestqueue.c
@@ -36,9 +36,6 @@ int dlm_add_requestqueue(struct dlm_ls *
 	int length = hd->h_length;
 	int rv = 0;
 
-	if (dlm_is_removed(ls, nodeid))
-		return 0;
-
 	e = kmalloc(sizeof(struct rq_entry) + length, GFP_KERNEL);
 	if (!e) {
 		log_print("dlm_add_requestqueue: out of memory\n");
@@ -133,6 +130,10 @@ static int purge_request(struct dlm_ls *
 {
 	uint32_t type = ms->m_type;
 
+	/* the ls is being cleaned up and freed by release_lockspace */
+	if (!ls->ls_count)
+		return 1;
+
 	if (dlm_is_removed(ls, nodeid))
 		return 1;
 
-- 
1.4.1



