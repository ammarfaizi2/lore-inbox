Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbQLPRoj>; Sat, 16 Dec 2000 12:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131397AbQLPRoa>; Sat, 16 Dec 2000 12:44:30 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:18185 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129752AbQLPRoV>;
	Sat, 16 Dec 2000 12:44:21 -0500
Date: Sat, 16 Dec 2000 09:13:51 -0800 (PST)
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <Pine.LNX.4.10.10012151711180.1325-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012160851270.30931-100000@home.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2000, Linus Torvalds wrote:

[ writepage for anon buffers ]

> 
> It might be 10 lines of change, and obviously correct.
> 
I'll give this a try, it will be interesting regardless of if it is simple
enough for kernel inclusion.  

On a related note, I hit a snag porting reiserfs into test12, where
block_read_full_page assumes the buffer it gets back from get_block won't
be up to date.  When reiserfs reads a packed tail directly into the page,
reading the  newly mapped buffer isn't required, and is actually a bad
idea, since the packed tails have a block number of 0 when copied into
the page cache.

In other words, after calling reiserfs_get_block, the buffer might be
mapped and uptodate, with no i/o required in block_read_full_page

The following patch to block_read_full_page fixes things for me, and seems
like a good idea in general.  It might be better to apply something
similar to submit_bh instead...comments?

-chris

--- linux-test12/fs/buffer.c	Mon Dec 18 11:37:42 2000
+++ linux/fs/buffer.c	Mon Dec 18 11:38:36 2000
@@ -1706,8 +1706,10 @@
 			}
 		}
 
-		arr[nr] = bh;
-		nr++;
+		if (!buffer_uptodate(bh)) {
+			arr[nr] = bh;
+			nr++;
+	        }
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
 
 	if (!nr) {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
