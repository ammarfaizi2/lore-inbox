Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSJQXkn>; Thu, 17 Oct 2002 19:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262541AbSJQXkn>; Thu, 17 Oct 2002 19:40:43 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:61947 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262296AbSJQXkk>; Thu, 17 Oct 2002 19:40:40 -0400
Date: Fri, 18 Oct 2002 00:47:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs 1/9 shmem_getpage unlock_page
Message-ID: <Pine.LNX.4.44.0210180042480.7220-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of nine tmpfs patches based on 2.5.43, hoping for inclusion in
2.5.43-mm then on to mainline.  The main change is in 8/9, enabling
loopable tmpfs.  9/9 instates Ingo's shmem_populate above the rest.

 Documentation/devices.txt           |    2 
 Documentation/filesystems/tmpfs.txt |   17 
 include/asm-sparc64/page.h          |    1 
 include/linux/fs.h                  |    1 
 include/linux/highmem.h             |   11 
 mm/filemap.c                        |    2 
 mm/shmem.c                          |  683 ++++++++++++++++++++----------------
 7 files changed, 410 insertions(+), 307 deletions(-)

[PATCH] tmpfs 1/9 shmem_getpage unlock_page

shmem_getpage does need to lock its page (to secure it against
shmem_writepage), but it's easier for its callers if it unlocks
before returning.  The only caller who appeared to be using the
page lock was shmem_file_write, but it wasn't actually protecting
against anything - i_sem prevents concurrent writes and truncates,
and do_shmem_file_read was dropping the lock before copying anyway.

--- 2.5.43/mm/shmem.c	Sat Oct 12 08:26:10 2002
+++ tmpfs1/mm/shmem.c	Thu Oct 17 22:00:49 2002
@@ -737,6 +737,7 @@
 repeat:
 	page = find_lock_page(mapping, idx);
 	if (page) {
+		unlock_page(page);
 		*pagep = page;
 		return 0;
 	}
@@ -852,6 +853,7 @@
 	}
 
 	/* We have the page */
+	unlock_page(page);
 	*pagep = page;
 	return 0;
 }
@@ -879,8 +881,7 @@
 	}
 	spin_unlock(&info->lock);
 	if (swap.val) {
-		if (shmem_getpage(inode, idx, &page) == 0)
-			unlock_page(page);
+		(void) shmem_getpage(inode, idx, &page);
 	}
 	return page;
 }
@@ -903,7 +904,6 @@
 	if (error)
 		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
 
-	unlock_page(page);
 	flush_page_to_ram(page);
 	return page;
 }
@@ -1101,15 +1101,9 @@
 		}
 
 		/*
-		 * Bring in the user page that we will copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
+		 * We don't hold page lock across copy from user -
+		 * what would it guard against? - so no deadlock here.
 		 */
-		{ volatile unsigned char dummy;
-			__get_user(dummy, buf);
-			__get_user(dummy, buf+bytes-1);
-		}
 
 		status = shmem_getpage(inode, index, &page);
 		if (status)
@@ -1131,9 +1125,7 @@
 			if (pos > inode->i_size)
 				inode->i_size = pos;
 		}
-unlock:
-		/* Mark it unlocked again and drop the page.. */
-		unlock_page(page);
+release:
 		page_cache_release(page);
 
 		if (status < 0)
@@ -1152,7 +1144,7 @@
 fail_write:
 	status = -EFAULT;
 	ClearPageUptodate(page);
-	goto unlock;
+	goto release;
 }
 
 static void do_shmem_file_read(struct file *filp, loff_t *ppos, read_descriptor_t *desc)
@@ -1194,12 +1186,10 @@
 		if (index == end_index) {
 			nr = inode->i_size & ~PAGE_CACHE_MASK;
 			if (nr <= offset) {
-				unlock_page(page);
 				page_cache_release(page);
 				break;
 			}
 		}
-		unlock_page(page);
 		nr -= offset;
 
 		if (!list_empty(&mapping->i_mmap_shared))
@@ -1443,7 +1433,6 @@
 		memcpy(kaddr, symname, len);
 		kunmap(page);
 		set_page_dirty(page);
-		unlock_page(page);
 		page_cache_release(page);
 	}
 	dir->i_size += BOGO_DIRENT_SIZE;
@@ -1471,7 +1460,6 @@
 		return res;
 	res = vfs_readlink(dentry, buffer, buflen, kmap(page));
 	kunmap(page);
-	unlock_page(page);
 	page_cache_release(page);
 	return res;
 }
@@ -1484,7 +1472,6 @@
 		return res;
 	res = vfs_follow_link(nd, kmap(page));
 	kunmap(page);
-	unlock_page(page);
 	page_cache_release(page);
 	return res;
 }

