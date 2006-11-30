Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936389AbWK3MXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936389AbWK3MXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936391AbWK3MXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:23:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12175 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936389AbWK3MXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:23:16 -0500
Subject: [DLM] fix size of STATUS_REPLY message [63/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:22:59 +0000
Message-Id: <1164889379.3752.431.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 1babdb453138f17b8ed3d1d5711089c4e2fa5ace Mon Sep 17 00:00:00 2001
From: David Teigland <teigland@redhat.com>
Date: Mon, 27 Nov 2006 13:18:41 -0600
Subject: [PATCH] [DLM] fix size of STATUS_REPLY message

When the not_ready routine sends a "fake" status reply with blank status
flags, it needs to use the correct size for a normal STATUS_REPLY by
including the size of the would-be config parameters.  We also fill in the
non-existant config parameters with an invalid lvblen value so it's easier
to notice if these invalid paratmers are ever being used.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/rcom.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index 87b12f7..6ac195c 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -370,9 +370,10 @@ static void receive_rcom_lock_reply(stru
 static int send_ls_not_ready(int nodeid, struct dlm_rcom *rc_in)
 {
 	struct dlm_rcom *rc;
+	struct rcom_config *rf;
 	struct dlm_mhandle *mh;
 	char *mb;
-	int mb_len = sizeof(struct dlm_rcom);
+	int mb_len = sizeof(struct dlm_rcom) + sizeof(struct rcom_config);
 
 	mh = dlm_lowcomms_get_buffer(nodeid, mb_len, GFP_KERNEL, &mb);
 	if (!mh)
@@ -391,6 +392,9 @@ static int send_ls_not_ready(int nodeid,
 	rc->rc_id = rc_in->rc_id;
 	rc->rc_result = -ESRCH;
 
+	rf = (struct rcom_config *) rc->rc_buf;
+	rf->rf_lvblen = -1;
+
 	dlm_rcom_out(rc);
 	dlm_lowcomms_commit_buffer(mh);
 
-- 
1.4.1



