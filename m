Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSFNR1p>; Fri, 14 Jun 2002 13:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSFNR1p>; Fri, 14 Jun 2002 13:27:45 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:65410 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S312619AbSFNR1o>;
	Fri, 14 Jun 2002 13:27:44 -0400
Date: Fri, 14 Jun 2002 21:27:43 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org
Subject: Slight inefficiency in fs/buffer.c::__block_prepare_write() ?
Message-ID: <20020614212743.A8884@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   It seems there is slight inefficiency in __block_prepare_write() function
   in fs/buffer.c
   It seems ennecessary READ request might be scheduled when all useful info
   in page was rewritten anyway.
   Offending code is this:
                if (!buffer_uptodate(bh) &&
                     (block_start < from || block_end > to)) {
                        ll_rw_block(READ, 1, &bh);
                        *wait_bh++=bh;
                }

   Suppose we have a 4k page with underlying buffer of 4k size (for simplicity)
   filled with 500 bytes.
   Now if we write 550 bytes to that page right from the start, 
   READ request would be scheduled, though it is totally pointless.
   Such a code exists both in 2.4 and 2.5 kernels.

   Am I overlooking something or is patch like below needed?

Bye,
    Oleg

===== buffer.c 1.66 vs edited =====
--- 1.66/fs/buffer.c	Sun May 12 04:26:20 2002
+++ edited/buffer.c	Fri Jun 14 21:16:32 2002
@@ -1591,7 +1591,8 @@
 			continue; 
 		}
 		if (!buffer_uptodate(bh) &&
-		     (block_start < from || block_end > to)) {
+		     (block_start < from || block_end > to) &&
+		     !(from == block_start && to > inode -> i_size)) {
 			ll_rw_block(READ, 1, &bh);
 			*wait_bh++=bh;
 		}
