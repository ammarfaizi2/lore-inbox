Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUHNOdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUHNOdy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 10:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUHNOdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 10:33:53 -0400
Received: from verein.lst.de ([213.95.11.210]:24491 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263117AbUHNOcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 10:32:46 -0400
Date: Sat, 14 Aug 2004 16:32:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] BUG() on inconsistant dcache tree in may_delete
Message-ID: <20040814143239.GA26038@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This can't happen with a sane filesystem (but is triggered by the buggy
clearcase bin only kernel module), so let's better BUG_ON early.

Adopted from Al's patch in the RH tree.


--- 1.103/fs/namei.c	2004-07-13 16:08:53 +02:00
+++ edited/fs/namei.c	2004-08-14 16:09:16 +02:00
@@ -1094,8 +1094,12 @@
 static inline int may_delete(struct inode *dir,struct dentry *victim,int isdir)
 {
 	int error;
-	if (!victim->d_inode || victim->d_parent->d_inode != dir)
+
+	if (!victim->d_inode)
 		return -ENOENT;
+
+	BUG_ON(victim->d_parent->d_inode != dir);
+
 	error = permission(dir,MAY_WRITE | MAY_EXEC, NULL);
 	if (error)
 		return error;
