Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbUKOVdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUKOVdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbUKOUpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:45:50 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:57624 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261697AbUKOUnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:43:41 -0500
Date: Mon, 15 Nov 2004 20:43:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs free_inodes leak
Message-ID: <Pine.LNX.4.44.0411152041180.4131-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When new_inode failed, shmem_get_inode forgot to restore free_inodes.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.10-rc2/mm/shmem.c	2004-11-15 16:21:24.000000000 +0000
+++ linux/mm/shmem.c	2004-11-15 19:13:10.535493992 +0000
@@ -1314,6 +1314,10 @@ shmem_get_inode(struct super_block *sb, 
 		case S_IFLNK:
 			break;
 		}
+	} else if (sbinfo) {
+		spin_lock(&sbinfo->stat_lock);
+		sbinfo->free_inodes++;
+		spin_unlock(&sbinfo->stat_lock);
 	}
 	return inode;
 }

