Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263182AbUDYRmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUDYRmS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 13:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUDYRmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 13:42:18 -0400
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:19730 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S263182AbUDYRmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 13:42:03 -0400
Date: Sun, 25 Apr 2004 19:41:51 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Sven Geggus <sven-im-usenet@gegg.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc2-mm1 pdflush eats my CPU
Message-ID: <20040425174151.GB22990@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <c6gi0f$g6i$1@benzin.geggus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6gi0f$g6i$1@benzin.geggus.net>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Geggus <sven-im-usenet@gegg.us>
Date: Sun, Apr 25, 2004 at 02:29:35PM +0000
> Hi there,
> 
> my Desktop machine 2.6.6-rc2-mm1 got almost unusable starting with Kernel
> 2.6.6-rc2-mm1. The machine starts up with pdflush eating up all CPU.
> 2.6.6-rc2 without mm1 has teh same behavour.
> 
> --top output--
> top - 16:27:07 up 21 min,  6 users,  load average: 1.07, 1.14, 0.87
> Tasks:  94 total,   2 running,  91 sleeping,   0 stopped,   1 zombie
> Cpu(s):   6.7% user,  90.4% system,   0.0% nice,   1.8% idle,   1.1% IO-wait
> Mem:    510596k total,   281644k used,   228952k free,        0k buffers
> Swap:        0k total,        0k used,        0k free,   114684k cached
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>     8 root      25   0     0    0    0 R 93.2  0.0  18:15.08 pdflush          
> --cut--
>    
> Its not happening when I use something like init=/bin/bash, but it does
> happen on Normal startup (KDM login).
>    
> The only thing which is somewhat exotic with this machine, is the fact, that
> there are no filesystems mounted besides NFS (root-NFS).
> 
> It did not happen with 2.6.5-rc3 which I have been using before.
> 
> I will be able to provide further debugging Information, when somebody tells
> me what will be of interest (output of readprofile etc.)
> 
I had that too, but without NFS. Andrew Morton thought it might have to
do with reiserfs, and send me a patch. Perhaps you can try this patch
and report back what happened (to the list and Andrew).

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


Good luck,
Jurriaan
-- 
"Bother!" said Pooh as he fished his diskettes out of the honey jar.
Debian (Unstable) GNU/Linux 2.6.6-rc2-mm1 2x6062 bogomips 1.09 1.02
