Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311504AbSCTEFq>; Tue, 19 Mar 2002 23:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311531AbSCTEEu>; Tue, 19 Mar 2002 23:04:50 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:38672 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311532AbSCTEEW>; Tue, 19 Mar 2002 23:04:22 -0500
Message-ID: <3C9809EE.D41EE6AC@zip.com.au>
Date: Tue, 19 Mar 2002 20:02:54 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-190-block_flushpage_check
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bugcheck.  It's needed - if the page had locked buffers here we'd do a
lock_buffer() inside spinlock.

=====================================

--- 2.4.19-pre3/mm/swap_state.c~aa-190-block_flushpage_check	Tue Mar 19 19:49:04 2002
+++ 2.4.19-pre3-akpm/mm/swap_state.c	Tue Mar 19 19:49:04 2002
@@ -117,7 +117,9 @@ void delete_from_swap_cache(struct page 
 	if (!PageLocked(page))
 		BUG();
 
-	block_flushpage(page, 0);
+	if (!block_flushpage(page, 0))
+		/* an anonymous page cannot have page->buffers set */
+		BUG();
 
 	entry.val = page->index;
 

-
