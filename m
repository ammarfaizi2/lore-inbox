Return-Path: <linux-kernel-owner+w=401wt.eu-S1751870AbXAVPAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbXAVPAr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbXAVPAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:00:47 -0500
Received: from mx2-2.mail.ru ([194.67.23.122]:34495 "EHLO mx2.mail.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751870AbXAVPAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:00:46 -0500
Date: Mon, 22 Jan 2007 18:05:43 +0300
From: Evgeniy Dushistov <dushistov@mail.ru>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] ufs: truncate negative to unsigned fix
Message-ID: <20070122150543.GA11031@rain>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


During ufs_trunc_direct which is subroutine of ufs::truncate,
we try the first of all free parts of block and then whole blocks.
But we calculate size of block's part to free in the wrong way.

This may cause bad update of used blocks and fragments statistic,
and you can got report that you have free 32T on 1Gb partition.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.20-rc5/fs/ufs/truncate.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/ufs/truncate.c
+++ linux-2.6.20-rc5/fs/ufs/truncate.c
@@ -109,10 +109,10 @@ static int ufs_trunc_direct (struct inod
 	tmp = fs32_to_cpu(sb, *p);
 	if (!tmp )
 		ufs_panic (sb, "ufs_trunc_direct", "internal error");
+	frag2 -= frag1;
 	frag1 = ufs_fragnum (frag1);
-	frag2 = ufs_fragnum (frag2);
 
-	ufs_free_fragments (inode, tmp + frag1, frag2 - frag1);
+	ufs_free_fragments(inode, tmp + frag1, frag2);
 	mark_inode_dirty(inode);
 	frag_to_free = tmp + frag1;
 
-- 
/Evgeniy

