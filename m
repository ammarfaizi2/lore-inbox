Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268200AbUI2E71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268200AbUI2E71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 00:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUI2E71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 00:59:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:24299 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268200AbUI2E7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 00:59:25 -0400
Date: Tue, 28 Sep 2004 21:57:18 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: neilb@cse.unsw.edu.au
Subject: [PATCH] exportfs: reduce stack usage
Message-Id: <20040928215718.55ed72a5.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


find_exported_dentry() declares
	char nbuf[NAME_MAX+1];
in 2 separate places, and gcc allocates space on the stack for both
of them.  Having just one of them will suffice, if we can put put
with its scope.

Reduces function stack usage on x86-32 from 0x230 to 0x130.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 fs/exportfs/expfs.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -Naurp ./fs/exportfs/expfs.c~expfs_stack ./fs/exportfs/expfs.c
--- ./fs/exportfs/expfs.c~expfs_stack	2004-09-15 19:27:42.000000000 -0700
+++ ./fs/exportfs/expfs.c	2004-09-28 21:35:42.339816784 -0700
@@ -55,7 +55,7 @@ find_exported_dentry(struct super_block 
 	struct list_head *le, *head;
 	struct dentry *toput = NULL;
 	int noprogress;
-
+	char nbuf[NAME_MAX+1];
 
 	/*
 	 * Attempt to find the inode.
@@ -176,7 +176,6 @@ find_exported_dentry(struct super_block 
 			 */
 			struct dentry *ppd;
 			struct dentry *npd;
-			char nbuf[NAME_MAX+1];
 
 			down(&pd->d_inode->i_sem);
 			ppd = CALL(nops,get_parent)(pd);
@@ -241,7 +240,6 @@ find_exported_dentry(struct super_block 
 	/* if we weren't after a directory, have one more step to go */
 	if (result != target_dir) {
 		struct dentry *nresult;
-		char nbuf[NAME_MAX+1];
 		err = CALL(nops,get_name)(target_dir, nbuf, result);
 		if (!err) {
 			down(&target_dir->d_inode->i_sem);


--
