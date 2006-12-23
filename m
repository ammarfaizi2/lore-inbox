Return-Path: <linux-kernel-owner+w=401wt.eu-S1753672AbWLWSb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbWLWSb2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 13:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbWLWSb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 13:31:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51542 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653AbWLWSb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 13:31:27 -0500
Date: Sat, 23 Dec 2006 10:30:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean Delvare <khali@linux-fr.org>, Ian McDonald <ian.mcdonald@jandi.co.nz>
cc: Thomas Meyer <thomas@m3y3r.de>, linux-cifs-client@lists.samba.org,
       Steve French <sfrench@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: WARNING: "test_clear_page_dirty" [fs/cifs/cifs.ko] undefined!
In-Reply-To: <Pine.LNX.4.64.0612221615430.3671@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612231004270.3671@woody.osdl.org>
References: <458BEB9D.8030709@m3y3r.de> <20061222223034.b29aeb5f.khali@linux-fr.org>
 <Pine.LNX.4.64.0612221615430.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Andrew - I'm cc'ing you, because you caused the requirement that people 
  use "set_page_writeback()" in their writepage() routine that CIFS seems 
  to have been ignoring all these years. That was introduced more than 
two years ago, back in April 11, 2004:

	[PATCH] fdatasync integrity fix

	fdatasync can fail to wait on some pages due to a race.
	...

  and as far as I can see, ever since then, any filesystem that didn't do 
  a "set_page_writeback()" to sync up the TAG_DIRTY bit would have this 
  CPU usage problem. Please double-check whether I'm right or barking up 
  the wrong tree.

  Afaik, the lack of doing the page writeback bit handling properly would 
  seem to not cause any actual visible _semantic_ problems, it would just 
  cause fdatasync to not necessarily be entirely reliable (which I guess 
  is semantic, but very hard to see) and just wasted CPU cycles when we 
  look up pages that are marked dirty in the radix tree, but aren't 
  actually really dirty. 

  Correct? Who else is implicated in all of this? ]

On Fri, 22 Dec 2006, Linus Torvalds wrote:
> 
> CIFS _should_ be using "clear_page_dirty_for_io()" in that place, and that 
> will fix the build. However, the reason I didn't just do that myself is 
> that I can't test the end result, and for the life of me, I can't see 
> where CIFS does the "end_page_writeback()" that it needs to do at IO 
> completion time.

Ok, I spent some more time looking at this.

The reason cifs didn't do an "end_page_writeback()" was that it didn't 
even do the "set_page_writeback()" to mark the page under writeback in the 
first place.

Now, you might think that since it didn't do a set_page_writeback(), it 
doesn't need to do the matching end_page_writeback() at all, and instead 
just continue to use the old (_really_ old) way of just unlocking the page 
when it is done.

However, you'd be wrong. The thing is, a "writepage()" function will be 
called with the dirty bit cleared in the "struct page *", but the mapping 
radix trees will still have the dirty bit set, exactly because the VM 
_requires_ the filesystem to tell it what the h*ll it is doing with the 
page. So a low-level filesystem must always do one of two things in it's 
"writepage()" function. Either: 

 - "set_page_writeback()" (and then an "end_page_writeback()" when 
   finished, of course)

OR

 - "redirty_page_for_writepage()" to tell the VM to move the page to the 
   back of the LRU queues because it can't be cleaned (eg, some temporary 
   problem with write ordering or similar, or something fundamental like 
   "I'm ramfs, and I don't _have_ any backing store").

and if the low-level filesystem doesn't do either of those, then the 
status bits in the radix tree that contains the mapping information will 
never be updated, so the page that got cleaned will continue to be marked 
"dirty" in the radix tree (which admittedly will generally be invisible, 
except for "sync()" and friends spending inordinate amounts of time 
looking at pages that aren't even dirty any more - since they look things 
up by the radix tree tags).

So I think the old code happened to work, but it was definitely incorrect, 
and would leave the dirty tags in the radix tree very confused indeed (it 
so happened that "cifs_writepages()" - with an "s" at the end - because it 
used "test_clear_page_dirty()" - would also clear the dirty tag, but any 
page that went through the generic VM routines and the single-page 
"cifs_writepage()" - without an "s" at the end - would then be forever 
marked dirty in the radix tree even though it was clean.

Somebody should check me, though.

This fairly mindless patch adds the proper "set_page_writeback()" calls 
(and the "clear_page_writeback()" ones I had already added before I looked 
more closely at this). 

I added a comment in "cifs_writepage()" (the single-page case) for why 
this all is the case,

			Linus

PS. To clarify: the old "test_clear_page_dirty()" would actually clear the 
dirty bit in the radix tree too, so in that sense it was the RIGHT thing 
to do for CIFS, since CIFS was mostly unaware of the need to clear the 
radix tree dirty bit (even if cifs_writepages() actually used that bit to 
look up pages).

HOWEVER, since CIFS is called from the generic routines (which _are_ 
radix-tree-aware and need the bit to be cleared explicitly), even the old 
code was actually totally broken. It would clear - largely by mistake - 
the radix tree dirty bit only for one case, not for _all_ the cases. A 
filesystem really does need to know about these things now, although a 
lot of filesystems can ignore them, since if they use all the generic 
routines, they generic routines will handle it all for them.

---
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 0f05cab..8a49b2e 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1245,14 +1245,21 @@ retry:
 				wait_on_page_writeback(page);
 
 			if (PageWriteback(page) ||
-					!test_clear_page_dirty(page)) {
+					!clear_page_dirty_for_io(page)) {
 				unlock_page(page);
 				break;
 			}
 
+			/*
+			 * This actually clears the dirty bit in the radix tree.
+			 * See cifs_writepage() for more commentary.
+			 */
+			set_page_writeback(page);
+
 			if (page_offset(page) >= mapping->host->i_size) {
 				done = 1;
 				unlock_page(page);
+				end_page_writeback(page);
 				break;
 			}
 
@@ -1316,6 +1323,7 @@ retry:
 					SetPageError(page);
 				kunmap(page);
 				unlock_page(page);
+				end_page_writeback(page);
 				page_cache_release(page);
 			}
 			if ((wbc->nr_to_write -= n_iov) <= 0)
@@ -1352,11 +1360,23 @@ static int cifs_writepage(struct page* page, struct writeback_control *wbc)
         if (!PageUptodate(page)) {
 		cFYI(1, ("ppw - page not up to date"));
 	}
-	
+
+	/*
+	 * Set the "writeback" flag, and clear "dirty" in the radix tree.
+	 *
+	 * A writepage() implementation always needs to do either this,
+	 * or re-dirty the page with "redirty_page_for_writepage()" in
+	 * the case of a failure.
+	 *
+	 * Just unlocking the page will cause the radix tree tag-bits
+	 * to fail to update with the state of the page correctly.
+	 */
+	set_page_writeback(page);		
 	rc = cifs_partialpagewrite(page, 0, PAGE_CACHE_SIZE);
 	SetPageUptodate(page); /* BB add check for error and Clearuptodate? */
 	unlock_page(page);
-	page_cache_release(page);	
+	end_page_writeback(page);
+	page_cache_release(page);
 	FreeXid(xid);
 	return rc;
 }
