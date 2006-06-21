Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbWFUTgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbWFUTgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWFUTgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:36:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24229 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932705AbWFUTgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:36:00 -0400
Date: Wed, 21 Jun 2006 20:35:54 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Brassow <jbrassow@redhat.com>
Subject: [PATCH 09/15] dm kcopyd: error accumulation fix
Message-ID: <20060621193554.GX4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jonathan Brassow <jbrassow@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Brassow <jbrassow@redhat.com>

kcopyd should accumulate errors - otherwise I/O failures may
be ignored unintentionally.

And invert 'success' (used in a future patch), using a more
intuitive !(read_err || write_err).

Signed-off-by: Jonathan Brassow <jbrassow@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/kcopyd.c
===================================================================
--- linux-2.6.17.orig/drivers/md/kcopyd.c	2006-06-21 16:19:34.000000000 +0100
+++ linux-2.6.17/drivers/md/kcopyd.c	2006-06-21 17:17:57.000000000 +0100
@@ -314,7 +314,7 @@ static void complete_io(unsigned long er
 
 	if (error) {
 		if (job->rw == WRITE)
-			job->write_err &= error;
+			job->write_err |= error;
 		else
 			job->read_err = 1;
 
@@ -460,7 +460,7 @@ static void segment_complete(int read_er
 		job->read_err = 1;
 
 	if (write_err)
-		job->write_err &= write_err;
+		job->write_err |= write_err;
 
 	/*
 	 * Only dispatch more work if there hasn't been an error.
Index: linux-2.6.17/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-raid1.c	2006-06-21 17:17:49.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-raid1.c	2006-06-21 17:17:57.000000000 +0100
@@ -604,7 +604,7 @@ static void recovery_complete(int read_e
 	struct region *reg = (struct region *) context;
 
 	/* FIXME: better error handling */
-	rh_recovery_end(reg, read_err || write_err);
+	rh_recovery_end(reg, !(read_err || write_err));
 }
 
 static int recover(struct mirror_set *ms, struct region *reg)
