Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVJOQ6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVJOQ6K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 12:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVJOQ6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 12:58:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13793 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751185AbVJOQ6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 12:58:08 -0400
Date: Sat, 15 Oct 2005 09:57:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, hugh@veritas.com,
       paulus@samba.org, anton@samba.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
In-Reply-To: <E1EQgxs-00061G-00@gondolin.me.apana.org.au>
Message-ID: <Pine.LNX.4.64.0510150945460.23590@g5.osdl.org>
References: <E1EQgxs-00061G-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Oct 2005, Herbert Xu wrote:
>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > yup, now the question is wether PG_Dirty will be visible to CPU 2 before
> > the page count is decremented right ? That depends on put_page, I
> > suppose. If it's doing a simple atomic, there is an issue. But atomics
> > with return has been so often abused as locks that they may have been
> > implemented with a barrier... (On ppc64, it will do an eieio, thus I
> > think it should be ok).
> 
> Yes atomic_add_negative should always be a barrier.

I disagree. That would be very expensive on anything but x86, where it 
just happens to be true for other reasons. Atomics do _not_ implement 
barriers.

Normally, we really don't care about any other decrement than the one that 
goes to zero, and that one tends to come with its own serialization logic.

In this case, we don't even care.

I agree, however, that it looks like PG_dirty is racy. Probably not in 
practice, but still.

So I'd suggest adding a smp_wmb() into set_page_dirty, and the rmb where 
Nick suggested.

So I'd suggest a patch something more like this.. Marking the dirty/count 
cases unlikely too in mm/page-writeback.c, since we should have tested for 
these conditions optimistically outside the lock.

Comments? Nick, did you have some test-case that you think might actually 
have been impacted by this?

		Linus

---
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0166ea1..722779c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -668,8 +668,14 @@ int fastcall set_page_dirty(struct page 
 			return (*spd)(page);
 		return __set_page_dirty_buffers(page);
 	}
-	if (!PageDirty(page))
+	if (!PageDirty(page)) {
 		SetPageDirty(page);
+		/*
+		 * Make sure the dirty bit percolates out
+		 * to other CPU's before we release the page
+		 */
+		smp_wmb();
+	}
 	return 0;
 }
 EXPORT_SYMBOL(set_page_dirty);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0ea71e8..64f9570 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -511,10 +511,11 @@ static int shrink_list(struct list_head 
 		 * PageDirty _after_ making sure that the page is freeable and
 		 * not in use by anybody. 	(pagecache + us == 2)
 		 */
-		if (page_count(page) != 2 || PageDirty(page)) {
-			write_unlock_irq(&mapping->tree_lock);
-			goto keep_locked;
-		}
+		if (unlikely(page_count(page) != 2))
+			goto cannot_free;
+		smp_rmb();
+		if (unlikely(PageDirty(page)))
+			goto cannot_free;
 
 #ifdef CONFIG_SWAP
 		if (PageSwapCache(page)) {
@@ -538,6 +539,10 @@ free_it:
 			__pagevec_release_nonlru(&freed_pvec);
 		continue;
 
+cannot_free:
+		write_unlock_irq(&mapping->tree_lock);
+		goto keep_locked;
+
 activate_locked:
 		SetPageActive(page);
 		pgactivate++;
