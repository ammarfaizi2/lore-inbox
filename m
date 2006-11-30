Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936324AbWK3Mcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936324AbWK3Mcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966288AbWK3McL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:32:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28812 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936329AbWK3MTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:19:55 -0500
Subject: [DLM] fix stopping unstarted recovery [43/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:19:56 +0000
Message-Id: <1164889196.3752.391.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 2cdc98aaf072d573df10c503d3b3b0b74e2a6d06 Mon Sep 17 00:00:00 2001
From: David Teigland <teigland@redhat.com>
Date: Tue, 31 Oct 2006 11:56:08 -0600
Subject: [PATCH] [DLM] fix stopping unstarted recovery

Red Hat BZ 211914

When many nodes are joining a lockspace simultaneously, the dlm gets a
quick sequence of stop/start events, a pair for adding each node.
dlm_controld in user space sends dlm_recoverd in the kernel each stop and
start event.  dlm_controld will sometimes send the stop before
dlm_recoverd has had a chance to take up the previously queued start.  The
stop aborts the processing of the previous start by setting the
RECOVERY_STOP flag.  dlm_recoverd is erroneously clearing this flag and
ignoring the stop/abort if it happens to take up the start after the stop
meant to abort it.  The fix is to check the sequence number that's
incremented for each stop/start before clearing the flag.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/recoverd.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 4a1d602..6e4ee94 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -219,6 +219,10 @@ static int ls_recover(struct dlm_ls *ls,
 	return error;
 }
 
+/* The dlm_ls_start() that created the rv we take here may already have been
+   stopped via dlm_ls_stop(); in that case we need to leave the RECOVERY_STOP
+   flag set. */
+
 static void do_ls_recovery(struct dlm_ls *ls)
 {
 	struct dlm_recover *rv = NULL;
@@ -226,7 +230,8 @@ static void do_ls_recovery(struct dlm_ls
 	spin_lock(&ls->ls_recover_lock);
 	rv = ls->ls_recover_args;
 	ls->ls_recover_args = NULL;
-	clear_bit(LSFL_RECOVERY_STOP, &ls->ls_flags);
+	if (rv && ls->ls_recover_seq == rv->seq)
+		clear_bit(LSFL_RECOVERY_STOP, &ls->ls_flags);
 	spin_unlock(&ls->ls_recover_lock);
 
 	if (rv) {
-- 
1.4.1



