Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUEHWHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUEHWHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbUEHWGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:06:03 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:53708 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264195AbUEHWEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:04:20 -0400
Date: Sat, 8 May 2004 23:04:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 30 fix bad mapcount
In-Reply-To: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405082303070.26569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <andrea@suse.de>

page_alloc.c's bad_page routine should reset a bad mapcount; and it's
more revealing to show the bad mapcount than just the boolean mapped.

 page_alloc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- rmap29/mm/page_alloc.c	2004-05-05 13:29:08.000000000 +0100
+++ rmap30/mm/page_alloc.c	2004-05-08 20:55:38.593511352 +0100
@@ -73,9 +73,9 @@ static void bad_page(const char *functio
 {
 	printk(KERN_EMERG "Bad page state at %s (in process '%s', page %p)\n",
 		function, current->comm, page);
-	printk(KERN_EMERG "flags:0x%08lx mapping:%p mapped:%d count:%d\n",
+	printk(KERN_EMERG "flags:0x%08lx mapping:%p mapcount:%d count:%d\n",
 		(unsigned long)page->flags, page->mapping,
-		page_mapped(page), page_count(page));
+		(int)page->mapcount, page_count(page));
 	printk(KERN_EMERG "Backtrace:\n");
 	dump_stack();
 	printk(KERN_EMERG "Trying to fix it up, but a reboot is needed\n");
@@ -90,6 +90,7 @@ static void bad_page(const char *functio
 			1 << PG_writeback);
 	set_page_count(page, 0);
 	page->mapping = NULL;
+	page->mapcount = 0;
 }
 
 #ifndef CONFIG_HUGETLB_PAGE

