Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVL2QlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVL2QlM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVL2Qkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:40:45 -0500
Received: from host3-98.pool876.interbusiness.it ([87.6.98.3]:50082 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750810AbVL2Qkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:40:43 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/5] uml: hostfs - fix possible PAGE_CACHE_SHIFT overflows
Date: Thu, 29 Dec 2005 17:39:57 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051229163956.4985.92278.stgit@zion.home.lan>
In-Reply-To: <20051229163803.4985.66742.stgit@zion.home.lan>
References: <20051229163803.4985.66742.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Prevent page->index << PAGE_CACHE_SHIFT from overflowing.

There is a casting there, but was added without care, so it's at the wrong
place. Note the extra parens around the shift - "+" is higher precedence than
"<<", leading to a GCC warning which saved all us.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hostfs/hostfs_kern.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 3aac164..b3ad0bd 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -501,11 +501,16 @@ int hostfs_commit_write(struct file *fil
 	long long start;
 	int err = 0;
 
-	start = (long long) (page->index << PAGE_CACHE_SHIFT) + from;
+	start = (((long long) page->index) << PAGE_CACHE_SHIFT) + from;
 	buffer = kmap(page);
 	err = write_file(FILE_HOSTFS_I(file)->fd, &start, buffer + from,
 			 to - from);
 	if(err > 0) err = 0;
+
+	/* Actually, if !err, write_file has added to-from to start, so, despite
+	 * the appearance, we are comparing i_size against the _last_ written
+	 * location, as we should. */
+
 	if(!err && (start > inode->i_size))
 		inode->i_size = start;
 

