Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTF0P7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTF0P7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 11:59:19 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:38685 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S264456AbTF0P7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 11:59:18 -0400
Date: Fri, 27 Jun 2003 11:13:19 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.73-mm1] Make sure truncate fix has no race
Message-ID: <69440000.1056730399@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1873729384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1873729384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Paul McKenney pointed out that reading the truncate sequence number in
do_no_page might not be entirely safe if the ->nopage callout takes no
locks.  The simple solution is to move the read before the unlock of
page_table_lock.  Here's a patch that does it.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1873729384==========
Content-Type: text/plain; charset=us-ascii; name="trunc-2.5.73-mm1-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="trunc-2.5.73-mm1-1.diff"; size=897

--- 2.5.73-mm1/mm/memory.c	2003-06-27 10:40:48.000000000 -0500
+++ 2.5.73-mm1-trunc/mm/memory.c	2003-06-27 10:47:10.000000000 -0500
@@ -1402,11 +1402,11 @@ do_no_page(struct mm_struct *mm, struct 
 		return do_anonymous_page(mm, vma, page_table,
 					pmd, write_access, address);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
 
 	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
-retry:
 	sequence = atomic_read(&mapping->truncate_count);
+	spin_unlock(&mm->page_table_lock);
+retry:
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
 
 	/* no page was available -- either SIGBUS or OOM */
@@ -1441,6 +1441,7 @@ retry:
 	 * retry getting the page.
 	 */
 	if (unlikely(sequence != atomic_read(&mapping->truncate_count))) {
+		sequence = atomic_read(&mapping->truncate_count);
 		spin_unlock(&mm->page_table_lock);
 		page_cache_release(new_page);
 		goto retry;

--==========1873729384==========--

