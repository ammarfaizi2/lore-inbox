Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263945AbVBDQju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbVBDQju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265597AbVBDQju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:39:50 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:58172 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264611AbVBDQjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:39:37 -0500
Date: Fri, 4 Feb 2005 16:39:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Mr. Berkley Shands" <bshands@exegy.com>
cc: Andrew Morton <akpm@osdl.org>, William Irwin <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 Kernel BUG at hugetlbpage:212 (x86_64 and i386)
In-Reply-To: <42023352.9040309@dssimail.com>
Message-ID: <Pine.LNX.4.61.0502041634090.10535@goblin.wat.veritas.com>
References: <42023352.9040309@dssimail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Mr. Berkley Shands wrote:
> Reproducible BUG on 3GB hugetlbfs filesystem for opterons and xeons with
> either
> FC3 or RedHat ES3.0 and GCC 3.4.2. Details and code snippets in attachment.
> Executables to reproduce BUG are available on request.

Patch below (against 2.6.11-rc3, applies at offset to 2.6.10) fixes
the unmap_hugepage_range BUGs I could generate: does it fix yours?

Hugh

The hugetlb_page test in do_munmap is too permissive.  It checks start
vma, but forgets that end vma might be different and huge though start
is not: so hits unmap_hugepage_range BUG if misaligned end was given.

And it's too restrictive: munmap has always succeeded on unmapped areas
within its range, why should it behave differently near a hugepage vma?

And the additional checks in is_aligned_hugepage_range are irrelevant
here, when the hugepage vma already exists.  But the function is still
required (on some arches), as the default for prepare_hugepage_range -
leave renaming cleanup to another occasion.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.11-rc3/mm/mmap.c	2005-02-03 09:06:16.000000000 +0000
+++ linux/mm/mmap.c	2005-02-04 15:40:25.000000000 +0000
@@ -1808,13 +1808,6 @@ int do_munmap(struct mm_struct *mm, unsi
 		return 0;
 	/* we have  start < mpnt->vm_end  */
 
-	if (is_vm_hugetlb_page(mpnt)) {
-		int ret = is_aligned_hugepage_range(start, len);
-
-		if (ret)
-			return ret;
-	}
-
 	/* if it doesn't overlap, we have nothing.. */
 	end = start + len;
 	if (mpnt->vm_start >= end)
@@ -1828,6 +1821,8 @@ int do_munmap(struct mm_struct *mm, unsi
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
 	if (start > mpnt->vm_start) {
+		if (is_vm_hugetlb_page(mpnt) && (start & ~HPAGE_MASK))
+			return -EINVAL;
 		if (split_vma(mm, mpnt, start, 0))
 			return -ENOMEM;
 		prev = mpnt;
@@ -1836,6 +1831,8 @@ int do_munmap(struct mm_struct *mm, unsi
 	/* Does it split the last one? */
 	last = find_vma(mm, end);
 	if (last && end > last->vm_start) {
+		if (is_vm_hugetlb_page(last) && (end & ~HPAGE_MASK))
+			return -EINVAL;
 		if (split_vma(mm, last, end, 1))
 			return -ENOMEM;
 	}
