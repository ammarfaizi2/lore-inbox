Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263998AbUDVMek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbUDVMek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 08:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264000AbUDVMek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 08:34:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8145 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263998AbUDVMei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 08:34:38 -0400
Date: Thu, 22 Apr 2004 14:34:38 +0200
From: Jan Kara <jack@ucw.cz>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Fix for ext3 journalled quota
Message-ID: <20040422123438.GM3895@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi!

  I've attached a fix for a problem in ext3 journalled quota patch - the
problem is that detecting whether dqput() sleeps was wrong and so we
could possibly schedule when holding a spinlock. If you applied the
patch for journalled quota please apply also this one.
  Andrew, can you please apply the patch to your kernel?

							Thanks
								Honza

diff -ruX /home/jack/.kerndiffexclude linux-2.6.5-2-jquota/fs/dquot.c linux-2.6.5-3-jquota2/fs/dquot.c
--- linux-2.6.5-2-jquota/fs/dquot.c	2004-04-21 10:45:30.000000000 +0200
+++ linux-2.6.5-3-jquota2/fs/dquot.c	2004-04-21 10:50:13.000000000 +0200
@@ -642,7 +642,7 @@
 /* Return 0 if dqput() won't block (note that 1 doesn't necessarily mean blocking) */
 static inline int dqput_blocks(struct dquot *dquot)
 {
-	if (atomic_read(&dquot->dq_count) <= 1 && dquot_dirty(dquot))
+	if (atomic_read(&dquot->dq_count) <= 1)
 		return 1;
 	return 0;
 }
