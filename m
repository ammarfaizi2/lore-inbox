Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVBCVyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVBCVyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVBCVyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:54:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:2726 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263182AbVBCVu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:50:28 -0500
Subject: [PATCH] make page_owner handle non-contiguous page ranges
To: akpm@osdl.org
Cc: alexn@dsv.su.se, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 03 Feb 2005 13:50:19 -0800
Message-Id: <E1Cwork-0006No-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While super-nifty, the new page_owner code assumes a contiguous
mem_map, which we don't all have.  This patch changes the
iterator in the read_page_owner() to be a pfn instead of a
'struct page'.  This makes it easy to jump around to different
non-contiuous 'struct pages' as with the CONFIG_DISCONTIG code.

It also uses pfn_valid() instead of max_pfn, which seems to be
a bit more flexible, and handles holes where there are no 
'struct pages' on the DISCONTIG systems.

BTW, I have no idea why that loop ended with a continue;

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/fs/proc/proc_misc.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff -puN fs/proc/proc_misc.c~A9-page_owner_no_contig fs/proc/proc_misc.c
--- memhotplug/fs/proc/proc_misc.c~A9-page_owner_no_contig	2005-02-03 13:26:47.000000000 -0800
+++ memhotplug-dave/fs/proc/proc_misc.c	2005-02-03 13:28:13.000000000 -0800
@@ -546,8 +546,9 @@ static struct file_operations proc_sysrq
 static ssize_t
 read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
-	struct page *start = pfn_to_page(min_low_pfn);
-	static struct page *page;
+	unsigned long start_pfn = min_low_pfn;
+	static unsigned long pfn;
+	struct page *page;
 	char *kbuf, *modname;
 	const char *symname;
 	int ret = 0, next_idx = 1;
@@ -555,15 +556,18 @@ read_page_owner(struct file *file, char 
 	unsigned long offset = 0, symsize;
 	int i;
 
-	page = start + *ppos;
-	for (; page < pfn_to_page(max_pfn); page++) {
+	pfn = start_pfn + *ppos;
+	page = pfn_to_page(pfn);
+	for (; pfn < max_pfn; pfn++) {
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
 		if (page->order >= 0)
 			break;
 		next_idx++;
-		continue;
 	}
 
-	if (page >= pfn_to_page(max_pfn))
+	if (!pfn_valid(pfn))
 		return 0;
 
 	*ppos += next_idx;
_
