Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757554AbWKXJbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757554AbWKXJbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757545AbWKXJbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:31:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28884 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757554AbWKXJbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:31:24 -0500
Subject: [DLM] fix requestqueue race [3/9]
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Nov 2006 09:34:12 +0000
Message-Id: <1164360852.3392.138.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 46fec31e347287f8b387ec4c675635f46b99c228 Mon Sep 17 00:00:00 2001
From: David Teigland <teigland@redhat.com>
Date: Tue, 31 Oct 2006 11:55:56 -0600
Subject: [PATCH] [DLM] fix requestqueue race

Red Hat BZ 211914

There's a race between dlm_recoverd (1) enabling locking and (2) clearing
out the requestqueue, and dlm_recvd (1) checking if locking is enabled and
(2) adding a message to the requestqueue.  An order of recoverd(1),
recvd(1), recvd(2), recoverd(2) will result in a message being left on the
requestqueue.  The fix is to have dlm_recvd check if dlm_recoverd has
enabled locking after taking the mutex for the requestqueue and if it has
processing the message instead of queueing it.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/lock.c         |   15 +++++++++++----
 fs/dlm/requestqueue.c |   21 +++++++++++++++++----
 fs/dlm/requestqueue.h |    2 +-
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 3f2befa..6088a16 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -3028,10 +3028,17 @@ int dlm_receive_message(struct dlm_heade
 
 	while (1) {
 		if (dlm_locking_stopped(ls)) {
-			if (!recovery)
-				dlm_add_requestqueue(ls, nodeid, hd);
-			error = -EINTR;
-			goto out;
+			if (recovery) {
+				error = -EINTR;
+				goto out;
+			}
+			error = dlm_add_requestqueue(ls, nodeid, hd);
+			if (error == -EAGAIN)
+				continue;
+			else {
+				error = -EINTR;
+				goto out;
+			}
 		}
 
 		if (lock_recovery_try(ls))
diff --git a/fs/dlm/requestqueue.c b/fs/dlm/requestqueue.c
index 7b2b089..0226d2a 100644
--- a/fs/dlm/requestqueue.c
+++ b/fs/dlm/requestqueue.c
@@ -30,26 +30,39 @@ struct rq_entry {
  * lockspace is enabled on some while still suspended on others.
  */
 
-void dlm_add_requestqueue(struct dlm_ls *ls, int nodeid, struct dlm_header *hd)
+int dlm_add_requestqueue(struct dlm_ls *ls, int nodeid, struct dlm_header *hd)
 {
 	struct rq_entry *e;
 	int length = hd->h_length;
+	int rv = 0;
 
 	if (dlm_is_removed(ls, nodeid))
-		return;
+		return 0;
 
 	e = kmalloc(sizeof(struct rq_entry) + length, GFP_KERNEL);
 	if (!e) {
 		log_print("dlm_add_requestqueue: out of memory\n");
-		return;
+		return 0;
 	}
 
 	e->nodeid = nodeid;
 	memcpy(e->request, hd, length);
 
+	/* We need to check dlm_locking_stopped() after taking the mutex to
+	   avoid a race where dlm_recoverd enables locking and runs
+	   process_requestqueue between our earlier dlm_locking_stopped check
+	   and this addition to the requestqueue. */
+
 	mutex_lock(&ls->ls_requestqueue_mutex);
-	list_add_tail(&e->list, &ls->ls_requestqueue);
+	if (dlm_locking_stopped(ls))
+		list_add_tail(&e->list, &ls->ls_requestqueue);
+	else {
+		log_debug(ls, "dlm_add_requestqueue skip from %d", nodeid);
+		kfree(e);
+		rv = -EAGAIN;
+	}
 	mutex_unlock(&ls->ls_requestqueue_mutex);
+	return rv;
 }
 
 int dlm_process_requestqueue(struct dlm_ls *ls)
diff --git a/fs/dlm/requestqueue.h b/fs/dlm/requestqueue.h
index 349f0d2..6a53ea0 100644
--- a/fs/dlm/requestqueue.h
+++ b/fs/dlm/requestqueue.h
@@ -13,7 +13,7 @@
 #ifndef __REQUESTQUEUE_DOT_H__
 #define __REQUESTQUEUE_DOT_H__
 
-void dlm_add_requestqueue(struct dlm_ls *ls, int nodeid, struct dlm_header *hd);
+int dlm_add_requestqueue(struct dlm_ls *ls, int nodeid, struct dlm_header *hd);
 int dlm_process_requestqueue(struct dlm_ls *ls);
 void dlm_wait_requestqueue(struct dlm_ls *ls);
 void dlm_purge_requestqueue(struct dlm_ls *ls);
-- 
1.4.1



