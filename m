Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVCZQtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVCZQtq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 11:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVCZQtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 11:49:45 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:26117 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261173AbVCZQtj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 11:49:39 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] read_kmem() fixes
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 27 Mar 2005 01:49:14 +0900
Message-ID: <87wtrutks5.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/mem.c:289
		if (p < PAGE_SIZE && read > 0) {
			[...]
			read -= tmp;
			count -= tmp;

    This part is losting the number of bytes which read.

drivers/char/mem.c:302
			sz = min_t(unsigned long, sz, count);

    This should use "read" instead of "count".

drivers/char/mem.c:315
			read -= sz;
			count -= sz;

    Also lost the number of bytes which read.


In short, kmem returns incorrect number always if user is accessing
the lowmem area. And also it doesn't handle the highmem boundary
rightly.

This patch uses "low_count" instead of "read", as the number of copy
in lowmem area. And "read" is used as the number of bytes which read.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 drivers/char/mem.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff -puN drivers/char/mem.c~read_kmem-broken-fix drivers/char/mem.c
--- linux-2.6.12-rc1/drivers/char/mem.c~read_kmem-broken-fix	2005-03-26 11:51:31.000000000 +0900
+++ linux-2.6.12-rc1-hirofumi/drivers/char/mem.c	2005-03-26 11:53:16.000000000 +0900
@@ -267,30 +267,30 @@ static ssize_t read_kmem(struct file *fi
 			 size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	ssize_t read, virtr, sz;
+	ssize_t low_count, read, sz;
 	char * kbuf; /* k-addr because vread() takes vmlist_lock rwlock */
 
 	read = 0;
-	virtr = 0;
 	if (p < (unsigned long) high_memory) {
-		read = count;
+		low_count = count;
 		if (count > (unsigned long) high_memory - p)
-			read = (unsigned long) high_memory - p;
+			low_count = (unsigned long) high_memory - p;
 
 #ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
 		/* we don't have page 0 mapped on sparc and m68k.. */
-		if (p < PAGE_SIZE && read > 0) {
+		if (p < PAGE_SIZE && low_count > 0) {
 			size_t tmp = PAGE_SIZE - p;
-			if (tmp > read) tmp = read;
+			if (tmp > low_count) tmp = low_count;
 			if (clear_user(buf, tmp))
 				return -EFAULT;
 			buf += tmp;
 			p += tmp;
-			read -= tmp;
+			read += tmp;
+			low_count -= tmp;
 			count -= tmp;
 		}
 #endif
-		while (read > 0) {
+		while (low_count > 0) {
 			/*
 			 * Handle first page in case it's not aligned
 			 */
@@ -299,7 +299,7 @@ static ssize_t read_kmem(struct file *fi
 			else
 				sz = PAGE_SIZE;
 
-			sz = min_t(unsigned long, sz, count);
+			sz = min_t(unsigned long, sz, low_count);
 
 			/*
 			 * On ia64 if a page has been mapped somewhere as
@@ -312,7 +312,8 @@ static ssize_t read_kmem(struct file *fi
 				return -EFAULT;
 			buf += sz;
 			p += sz;
-			read -= sz;
+			read += sz;
+			low_count -= sz;
 			count -= sz;
 		}
 	}
@@ -335,13 +336,13 @@ static ssize_t read_kmem(struct file *fi
 			}
 			count -= len;
 			buf += len;
-			virtr += len;
+			read += len;
 			p += len;
 		}
 		free_page((unsigned long)kbuf);
 	}
  	*ppos = p;
- 	return virtr + read;
+ 	return read;
 }
 
 
_
