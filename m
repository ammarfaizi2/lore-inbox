Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161487AbWAMHdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161487AbWAMHdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161489AbWAMHdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:33:07 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:4736 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161487AbWAMHdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:33:06 -0500
Date: Fri, 13 Jan 2006 09:33:05 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs: use __GFP_NOFAIL instead of yield and retry loop
 for allocation
Message-ID: <Pine.LNX.4.58.0601130932090.17696@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch replaces yield and retry loop with __GFP_NOFAIL in
alloc_journal_list(). Compile-tested only.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/reiserfs/journal.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: 2.6/fs/reiserfs/journal.c
===================================================================
--- 2.6.orig/fs/reiserfs/journal.c
+++ 2.6/fs/reiserfs/journal.c
@@ -2446,12 +2446,8 @@ static int journal_read(struct super_blo
 static struct reiserfs_journal_list *alloc_journal_list(struct super_block *s)
 {
 	struct reiserfs_journal_list *jl;
-      retry:
-	jl = kzalloc(sizeof(struct reiserfs_journal_list), GFP_NOFS);
-	if (!jl) {
-		yield();
-		goto retry;
-	}
+	jl = kzalloc(sizeof(struct reiserfs_journal_list),
+		     GFP_NOFS | __GFP_NOFAIL);
 	INIT_LIST_HEAD(&jl->j_list);
 	INIT_LIST_HEAD(&jl->j_working_list);
 	INIT_LIST_HEAD(&jl->j_tail_bh_list);
