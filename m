Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267861AbUHETEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267861AbUHETEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUHETDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:03:08 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:33552 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S267914AbUHETCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:02:36 -0400
Message-ID: <41127371.1000603@lougher.demon.co.uk>
Date: Thu, 05 Aug 2004 18:50:41 +0100
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-GB; rv:1.2.1) Gecko/20030228
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a readahead bug in do_generic_mapping_read (filemap.c).  This
bug appears to have been introduced in 2.6.8-rc1.  Specifically the bug
is caused by an incorrect code change which causes VFS to call
readpage() for indexes beyond the end of files where the file length is
zero or a 4k multiple.

In Squashfs this causes a variety of almost immediate OOPes because
Squashfs trusts the VFS not to pass invalid index values.  For other
filesystems it may also be causing subtle bugs.  I have received
prune_dcache oopes similar to Gene Heskett's (which was also
pointer corruption), and so it may fix this and other reported
readahead bugs.

The patch is against 2.6.8-rc3.

Regards

Phillip Lougher

diff --new-file -ur linux-2.6.8-rc3-squashfs2.0-test/mm/filemap.c linux-2.6.8-rc3-squashfs2.0-patched/mm/filemap.c
--- linux-2.6.8-rc3-squashfs2.0-test/mm/filemap.c       2004-08-05 02:14:39.000000000 +0100
+++ linux-2.6.8-rc3-squashfs2.0-patched/mm/filemap.c    2004-08-05 18:15:00.000000000 +0100
@@ -674,6 +674,15 @@
                 unsigned long nr, ret;

                 cond_resched();
+
+               /* nr is the maximum number of bytes to copy from this page */
+               nr = PAGE_CACHE_SIZE;
+               if (index == end_index) {
+                       nr = isize & ~PAGE_CACHE_MASK;
+                       if (nr <= offset)
+                               goto out;
+               }
+
                 page_cache_readahead(mapping, &ra, filp, index);

  find_page:
@@ -685,15 +694,6 @@
                 if (!PageUptodate(page))
                         goto page_not_up_to_date;
  page_ok:
-               /* nr is the maximum number of bytes to copy from this page */
-               nr = PAGE_CACHE_SIZE;
-               if (index == end_index) {
-                       nr = isize & ~PAGE_CACHE_MASK;
-                       if (nr <= offset) {
-                               page_cache_release(page);
-                               goto out;
-                       }
-               }
                 nr = nr - offset;

                 /* If users can be writing to this page using arbitrary

