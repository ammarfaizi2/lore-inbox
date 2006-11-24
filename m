Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756521AbWKXJbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521AbWKXJbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757545AbWKXJbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:31:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26324 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756521AbWKXJbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:31:21 -0500
Subject: [DLM] status messages ping-pong between unmounted nodes [2/9]
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Nov 2006 09:34:07 +0000
Message-Id: <1164360847.3392.137.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 4c6500d84e356f0e1ab859ba179050c86e006b02 Mon Sep 17 00:00:00 2001
From: David Teigland <teigland@redhat.com>
Date: Thu, 2 Nov 2006 09:45:56 -0600
Subject: [PATCH] [DLM] status messages ping-pong between unmounted nodes

Red Hat BZ 213682

If two nodes leave the lockspace (while unmounting the fs in the case of
gfs) after one has sent a STATUS message to the other, STATUS/STATUS_REPLY
messages will then ping-pong between the nodes when neither of them can
find the lockspace in question any longer.  We kill this by not sending
another STATUS message when we get a STATUS_REPLY for an unknown
lockspace.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/rcom.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index 518239a..87b12f7 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -412,9 +412,10 @@ void dlm_receive_rcom(struct dlm_header 
 
 	ls = dlm_find_lockspace_global(hd->h_lockspace);
 	if (!ls) {
-		log_print("lockspace %x from %d not found",
-			  hd->h_lockspace, nodeid);
-		send_ls_not_ready(nodeid, rc);
+		log_print("lockspace %x from %d type %x not found",
+			  hd->h_lockspace, nodeid, rc->rc_type);
+		if (rc->rc_type == DLM_RCOM_STATUS)
+			send_ls_not_ready(nodeid, rc);
 		return;
 	}
 
-- 
1.4.1



