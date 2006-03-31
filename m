Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWCaRcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWCaRcJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWCaRcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:32:08 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:60391 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751059AbWCaRcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:32:07 -0500
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:26:25 +0200)
Subject: [PATCH 3/4] locks: don't do unnecessary allocations
References: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNTX-0005W5-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:31:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

posix_lock_file() always allocates new locks in advance, even if it's
easy to determine that no allocations will be needed.

Optimize these cases:

 - FL_ACCESS flag is set

 - Unlocking the whole range

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/locks.c
===================================================================
--- linux.orig/fs/locks.c	2006-03-31 18:55:33.000000000 +0200
+++ linux/fs/locks.c	2006-03-31 18:55:33.000000000 +0200
@@ -795,7 +795,8 @@ int __posix_lock_file(struct inode *inod
 		      struct file_lock *conflock)
 {
 	struct file_lock *fl;
-	struct file_lock *new_fl, *new_fl2;
+	struct file_lock *new_fl = NULL;
+	struct file_lock *new_fl2 = NULL;
 	struct file_lock *left = NULL;
 	struct file_lock *right = NULL;
 	struct file_lock **before;
@@ -804,9 +805,15 @@ int __posix_lock_file(struct inode *inod
 	/*
 	 * We may need two file_lock structures for this operation,
 	 * so we get them in advance to avoid races.
+	 *
+	 * In some cases we can be sure, that no new locks will be needed
 	 */
-	new_fl = locks_alloc_lock();
-	new_fl2 = locks_alloc_lock();
+	if (!(request->fl_flags & FL_ACCESS) &&
+	    (request->fl_type != F_UNLCK ||
+	     request->fl_start != 0 || request->fl_end != OFFSET_MAX)) {
+		new_fl = locks_alloc_lock();
+		new_fl2 = locks_alloc_lock();
+	}
 
 	lock_kernel();
 	if (request->fl_type != F_UNLCK) {
