Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318888AbSH1PmR>; Wed, 28 Aug 2002 11:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318882AbSH1PlP>; Wed, 28 Aug 2002 11:41:15 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:3971 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318883AbSH1PlH>; Wed, 28 Aug 2002 11:41:07 -0400
Date: Wed, 28 Aug 2002 16:45:19 +0100
Message-Id: <200208281545.g7SFjJw14322@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 1/8] 2.4.20-pre4/ext3: fsync optimisation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fsync optimisation: save an extra unnecessary pass over the data if we
are in an ordered or journaled data mode.

--- linux-ext3-2.4merge/fs/ext3/fsync.c.=K0002=.orig	Tue Aug 27 23:16:39 2002
+++ linux-ext3-2.4merge/fs/ext3/fsync.c	Tue Aug 27 23:19:57 2002
@@ -62,7 +62,12 @@
 	 * we'll end up waiting on them in commit.
 	 */
 	ret = fsync_inode_buffers(inode);
-	ret |= fsync_inode_data_buffers(inode);
+
+	/* In writeback mode, we need to force out data buffers too.  In
+	 * the other modes, ext3_force_commit takes care of forcing out
+	 * just the right data blocks. */
+	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)
+		ret |= fsync_inode_data_buffers(inode);
 
 	ext3_force_commit(inode->i_sb);
 
