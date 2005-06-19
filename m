Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVFSVJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVFSVJy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 17:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVFSVJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 17:09:42 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:61459 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261325AbVFSVJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 17:09:27 -0400
Message-ID: <42B5DF04.6040505@ntlworld.com>
Date: Sun, 19 Jun 2005 22:09:24 +0100
From: Matt Keenan <matthew.keenan@ntlworld.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bug #3054 madvise(MADV_WILLNEED,...) fix for exceeding
 rlimit rss
References: <42B5A21B.5030300@ntlworld.com> <20050619202333.GZ9153@shell0.pdx.osdl.net>
In-Reply-To: <20050619202333.GZ9153@shell0.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------060801030706020409030507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060801030706020409030507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:

>* Matt Keenan (matthew.keenan@ntlworld.com) wrote:
>  
>
>>--- linux-2.6.11.7/mm/madvise.c 2005-04-12 15:58:30.000000000 +0100
>>+++ linux/mm/madvise.c  2005-06-19 17:20:56.000000000 +0100
>>@@ -61,6 +61,7 @@ static long madvise_willneed(struct vm_a
>>                            unsigned long start, unsigned long end)
>>{
>>       struct file *file = vma->vm_file;
>>+       struct task_struct *tsk = current;
>>    
>>
>
>Looks like you've got some tab/whitespace damage going on here.
>
>  
>
Damn mailer! I might have to go back to mutt.

>>       if (!file)
>>               return -EBADF;
>>@@ -70,6 +71,28 @@ static long madvise_willneed(struct vm_a
>>               end = vma->vm_end;
>>       end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
>>
>>+       /*
>>+        * This code below checks to see if mapping the requested
>>+        * readahead would make the task's rss exceed the task's
>>+        * rlimit rss.
>>+        *
>>+        * This doesn't account for pages that may already be mapped
>>+        * due to readahead, but since this is merely a hint to the
>>+        * kernel no harm should be done, it won't unmap anything
>>+        * already mapped if it fails. N.B. This won't affect the
>>+        * kernel's internal automatic readahead which doesn't check
>>+        * (or honour) rlimit rss.
>>+        */
>>+
>>+       spin_lock(&tsk->mm->page_table_lock);
>>+       if (((max_sane_readahead(end-start) << PAGE_SHIFT) +
>>+           tsk->mm->_rss) > tsk->signal->rlim[RLIMIT_RSS].rlim_cur)
>>    
>>
>
>I doubt this one would overflow, but we recenly made changes in similar
>tests to use page count rather than byte count.  I belive this should
>use get_mm_counter().  Isn't _rss counting pages rather than bytes,
>so I think the math is off here.  Something like:
>
>	if ((max_sane_readahead(end - start) + get_mm_counter(tsk->mm, rss)) >
>	    tsk->signal->rlim[RLIMIT_RSS].rlim_cur >> PAGE_SHIFT)
>
>  
>
Ok, here is the patch again with the suggested fixes. I have attached 
the patch (yes yes i know!), that will probably screw up people's mail 
-> patch generators, but the whitespace issue should be fixed. Hopefully 
this is ok, I'm going to bang on it for an hour or so here to make sure.

Signed-off-by: Matthew Keenan <matthew.keenan@ntlworld.com>



--------------060801030706020409030507
Content-Type: text/x-patch;
 name="patch-2.6.12-madvise-willneed-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.12-madvise-willneed-fix.diff"

--- linux-2.6.11.7/mm/madvise.c	2005-04-12 15:58:30.000000000 +0100
+++ linux/mm/madvise.c	2005-06-19 21:39:57.000000000 +0100
@@ -61,6 +61,7 @@ static long madvise_willneed(struct vm_a
 			     unsigned long start, unsigned long end)
 {
 	struct file *file = vma->vm_file;
+	struct task_struct *tsk = current;
 
 	if (!file)
 		return -EBADF;
@@ -70,6 +71,28 @@ static long madvise_willneed(struct vm_a
 		end = vma->vm_end;
 	end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 
+	/*
+	 * This code below checks to see if mapping the requested
+	 * readahead would make the task's rss exceed the task's
+	 * rlimit rss.
+	 *
+	 * This doesn't account for pages that may already be mapped
+	 * due to readahead, but since this is merely a hint to the
+	 * kernel no harm should be done, it won't unmap anything
+	 * already mapped if it fails. N.B. This won't affect the
+	 * kernel's internal automatic readahead which doesn't check
+	 * (or honour) rlimit rss.
+	 */
+
+	spin_lock(&tsk->mm->page_table_lock);
+	if ((max_sane_readahead(end - start) + get_mm_counter(tsk->mm, rss)) >
+	    (tsk->signal->rlim[RLIMIT_RSS].rlim_cur >> PAGE_SHIFT))
+	{
+		spin_unlock(&tsk->mm->page_table_lock);
+		return -EIO;
+	}
+	spin_unlock(&tsk->mm->page_table_lock);
+
 	force_page_cache_readahead(file->f_mapping,
 			file, start, max_sane_readahead(end - start));
 	return 0;
@@ -170,6 +193,8 @@ static long madvise_vma(struct vm_area_s
  *  -ENOMEM - addresses in the specified range are not currently
  *		mapped, or are outside the AS of the process.
  *  -EIO    - an I/O error occurred while paging in data.
+ *          - MADV_WILLNEED would map in pages that would make the task's
+ *              rss exceed rlimit rss.
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
  */

--------------060801030706020409030507--
