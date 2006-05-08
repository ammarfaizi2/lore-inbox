Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWEHBSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWEHBSL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 21:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWEHBSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 21:18:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:49513 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932242AbWEHBSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 21:18:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:from;
        b=XMlo42COcs/MSWQT8eOZNEbAQUb4qAC4CWQBZV4njSkkywhLqHTqsOaRbcete19zVfswSqkjeb9hALil66i4sTe0yIGiQyBK7TjK5Y/B58tw71NUsP4rmmQ80hBhTgs/m81mroxaSsj/HjWIAb3dlwKcKJ6K2ytwmIJvu/ICNDQ=
Date: Sun, 7 May 2006 18:17:02 -0700 (PDT)
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, linux-mm@kvack.org
Subject: [PATCH] fix can_share_swap_page() when !CONFIG_SWAP
Message-ID: <Pine.LNX.4.64.0605071525550.2515@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Hua Zhong <hzhong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

can_share_swap_page() is used to check if the page has the last reference. This avoids allocating a new page for COW if it's the last page.

However, if CONFIG_SWAP is not set, can_share_swap_page() is defined as 0, thus always causes a copy for the last COW page. The below simple patch fixes it.

I'm not sure if it's the best fix. Maybe we should rename can_share_swap_page() and move it out of swapfile.c. Comments?

Signed-off-by: Hua Zhong <hzhong@gmail.com>

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5b1fdf1..f03c247 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -296,7 +296,7 @@ #define swap_free(swp)				/*NOTHING*/
 #define read_swap_cache_async(swp,vma,addr)	NULL
 #define lookup_swap_cache(swp)			NULL
 #define valid_swaphandles(swp, off)		0
-#define can_share_swap_page(p)			0
+#define can_share_swap_page(p)			(page_mapcount(p) == 1)
 #define move_to_swap_cache(p, swp)		1
 #define move_from_swap_cache(p, i, m)		1
 #define __delete_from_swap_cache(p)		/*NOTHING*/
