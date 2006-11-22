Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756677AbWKVTEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbWKVTEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756666AbWKVTEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:04:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43684 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756664AbWKVTEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:04:52 -0500
Date: Wed, 22 Nov 2006 19:04:48 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Milan Broz <mbroz@redhat.com>
Subject: [PATCH 09/11] dm: snapshot: abstract memory release
Message-ID: <20061122190448.GZ6993@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com,
	Milan Broz <mbroz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <mbroz@redhat.com>

Move the code that releases memory used by a snapshot into a separate function.

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com

Index: linux-2.6.19-rc6/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-snap.c	2006-11-22 17:26:58.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-snap.c	2006-11-22 17:27:01.000000000 +0000
@@ -564,6 +564,17 @@ static int snapshot_ctr(struct dm_target
 	return r;
 }
 
+static void __free_exceptions(struct dm_snapshot *s)
+{
+	kcopyd_client_destroy(s->kcopyd_client);
+	s->kcopyd_client = NULL;
+
+	exit_exception_table(&s->pending, pending_cache);
+	exit_exception_table(&s->complete, exception_cache);
+
+	s->store.destroy(&s->store);
+}
+
 static void snapshot_dtr(struct dm_target *ti)
 {
 	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
@@ -574,13 +585,7 @@ static void snapshot_dtr(struct dm_targe
 	/* After this returns there can be no new kcopyd jobs. */
 	unregister_snapshot(s);
 
-	kcopyd_client_destroy(s->kcopyd_client);
-
-	exit_exception_table(&s->pending, pending_cache);
-	exit_exception_table(&s->complete, exception_cache);
-
-	/* Deallocate memory used */
-	s->store.destroy(&s->store);
+	__free_exceptions(s);
 
 	dm_put_device(ti, s->origin);
 	dm_put_device(ti, s->cow);
