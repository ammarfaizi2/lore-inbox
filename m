Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUC3Wv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUC3Wur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:50:47 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:48203 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261597AbUC3WsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:48:23 -0500
Date: Tue, 30 Mar 2004 23:48:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] mremap check map_count
In-Reply-To: <Pine.LNX.4.44.0403302340220.24019-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403302347131.24019-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mremap's move_vma should think ahead to lessen the chance of failure
during its rewind on failure: running out of memory always possible,
but it's silly for it to embark when it's near the map_count limit.

Note: -mm tree needs sysctl_max_map_count in place of MAX_MAP_COUNT.

--- mremap4/mm/mremap.c	2004-03-30 21:25:00.136666640 +0100
+++ mremap5/mm/mremap.c	2004-03-30 21:25:11.549931560 +0100
@@ -176,6 +176,13 @@ static unsigned long move_vma(struct vm_
 	unsigned long excess = 0;
 	int split = 0;
 
+	/*
+	 * We'd prefer to avoid failure later on in do_munmap:
+	 * which may split one vma into three before unmapping.
+	 */
+	if (mm->map_count >= MAX_MAP_COUNT - 3)
+		return -ENOMEM;
+
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(vma, new_addr, new_len, new_pgoff);
 	if (!new_vma)

