Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268149AbUIWDBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbUIWDBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 23:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUIWDBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 23:01:12 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:857 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268149AbUIWDBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:01:00 -0400
Message-ID: <41523C66.3080508@yahoo.com.au>
Date: Thu, 23 Sep 2004 13:00:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
References: <20040922131210.6c08b94c.akpm@osdl.org>
In-Reply-To: <20040922131210.6c08b94c.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020704050406000503060606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020704050406000503060606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm2/
> 

fs/dcache.c:select_parent()
{
...
                 /*
                  * select_parent() is a performance optimization, it is
                  * not necessary to complete it. Abort if a reschedule is
                  * pending:
                  */
                 if (need_resched())
                         goto out;
...
}

This one came back. It is the
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
thing.

Attached is a fix.

--------------020704050406000503060606
Content-Type: text/x-patch;
 name="sched-vfs-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-vfs-fix.patch"




---

 linux-2.6-npiggin/fs/dcache.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff -puN fs/dcache.c~sched-vfs-fix fs/dcache.c
--- linux-2.6/fs/dcache.c~sched-vfs-fix	2004-09-23 12:53:04.000000000 +1000
+++ linux-2.6-npiggin/fs/dcache.c	2004-09-23 12:59:25.000000000 +1000
@@ -156,7 +156,7 @@ repeat:
 		spin_unlock(&dcache_lock);
 		return;
 	}
-			
+
 	/*
 	 * AV: ->d_delete() is _NOT_ allowed to block now.
 	 */
@@ -540,6 +540,13 @@ positive:
  * list for prune_dcache(). We descend to the next level
  * whenever the d_subdirs list is non-empty and continue
  * searching.
+ *
+ * It returns zero iff there are no unused children,
+ * otherwise  it returns the number of children moved to
+ * the end of the unused list. This may not be the total
+ * number of unused children, because select_parent can
+ * drop the lock and return early due to latency
+ * constraints.
  */
 static int select_parent(struct dentry * parent)
 {
@@ -556,14 +563,6 @@ resume:
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
 
-		/*
-		 * select_parent() is a performance optimization, it is
-		 * not necessary to complete it. Abort if a reschedule is
-		 * pending:
-		 */
-		if (need_resched())
-			goto out;
-
 		if (!list_empty(&dentry->d_lru)) {
 			dentry_stat.nr_unused--;
 			list_del_init(&dentry->d_lru);
@@ -577,6 +576,15 @@ resume:
 			dentry_stat.nr_unused++;
 			found++;
 		}
+
+		/*
+		 * We can return to the caller if we have found some (this
+		 * ensures forward progress). We'll be coming back to find
+		 * the rest.
+		 */
+		if (found && need_resched())
+			goto out;
+
 		/*
 		 * Descend a level if the d_subdirs list is non-empty.
 		 */

_

--------------020704050406000503060606--
