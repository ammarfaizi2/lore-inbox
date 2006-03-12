Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWCLWlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWCLWlE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWCLWlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:41:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56488 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750779AbWCLWlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:41:03 -0500
Date: Sun, 12 Mar 2006 22:41:00 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dm flush queue EINTR
Message-ID: <20060312224100.GD4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

If dm_suspend() is cancelled, bios already added
to the deferred list need to be submitted.
Otherwise they remain 'in limbo' until there's a dm_resume().

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc5/drivers/md/dm.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/dm.c	2006-03-12 21:56:04.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/dm.c	2006-03-12 21:58:05.000000000 +0000
@@ -1093,6 +1093,7 @@ int dm_suspend(struct mapped_device *md,
 {
 	struct dm_table *map = NULL;
 	DECLARE_WAITQUEUE(wait, current);
+	struct bio *def;
 	int r = -EINVAL;
 
 	down(&md->suspend_lock);
@@ -1152,9 +1153,11 @@ int dm_suspend(struct mapped_device *md,
 	/* were we interrupted ? */
 	r = -EINTR;
 	if (atomic_read(&md->pending)) {
+		clear_bit(DMF_BLOCK_IO, &md->flags);
+		def = bio_list_get(&md->deferred);
+		__flush_deferred_io(md, def);
 		up_write(&md->io_lock);
 		unlock_fs(md);
-		clear_bit(DMF_BLOCK_IO, &md->flags);
 		goto out;
 	}
 	up_write(&md->io_lock);
