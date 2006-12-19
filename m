Return-Path: <linux-kernel-owner+w=401wt.eu-S1752451AbWLSFNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbWLSFNH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 00:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbWLSFNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 00:13:07 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:26473 "HELO
	smtp103.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752451AbWLSFNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 00:13:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=2K+OLfvFiL6OkjrhFr8V7Smw/jTg3naqk2L93zv0OpG4ZvSSbJDa+SNbKqK03EtGOm9sqoLFfiB3a//ep3lnk4cTv8AFWmnQ5k0KE1KeAYJdyDmeHo3olk7vzsy/pKqEOP6+7xR5w7GGCwcyXPD5eyq7RxMsQik9fwVhQM1muvg=  ;
X-YMail-OSG: JP27vXsVM1kce679TyT96xtZFcuLgJ4UiPYlNvIF8BpHo86u5SVcHw1nhWxNvf6W.Z.gTqwmttG8qPnGwW9IEs7qaZv3LSjp6dct0iL_qA04kmB2UBK7sUYxhEGPI.ksek0I5aR8uOb0HYw-
Message-ID: <45876C65.7010301@yahoo.com.au>
Date: Tue, 19 Dec 2006 15:36:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins> <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080502080602020207010106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080502080602020207010106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> On Mon, 18 Dec 2006, Peter Zijlstra wrote:
> 
>>This should be safe; page_mkclean walks the rmap and flips the pte's
>>under the pte lock and records the dirty state while iterating.
>>Concurrent faults will either do set_page_dirty() before we get around
>>to doing it or vice versa, but dirty state is not lost.
> 
> 
> Ok, I really liked this patch, but the more I thought about it, the more I 
> started to doubt the reasons for liking it.

Well this implements my suggestion to redirty the page if there were dirty
ptes. I think it is a good fix (whether or not it fixes Andrei's bug, it
does fix a bug), though maybe _slightly_ suboptimal.

> I think we have some core fundamental problem here that this patch is 
> needed at all.
> 
> So let's think about this: we apparently have two cases of 
> "clear_page_dirty()":
> 
>  - the one that really wants to clear the bit unconditionally (Andrew 
>    calls this the "must_clean_ptes" case, which I personally find to be a 
>    really confusing name, but whatever)
> 
>  - the other case. The case that doesn't want to really clear the pte 
>    dirty bits.

I don't think this characterises it correctly. Think about how it worked
before the page_mkclean went in there.

We really _never_ want to just clear pte dirty bits, because that would be
a data loss situation[*]. The only reason we clear PG_dirty is because some
filesystem may have cleaned each buffer without realising it has cleaned
the whole page. But if you have a dirty pte, then all bets are off: a
buffer with a clear dirty bit can not be considered clean.

Before the dirty page tracking, it was fine to clear PG_dirty here, because
we would pick up the pte dirty info later on. After the page dirty tracking,
clearing pte dirty is a bug here, and re-accounting the dirty page is
arguably the minimal fix.

[*] except in the truncate case where we are happy to throw out dirty data,
     but in that case there would be no ptes anyway.

The only thing I would suggest is not applying Andrew's patch at all, and
do the special casing in try_to_free_buffers(). I've attached a patch for
comments.


> and I thought your patch made sense, because it saved away the pte state 
> in the page dirty state, and that matches my mental model, but the more I 
> think about it, the less sense that whole "the other case" situation makes 
> AT ALL.
> 
> Why does "the other case" exist at all? If you want to clear the dirty 
> page flag, what is _ever_ the reason for not wanting to drop PTE dirty 
> information? In other words, what possible reason can there ever be for 
> saying "I want this page to be clean", while at the same time saying "but 
> if it was dirty in the page tables, don't forget about that state".

We never want to drop dirty data! (ignoring the truncate case, which is
handled privately by truncate anyway)

This whole exercise is not about cleaning or dirtying or fogetting the actual
*data* in the page. It is about bringing the pagecache's notion of whether
the page is dirty or clean in line with the (more uptodate) filesystem's
notion.

After dirty write accounting, we also threw in "the virtual memory manager's
notion", but got that case slightly wrong.

As unlikely as this race is for SMP systems, I think it is easily possible
for PREEMPT kernels. And they have featured in all bug reports, AFAIKS.

-- 
SUSE Labs, Novell Inc.

--------------080502080602020207010106
Content-Type: text/plain;
 name="fs-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs-fix.patch"

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2006-12-19 15:15:46.000000000 +1100
+++ linux-2.6/fs/buffer.c	2006-12-19 15:36:01.000000000 +1100
@@ -2852,7 +2852,17 @@ int try_to_free_buffers(struct page *pag
 		 * This only applies in the rare case where try_to_free_buffers
 		 * succeeds but the page is not freed.
 		 */
-		clear_page_dirty(page);
+
+		/*
+		 * If the page has been dirtied via the user mappings, then
+		 * clean buffers does not indicate the page data is actually
+		 * clean! Only clear the page dirty bit if there are no dirty
+		 * ptes either.
+		 *
+		 * If there are dirty ptes, then the page must be uptodate, so
+		 * the above concern does not apply.
+		 */
+		clear_page_dirty_sync_ptes(page);
 	}
 out:
 	if (buffers_to_free) {
Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h	2006-12-19 15:17:18.000000000 +1100
+++ linux-2.6/include/linux/page-flags.h	2006-12-19 15:34:24.000000000 +1100
@@ -254,6 +254,7 @@ static inline void SetPageUptodate(struc
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
+int test_clear_page_dirty_sync_ptes(struct page *page);
 int test_clear_page_writeback(struct page *page);
 int test_set_page_writeback(struct page *page);
 
@@ -262,6 +263,11 @@ static inline void clear_page_dirty(stru
 	test_clear_page_dirty(page);
 }
 
+static inline void clear_page_dirty_sync_ptes(struct page *page)
+{
+	test_clear_page_dirty_sync_ptes(page);
+}
+
 static inline void set_page_writeback(struct page *page)
 {
 	test_set_page_writeback(page);
Index: linux-2.6/mm/page-writeback.c
===================================================================
--- linux-2.6.orig/mm/page-writeback.c	2006-12-19 15:17:53.000000000 +1100
+++ linux-2.6/mm/page-writeback.c	2006-12-19 15:33:29.000000000 +1100
@@ -844,9 +844,10 @@ EXPORT_SYMBOL(set_page_dirty_lock);
 
 /*
  * Clear a page's dirty flag, while caring for dirty memory accounting. 
+ * Does not clear pte dirty bits.
  * Returns true if the page was previously dirty.
  */
-int test_clear_page_dirty(struct page *page)
+static int test_clear_page_dirty_leave_ptes(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 	unsigned long flags;
@@ -862,10 +863,8 @@ int test_clear_page_dirty(struct page *p
 			 * We can continue to use `mapping' here because the
 			 * page is locked, which pins the address_space
 			 */
-			if (mapping_cap_account_dirty(mapping)) {
-				page_mkclean(page);
+			if (mapping_cap_account_dirty(mapping))
 				dec_zone_page_state(page, NR_FILE_DIRTY);
-			}
 			return 1;
 		}
 		write_unlock_irqrestore(&mapping->tree_lock, flags);
@@ -873,9 +872,43 @@ int test_clear_page_dirty(struct page *p
 	}
 	return TestClearPageDirty(page);
 }
+
+/*
+ * As above, but does clear dirty bits from ptes
+ */
+int test_clear_page_dirty(struct page *page)
+{
+	struct address_space *mapping = page_mapping(page);
+
+	if (test_clear_page_dirty_leave_ptes(page)) {
+		if (mapping_cap_account_dirty(mapping))
+			page_mkclean(page);
+		return 1;
+	}
+	return 0;
+}
 EXPORT_SYMBOL(test_clear_page_dirty);
 
 /*
+ * As above, but redirties page if any dirty ptes are found (and then only
+ * if the mapping accounts dirty pages, otherwise dirty ptes are left dirty
+ * but the page is cleaned).
+ */
+int test_clear_page_dirty_sync_ptes(struct page *page)
+{
+	struct address_space *mapping = page_mapping(page);
+
+	if (test_clear_page_dirty_leave_ptes(page)) {
+		if (mapping_cap_account_dirty(mapping)) {
+			if (page_mkclean(page))
+				set_page_dirty(page);
+		}
+		return 1;
+	}
+	return 0;
+}
+
+/*
  * Clear a page's dirty flag, while caring for dirty memory accounting.
  * Returns true if the page was previously dirty.
  *

--------------080502080602020207010106--
Send instant messages to your online friends http://au.messenger.yahoo.com 
