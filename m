Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291084AbSBGCkb>; Wed, 6 Feb 2002 21:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291080AbSBGCkV>; Wed, 6 Feb 2002 21:40:21 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:7565 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S291084AbSBGCkJ>; Wed, 6 Feb 2002 21:40:09 -0500
Date: Thu, 7 Feb 2002 03:39:59 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: [PATCH] Fix mount hash table
Message-ID: <20020207033959.A2468@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On my 512MB machine with 6 mount points the mount hash table uses 64K.
This patch brings it to a more reasonable size by limiting it to one
page. 

Patch against 2.5.4pre1. Please apply. 

-Andi



--- linux-2.5.4pre1-work/fs/namespace.c-o	Wed Jan 30 22:38:09 2002
+++ linux-2.5.4pre1-work/fs/namespace.c	Thu Feb  7 03:35:53 2002
@@ -1048,15 +1048,9 @@
 	if (!mnt_cache)
 		panic("Cannot create vfsmount cache");
 
-	mempages >>= (16 - PAGE_SHIFT);
-	mempages *= sizeof(struct list_head);
-	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
-		;
-
-	do {
-		mount_hashtable = (struct list_head *)
-			__get_free_pages(GFP_ATOMIC, order);
-	} while (mount_hashtable == NULL && --order >= 0);
+	order = 0; 
+	mount_hashtable = (struct list_head *)
+		__get_free_pages(GFP_ATOMIC, order);
 
 	if (!mount_hashtable)
 		panic("Failed to allocate mount hash table\n");
