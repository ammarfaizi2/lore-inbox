Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261298AbSIZNvr>; Thu, 26 Sep 2002 09:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSIZNug>; Thu, 26 Sep 2002 09:50:36 -0400
Received: from pc-62-31-66-34-ed.blueyonder.co.uk ([62.31.66.34]:21635 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261288AbSIZNu3>; Thu, 26 Sep 2002 09:50:29 -0400
Date: Thu, 26 Sep 2002 14:55:31 +0100
Message-Id: <200209261355.g8QDtVC16990@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 1/7] 2.4.20-pre4/ext3: Fix LVM snapshot deadlock
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix LVM snapshot deadlock: it is a bad idea to try to flush all running
transactions while we already hold the superblock lock.  Drop the sb lock
while we flush.

This only affects kernels that have the extra LVM VFS locking added in
for filesystem quiescing on snapshots.

--- linux-2.4-ext3merge/fs/ext3/super.c.=K0000=.orig	Thu Sep 26 12:19:14 2002
+++ linux-2.4-ext3merge/fs/ext3/super.c	Thu Sep 26 12:25:37 2002
@@ -1588,8 +1588,10 @@
 		journal_t *journal = EXT3_SB(sb)->s_journal;
 
 		/* Now we set up the journal barrier. */
+		unlock_super(sb);
 		journal_lock_updates(journal);
 		journal_flush(journal);
+		lock_super(sb);
 
 		/* Journal blocked and flushed, clear needs_recovery flag. */
 		EXT3_CLEAR_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER);
