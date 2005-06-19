Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVFSQtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVFSQtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 12:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVFSQtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 12:49:50 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:31286 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262262AbVFSQtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 12:49:36 -0400
Message-ID: <42B5A21B.5030300@ntlworld.com>
Date: Sun, 19 Jun 2005 17:49:31 +0100
From: Matt Keenan <matthew.keenan@ntlworld.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Bug #3054 madvise(MADV_WILLNEED,...) fix for exceeding rlimit
 rss
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated patch for 2.6.12, can it be included in -mm for 
testing? I have been banging on the code for an hour or so now; no probs.

Matt

--- linux-2.6.11.7/mm/madvise.c 2005-04-12 15:58:30.000000000 +0100
+++ linux/mm/madvise.c  2005-06-19 17:20:56.000000000 +0100
@@ -61,6 +61,7 @@ static long madvise_willneed(struct vm_a
                             unsigned long start, unsigned long end)
 {
        struct file *file = vma->vm_file;
+       struct task_struct *tsk = current;

        if (!file)
                return -EBADF;
@@ -70,6 +71,28 @@ static long madvise_willneed(struct vm_a
                end = vma->vm_end;
        end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;

+       /*
+        * This code below checks to see if mapping the requested
+        * readahead would make the task's rss exceed the task's
+        * rlimit rss.
+        *
+        * This doesn't account for pages that may already be mapped
+        * due to readahead, but since this is merely a hint to the
+        * kernel no harm should be done, it won't unmap anything
+        * already mapped if it fails. N.B. This won't affect the
+        * kernel's internal automatic readahead which doesn't check
+        * (or honour) rlimit rss.
+        */
+
+       spin_lock(&tsk->mm->page_table_lock);
+       if (((max_sane_readahead(end-start) << PAGE_SHIFT) +
+           tsk->mm->_rss) > tsk->signal->rlim[RLIMIT_RSS].rlim_cur)
+       {
+               spin_unlock(&tsk->mm->page_table_lock);
+               return -EIO;
+       }
+       spin_unlock(&tsk->mm->page_table_lock);
+
        force_page_cache_readahead(file->f_mapping,
                        file, start, max_sane_readahead(end - start));
        return 0;
@@ -170,6 +193,8 @@ static long madvise_vma(struct vm_area_s
  *  -ENOMEM - addresses in the specified range are not currently
  *             mapped, or are outside the AS of the process.
  *  -EIO    - an I/O error occurred while paging in data.
+ *          - MADV_WILLNEED would map in pages that would make the task's
+ *              rss exceed rlimit rss.
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
  */

