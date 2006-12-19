Return-Path: <linux-kernel-owner+w=401wt.eu-S932651AbWLSIPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbWLSIPP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWLSIPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:15:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35797 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932651AbWLSIPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:15:13 -0500
Date: Tue, 19 Dec 2006 00:14:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <45879BEF.9060001@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0612190011170.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <45876C65.7010301@yahoo.com.au> <1166512923.10372.114.camel@twins>
 <45879BEF.9060001@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2006, Nick Piggin wrote:
> > 
> > Anyway it has the same issues as the others. See what happens when you
> > run two test_clear_page_dirty_sync_ptes() consecutively, you still loose
> > PG_dirty even though the page might actually be dirty.
> 
> How can this happen? We'll only test_clear_page_dirty_sync_ptes again
> after buffers have been reattached, and subsequently cleaned. And in
> that case if the ptes are still clean at this point then the page really
> is clean.

Why do you talk about buffers being reattached? Are you still in some 
world where "try_to_free_buffers()" matters? Have you not followed the 
discussion? Why do you ignore my MUCH SIMPLER patch that just removed all 
this crap ENTIRELY from "try_to_free_buffers()", and the exact same 
corruption happened?

Forget about "try_to_free_buffers()". Please apply this patch to your tree 
first. That gets rid of _one_ copy of totally insane code that did all the 
wrong things.

Only after you have applied this patch should you look at the code again. 
Realizing that the corruption still happens.

So forget about buffers already. That piece of code was crap.

		Linus

---
diff --git a/fs/buffer.c b/fs/buffer.c
index d1f1b54..263f88e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2834,7 +2834,7 @@ int try_to_free_buffers(struct page *page)
 	int ret = 0;
 
 	BUG_ON(!PageLocked(page));
-	if (PageWriteback(page))
+	if (PageDirty(page) || PageWriteback(page))
 		return 0;
 
 	if (mapping == NULL) {		/* can this still happen? */
@@ -2845,22 +2845,6 @@ int try_to_free_buffers(struct page *page)
 	spin_lock(&mapping->private_lock);
 	ret = drop_buffers(page, &buffers_to_free);
 	spin_unlock(&mapping->private_lock);
-	if (ret) {
-		/*
-		 * If the filesystem writes its buffers by hand (eg ext3)
-		 * then we can have clean buffers against a dirty page.  We
-		 * clean the page here; otherwise later reattachment of buffers
-		 * could encounter a non-uptodate page, which is unresolvable.
-		 * This only applies in the rare case where try_to_free_buffers
-		 * succeeds but the page is not freed.
-		 *
-		 * Also, during truncate, discard_buffer will have marked all
-		 * the page's buffers clean.  We discover that here and clean
-		 * the page also.
-		 */
-		if (test_clear_page_dirty(page))
-			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
-	}
 out:
 	if (buffers_to_free) {
 		struct buffer_head *bh = buffers_to_free;
