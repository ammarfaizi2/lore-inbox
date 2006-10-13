Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751884AbWJMUef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbWJMUef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWJMUef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:34:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:24238 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751884AbWJMUef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:34:35 -0400
Date: Fri, 13 Oct 2006 15:33:42 -0500
From: Robin Holt <holt@sgi.com>
To: Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] get_user_pages(..., write==1, ...) may return with readable pte.
Message-ID: <20061013203342.GA21610@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the case in get_user_pages() when a call to __handle_mm_fault()
inserts a writable pte, and a process doing dup_mmap converts it
to readable before get_user_pages() does the subsequent request to
follow_page().


Signed-off-by: Robin Holt <holt@sgi.com>

---

Hugh, Nick, and Linus,

I think I have tripped over another flavor of a get_user_pages bug
we addressed back in 2005.  I do not have a test case to prove it is
the issue I am trying to address, but I have done as thorough a code
walk-through as I can.

Assume a pte is currently empty.  A first pthread is in the kernel on
a call path which is leading to get_user_pages.  A second pthread is
in the process of doing a fork.  The process doing get_user_pages()
gets into __handle_mm_fault() and grabs ptl just before the process
doing a fork attempts to grab the ptl to convert the pages to COW.
__handle_mm_fault() will insert the writable pte and unlock ptl then
return with VM_FAULT_WRITE set.  The process doing a fork then gets
the lock and starts converting the pte to RO/COW.  The get_user_pages()
process then clears FOLL_WRITE from foll_flags and calls follow_page()
without write, adds to the map count for the page, but does not have a
writable mapping.


Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2006-10-06 12:06:25.000000000 -0500
+++ linux-2.6/mm/memory.c	2006-10-13 15:06:38.286230638 -0500
@@ -1063,15 +1063,7 @@ int get_user_pages(struct task_struct *t
 				int ret;
 				ret = __handle_mm_fault(mm, vma, start,
 						foll_flags & FOLL_WRITE);
-				/*
-				 * The VM_FAULT_WRITE bit tells us that do_wp_page has
-				 * broken COW when necessary, even if maybe_mkwrite
-				 * decided not to set pte_write. We can thus safely do
-				 * subsequent page lookups as if they were reads.
-				 */
-				if (ret & VM_FAULT_WRITE)
-					foll_flags &= ~FOLL_WRITE;
-				
+
 				switch (ret & ~VM_FAULT_WRITE) {
 				case VM_FAULT_MINOR:
 					tsk->min_flt++;
