Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVGOKoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVGOKoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbVGOKes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:34:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7827 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263271AbVGOKcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:32:05 -0400
Date: Fri, 15 Jul 2005 18:37:02 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 09/12] dlm: clear NEW_MASTER flag
Message-ID: <20050715103702.GL17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="clear-new-master.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If recover_locks() on an rsb doesn't find any locks to recover, we need to
clear the NEW_MASTER flag since it won't be cleared by
dlm_recovered_lock().

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/recover.c
===================================================================
--- linux.orig/drivers/dlm/recover.c
+++ linux/drivers/dlm/recover.c
@@ -502,6 +502,8 @@ static int recover_locks(struct dlm_rsb 
 
 	if (r->res_recover_locks_count)
 		recover_list_add(r);
+	else
+		rsb_clear_flag(r, RSB_NEW_MASTER);
  out:
 	unlock_rsb(r);
 	return error;
@@ -553,6 +555,8 @@ int dlm_recover_locks(struct dlm_ls *ls)
 
 void dlm_recovered_lock(struct dlm_rsb *r)
 {
+	DLM_ASSERT(rsb_flag(r, RSB_NEW_MASTER), dlm_print_rsb(r););
+
 	r->res_recover_locks_count--;
 	if (!r->res_recover_locks_count) {
 		rsb_clear_flag(r, RSB_NEW_MASTER);

--
