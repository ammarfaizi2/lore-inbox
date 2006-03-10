Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751969AbWCJSii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbWCJSii (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 13:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWCJSii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 13:38:38 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:61352 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751969AbWCJSih
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 13:38:37 -0500
Subject: [PATCH] ext3 nobh cleanups
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 10:40:12 -0800
Message-Id: <1142016012.21442.34.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One can do "chattr +j" on a file to change its journalling mode.
Here is the patch to fix writeback mode with "nobh" handling for it.

Thanks,
Badari

Even though, we mount ext3 filesystem in writeback mode with
"nobh" option, some one can do "chattr +j" on a single file
to force it to do journalled mode.  In order to do journaling,
ext3_block_truncate_page() need to fallback to default case 
of creating buffers and adding them to transcation etc. 

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Index: linux-2.6.16-rc5/fs/ext3/inode.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/ext3/inode.c	2006-03-10 10:19:14.000000000
-0800
+++ linux-2.6.16-rc5/fs/ext3/inode.c	2006-03-10 10:40:43.000000000 -0800
@@ -1624,15 +1624,14 @@ static int ext3_block_truncate_page(hand
 	 * For "nobh" option,  we can only work if we don't need to
 	 * read-in the page - otherwise we create buffers to do the IO.
 	 */
-	if (!page_has_buffers(page) && test_opt(inode->i_sb, NOBH)) {
-		if (PageUptodate(page)) {
+	if (!page_has_buffers(page) && test_opt(inode->i_sb, NOBH) &&
+	     ext3_should_writeback_data(inode) && PageUptodate(page)) {
 			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr + offset, 0, length);
 			flush_dcache_page(page);
 			kunmap_atomic(kaddr, KM_USER0);
 			set_page_dirty(page);
 			goto unlock;
-		}
 	}
 
 	if (!page_has_buffers(page))


