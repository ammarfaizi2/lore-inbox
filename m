Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135789AbREICfA>; Tue, 8 May 2001 22:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135793AbREICev>; Tue, 8 May 2001 22:34:51 -0400
Received: from waulogy.Stanford.EDU ([128.12.53.47]:45833 "EHLO
	waulogy.stanford.edu") by vger.kernel.org with ESMTP
	id <S135789AbREICeg>; Tue, 8 May 2001 22:34:36 -0400
Newsgroups: su.class.cs99q
Date: Tue, 8 May 2001 19:32:55 -0700 (PDT)
From: david chan <dmchan@stanford.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@redhat.com>, Carsten Paeth <calle@calle.in-berlin.de>,
        Karsten Keil <kkeil@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] RAID5 NULL Checking Bug Fix
Message-ID: <Pine.LNX.4.30.0105081923540.21906-100000@waulogy.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
In drivers/md/raid5.c, the author does not check to see if alloc_page() returns
NULL. This patch also adds checks that return 1 (following the
error-path convention in the respective function).

Please discard this e-mail if this patch is irrelevant to you. I just
tried to be thorough.

Thank you,
David Chan

---snip----
--- drivers/md/raid5.c.orig	Tue May  8 19:17:22 2001
+++ drivers/md/raid5.c	Tue May  8 19:20:07 2001
@@ -157,17 +157,21 @@
 		memset(bh, 0, sizeof (struct buffer_head));
 		init_waitqueue_head(&bh->b_wait);
 		page = alloc_page(priority);
+		if (!page)
+			goto nomem_path;
 		bh->b_data = page_address(page);
-		if (!bh->b_data) {
-			kfree(bh);
-			return 1;
-		}
+		if (!bh->b_data)
+			goto nomem_path;
 		atomic_set(&bh->b_count, 0);
 		bh->b_page = page;
 		sh->bh_cache[i] = bh;

 	}
 	return 0;
+
+nomem_path:
+	kfree(bh);
+	return 1;
 }

 static struct buffer_head *raid5_build_block (struct stripe_head *sh, int i);
---snip---

