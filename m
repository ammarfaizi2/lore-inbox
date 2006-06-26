Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933235AbWFZXa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933235AbWFZXa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933288AbWFZXax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:30:53 -0400
Received: from dh134.citi.umich.edu ([141.211.133.134]:2748 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S933210AbWFZXaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:30:11 -0400
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH 4/5] VFS: Add support for the FL_ACCESS flag to flock_lock_file()
Date: Mon, 26 Jun 2006 19:30:10 -0400
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20060626233010.6059.52077.stgit@lade.trondhjem.org>
In-Reply-To: <20060626232936.6059.50399.stgit@lade.trondhjem.org>
References: <20060626232936.6059.50399.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/locks.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 50cb0a2..b0b41a6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -739,6 +739,8 @@ static int flock_lock_file(struct file *
 	int found = 0;
 
 	lock_kernel();
+	if (request->fl_flags & FL_ACCESS)
+		goto find_conflict;
 	for_each_lock(inode, before) {
 		struct file_lock *fl = *before;
 		if (IS_POSIX(fl))
@@ -771,6 +773,7 @@ static int flock_lock_file(struct file *
 	if (found)
 		cond_resched();
 
+find_conflict:
 	for_each_lock(inode, before) {
 		struct file_lock *fl = *before;
 		if (IS_POSIX(fl))
@@ -784,6 +787,8 @@ static int flock_lock_file(struct file *
 			locks_insert_block(fl, request);
 		goto out;
 	}
+	if (request->fl_flags & FL_ACCESS)
+		goto out;
 	locks_copy_lock(new_fl, request);
 	locks_insert_lock(&inode->i_flock, new_fl);
 	new_fl = NULL;
