Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVGZJFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVGZJFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 05:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVGZJFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 05:05:47 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:61090 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261651AbVGZJFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 05:05:43 -0400
Subject: [PATCH -mm/-rc] fix xip sparse file handling in ext2
From: Carsten Otte <cotte@freenet.de>
To: torvalds@osdl.org, akpm@osdl.org
Cc: paukstad@de.ibm.com, linux-kernel@vger.kernel.org, geraldsc@de.ibm.com,
       schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Tue, 26 Jul 2005 11:05:33 +0200
Message-Id: <1122368733.1695.21.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH -mm/-rc] fix xip sparse file handling in ext2
Oliver Paukstadt from our test department is testing the xip patches in
Linus' git-tree. He found a problem that shows when reading a file that
contains sparse blocks (holes) on a -o xip mounted ext2 filesystem: the
BUG_ON() in fs/ext2/xip.c:40 triggers where it should not. The problem
was introduced by a cleanup in my previous patch, this patch fixes it.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
---
diff -ruwN linux-git/fs/ext2/xip.c linux-git-xip-fixup/fs/ext2/xip.c
--- linux-git/fs/ext2/xip.c	2005-07-25 17:18:38.000000000 +0200
+++ linux-git-xip-fixup/fs/ext2/xip.c	2005-07-26 09:10:49.593563928 +0200
@@ -36,7 +36,7 @@
 	*result = tmp.b_blocknr;
 
 	/* did we get a sparse block (hole in the file)? */
-	if (!(*result)) {
+	if (!tmp.b_blocknr && !rc) {
 		BUG_ON(create);
 		rc = -ENODATA;
 	}


