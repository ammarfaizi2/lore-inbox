Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274968AbTHAUbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 16:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274969AbTHAUbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 16:31:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54788 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S274968AbTHAUb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 16:31:26 -0400
Date: Fri, 1 Aug 2003 22:31:24 +0200
From: Jan Kara <jack@ucw.cz>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix 2.6.0-test2 quota
Message-ID: <20030801203124.GC17782@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Linus,

  I'm sending you a patch which fixes a bug in locking (we take one lock
twice) for old quota format. Without this patch the old format simply
don't work (I really don't know how that could happen). My thanks go to
Herbert Potzl who spotted it. The patch is attached, please apply.

							Thanks
								Honza


diff -ruNX /home/jack/.kerndiffexclude linux-2.6.0-test2/fs/quota_v1.c linux-2.6.0-test2-quotafix/fs/quota_v1.c
--- linux-2.6.0-test2/fs/quota_v1.c	Sun Jul 27 19:06:18 2003
+++ linux-2.6.0-test2-quotafix/fs/quota_v1.c	Tue Jul 29 21:19:39 2003
@@ -164,7 +164,6 @@
 	struct v1_disk_dqblk dqblk;
 	int ret;
 
-	down(&dqopt->dqio_sem);
 	offset = v1_dqoff(0);
 	fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -177,7 +176,6 @@
 	dqopt->info[type].dqi_igrace = dqblk.dqb_itime ? dqblk.dqb_itime : MAX_IQ_TIME;
 	dqopt->info[type].dqi_bgrace = dqblk.dqb_btime ? dqblk.dqb_btime : MAX_DQ_TIME;
 out:
-	up(&dqopt->dqio_sem);
 	set_fs(fs);
 	return ret;
 }
@@ -191,7 +189,6 @@
 	loff_t offset;
 	int ret;
 
-	down(&dqopt->dqio_sem);
 	dqopt->info[type].dqi_flags &= ~DQF_INFO_DIRTY;
 	offset = v1_dqoff(0);
 	fs = get_fs();
@@ -210,7 +207,6 @@
 	else if (ret > 0)
 		ret = -EIO;
 out:
-	up(&dqopt->dqio_sem);
 	set_fs(fs);
 	return ret;
 }
