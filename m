Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVGLOUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVGLOUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVGLOUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:20:50 -0400
Received: from gold.veritas.com ([143.127.12.110]:56094 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261417AbVGLOUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:20:44 -0400
Date: Tue, 12 Jul 2005 15:22:11 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Mark Fasheh <mark.fasheh@oracle.com>, linux-kernel@vger.kernel.org
Subject: [PATCH -rc2-mm2] update tmpfs for new delete_inode behavior
Message-ID: <Pine.LNX.4.61.0507121508520.6933@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Jul 2005 14:20:43.0902 (UTC) FILETIME=[E39C91E0:01C586EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LTP on tmpfs hits kernel BUG at mm/shmem.c:680!  shmem_delete_inode needs
to truncate_inode_pages for itself now.  It's not immediately obvious since
many cases get covered by shmem_truncate's followup truncate_inode_pages:
maybe with thought we can just call it once, but right now fix the BUG.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.13-rc2-mm2/mm/shmem.c	2005-07-06 11:23:52.000000000 +0100
+++ linux/mm/shmem.c	2005-07-12 13:58:26.000000000 +0100
@@ -668,6 +668,7 @@ static void shmem_delete_inode(struct in
 	struct shmem_inode_info *info = SHMEM_I(inode);
 
 	if (inode->i_op->truncate == shmem_truncate) {
+		truncate_inode_pages(inode->i_mapping, 0);
 		shmem_unacct_size(info->flags, inode->i_size);
 		inode->i_size = 0;
 		shmem_truncate(inode);
