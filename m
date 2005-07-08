Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbVGHUXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbVGHUXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVGHTlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:41:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42421 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262824AbVGHTkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:40:35 -0400
Date: Fri, 8 Jul 2005 20:40:19 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>
Subject: [PATCH] device-mapper: Fix dm_swap_table error cases
Message-ID: <20050708194019.GH12355@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Lars Marowsky-Bree <lmb@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dm_swap_table() __bind error cases: a missing unlock, and EINVAL
preferable to EPERM.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm.c	2005-07-08 19:21:37.000000000 +0100
+++ source/drivers/md/dm.c	2005-07-08 19:36:03.000000000 +0100
@@ -966,23 +966,20 @@
  */
 int dm_swap_table(struct mapped_device *md, struct dm_table *table)
 {
-	int r;
+	int r = -EINVAL;
 
 	down_write(&md->lock);
 
 	/* device must be suspended */
-	if (!test_bit(DMF_SUSPENDED, &md->flags)) {
-		up_write(&md->lock);
-		return -EPERM;
-	}
+	if (!test_bit(DMF_SUSPENDED, &md->flags))
+		goto out;
 
 	__unbind(md);
 	r = __bind(md, table);
-	if (r)
-		return r;
 
+out:
 	up_write(&md->lock);
-	return 0;
+	return r;
 }
 
 /*

