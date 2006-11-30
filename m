Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936372AbWK3MYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936372AbWK3MYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936370AbWK3MXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:23:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17551 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936391AbWK3MXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:23:23 -0500
Subject: [DLM] don't accept replies to old recovery messages [64/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:23:17 +0000
Message-Id: <1164889397.3752.437.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 98f176fb32f33795b6d0f83856008b932123ab38 Mon Sep 17 00:00:00 2001
From: David Teigland <teigland@redhat.com>
Date: Mon, 27 Nov 2006 13:19:28 -0600
Subject: [PATCH] [DLM] don't accept replies to old recovery messages

We often abort a recovery after sending a status request to a remote node.
We want to ignore any potential status reply we get from the remote node.
If we get one of these unwanted replies, we've often moved on to the next
recovery message and incremented the message sequence counter, so the
reply will be ignored due to the seq number.  In some cases, we've not
moved on to the next message so the seq number of the reply we want to
ignore is still correct, causing the reply to be accepted.  The next
recovery message will then mistake this old reply as a new one.

To fix this, we add the flag RCOM_WAIT to indicate when we can accept a
new reply.  We clear this flag if we abort recovery while waiting for a
reply.  Before the flag is set again (to allow new replies) we know that
any old replies will be rejected due to their sequence number.  We also
initialize the recovery-message sequence number to a random value when a
lockspace is first created.  This makes it clear when messages are being
rejected from an old instance of a lockspace that has since been
recreated.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/dlm_internal.h |    4 +++-
 fs/dlm/lockspace.c    |    2 ++
 fs/dlm/rcom.c         |   44 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 1e5cd67..1ee8195 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -471,6 +471,7 @@ struct dlm_ls {
 	char			*ls_recover_buf;
 	int			ls_recover_nodeid; /* for debugging */
 	uint64_t		ls_rcom_seq;
+	spinlock_t		ls_rcom_spin;
 	struct list_head	ls_recover_list;
 	spinlock_t		ls_recover_list_lock;
 	int			ls_recover_list_count;
@@ -488,7 +489,8 @@ #define LSFL_WORK		0
 #define LSFL_RUNNING		1
 #define LSFL_RECOVERY_STOP	2
 #define LSFL_RCOM_READY		3
-#define LSFL_UEVENT_WAIT	4
+#define LSFL_RCOM_WAIT		4
+#define LSFL_UEVENT_WAIT	5
 
 /* much of this is just saving user space pointers associated with the
    lock that we pass back to the user lib with an ast */
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 791388b..59012b0 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -479,6 +479,8 @@ static int new_lockspace(char *name, int
 	ls->ls_recoverd_task = NULL;
 	mutex_init(&ls->ls_recoverd_active);
 	spin_lock_init(&ls->ls_recover_lock);
+	spin_lock_init(&ls->ls_rcom_spin);
+	get_random_bytes(&ls->ls_rcom_seq, sizeof(uint64_t));
 	ls->ls_recover_status = 0;
 	ls->ls_recover_seq = 0;
 	ls->ls_recover_args = NULL;
diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index 6ac195c..c42f2db 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -90,13 +90,28 @@ static int check_config(struct dlm_ls *l
 	return 0;
 }
 
+static void allow_sync_reply(struct dlm_ls *ls, uint64_t *new_seq)
+{
+	spin_lock(&ls->ls_rcom_spin);
+	*new_seq = ++ls->ls_rcom_seq;
+	set_bit(LSFL_RCOM_WAIT, &ls->ls_flags);
+	spin_unlock(&ls->ls_rcom_spin);
+}
+
+static void disallow_sync_reply(struct dlm_ls *ls)
+{
+	spin_lock(&ls->ls_rcom_spin);
+	clear_bit(LSFL_RCOM_WAIT, &ls->ls_flags);
+	clear_bit(LSFL_RCOM_READY, &ls->ls_flags);
+	spin_unlock(&ls->ls_rcom_spin);
+}
+
 int dlm_rcom_status(struct dlm_ls *ls, int nodeid)
 {
 	struct dlm_rcom *rc;
 	struct dlm_mhandle *mh;
 	int error = 0;
 
-	memset(ls->ls_recover_buf, 0, dlm_config.buffer_size);
 	ls->ls_recover_nodeid = nodeid;
 
 	if (nodeid == dlm_our_nodeid()) {
@@ -108,12 +123,14 @@ int dlm_rcom_status(struct dlm_ls *ls, i
 	error = create_rcom(ls, nodeid, DLM_RCOM_STATUS, 0, &rc, &mh);
 	if (error)
 		goto out;
-	rc->rc_id = ++ls->ls_rcom_seq;
+
+	allow_sync_reply(ls, &rc->rc_id);
+	memset(ls->ls_recover_buf, 0, dlm_config.buffer_size);
 
 	send_rcom(ls, mh, rc);
 
 	error = dlm_wait_function(ls, &rcom_response);
-	clear_bit(LSFL_RCOM_READY, &ls->ls_flags);
+	disallow_sync_reply(ls);
 	if (error)
 		goto out;
 
@@ -150,14 +167,20 @@ static void receive_rcom_status(struct d
 
 static void receive_sync_reply(struct dlm_ls *ls, struct dlm_rcom *rc_in)
 {
-	if (rc_in->rc_id != ls->ls_rcom_seq) {
-		log_debug(ls, "reject old reply %d got %llx wanted %llx",
-			  rc_in->rc_type, rc_in->rc_id, ls->ls_rcom_seq);
-		return;
+	spin_lock(&ls->ls_rcom_spin);
+	if (!test_bit(LSFL_RCOM_WAIT, &ls->ls_flags) ||
+	    rc_in->rc_id != ls->ls_rcom_seq) {
+		log_debug(ls, "reject reply %d from %d seq %llx expect %llx",
+			  rc_in->rc_type, rc_in->rc_header.h_nodeid,
+			  rc_in->rc_id, ls->ls_rcom_seq);
+		goto out;
 	}
 	memcpy(ls->ls_recover_buf, rc_in, rc_in->rc_header.h_length);
 	set_bit(LSFL_RCOM_READY, &ls->ls_flags);
+	clear_bit(LSFL_RCOM_WAIT, &ls->ls_flags);
 	wake_up(&ls->ls_wait_general);
+ out:
+	spin_unlock(&ls->ls_rcom_spin);
 }
 
 static void receive_rcom_status_reply(struct dlm_ls *ls, struct dlm_rcom *rc_in)
@@ -171,7 +194,6 @@ int dlm_rcom_names(struct dlm_ls *ls, in
 	struct dlm_mhandle *mh;
 	int error = 0, len = sizeof(struct dlm_rcom);
 
-	memset(ls->ls_recover_buf, 0, dlm_config.buffer_size);
 	ls->ls_recover_nodeid = nodeid;
 
 	if (nodeid == dlm_our_nodeid()) {
@@ -185,12 +207,14 @@ int dlm_rcom_names(struct dlm_ls *ls, in
 	if (error)
 		goto out;
 	memcpy(rc->rc_buf, last_name, last_len);
-	rc->rc_id = ++ls->ls_rcom_seq;
+
+	allow_sync_reply(ls, &rc->rc_id);
+	memset(ls->ls_recover_buf, 0, dlm_config.buffer_size);
 
 	send_rcom(ls, mh, rc);
 
 	error = dlm_wait_function(ls, &rcom_response);
-	clear_bit(LSFL_RCOM_READY, &ls->ls_flags);
+	disallow_sync_reply(ls);
  out:
 	return error;
 }
-- 
1.4.1



