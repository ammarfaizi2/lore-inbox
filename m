Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTKXJjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 04:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTKXJjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 04:39:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35276 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263695AbTKXJjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 04:39:00 -0500
Date: Mon, 24 Nov 2003 10:38:59 +0100
From: Jan Kara <jack@ucw.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] Fix possible oops in sync_dquots
Message-ID: <20031124093859.GA13790@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Andrew,

  I'm sending you a fix of possible Oops in vfs_quota_sync(). Actually
nobody has run into that I found it when I was looking through the
code... The patch is against -test9 but should apply against -test10
too. Please apply.

								Honza

PS: Linus, if you find it interesting for your patch queue then apply
too :)...

diff -ruX ../kerndiffexclude linux-2.6.0-test9-um/fs/dquot.c linux-2.6.0-test9-syncfix/fs/dquot.c
--- linux-2.6.0-test9-um/fs/dquot.c	Thu Nov  6 19:10:37 2003
+++ linux-2.6.0-test9-syncfix/fs/dquot.c	Mon Nov 24 10:31:41 2003
@@ -192,6 +192,8 @@
 
 struct dqstats dqstats;
 
+static void dqput(struct dquot *dquot);
+
 static inline int const hashfn(struct super_block *sb, unsigned int id, int type)
 {
 	return((((unsigned long)sb>>L1_CACHE_SHIFT) ^ id) * (MAXQUOTAS - type)) % NR_DQHASH;
@@ -339,8 +341,11 @@
 			continue;
 		if (!dquot_dirty(dquot))
 			continue;
+		atomic_inc(&dquot->dq_count);
+		dqstats.lookups++;
 		spin_unlock(&dq_list_lock);
 		sb->dq_op->sync_dquot(dquot);
+		dqput(dquot);
 		goto restart;
 	}
 	spin_unlock(&dq_list_lock);
