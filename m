Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVKRPBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVKRPBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVKRPBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:01:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14745 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750769AbVKRPBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:01:41 -0500
Date: Fri, 18 Nov 2005 15:01:35 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper snapshot: metadata reading separation
Message-ID: <20051118150135.GP11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More snapshot metadata reading into separate function, to prepare
for changing the place it gets called from.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.14.orig/drivers/md/dm-snap.c	2005-11-17 22:17:55.000000000 +0000
+++ linux-2.6.14/drivers/md/dm-snap.c	2005-11-17 22:18:25.000000000 +0000
@@ -371,6 +371,20 @@ static inline ulong round_up(ulong n, ul
 	return (n + size) & ~size;
 }
 
+static void read_snapshot_metadata(struct dm_snapshot *s)
+{
+	if (s->have_metadata)
+		return;
+
+	if (s->store.read_metadata(&s->store)) {
+		down_write(&s->lock);
+		s->valid = 0;
+		up_write(&s->lock);
+	}
+
+	s->have_metadata = 1;
+}
+
 /*
  * Construct a snapshot mapping: <origin_dev> <COW-dev> <p/n> <chunk-size>
  */
@@ -848,16 +862,7 @@ static void snapshot_resume(struct dm_ta
 {
 	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
 
-	if (s->have_metadata)
-		return;
-
-	if (s->store.read_metadata(&s->store)) {
-		down_write(&s->lock);
-		s->valid = 0;
-		up_write(&s->lock);
-	}
-
-	s->have_metadata = 1;
+	read_snapshot_metadata(s);
 }
 
 static int snapshot_status(struct dm_target *ti, status_type_t type,
