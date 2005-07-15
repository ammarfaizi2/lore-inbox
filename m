Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263284AbVGOKeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263284AbVGOKeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbVGOKcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:32:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9362 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263271AbVGOKaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:30:02 -0400
Date: Fri, 15 Jul 2005 18:34:52 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 02/12] dlm: resend lookups
Message-ID: <20050715103452.GE17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="resend-lookups.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During recovery, set the RESEND flag on locks waiting for a lookup so
they'll be resent when recovery completes.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux-2.6.12-mm1/drivers/dlm/lock.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/lock.c
+++ linux-2.6.12-mm1/drivers/dlm/lock.c
@@ -3212,12 +3212,20 @@ void dlm_recover_waiters_pre(struct dlm_
 	down(&ls->ls_waiters_sem);
 
 	list_for_each_entry_safe(lkb, safe, &ls->ls_waiters, lkb_wait_reply) {
-		if (!dlm_is_removed(ls, lkb->lkb_nodeid))
-			continue;
-
 		log_debug(ls, "pre recover waiter lkid %x type %d flags %x",
 			  lkb->lkb_id, lkb->lkb_wait_type, lkb->lkb_flags);
 
+		/* all outstanding lookups, regardless of destination  will be
+		   resent after recovery is done */
+
+		if (lkb->lkb_wait_type == DLM_MSG_LOOKUP) {
+			lkb->lkb_flags |= DLM_IFL_RESEND;
+			continue;
+		}
+
+		if (!dlm_is_removed(ls, lkb->lkb_nodeid))
+			continue;
+
 		switch (lkb->lkb_wait_type) {
 
 		case DLM_MSG_REQUEST:
@@ -3244,11 +3252,6 @@ void dlm_recover_waiters_pre(struct dlm_
 			put_lkb(lkb);
 			break;
 
-		case DLM_MSG_LOOKUP:
-			/* all outstanding lookups, regardless of dest.
-			   will be resent after recovery is done */
-			break;
-
 		default:
 			log_error(ls, "invalid lkb wait_type %d",
 				  lkb->lkb_wait_type);

--
