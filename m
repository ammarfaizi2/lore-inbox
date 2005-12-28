Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVL1BZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVL1BZy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 20:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVL1BZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 20:25:54 -0500
Received: from kanga.kvack.org ([66.96.29.28]:65432 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932440AbVL1BZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 20:25:53 -0500
Date: Tue, 27 Dec 2005 20:22:14 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reduce size of bio mempools
Message-ID: <20051228012214.GB8195@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The biovec default mempool limit of 256 entries results in over 3MB of RAM 
being permanently pinned, even on systems with only 128MB of RAM.  Since 
mempool tries to allocate from the system pool first, it makes sense to 
reduce the size of the mempool fallbacks to a more reasonable limit of 1-5 
entries -- enough for the system to be able to make progress even under 
load.

Signed-off-by: Benjamin LaHaise <bcrl@kvack.org>
diff --git a/fs/bio.c b/fs/bio.c
index 460554b..4944009 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -1198,11 +1198,11 @@ static int __init init_bio(void)
 		scale = 4;
 
 	/*
-	 * scale number of entries
+	 * Limit number of entries reserved -- mempools are only used when
+	 * the system is completely unable to allocate memory, so we only
+	 * need enough to make progress.
 	 */
-	bvec_pool_entries = megabytes * 2;
-	if (bvec_pool_entries > 256)
-		bvec_pool_entries = 256;
+	bvec_pool_entries = 1 + scale;
 
 	fs_bio_set = bioset_create(BIO_POOL_SIZE, bvec_pool_entries, scale);
 	if (!fs_bio_set)
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
