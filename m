Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267241AbUBMVuC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267239AbUBMVuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:50:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:9610 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267237AbUBMVtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:49:53 -0500
Subject: [PATCH 2.6.3-rc2-mm1] filemap_fdatawait patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
References: <20040212015710.3b0dee67.akpm@osdl.org>
	 <1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-T1i0zITYmnsNG1tLD7ah"
Organization: 
Message-Id: <1076708987.1956.63.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Feb 2004 13:49:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T1i0zITYmnsNG1tLD7ah
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

This is re-diffed against 2.6.3-rc2-mm1.

This adds the lock_page() and check for PageDirty() in
filemap_fdatawait().

I did additional direct_read_under testing with a forked() process
doing "sync()" and without this patch I hit uninitialized data
even with the __block_write_full_page() patch.

Thoughts?

Daniel

PS

I still think there is potential problem if we ever allow multiple
filemap_fdatawait() to occur in parallel since filemap_fdatawait()
waits for a page with the page unlinked from the locked list.
The 2nd filemap_fdatawait() would never see that page to wait.
I might take care of that in a future patch.



--=-T1i0zITYmnsNG1tLD7ah
Content-Disposition: attachment; filename=filemap_fdatawait.2.6.3-rc2-mm1.patch
Content-Type: text/plain; name=filemap_fdatawait.2.6.3-rc2-mm1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.3-rc2-mm1.orig/mm/filemap.c	2004-02-12 15:04:41.000000000 -0800
+++ linux-2.6.3-rc2-mm1/mm/filemap.c	2004-02-13 12:57:08.777799758 -0800
@@ -209,10 +209,15 @@ restart:
 		page_cache_get(page);
 		spin_unlock(&mapping->page_lock);
 
-		wait_on_page_writeback(page);
-		if (PageError(page))
-			ret = -EIO;
-
+		lock_page(page);
+		if (PageDirty(page) && mapping->a_ops->writepage) {
+			write_one_page(page, 1);
+		} else {
+			wait_on_page_writeback(page);
+			unlock_page(page);
+		}
+ 		if (PageError(page))
+ 			ret = -EIO;
 		page_cache_release(page);
 		spin_lock(&mapping->page_lock);
 	}

--=-T1i0zITYmnsNG1tLD7ah--

