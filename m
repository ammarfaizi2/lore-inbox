Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWAKWY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWAKWY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWAKWY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:24:26 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51927 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932298AbWAKWYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:24:25 -0500
Subject: [PATCH 2/2] hugetlb: synchronize alloc with page cache insert
From: Adam Litke <agl@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1137016960.9672.5.camel@localhost.localdomain>
References: <1136920951.23288.5.camel@localhost.localdomain>
	 <1137016960.9672.5.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Wed, 11 Jan 2006 16:24:23 -0600
Message-Id: <1137018263.9672.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 16:02 -0600, Adam Litke wrote:
> here).  The patch doesn't completely close the race (there is a much
> smaller window without the zeroing though).  The next patch should close
> the race window completely.

My only concern is if I am using the correct lock for the job here.

 hugetlb.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -445,6 +445,7 @@ int hugetlb_no_page(struct mm_struct *mm
 	struct page *page;
 	struct address_space *mapping;
 	pte_t new_pte;
+	int shared = vma->vm_flags & VM_SHARED;
 
 	mapping = vma->vm_file->f_mapping;
 	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
@@ -454,26 +455,31 @@ int hugetlb_no_page(struct mm_struct *mm
 	 * Use page lock to guard against racing truncation
 	 * before we get page_table_lock.
 	 */
-retry:
 	page = find_lock_page(mapping, idx);
 	if (!page) {
 		if (hugetlb_get_quota(mapping))
 			goto out;
+
+		if (shared)
+			spin_lock(&mapping->host->i_lock);
+		
 		page = alloc_unzeroed_huge_page(vma, address);
 		if (!page) {
 			hugetlb_put_quota(mapping);
+			if (shared)
+				spin_unlock(&mapping->host->i_lock);
 			goto out;
 		}
 
-		if (vma->vm_flags & VM_SHARED) {
+		if (shared) {
 			int err;
 
 			err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
+			spin_unlock(&mapping->host->i_lock);
 			if (err) {
 				put_page(page);
 				hugetlb_put_quota(mapping);
-				if (err == -EEXIST)
-					goto retry;
+				BUG_ON(-EEXIST);
 				goto out;
 			}
 		} else


-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

