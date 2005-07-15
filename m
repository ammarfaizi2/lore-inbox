Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263288AbVGOKhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbVGOKhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVGOKfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:35:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19091 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263272AbVGOKc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:32:28 -0400
Date: Fri, 15 Jul 2005 18:37:19 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 11/12] dlm: return error in status reply
Message-ID: <20050715103719.GN17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="rcom-status-reply.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a lockspace on a remote node is not found for a recovery status
request, an error needs to be returned so the requesting node can
distinguish it from a normal reply with a zero status.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/rcom.c
===================================================================
--- linux.orig/drivers/dlm/rcom.c
+++ linux/drivers/dlm/rcom.c
@@ -78,13 +78,13 @@ static void make_config(struct dlm_ls *l
 	rf->rf_lsflags = ls->ls_exflags;
 }
 
-static int check_config(struct dlm_ls *ls, struct rcom_config *rf)
+static int check_config(struct dlm_ls *ls, struct rcom_config *rf, int nodeid)
 {
 	if (rf->rf_lvblen != ls->ls_lvblen ||
 	    rf->rf_lsflags != ls->ls_exflags) {
-		log_error(ls, "config mismatch %d,%d %x,%x",
-			  rf->rf_lvblen, ls->ls_lvblen,
-			  rf->rf_lsflags, ls->ls_exflags);
+		log_error(ls, "config mismatch: %d,%x nodeid %d: %d,%x",
+			  ls->ls_lvblen, ls->ls_exflags,
+			  nodeid, rf->rf_lvblen, rf->rf_lsflags);
 		return -EINVAL;
 	}
 	return 0;
@@ -116,7 +116,15 @@ int dlm_rcom_status(struct dlm_ls *ls, i
 		goto out;
 
 	rc = (struct dlm_rcom *) ls->ls_recover_buf;
-	error = check_config(ls, (struct rcom_config *) rc->rc_buf);
+
+	if (rc->rc_result == -ESRCH) {
+		/* we pretend the remote lockspace exists with 0 status */
+		log_debug(ls, "remote node %d not ready", nodeid);
+		rc->rc_result = 0;
+	} else
+		error = check_config(ls, (struct rcom_config *) rc->rc_buf,
+				     nodeid);
+	/* the caller looks at rc_result for the remote recovery status */
  out:
 	return error;
 }
@@ -369,7 +377,7 @@ static int send_ls_not_ready(int nodeid,
 	rc->rc_header.h_cmd = DLM_RCOM;
 
 	rc->rc_type = DLM_RCOM_STATUS_REPLY;
-	rc->rc_result = 0;
+	rc->rc_result = -ESRCH;
 
 	dlm_rcom_out(rc);
 	dlm_lowcomms_commit_buffer(mh);
@@ -392,6 +400,8 @@ void dlm_receive_rcom(struct dlm_header 
 
 	ls = dlm_find_lockspace_global(hd->h_lockspace);
 	if (!ls) {
+		log_print("lockspace %x from %d not found",
+			  hd->h_lockspace, nodeid);
 		send_ls_not_ready(nodeid, rc);
 		return;
 	}

--
