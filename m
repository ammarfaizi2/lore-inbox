Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSFQGwA>; Mon, 17 Jun 2002 02:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316776AbSFQGtX>; Mon, 17 Jun 2002 02:49:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19214 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316778AbSFQGrv>;
	Mon, 17 Jun 2002 02:47:51 -0400
Message-ID: <3D0D8706.8B8CFA60@zip.com.au>
Date: Sun, 16 Jun 2002 23:51:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 6/19] mark_buffer_dirty() speedup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



mark_buffer_dirty() is showing up on Anton's graphs.  Avoiding the
buslocked RMW if the buffer is already dirty should fix that up.



--- 2.5.22/fs/buffer.c~mark_buffer_dirty-speedup	Sun Jun 16 22:50:17 2002
+++ 2.5.22-akpm/fs/buffer.c	Sun Jun 16 23:22:47 2002
@@ -1218,7 +1218,7 @@ void mark_buffer_dirty(struct buffer_hea
 {
 	if (!buffer_uptodate(bh))
 		buffer_error();
-	if (!test_set_buffer_dirty(bh))
+	if (!buffer_dirty(bh) && !test_set_buffer_dirty(bh))
 		__set_page_dirty_nobuffers(bh->b_page);
 }
 

-
