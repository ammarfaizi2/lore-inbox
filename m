Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbUKPUsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUKPUsy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUKPUrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:47:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:2973 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261783AbUKPUpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:45:18 -0500
Date: Tue, 16 Nov 2004 14:45:07 -0600
From: Robin Holt <holt@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Hold BKL for shorter period in generic_shutdown_super().
Message-ID: <20041116204507.GA8524@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Testing revealed long pauses of the entire system while autofs initiated
umounts as a result of timing out the mounts.

It was noticed that during a umount, the BKL is held while scanning
the inode_list and removing and inodes that are candidates.  This patch
moves locking until after the first pass had gone through the inode_list.

Testing revelead that on an ia64 machine with a filesystem that had
8.4 Million inodes, there were no observable pauses during the umount.
This was down from over 4 seconds without this patch.

Signed-Off-By: Robin Holt <holt@sgi.com>


Index: linux/fs/super.c
===================================================================
--- linux.orig/fs/super.c       2004-11-16 14:41:37.213825056 -0600
+++ linux/fs/super.c    2004-11-16 14:41:49.027032016 -0600
@@ -233,10 +233,10 @@
                dput(root);
                fsync_super(sb);
                lock_super(sb);
-               lock_kernel();
                sb->s_flags &= ~MS_ACTIVE;
                /* bad name - it should be evict_inodes() */
                invalidate_inodes(sb);
+               lock_kernel();

                if (sop->write_super && sb->s_dirt)
                        sop->write_super(sb);

