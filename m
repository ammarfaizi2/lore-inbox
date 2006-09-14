Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWINVjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWINVjH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWINVjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:39:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751149AbWINVjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:39:04 -0400
Date: Thu, 14 Sep 2006 22:39:00 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>
Subject: [PATCH 04/25] dm snapshot: fix metadata error handling
Message-ID: <20060914213900.GL3928@agk.surrey.redhat.com>
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

Fix the error handling when store.read_metadata is called:
the error should be returned immediately.

Signed-off-by: Mark McLoughlin <markmc@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-snap.c	2006-09-14 20:38:48.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-snap.c	2006-09-14 20:38:50.000000000 +0100
@@ -387,17 +387,6 @@ static inline ulong round_up(ulong n, ul
 	return (n + size) & ~size;
 }
 
-static void read_snapshot_metadata(struct dm_snapshot *s)
-{
-	if (s->store.read_metadata(&s->store)) {
-		down_write(&s->lock);
-		s->valid = 0;
-		up_write(&s->lock);
-
-		dm_table_event(s->table);
-	}
-}
-
 static int set_chunk_size(struct dm_snapshot *s, const char *chunk_size_arg,
 			  char **error)
 {
@@ -528,7 +517,11 @@ static int snapshot_ctr(struct dm_target
 	}
 
 	/* Metadata must only be loaded into one table at once */
-	read_snapshot_metadata(s);
+	r = s->store.read_metadata(&s->store);
+	if (r) {
+		ti->error = "Failed to read snapshot metadata";
+		goto bad6;
+	}
 
 	/* Add snapshot to the list of snapshots for this origin */
 	/* Exceptions aren't triggered till snapshot_resume() is called */
