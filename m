Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTEOISc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 04:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTEOISc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 04:18:32 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:24286 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263749AbTEOISa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 04:18:30 -0400
Date: Thu, 15 May 2003 01:32:45 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: dmccr@us.ibm.com, mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-Id: <20030515013245.58bcaf8f.akpm@digeo.com>
In-Reply-To: <20030515004915.GR1429@dualathlon.random>
References: <154080000.1052858685@baldur.austin.ibm.com>
	<20030513181018.4cbff906.akpm@digeo.com>
	<18240000.1052924530@baldur.austin.ibm.com>
	<20030514103421.197f177a.akpm@digeo.com>
	<82240000.1052934152@baldur.austin.ibm.com>
	<20030515004915.GR1429@dualathlon.random>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 08:31:15.0346 (UTC) FILETIME=[59741720:01C31ABC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
>  what do you think of this untested fix?
> 
>  I wonder if vm_file is valid for all nopage operations, I think it
>  should, and the i_mapping as well should always exist, but in the worst
>  case it shouldn't be too difficult to take care of special cases
>  (just checking if the new_page is reserved and if the vma is VM_SPECIAL)
>  would eliminate most issues, shall there be any.

yes, I think this is a good solution.

In 2.5 (at least) we can push all the sequence number work into
filemap_nopage(), and add a new vm_ops->revalidate() thing, so do_no_page()
doesn't need to know about inodes and such.

So the mm/memory.c part would look something like:

diff -puN mm/memory.c~a mm/memory.c
--- 25/mm/memory.c~a	2003-05-15 01:29:21.000000000 -0700
+++ 25-akpm/mm/memory.c	2003-05-15 01:32:02.000000000 -0700
@@ -1399,7 +1399,7 @@ do_no_page(struct mm_struct *mm, struct 
 					pmd, write_access, address);
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
-
+retry:
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
 
 	/* no page was available -- either SIGBUS or OOM */
@@ -1408,9 +1408,11 @@ do_no_page(struct mm_struct *mm, struct 
 	if (new_page == NOPAGE_OOM)
 		return VM_FAULT_OOM;
 
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto oom;
+	if (!pte_chain) {
+		pte_chain = pte_chain_alloc(GFP_KERNEL);
+		if (!pte_chain)
+			goto oom;
+	}
 
 	/*
 	 * Should we do an early C-O-W break?
@@ -1428,6 +1430,17 @@ do_no_page(struct mm_struct *mm, struct 
 	}
 
 	spin_lock(&mm->page_table_lock);
+
+	/*
+	 * comment goes here
+	 */
+	if (vma->vm_ops && vma->vm_ops->revalidate &&
+			vma->vm_ops->revalidate(vma, address) {
+		spin_unlock(&mm->page_table_lock);
+		put_page(new_page);
+		goto retry;
+	}
+
 	page_table = pte_offset_map(pmd, address);
 
 	/*

_

