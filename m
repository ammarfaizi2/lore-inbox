Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757660AbWKXJcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660AbWKXJcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757663AbWKXJcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:32:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50900 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757651AbWKXJbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:31:53 -0500
Subject: [DLM] do full recover_locks barrier [6/9]
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Nov 2006 09:34:28 +0000
Message-Id: <1164360868.3392.143.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 7aa1c6ae53b16b07c3f31296929750f3187378b3 Mon Sep 17 00:00:00 2001
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



