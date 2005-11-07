Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVKGRmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVKGRmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbVKGRmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:42:46 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:52489 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S964868AbVKGRmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:42:44 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] export/change sync_page_range/_nolock()
References: <87hdaotlci.fsf@devron.myhome.or.jp>
	<87d5lctl5y.fsf@devron.myhome.or.jp>
	<878xw0tl3r.fsf_-_@devron.myhome.or.jp>
	<874q6otl0q.fsf_-_@devron.myhome.or.jp>
	<87zmogs6cs.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Nov 2005 02:42:36 +0900
In-Reply-To: <87zmogs6cs.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Tue, 08 Nov 2005 02:41:39 +0900")
Message-ID: <87vez4s6b7.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This exports/changes the sync_page_range/_nolock(). The fatfs needs
sync_page_range/_nolock() for expanding truncate, and changes "size_t
count" to "loff_t count".

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 include/linux/writeback.h |    4 +++-
 mm/filemap.c              |    8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff -puN include/linux/writeback.h~export-sync_page_range_nolock include/linux/writeback.h
--- linux-2.6.14/include/linux/writeback.h~export-sync_page_range_nolock	2005-11-07 03:59:03.000000000 +0900
+++ linux-2.6.14-hirofumi/include/linux/writeback.h	2005-11-07 03:59:03.000000000 +0900
@@ -108,7 +108,9 @@ void balance_dirty_pages_ratelimited(str
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 int sync_page_range(struct inode *inode, struct address_space *mapping,
-			loff_t pos, size_t count);
+			loff_t pos, loff_t count);
+int sync_page_range_nolock(struct inode *inode, struct address_space *mapping,
+			   loff_t pos, loff_t count);
 
 /* pdflush.c */
 extern int nr_pdflush_threads;	/* Global so it can be exported to sysctl
diff -puN mm/filemap.c~export-sync_page_range_nolock mm/filemap.c
--- linux-2.6.14/mm/filemap.c~export-sync_page_range_nolock	2005-11-07 03:59:03.000000000 +0900
+++ linux-2.6.14-hirofumi/mm/filemap.c	2005-11-07 03:59:03.000000000 +0900
@@ -280,7 +280,7 @@ static int wait_on_page_writeback_range(
  * it is otherwise livelockable.
  */
 int sync_page_range(struct inode *inode, struct address_space *mapping,
-			loff_t pos, size_t count)
+			loff_t pos, loff_t count)
 {
 	pgoff_t start = pos >> PAGE_CACHE_SHIFT;
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
@@ -305,9 +305,8 @@ EXPORT_SYMBOL(sync_page_range);
  * as it forces O_SYNC writers to different parts of the same file
  * to be serialised right until io completion.
  */
-static int sync_page_range_nolock(struct inode *inode,
-				  struct address_space *mapping,
-				  loff_t pos, size_t count)
+int sync_page_range_nolock(struct inode *inode, struct address_space *mapping,
+			   loff_t pos, loff_t count)
 {
 	pgoff_t start = pos >> PAGE_CACHE_SHIFT;
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
@@ -322,6 +321,7 @@ static int sync_page_range_nolock(struct
 		ret = wait_on_page_writeback_range(mapping, start, end);
 	return ret;
 }
+EXPORT_SYMBOL(sync_page_range_nolock);
 
 /**
  * filemap_fdatawait - walk the list of under-writeback pages of the given
_
