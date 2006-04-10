Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWDJUis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWDJUis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 16:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWDJUis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 16:38:48 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:9915 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932135AbWDJUir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 16:38:47 -0400
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <E1FT36W-0004KP-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 10 Apr 2006 22:35:20 +0200)
Subject: [PATCH 2/3] locks: don't do unnecessary allocations
References: <E1FT36W-0004KP-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FT39c-0004LV-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Apr 2006 22:38:32 +0200
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
--- linux.orig/fs/locks.c	2006-04-09 11:07:10.000000000 +0200
+++ linux/fs/locks.c	2006-04-09 11:07:13.000000000 +0200
@@ -790,7 +790,8 @@ out:
 static int __posix_lock_file_conf(struct inode *inode, struct file_lock *request, struct file_lock *conflock)
 {
 	struct file_lock *fl;
-	struct file_lock *new_fl, *new_fl2;
+	struct file_lock *new_fl = NULL;
+	struct file_lock *new_fl2 = NULL;
 	struct file_lock *left = NULL;
 	struct file_lock *right = NULL;
 	struct file_lock **before;
@@ -799,9 +800,15 @@ static int __posix_lock_file_conf(struct
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
