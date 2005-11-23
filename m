Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbVKWP2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVKWP2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVKWP2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:28:48 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:46302 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751000AbVKWP2s (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 23 Nov 2005 10:28:48 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17284.35254.577998.442784@gargle.gargle.HOWL>
Date: Wed, 23 Nov 2005 18:24:38 +0300
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Cc: Andrew Morton <AKPM@Osdl.ORG>
Subject: [PATCH]: find_lock_page(): call __lock_page() directly.
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

as find_lock_page() already checks with TestSetPageLocked() that page is
locked, there is no need to call lock_page() that will try-lock page
again (chances of page being unlocked in between are small). Call
__lock_page() directly, this saves one atomic operation.

Also, mark truncate-while-slept path as unlikely while we are here.

Andrew, please apply.

Nikita.

Signed-off-by: Nikita Danilov <danilov@gmail.com>


 mm/filemap.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff -puN mm/filemap.c~find_lock_page-use-__lock_page mm/filemap.c
--- git-linux/mm/filemap.c~find_lock_page-use-__lock_page	2005-11-20 16:33:58.000000000 +0300
+++ git-linux-nikita/mm/filemap.c	2005-11-20 16:41:46.000000000 +0300
@@ -555,11 +555,12 @@ repeat:
 		page_cache_get(page);
 		if (TestSetPageLocked(page)) {
 			read_unlock_irq(&mapping->tree_lock);
-			lock_page(page);
+			__lock_page(page);
 			read_lock_irq(&mapping->tree_lock);
 
 			/* Has the page been truncated while we slept? */
-			if (page->mapping != mapping || page->index != offset) {
+			if (unlikely(page->mapping != mapping ||
+				     page->index != offset)) {
 				unlock_page(page);
 				page_cache_release(page);
 				goto repeat;
_
