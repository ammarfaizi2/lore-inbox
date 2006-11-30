Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936395AbWK3M0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936395AbWK3M0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936348AbWK3M0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:26:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42383 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936364AbWK3MXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:23:44 -0500
Subject: [DLM] fix format warnings in rcom.c and recoverd.c [66/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Ryusuke Konishi <ryusuke@osrg.net>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:23:31 +0000
Message-Id: <1164889411.3752.441.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 57adf7eede38d315e0e328c52484d6a596e9a238 Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <ryusuke@osrg.net>
Date: Wed, 29 Nov 2006 09:33:48 -0500
Subject: [PATCH] [DLM] fix format warnings in rcom.c and recoverd.c

This fixes the following gcc warnings generated on
the architectures where uint64_t != unsigned long long (e.g. ppc64).

fs/dlm/rcom.c:154: warning: format '%llx' expects type 'long long unsigned int', but argument 4 has type 'uint64_t'
fs/dlm/rcom.c:154: warning: format '%llx' expects type 'long long unsigned int', but argument 5 has type 'uint64_t'
fs/dlm/recoverd.c:48: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'uint64_t'
fs/dlm/recoverd.c:202: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'uint64_t'
fs/dlm/recoverd.c:210: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'uint64_t'

Signed-off-by: Ryusuke Konishi <ryusuke@osrg.net>
Signed-off-by: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/rcom.c     |    3 ++-
 fs/dlm/recoverd.c |    8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index c42f2db..4cc31be 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -172,7 +172,8 @@ static void receive_sync_reply(struct dl
 	    rc_in->rc_id != ls->ls_rcom_seq) {
 		log_debug(ls, "reject reply %d from %d seq %llx expect %llx",
 			  rc_in->rc_type, rc_in->rc_header.h_nodeid,
-			  rc_in->rc_id, ls->ls_rcom_seq);
+			  (unsigned long long)rc_in->rc_id,
+			  (unsigned long long)ls->ls_rcom_seq);
 		goto out;
 	}
 	memcpy(ls->ls_recover_buf, rc_in, rc_in->rc_header.h_length);
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 9dc2f91..650536a 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -45,7 +45,7 @@ static int ls_recover(struct dlm_ls *ls,
 	unsigned long start;
 	int error, neg = 0;
 
-	log_debug(ls, "recover %llx", rv->seq);
+	log_debug(ls, "recover %llx", (unsigned long long)rv->seq);
 
 	mutex_lock(&ls->ls_recoverd_active);
 
@@ -212,7 +212,8 @@ static int ls_recover(struct dlm_ls *ls,
 
 	dlm_astd_wake();
 
-	log_debug(ls, "recover %llx done: %u ms", rv->seq,
+	log_debug(ls, "recover %llx done: %u ms",
+		  (unsigned long long)rv->seq,
 		  jiffies_to_msecs(jiffies - start));
 	mutex_unlock(&ls->ls_recoverd_active);
 
@@ -220,7 +221,8 @@ static int ls_recover(struct dlm_ls *ls,
 
  fail:
 	dlm_release_root_list(ls);
-	log_debug(ls, "recover %llx error %d", rv->seq, error);
+	log_debug(ls, "recover %llx error %d",
+		  (unsigned long long)rv->seq, error);
 	mutex_unlock(&ls->ls_recoverd_active);
 	return error;
 }
-- 
1.4.1



