Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286315AbRLTSXJ>; Thu, 20 Dec 2001 13:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286316AbRLTSXA>; Thu, 20 Dec 2001 13:23:00 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:44568 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286315AbRLTSWv>; Thu, 20 Dec 2001 13:22:51 -0500
Date: Thu, 20 Dec 2001 19:22:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Gergely Nagy <algernon@debian.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.17rc2aa1
Message-ID: <20011220192255.B1477@athlon.random>
In-Reply-To: <20011219161610.I1395@athlon.random> <83k7vjdk8j.wl@iluvatar.ath.cx> <20011219215208.U1395@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011219215208.U1395@athlon.random>; from andrea@suse.de on Wed, Dec 19, 2001 at 09:52:08PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 09:52:08PM +0100, Andrea Arcangeli wrote:
> On Wed, Dec 19, 2001 at 09:32:12PM +0100, Gergely Nagy wrote:
> > > This should fix the last loop deadlocks under VM pressure, if not please
> > > let me know.
> > > 
> > 
> > Unfortunately, it doesn't. I'll do a SysRq+T and kysmoops combo as
> > soon as I boot into that kernel again (probably later tonight).
> 
> perfect, thanks.

My desktop running rc2aa1 crashed in lo_send a few minutes ago while
testing oom conditions with simultaneous heavy I/O to the loop device,
so I had a chance to fix another bug. Maybe this is what you
experienced, but I also got an oops (maybe you didn't seen the oops
because the machine hanged up?). Just guessing.

Anyways here the fix (untested as usual :)

--- 2.4.17rc2aa1/fs/buffer.c.~1~	Wed Dec 19 03:43:24 2001
+++ 2.4.17rc2aa1/fs/buffer.c	Thu Dec 20 19:02:02 2001
@@ -2337,7 +2337,7 @@
 	struct buffer_head *bh;
 
 	page = find_or_create_page(bdev->bd_inode->i_mapping, index, GFP_NOFS);
-	if (IS_ERR(page))
+	if (!page)
 		return NULL;
 
 	if (!PageLocked(page))
--- 2.4.17rc2aa1/mm/filemap.c.~1~	Wed Dec 19 03:43:23 2001
+++ 2.4.17rc2aa1/mm/filemap.c	Thu Dec 20 19:01:53 2001
@@ -942,7 +942,7 @@
 	spin_unlock(&pagecache_lock);
 	if (!page) {
 		struct page *newpage = alloc_page(gfp_mask);
-		page = ERR_PTR(-ENOMEM);
+		page = NULL;
 		if (newpage) {
 			spin_lock(&pagecache_lock);
 			page = __find_lock_page_helper(mapping, index, *hash);



explanation: grab_cache_page must definitely return NULL in case of oom,
that's the API used by the callers. find_or_create_page can use the same
API as well (there's no point for the ERR_PTR(-ENOMEM) complication).

Andrea
