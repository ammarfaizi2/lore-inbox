Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVDLStH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVDLStH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVDLSrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:47:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:12490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262237AbVDLKc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:56 -0400
Message-Id: <200504121032.j3CAWj6x005668@shell0.pdx.osdl.net>
Subject: [patch 132/198] quota: possible bug in quota format v2 support
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, niu@clusterfs.com,
       jack@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Niu YaWei <niu@clusterfs.com>

Don't put root block of quota tree to the free list (when quota file is
completely empty).  That should not actually happen anyway (somebody should
get accounted for the filesystem root and so quota file should never be
empty) but better prevent it here than solve magical quota file
corruption.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/quota_v2.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN fs/quota_v2.c~quota-possible-bug-in-quota-format-v2-support fs/quota_v2.c
--- 25/fs/quota_v2.c~quota-possible-bug-in-quota-format-v2-support	2005-04-12 03:21:35.447748024 -0700
+++ 25-akpm/fs/quota_v2.c	2005-04-12 03:21:35.450747568 -0700
@@ -503,7 +503,8 @@ static int remove_tree(struct dquot *dqu
 		int i;
 		ref[GETIDINDEX(dquot->dq_id, depth)] = cpu_to_le32(0);
 		for (i = 0; i < V2_DQBLKSIZE && !buf[i]; i++);	/* Block got empty? */
-		if (i == V2_DQBLKSIZE) {
+		/* Don't put the root block into the free block list */
+		if (i == V2_DQBLKSIZE && *blk != V2_DQTREEOFF) {
 			put_free_dqblk(sb, type, buf, *blk);
 			*blk = 0;
 		}
_
