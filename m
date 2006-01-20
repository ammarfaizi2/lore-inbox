Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWATVSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWATVSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWATVSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:18:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55776 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932206AbWATVSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:18:07 -0500
Date: Fri, 20 Jan 2006 21:17:59 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] device-mapper snapshot: barriers not supported
Message-ID: <20060120211759.GG4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The snapshot and origin targets are incapable of handling barriers and 
need to indicate this.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc1/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm-snap.c
+++ linux-2.6.16-rc1/drivers/md/dm-snap.c
@@ -792,6 +792,9 @@ static int snapshot_map(struct dm_target
 	if (!s->valid)
 		return -EIO;
 
+	if (unlikely(bio_barrier(bio)))
+		return -EOPNOTSUPP;
+
 	/*
 	 * Write to snapshot - higher level takes care of RW/RO
 	 * flags so we should only get this if we are
@@ -1058,6 +1061,9 @@ static int origin_map(struct dm_target *
 	struct dm_dev *dev = (struct dm_dev *) ti->private;
 	bio->bi_bdev = dev->bdev;
 
+	if (unlikely(bio_barrier(bio)))
+		return -EOPNOTSUPP;
+
 	/* Only tell snapshots if this is a write */
 	return (bio_rw(bio) == WRITE) ? do_origin(dev, bio) : 1;
 }
