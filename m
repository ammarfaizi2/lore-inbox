Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTHBKrx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 06:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272457AbTHBKrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 06:47:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:58335 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263752AbTHBKrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 06:47:45 -0400
Date: Sat, 2 Aug 2003 03:48:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/3] writes: use flags in address space
Message-Id: <20030802034843.21cb8564.akpm@osdl.org>
In-Reply-To: <20030802041823.GB22824@waste.org>
References: <20030802041823.GB22824@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> wrote:
>
> Combine mapping->error and ->gfp_mask into ->flags

Some tweaks here too.



- Robustify the logic a bit.  At present if writepage() returns an error
  which is not -EIO or -ENOSPC we lose track of it.

  So instead, treat all unknown errors as -EIO.



 fs/mpage.c  |   12 ++++++------
 mm/vmscan.c |    6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff -puN fs/mpage.c~awe-use-gfp_flags-fixes fs/mpage.c
--- 25/fs/mpage.c~awe-use-gfp_flags-fixes	2003-08-02 03:40:29.000000000 -0700
+++ 25-akpm/fs/mpage.c	2003-08-02 03:40:29.000000000 -0700
@@ -566,10 +566,10 @@ confused:
 	/*
 	 * The caller has a ref on the inode, so *mapping is stable
 	 */
-	if (*ret == -EIO)
-		set_bit(AS_EIO, &mapping->flags);
-	else if (*ret == -ENOSPC)
+	if (*ret == -ENOSPC)
 		set_bit(AS_ENOSPC, &mapping->flags);
+	else
+		set_bit(AS_EIO, &mapping->flags);
 out:
 	return bio;
 }
@@ -671,10 +671,10 @@ mpage_writepages(struct address_space *m
 					test_clear_page_dirty(page)) {
 			if (writepage) {
 				ret = (*writepage)(page, wbc);
-				if (ret == -EIO)
-					set_bit(AS_EIO, &mapping->flags);
-				else if (ret == -ENOSPC)
+				if (ret == -ENOSPC)
 					set_bit(AS_ENOSPC, &mapping->flags);
+				else
+					set_bit(AS_EIO, &mapping->flags);
 			} else {
 				bio = mpage_writepage(bio, page, get_block,
 					&last_block_in_bio, &ret, wbc);
diff -puN mm/vmscan.c~awe-use-gfp_flags-fixes mm/vmscan.c
--- 25/mm/vmscan.c~awe-use-gfp_flags-fixes	2003-08-02 03:40:29.000000000 -0700
+++ 25-akpm/mm/vmscan.c	2003-08-02 03:40:29.000000000 -0700
@@ -252,10 +252,10 @@ static void handle_write_error(struct ad
 {
 	lock_page(page);
 	if (page->mapping == mapping) {
-		if (error == -EIO)
-			set_bit(AS_EIO, &mapping->flags);
-		else if (error == -ENOSPC)
+		if (error == -ENOSPC)
 			set_bit(AS_ENOSPC, &mapping->flags);
+		else
+			set_bit(AS_EIO, &mapping->flags);
 	}
 	unlock_page(page);
 }

_

