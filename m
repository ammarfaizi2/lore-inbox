Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030747AbWKORjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030747AbWKORjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030763AbWKORjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:39:20 -0500
Received: from mail.parknet.jp ([210.171.160.80]:25348 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1030761AbWKORjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:39:19 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix strange size check in __get_vm_area_node()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 16 Nov 2006 02:39:15 +0900
Message-ID: <87k61wa9to.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, __get_vm_area_node() was changed like following

 	if (unlikely(!area))
 		return NULL;
 
-	if (unlikely(!size)) {
-		kfree (area);
+	if (unlikely(!size))
 		return NULL;
-	}

It is leaking `area', also original code seems strange already.
Probably, we wanted to do this patch.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 mm/vmalloc.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff -puN mm/vmalloc.c~vmalloc-leak-fix mm/vmalloc.c
--- linux-2.6/mm/vmalloc.c~vmalloc-leak-fix	2006-11-16 00:41:49.000000000 +0900
+++ linux-2.6-hirofumi/mm/vmalloc.c	2006-11-16 00:41:49.000000000 +0900
@@ -181,14 +181,13 @@ static struct vm_struct *__get_vm_area_n
 	}
 	addr = ALIGN(start, align);
 	size = PAGE_ALIGN(size);
+	if (unlikely(!size))
+		return NULL;
 
 	area = kmalloc_node(sizeof(*area), gfp_mask & GFP_LEVEL_MASK, node);
 	if (unlikely(!area))
 		return NULL;
 
-	if (unlikely(!size))
-		return NULL;
-
 	/*
 	 * We always allocate a guard page.
 	 */
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
