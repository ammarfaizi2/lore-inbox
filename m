Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265037AbUDUGr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbUDUGr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbUDUGr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:47:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:2758 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265117AbUDUGrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:47:12 -0400
Date: Tue, 20 Apr 2004 23:46:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1 (and earlier): pdflush taking 100% cpu time
 (profile, .config etc. provided)
Message-Id: <20040420234650.058598ce.akpm@osdl.org>
In-Reply-To: <20040421041308.GA19740@middle.of.nowhere>
References: <20040420203449.GA21351@middle.of.nowhere>
	<20040420191533.6af76eb2.akpm@osdl.org>
	<20040421041308.GA19740@middle.of.nowhere>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan <thunder7@xs4all.nl> wrote:
>
> From: Andrew Morton <akpm@osdl.org>
>  Date: Tue, Apr 20, 2004 at 07:15:33PM -0700
>  > Jurriaan <thunder7@xs4all.nl> wrote:
>  > >
>  > >  at times, pdflush is taking over my system:
>  > 
>  > yup, there's some logic error in there.  If I could reproduce it, it would
>  > be fixed in a jiffy :(
>  > 
>  > Which filesystems are in active use at the time?  reiserfs?
>  > 
> 
>  mostly, yes, also ext3, and raid-1 and linear raid. I can't always
>  reproduce it either, unfortunately :-(

I'm suspecting that reiserfs_writepage() is redirty pages rather than
writing them and writeback is livelocking.

Could you try this?




---

 25-akpm/fs/buffer.c         |    2 +-
 25-akpm/fs/ext3/inode.c     |    6 +++---
 25-akpm/fs/ntfs/aops.c      |   15 +++------------
 25-akpm/fs/reiserfs/inode.c |    2 +-
 25-akpm/include/linux/mm.h  |    2 ++
 25-akpm/mm/page-writeback.c |   12 ++++++++++++
 6 files changed, 22 insertions(+), 17 deletions(-)

diff -puN fs/buffer.c~writeback-livelock-fix fs/buffer.c
--- 25/fs/buffer.c~writeback-livelock-fix	2004-04-20 23:46:12.979432024 -0700
+++ 25-akpm/fs/buffer.c	2004-04-20 23:46:13.000428832 -0700
@@ -1826,7 +1826,7 @@ static int __block_write_full_page(struc
 		if (wbc->sync_mode != WB_SYNC_NONE || !wbc->nonblocking) {
 			lock_buffer(bh);
 		} else if (test_set_buffer_locked(bh)) {
-			__set_page_dirty_nobuffers(page);
+			redirty_page_for_writepage(wbc, page);
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
diff -puN fs/ext3/inode.c~writeback-livelock-fix fs/ext3/inode.c
--- 25/fs/ext3/inode.c~writeback-livelock-fix	2004-04-20 23:46:12.981431720 -0700
+++ 25-akpm/fs/ext3/inode.c	2004-04-20 23:46:12.998429136 -0700
@@ -1311,7 +1311,7 @@ static int ext3_ordered_writepage(struct
 	return ret;
 
 out_fail:
-	__set_page_dirty_nobuffers(page);
+	redirty_page_for_writepage(wbc, page);
 	unlock_page(page);
 	return ret;
 }
@@ -1340,7 +1340,7 @@ static int ext3_writeback_writepage(stru
 	return ret;
 
 out_fail:
-	__set_page_dirty_nobuffers(page);
+	redirty_page_for_writepage(wbc, page);
 	unlock_page(page);
 	return ret;
 }
@@ -1396,7 +1396,7 @@ out:
 	return ret;
 
 no_write:
-	__set_page_dirty_nobuffers(page);
+	redirty_page_for_writepage(wbc, page);
 out_unlock:
 	unlock_page(page);
 	goto out;
diff -puN fs/ntfs/aops.c~writeback-livelock-fix fs/ntfs/aops.c
--- 25/fs/ntfs/aops.c~writeback-livelock-fix	2004-04-20 23:46:12.983431416 -0700
+++ 25-akpm/fs/ntfs/aops.c	2004-04-20 23:46:12.995429592 -0700
@@ -499,10 +499,7 @@ static int ntfs_write_block(struct page 
 		 * Put the page back on mapping->dirty_pages, but leave its
 		 * buffer's dirty state as-is.
 		 */
-		// FIXME: Once Andrew's -EAGAIN patch goes in, remove the
-		// __set_page_dirty_nobuffers(page) and return -EAGAIN instead
-		// of zero.
-		__set_page_dirty_nobuffers(page);
+		redirty_page_for_writepage(wbc, page);
 		unlock_page(page);
 		return 0;
 	}
@@ -733,10 +730,7 @@ lock_retry_remap:
 			 * Put the page back on mapping->dirty_pages, but
 			 * leave its buffer's dirty state as-is.
 			 */
-			// FIXME: Once Andrew's -EAGAIN patch goes in, remove
-			// the __set_page_dirty_nobuffers(page) and set err to
-			// -EAGAIN instead of zero.
-			__set_page_dirty_nobuffers(page);
+			redirty_page_for_writepage(wbc, page);
 			err = 0;
 		} else
 			SetPageError(page);
@@ -986,10 +980,7 @@ err_out:
 		 * Put the page back on mapping->dirty_pages, but leave its
 		 * buffer's dirty state as-is.
 		 */
-		// FIXME: Once Andrew's -EAGAIN patch goes in, remove the
-		// __set_page_dirty_nobuffers(page) and set err to -EAGAIN
-		// instead of zero.
-		__set_page_dirty_nobuffers(page);
+		redirty_page_for_writepage(wbc, page);
 		err = 0;
 	} else {
 		ntfs_error(vi->i_sb, "Resident attribute write failed with "
diff -puN fs/reiserfs/inode.c~writeback-livelock-fix fs/reiserfs/inode.c
--- 25/fs/reiserfs/inode.c~writeback-livelock-fix	2004-04-20 23:46:12.985431112 -0700
+++ 25-akpm/fs/reiserfs/inode.c	2004-04-20 23:46:12.993429896 -0700
@@ -2112,7 +2112,7 @@ static int reiserfs_write_full_page(stru
 	    lock_buffer(bh);
 	} else {
 	    if (test_set_buffer_locked(bh)) {
-		__set_page_dirty_nobuffers(page);
+		redirty_page_for_writepage(wbc, page);
 		continue;
 	    }
 	}
diff -puN include/linux/mm.h~writeback-livelock-fix include/linux/mm.h
--- 25/include/linux/mm.h~writeback-livelock-fix	2004-04-20 23:46:12.986430960 -0700
+++ 25-akpm/include/linux/mm.h	2004-04-20 23:46:12.992430048 -0700
@@ -499,6 +499,8 @@ int get_user_pages(struct task_struct *t
 
 int __set_page_dirty_buffers(struct page *page);
 int __set_page_dirty_nobuffers(struct page *page);
+int redirty_page_for_writepage(struct writeback_control *wbc,
+				struct page *page);
 int FASTCALL(set_page_dirty(struct page *page));
 int set_page_dirty_lock(struct page *page);
 int clear_page_dirty_for_io(struct page *page);
diff -puN mm/page-writeback.c~writeback-livelock-fix mm/page-writeback.c
--- 25/mm/page-writeback.c~writeback-livelock-fix	2004-04-20 23:46:12.988430656 -0700
+++ 25-akpm/mm/page-writeback.c	2004-04-20 23:46:13.001428680 -0700
@@ -581,6 +581,18 @@ int __set_page_dirty_nobuffers(struct pa
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
 
 /*
+ * When a writepage implementation decides that it doesn't want to write this
+ * page for some reason, it should redirty the locked page via
+ * redirty_page_for_writepage() and it should then unlock the page and return 0
+ */
+int redirty_page_for_writepage(struct writeback_control *wbc, struct page *page)
+{
+	wbc->pages_skipped++;
+	return __set_page_dirty_nobuffers(page);
+}
+EXPORT_SYMBOL(redirty_page_for_writepage);
+
+/*
  * If the mapping doesn't provide a set_page_dirty a_op, then
  * just fall through and assume that it wants buffer_heads.
  */

_

