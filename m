Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWINVkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWINVkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWINVkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:40:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47827 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751175AbWINVkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:40:22 -0400
Date: Thu, 14 Sep 2006 22:40:16 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>
Subject: [PATCH 06/25] dm snapshot: fix metadata writing when suspending
Message-ID: <20060914214016.GN3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark McLoughlin <markmc@redhat.com>

When suspending a device-mapper device, dm_suspend() sleeps until all
necessary I/O is completed.  This state is triggered by a callback from
persistent_commit().  But some I/O can still be issued *after* the
callback (to prepare the next metadata area for use if the current one is
full).  This patch delays the callback until after that I/O is complete.

Signed-off-by: Mark McLoughlin <markmc@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-exception-store.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-exception-store.c	2006-09-14 20:39:03.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-exception-store.c	2006-09-14 20:39:29.000000000 +0100
@@ -536,6 +536,16 @@ static void persistent_commit(struct exc
 		if (r)
 			ps->valid = 0;
 
+		/*
+		 * Have we completely filled the current area ?
+		 */
+		if (ps->current_committed == ps->exceptions_per_area) {
+			ps->current_committed = 0;
+			r = zero_area(ps, ps->current_area + 1);
+			if (r)
+				ps->valid = 0;
+		}
+
 		for (i = 0; i < ps->callback_count; i++) {
 			cb = ps->callbacks + i;
 			cb->callback(cb->context, r == 0 ? 1 : 0);
@@ -543,16 +553,6 @@ static void persistent_commit(struct exc
 
 		ps->callback_count = 0;
 	}
-
-	/*
-	 * Have we completely filled the current area ?
-	 */
-	if (ps->current_committed == ps->exceptions_per_area) {
-		ps->current_committed = 0;
-		r = zero_area(ps, ps->current_area + 1);
-		if (r)
-			ps->valid = 0;
-	}
 }
 
 static void persistent_drop(struct exception_store *store)
