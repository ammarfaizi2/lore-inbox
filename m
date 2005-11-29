Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVK2Qxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVK2Qxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVK2Qxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:53:46 -0500
Received: from gold.veritas.com ([143.127.12.110]:7081 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932173AbVK2Qxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:53:45 -0500
Date: Tue, 29 Nov 2005 16:53:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] pfnmap: cow_user_page needs mask
In-Reply-To: <Pine.LNX.4.61.0511291650400.5527@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511291653160.5527@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511291650400.5527@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 29 Nov 2005 16:53:45.0031 (UTC) FILETIME=[75D2AD70:01C5F505]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fault address to cow_user_page is not usually page aligned, so needs
to be masked in the unusual case when that copies via the user address.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- 2.6.15-rc3/mm/memory.c	2005-11-29 08:40:07.000000000 +0000
+++ linux/mm/memory.c	2005-11-29 15:59:34.000000000 +0000
@@ -1300,7 +1313,8 @@ static inline void cow_user_page(struct 
 	 */
 	if (unlikely(!src)) {
 		void *kaddr = kmap_atomic(dst, KM_USER0);
-		unsigned long left = __copy_from_user_inatomic(kaddr, (void __user *)va, PAGE_SIZE);
+		unsigned long left = __copy_from_user_inatomic(kaddr,
+			(void __user *)(va & PAGE_MASK), PAGE_SIZE);
 		if (left)
 			memset(kaddr, 0, PAGE_SIZE);
 		kunmap_atomic(kaddr, KM_USER0);
