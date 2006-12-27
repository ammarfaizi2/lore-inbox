Return-Path: <linux-kernel-owner+w=401wt.eu-S932943AbWL0HCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbWL0HCJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 02:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbWL0HCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 02:02:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35063 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932944AbWL0HCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 02:02:08 -0500
Date: Tue, 26 Dec 2006 23:00:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: ranma@tdiedrich.de, gordonfarquharson@gmail.com, tbm@cyrius.com,
       a.p.zijlstra@chello.nl, andrei.popa@i-neo.ro, akpm@osdl.org,
       hugh@veritas.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <20061226.205518.63739038.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0612262254090.4473@woody.osdl.org>
References: <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org> <20061226161700.GA14128@yamamaya.is-a-geek.org>
 <20061226.205518.63739038.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Dec 2006, David Miller wrote:
> 
> I've seen it on sparc64, UP kernel, no preempt.

Btw, having tried to debug the writeback code, there's one very special 
case that just makes me go "hmm".

If we have a buffer that is "busy" when we try to write back a page, we 
have this magic "wbc->sync_mode == WB_SYNC_NONE && wbc->nonblocking" mode, 
where we won't wait for it, but instead we'll redirty the page and redo 
the whole thing.

Looking at the code, that should all work, but at the same time, it 
triggers some of my debug messages about having a dirty page during 
writeback, and one way to trigger that debug message is to try to run 
rtorrent on the machine.. 

I dunno. Witht he writeback being suspicious, and the normal 
"block_write_full_page()" path being implicated in at least ext2, I just 
wonder. This is one of those "let's see if behaviour changes" patches, 
that I'm just throwing out there..

		Linus

---
diff --git a/fs/buffer.c b/fs/buffer.c
index 263f88e..4652ef1 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1653,19 +1653,7 @@ static int __block_write_full_page(struct inode *inode, struct page *page,
 	do {
 		if (!buffer_mapped(bh))
 			continue;
-		/*
-		 * If it's a fully non-blocking write attempt and we cannot
-		 * lock the buffer then redirty the page.  Note that this can
-		 * potentially cause a busy-wait loop from pdflush and kswapd
-		 * activity, but those code paths have their own higher-level
-		 * throttling.
-		 */
-		if (wbc->sync_mode != WB_SYNC_NONE || !wbc->nonblocking) {
-			lock_buffer(bh);
-		} else if (test_set_buffer_locked(bh)) {
-			redirty_page_for_writepage(wbc, page);
-			continue;
-		}
+		lock_buffer(bh);
 		if (test_clear_buffer_dirty(bh)) {
 			mark_buffer_async_write(bh);
 		} else {
