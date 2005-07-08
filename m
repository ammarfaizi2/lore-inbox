Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVGHTdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVGHTdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbVGHTaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:30:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41641 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262790AbVGHTaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:30:22 -0400
Date: Fri, 8 Jul 2005 20:30:07 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>
Subject: [PATCH] device-mapper multipath: Barriers not supported
Message-ID: <20050708193007.GD12355@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Lars Marowsky-Bree <lmb@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm multipath will report barriers as not supported with this patch.
                                                                                
Signed-off-by: Lars Marowsky-Bree <lmb@suse.de>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

--- diff/drivers/md/dm-mpath.c	2005-06-17 20:48:29.000000000 +0100
+++ source/drivers/md/dm-mpath.c	2005-07-08 19:01:41.000000000 +0100
@@ -765,6 +765,9 @@
 	struct mpath_io *mpio;
 	struct multipath *m = (struct multipath *) ti->private;
 
+	if (bio_barrier(bio))
+		return -EOPNOTSUPP;
+
 	mpio = mempool_alloc(m->mpio_pool, GFP_NOIO);
 	dm_bio_record(&mpio->details, bio);
 
@@ -988,6 +991,9 @@
 	if ((error == -EWOULDBLOCK) && bio_rw_ahead(bio))
 		return error;
 
+	if (error == -EOPNOTSUPP)
+		return error;
+
 	spin_lock(&m->lock);
 	if (!m->nr_valid_paths) {
 		if (!m->queue_if_no_path || m->suspended) {
--- diff/drivers/md/dm-snap.c	2005-06-17 20:48:29.000000000 +0100
+++ source/drivers/md/dm-snap.c	2005-07-08 19:01:41.000000000 +0100
@@ -777,7 +777,7 @@
 
 	/* Full snapshots are not usable */
 	if (!s->valid)
-		return -1;
+		return -EIO;
 
 	/*
 	 * Write to snapshot - higher level takes care of RW/RO
--- diff/drivers/md/dm.c	2005-06-17 20:48:29.000000000 +0100
+++ source/drivers/md/dm.c	2005-07-08 19:01:41.000000000 +0100
@@ -384,7 +384,7 @@
 		/* error the io and bail out */
 		struct dm_io *io = tio->io;
 		free_tio(tio->io->md, tio);
-		dec_pending(io, -EIO);
+		dec_pending(io, r);
 		bio_put(clone);
 	}
 }
