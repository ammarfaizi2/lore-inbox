Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUCDPNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 10:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUCDPNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 10:13:18 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:36088 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261929AbUCDPNP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 10:13:15 -0500
Subject: Race in nobh_prepare_write
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078413178.9164.24.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 09:12:58 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
I discovered a race betwen nobh_prepare_write and end_buffer_read_sync. 
end_buffer_read_sync calls unlock_buffer, waking the nobh_prepare_write
thread, which immediately frees the buffer_head.  end_buffer_read_sync
then calls put_bh which decrements b_count for the already freed
structure.  The SLAB_DEBUG code detects the slab corruption.

I was able to fix it with the following patch.  I reversed the order of
unlock_buffer and put_bh in end_buffer_read_sync.  I also set b_count to
1 and later called brelse in nobh_prepare_write, since unlock_buffer may
expect b_count to be non-zero.  I didn't change the other end_io
functions, as I'm not sure what effect this may have on other callers.

Is my fix correct?  Is it complete?

Here's the patch:

--- linux-2.6.4-rc1+/fs/buffer.c.orig	2004-03-03 13:50:10.000000000 -0600
+++ linux-2.6.4-rc1+/fs/buffer.c	2004-03-04 08:30:03.000000000 -0600
@@ -178,8 +178,8 @@ void end_buffer_read_sync(struct buffer_
 		/* This happens, due to failed READA attempts. */
 		clear_buffer_uptodate(bh);
 	}
-	unlock_buffer(bh);
 	put_bh(bh);
+	unlock_buffer(bh);
 }
 
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
@@ -2395,7 +2395,7 @@ int nobh_prepare_write(struct page *page
 				goto failed;
 			}
 			bh->b_state = map_bh.b_state;
-			atomic_set(&bh->b_count, 0);
+			atomic_set(&bh->b_count, 1);
 			bh->b_this_page = 0;
 			bh->b_page = page;
 			bh->b_blocknr = map_bh.b_blocknr;
@@ -2413,6 +2413,7 @@ int nobh_prepare_write(struct page *page
 			wait_on_buffer(read_bh[i]);
 			if (!buffer_uptodate(read_bh[i]))
 				ret = -EIO;
+			brelse(read_bh[i]);
 			free_buffer_head(read_bh[i]);
 			read_bh[i] = NULL;
 		}
@@ -2438,8 +2439,10 @@ int nobh_prepare_write(struct page *page
 
 failed:
 	for (i = 0; i < nr_reads; i++) {
-		if (read_bh[i])
+		if (read_bh[i]) {
+			brelse(read_bh[i]);
 			free_buffer_head(read_bh[i]);
+		}
 	}
 
 	/*


Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

