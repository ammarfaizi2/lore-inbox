Return-Path: <linux-kernel-owner+w=401wt.eu-S1753703AbWLWUIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbWLWUIh (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 15:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbWLWUIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 15:08:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59027 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701AbWLWUIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 15:08:36 -0500
Date: Sat, 23 Dec 2006 12:06:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Jean Delvare <khali@linux-fr.org>, Ian McDonald <ian.mcdonald@jandi.co.nz>,
       Thomas Meyer <thomas@m3y3r.de>, linux-cifs-client@lists.samba.org,
       Steve French <sfrench@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: WARNING: "test_clear_page_dirty" [fs/cifs/cifs.ko] undefined!
In-Reply-To: <20061223114458.30722de7.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0612231152360.3671@woody.osdl.org>
References: <458BEB9D.8030709@m3y3r.de> <20061222223034.b29aeb5f.khali@linux-fr.org>
 <Pine.LNX.4.64.0612221615430.3671@woody.osdl.org>
 <Pine.LNX.4.64.0612231004270.3671@woody.osdl.org>
 <20061223114458.30722de7.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Dec 2006, Randy Dunlap wrote:
> 
> BTW, reiserfs has similar build problems:  it uses clear_page_dirty()
> so it won't build.

Not any more. I fixed that one (very different issue, btw: it's not 
actually doign writeout, it actually wanted to cancel IO on truncated 
buffers.

However, it's certainly possible that my fix hasn't mirrored out yet, I 
pushed it just a couple of hours ago. So if you want to test it, here are 
the two commits in question..

(The "cancel_dirty_page()" cleanup is needed not just to do reiserfs as a 
module, it's also to make it more robust against reiserfs possibly feeding 
that function with strange pages, and to match the other related functions 
in the accounting functions).

Len Brown tested the reiserfs changes, and claims that it was all good, 
but if somebody wants to run fsx-linux or some other filesystem stress 
testing tool that actually tests shared mmap (and truncate), that would be 
really appreciated.

		Linus

--
commit 8368e328dfe1c534957051333a87b3210a12743b
Author: Linus Torvalds <torvalds@woody.osdl.org>
Date:   Sat Dec 23 09:25:04 2006 -0800

    Clean up and export cancel_dirty_page() to modules
    
    Make cancel_dirty_page() act more like all the other dirty and writeback
    accounting functions: test for "mapping" being NULL, and do the
    NR_FILE_DIRY accounting purely based on mapping_cap_account_dirty()).
    
    Also, add it to the exports, so that modular filesystems can use it.
    
    Acked-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 mm/truncate.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 4a38dd1..ecdfdcc 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -60,12 +60,16 @@ void cancel_dirty_page(struct page *page, unsigned int account_size)
 		WARN_ON(++warncount < 5);
 	}
 		
-	if (TestClearPageDirty(page) && account_size &&
-			mapping_cap_account_dirty(page->mapping)) {
-		dec_zone_page_state(page, NR_FILE_DIRTY);
-		task_io_account_cancelled_write(account_size);
+	if (TestClearPageDirty(page)) {
+		struct address_space *mapping = page->mapping;
+		if (mapping && mapping_cap_account_dirty(mapping)) {
+			dec_zone_page_state(page, NR_FILE_DIRTY);
+			if (account_size)
+				task_io_account_cancelled_write(account_size);
+		}
 	}
 }
+EXPORT_SYMBOL(cancel_dirty_page);
 
 /*
  * If truncate cannot remove the fs-private metadata from the page, the page

commit ffaa82008f1aad52a6d3979f49d2a76c2928b60f
Author: Linus Torvalds <torvalds@woody.osdl.org>
Date:   Sat Dec 23 09:32:45 2006 -0800

    Fix reiserfs after "test_clear_page_dirty()" removal
    
    Thanks to Len Brown for testing this fix, since while they have in the
    past, none of my machines run reiserfs at the moment.
    
    Cc: Vladimir V. Saveliev <vs@namesys.com>
    Acked-by: Len Brown <lenb@kernel.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 fs/reiserfs/stree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 47e7027..afb21ea 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -1459,7 +1459,7 @@ static void unmap_buffers(struct page *page, loff_t pos)
 				bh = next;
 			} while (bh != head);
 			if (PAGE_SIZE == bh->b_size) {
-				clear_page_dirty(page);
+				cancel_dirty_page(page, PAGE_CACHE_SIZE);
 			}
 		}
 	}

