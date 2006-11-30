Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936345AbWK3MVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936345AbWK3MVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936322AbWK3MUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:20:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37772 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936341AbWK3MUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:20:02 -0500
Subject: [DLM] do full recover_locks barrier [44/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:20:05 +0000
Message-Id: <1164889205.3752.393.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 4b77f2c93d052adca8cc8690b9b5e7f8798f4ddd Mon Sep 17 00:00:00 2001
From: David Teigland <teigland@redhat.com>
Date: Wed, 1 Nov 2006 09:31:48 -0600
Subject: [PATCH] [DLM] do full recover_locks barrier

Red Hat BZ 211914

The previous patch "[DLM] fix aborted recovery during
node removal" was incomplete as discovered with further testing.  It set
the bit for the RS_LOCKS barrier but did not then wait for the barrier.
This is often ok, but sometimes it will cause yet another recovery hang.
If it's a new node that also has the lowest nodeid that skips the barrier
wait, then it misses the important step of collecting and reporting the
barrier status from the other nodes (which is the job of the low nodeid in
the barrier wait routine).

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/recoverd.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 6e4ee94..8bb895f 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -168,9 +168,15 @@ static int ls_recover(struct dlm_ls *ls,
 		/*
 		 * Other lockspace members may be going through the "neg" steps
 		 * while also adding us to the lockspace, in which case they'll
-		 * be looking for this status bit during dlm_recover_locks().
+		 * be doing the recover_locks (RS_LOCKS) barrier.
 		 */
 		dlm_set_recover_status(ls, DLM_RS_LOCKS);
+
+		error = dlm_recover_locks_wait(ls);
+		if (error) {
+			log_error(ls, "recover_locks_wait failed %d", error);
+			goto fail;
+		}
 	}
 
 	dlm_release_root_list(ls);
-- 
1.4.1



