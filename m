Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311600AbSCaFdS>; Sun, 31 Mar 2002 00:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311618AbSCaFdJ>; Sun, 31 Mar 2002 00:33:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58640 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311600AbSCaFcz>;
	Sun, 31 Mar 2002 00:32:55 -0500
Message-ID: <3CA69F33.90B37E83@zip.com.au>
Date: Sat, 30 Mar 2002 21:31:31 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] fix loop deadlock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5 is missing a chunk from 2.4

--- 2.5.7/fs/buffer.c~loop-deadlock	Sat Mar 30 21:18:13 2002
+++ 2.5.7-akpm/fs/buffer.c	Sat Mar 30 21:18:22 2002
@@ -992,7 +992,7 @@ static int balance_dirty_state(void)
 
 	/* First, check for the "real" dirty limit. */
 	if (dirty > soft_dirty_limit) {
-		if (dirty > hard_dirty_limit)
+		if (dirty > hard_dirty_limit && !(current->flags & PF_NOIO))
 			return 1;
 		return 0;
 	}


>From an efficiency POV loop is looking rather hilarious:

c013da84 kmem_cache_alloc                             30   0.0355
c0239bc0 __make_request                               41   0.0321
c02457e0 transfer_none                                90   1.2500
c0148480 create_bounce                               171   0.2007
c0138a00 generic_file_write                          305   0.1540
c014d558 write_some_buffers                        10028  28.4886
c0151db5 .text.lock.buffer                         29229  47.2197
00000000 total                                     40308   0.0195

Probably we can fix this using the BH_Launder bit from
Andrea's kit.

-
