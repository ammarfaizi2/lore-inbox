Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbVHXL6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVHXL6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 07:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVHXL6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 07:58:00 -0400
Received: from silver.veritas.com ([143.127.12.111]:20571 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750900AbVHXL6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 07:58:00 -0400
Date: Wed, 24 Aug 2005 13:00:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mremap() use is racy
In-Reply-To: <Pine.LNX.4.58.0508231705470.3317@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0508241242300.3882@goblin.wat.veritas.com>
References: <430B7EAE.6020001@redhat.com> <Pine.LNX.4.61.0508232135480.12189@goblin.wat.veritas.com>
 <430B8D96.5080002@redhat.com> <Pine.LNX.4.58.0508231425330.3317@g5.osdl.org>
 <430B9E45.3080107@redhat.com> <Pine.LNX.4.58.0508231705470.3317@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Aug 2005 11:57:59.0831 (UTC) FILETIME=[12CA4A70:01C5A8A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2005, Linus Torvalds wrote:
> On Tue, 23 Aug 2005, Ulrich Drepper wrote:
> > Linus Torvalds wrote:
> > > 
> > > Especially if you use MAP_SHARED, you don't even need to mprotect 
> > > anything: you'll get a nice SIGBUS if you ever try to access past
> > > the last page that maps the file.

MAP_PRIVATE also - even if you earlier wrote private data there before
the file got truncated down.

> > If you guarantee this (and test for this) it's fine with me. 

Since you're not guaranteeing it, shall I?

The Open Posix Testsuite tests for it: though I haven't run that up,
and its conformance/interfaces/mmap/coverage.txt notes it failed with
glibc-2.3 on Linux-2.6.0-test2.

I have just tested mmap SIGBUS beyond EOF on 2.6.13-rc7,
i386 and x86_64, works correctly as expected.

A quick browse through the others shows all the MMU architectures
appearing to support it: delivering SIGBUS signal if VM_FAULT_SIGBUS
returned by handle_mm_fault.

Except for PA-RISC, which delivers SIGSEGV instead.  I imagine that's
wrong, but safer to leave unchanged now - I won't guarantee that one.

> It's how the kernel _should_ work, but very few apps seem to depend on it, 
> so no guarantees. I looked over the code, and I think we've lost the 
> SIGBUS thing.

It would be easier to follow the route from ->nopage observing offset
beyond EOF through to delivery of the SIGBUS if filemap_nopage were
to say NOPAGE_SIGBUS, rather than the NULL that's defined to be.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.13-rc7/mm/filemap.c	2005-08-24 11:13:41.000000000 +0100
+++ linux/mm/filemap.c	2005-08-24 12:35:33.000000000 +0100
@@ -1281,7 +1281,7 @@ outside_data_content:
 	 * accessible..
 	 */
 	if (area->vm_mm == current->mm)
-		return NULL;
+		return NOPAGE_SIGBUS;
 	/* Fall through to the non-read-ahead case */
 no_cached_page:
 	/*
@@ -1306,7 +1306,7 @@ no_cached_page:
 	 */
 	if (error == -ENOMEM)
 		return NOPAGE_OOM;
-	return NULL;
+	return NOPAGE_SIGBUS;
 
 page_not_uptodate:
 	if (!did_readaround) {
@@ -1366,7 +1366,7 @@ page_not_uptodate:
 	 * mm layer so, possibly freeing the page cache page first.
 	 */
 	page_cache_release(page);
-	return NULL;
+	return NOPAGE_SIGBUS;
 }
 
 EXPORT_SYMBOL(filemap_nopage);
