Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932817AbWF1O6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932817AbWF1O6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932822AbWF1O6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:58:40 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:65434 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S932817AbWF1O6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:58:38 -0400
Subject: [RFC][PATCH] mm: fixup do_wp_page()
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231933060.7524@blonde.wat.veritas.com>
References: <20060619175243.24655.76005.sendpatchset@lappy>
	 <20060619175253.24655.96323.sendpatchset@lappy>
	 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
	 <1151019590.15744.144.camel@lappy>
	 <Pine.LNX.4.64.0606231933060.7524@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 16:58:31 +0200
Message-Id: <1151506711.5383.24.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 20:06 +0100, Hugh Dickins wrote:

> But grrr, sigh, damn, argh - I now realize it's right to the first
> order (normal case) and to the second order (ptrace poke), but not
> to the third order (ptrace poke anon page here to be COWed -
> perhaps can't occur without intervening mprotects).
> 
> That's not an issue for you at all (there are other places which
> are inconsistent on whether such pages are private or shared e.g.
> copy_one_pte does not wrprotect them), but could be a problem for
> David's page_mkwrite - there's a danger of passing it an anonymous
> page, which (depending on what the ->page_mkwrite actually does)
> could go seriously wrong.
> 
> I guess it ought to be restructured
> 	if (PageAnon(old_page)) {
> 		...
> 	} else if (shared writable vma) {
> 		...
> 	}
> and a patch to do that should precede your dirty page patches
> (and the only change your dirty page patches need add here on top
> of that would be the dirty_page = old_page, get_page(dirty_page)).
> 
> Oh, it looks like Linus is keen to go ahead with your patches in
> 2.6.18, so in that case it'll be easier to go ahead with the patch
> as you have it, and fix up this order-3 issue on top afterwards -
> it's not something testers are going to be hitting every day,
> especially without any ->page_mkwrite implementations.

How about something like this? This should make all anonymous write
faults do as before the page_mkwrite patch.

As for copy_one_pte(), I'm not sure what you meant, shared writable
anonymous pages need not be write protected as far as I can see.
If you meant to say, anonymous or file-backed, then copy_one_pte() still
does the right thing. If the source is untouched/clean it will still be
wrprotected and this state will be copied, if its dirtied and made
writeable we don't need the notification anymore anyway and hence the
regular copy is still correct.

Peter

---
 mm/memory.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

Index: linux-2.6-dirty/mm/memory.c
===================================================================
--- linux-2.6-dirty.orig/mm/memory.c	2006-06-28 13:16:15.000000000 +0200
+++ linux-2.6-dirty/mm/memory.c	2006-06-28 16:18:51.000000000 +0200
@@ -1466,11 +1466,21 @@ static int do_wp_page(struct mm_struct *
 		goto gotten;
 
 	/*
-	 * Only catch write-faults on shared writable pages, read-only
-	 * shared pages can get COWed by get_user_pages(.write=1, .force=1).
+	 * Take out anonymous pages first, anonymous shared vmas are
+	 * not accountable.
 	 */
-	if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
+	if (PageAnon(old_page)) {
+		if (!TestSetPageLocked(old_page)) {
+			reuse = can_share_swap_page(old_page);
+			unlock(old_page);
+		}
+	} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
 					(VM_WRITE|VM_SHARED))) {
+		/*
+		 * Only catch write-faults on shared writable pages,
+		 * read-only shared pages can get COWed by
+		 * get_user_pages(.write=1, .force=1).
+		 */
 		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
 			/*
 			 * Notify the address space that the page is about to
@@ -1502,9 +1512,6 @@ static int do_wp_page(struct mm_struct *
 		dirty_page = old_page;
 		get_page(dirty_page);
 		reuse = 1;
-	} else if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
-		reuse = can_share_swap_page(old_page);
-		unlock_page(old_page);
 	}
 
 	if (reuse) {


