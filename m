Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbUBXQwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbUBXQwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:52:22 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:17484 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262301AbUBXQwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:52:17 -0500
Date: Tue, 24 Feb 2004 16:52:19 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sync_sb_inodes sync hang
Message-ID: <Pine.LNX.4.44.0402241636160.1681-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.3-mm UP without PREEMPT easily hangs looping around pdflush's
sync_sb_inodes, failing the down_read_trylock in do_writepages,
but giving the concurrent sync no chance to complete: just try
while : ; do echo $SECONDS; sync; cp /etc/termcap .; done

I think sync_sb_inodes is the only loop vulnerable to that
change in do_writepages, so site the cond_resched() here.

Hugh

--- 2.6.3-mm3/fs/fs-writeback.c	2004-02-23 12:51:49.000000000 +0000
+++ linux/fs/fs-writeback.c	2004-02-24 16:14:49.000000000 +0000
@@ -326,6 +326,7 @@ sync_sb_inodes(struct super_block *sb, s
 			writeback_release(bdi);
 		spin_unlock(&inode_lock);
 		iput(inode);
+		cond_resched();
 		spin_lock(&inode_lock);
 		if (wbc->nr_to_write <= 0)
 			break;

