Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWCLWqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWCLWqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWCLWqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:46:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38061 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751343AbWCLWqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:46:37 -0500
Date: Sun, 12 Mar 2006 22:46:28 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] dm snapshot: fix pending pe ref
Message-ID: <20060312224628.GE4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid references to 'pe->primary_pe' after freeing 'pe'.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
Index: linux-2.6.16-rc1/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm-snap.c	2006-02-06 23:18:03.000000000 +0000
+++ linux-2.6.16-rc1/drivers/md/dm-snap.c	2006-02-06 23:18:44.000000000 +0000
@@ -651,6 +651,7 @@ static void __invalidate_snapshot(struct
 static void pending_complete(struct pending_exception *pe, int success)
 {
 	struct exception *e;
+	struct pending_exception *primary_pe;
 	struct dm_snapshot *s = pe->snap;
 	struct bio *flush = NULL;
 
@@ -702,18 +703,20 @@ static void pending_complete(struct pend
 	flush_bios(bio_list_get(&pe->snapshot_bios));
 
  out:
+	primary_pe = pe->primary_pe;
+
 	/*
 	 * Free the pe if it's not linked to an origin write or if
 	 * it's not itself a primary pe.
 	 */
-	if (!pe->primary_pe || pe->primary_pe != pe)
+	if (!primary_pe || primary_pe != pe)
 		free_pending_exception(pe);
 
 	/*
 	 * Free the primary pe if nothing references it.
 	 */
-	if (pe->primary_pe && !atomic_read(&pe->primary_pe->sibling_count))
-		free_pending_exception(pe->primary_pe);
+	if (primary_pe && !atomic_read(&primary_pe->sibling_count))
+		free_pending_exception(primary_pe);
 
 	if (flush)
 		flush_bios(flush);
