Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWBLTtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWBLTtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWBLTtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:49:32 -0500
Received: from gold.veritas.com ([143.127.12.110]:54354 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751421AbWBLTtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:49:32 -0500
Date: Sun, 12 Feb 2006 19:50:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: David Gibson <david@gibson.dropbear.id.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] compound page: no access_process_vm check
In-Reply-To: <Pine.LNX.4.61.0602121943150.15774@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0602121947440.15774@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602121943150.15774@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Feb 2006 19:49:31.0786 (UTC) FILETIME=[712906A0:01C6300D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PageCompound check before access_process_vm's set_page_dirty_lock is
no longer necessary, so remove it.  But leave the PageCompound checks in
bio_set_pages_dirty, dio_bio_complete and nfs_free_user_pages: at least
some of those were introduced as a little optimization on hugetlb pages.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 kernel/ptrace.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- 2.6.16-rc2-git11/kernel/ptrace.c	2006-02-03 09:32:51.000000000 +0000
+++ 2.6.16-rc2-git11+/kernel/ptrace.c	2006-02-10 20:07:05.000000000 +0000
@@ -242,8 +242,7 @@ int access_process_vm(struct task_struct
 		if (write) {
 			copy_to_user_page(vma, page, addr,
 					  maddr + offset, buf, bytes);
-			if (!PageCompound(page))
-				set_page_dirty_lock(page);
+			set_page_dirty_lock(page);
 		} else {
 			copy_from_user_page(vma, page, addr,
 					    buf, maddr + offset, bytes);
