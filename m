Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266783AbUG1EwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266783AbUG1EwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 00:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266782AbUG1EwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 00:52:19 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:60546 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266780AbUG1EwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 00:52:10 -0400
Date: Wed, 28 Jul 2004 06:51:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: writepages drops bh on not uptodate page
Message-ID: <20040728045156.GH15895@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I think I understood why some ext2 fs corruption still happens even
after the last i_size fix.

what happened I believe is that the writepages layer got a not a fully
uptodate page (in turn with bh mapped on top of it), and then right
before unlocking the page and entering the writeback mode, it freed all
the bh. Without bh a not uptodate page will trigger a full readpage from
disk, that overwrites the pagecache before the multi-bio gets submitted,
generating fs corruption.

I believe the below patch should fix it (untested) against kernel CVS.

The testcases developed by Kurt showed the pagecache being overwritten
with on-disk data at block offsets, and Chris as well was wondering
about races between wait_on_page_writeback and readpage. the below fix
just explains everything we've seen since not-fully-uptodate pages must
have always bh on them and the below patch enforces just that invariant,
and it should fix our pagecache-overwritten-by-disk-data problem.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

Index: writepages-bh-race/fs/mpage.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/fs/mpage.c,v
retrieving revision 1.55
diff -u -p -r1.55 mpage.c
--- writepages-bh-race/fs/mpage.c	11 Jul 2004 16:38:19 -0000	1.55
+++ writepages-bh-race/fs/mpage.c	28 Jul 2004 04:39:13 -0000
@@ -553,7 +553,12 @@ alloc_new:
 			bh = bh->b_this_page;
 		} while (bh != head);
 
-		if (buffer_heads_over_limit)
+		/*
+		 * we cannot drop the bh if the page is not uptodate
+		 * or a concurrent readpage would fail to serialize with the bh
+		 * and it would read from disk before we reach the platter.
+		 */
+		if (buffer_heads_over_limit && PageUptodate(page))
 			try_to_free_buffers(page);
 	}
 
