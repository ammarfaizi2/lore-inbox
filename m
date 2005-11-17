Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVKQTah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVKQTah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVKQTah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:30:37 -0500
Received: from gold.veritas.com ([143.127.12.110]:18231 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964798AbVKQTag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:30:36 -0500
Date: Thu, 17 Nov 2005 19:29:17 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] unpaged: get_user_pages VM_RESERVED
In-Reply-To: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511171928320.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:30:35.0133 (UTC) FILETIME=[61B94AD0:01C5EBAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PageReserved removal in 2.6.15-rc1 prohibited get_user_pages on the
areas flagged VM_RESERVED in place of PageReserved.  That is correct in
theory - we ought not to interfere with struct pages in such a reserved
area; but in practice it broke BTTV for one.

So revert to prohibiting only on VM_IO: if someone gets into trouble
with get_user_pages on VM_RESERVED, it'll just be a "don't do that".

You can argue that videobuf_mmap_mapper shouldn't set VM_RESERVED in the
first place, but now's not the time for breaking drivers without notice.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.15-rc1-git5/mm/memory.c	2005-11-17 13:53:21.000000000 +0000
+++ unpaged01/mm/memory.c	2005-11-17 15:10:08.000000000 +0000
@@ -968,7 +968,7 @@ int get_user_pages(struct task_struct *t
 			continue;
 		}
 
-		if (!vma || (vma->vm_flags & (VM_IO | VM_RESERVED))
+		if (!vma || (vma->vm_flags & VM_IO)
 				|| !(vm_flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
