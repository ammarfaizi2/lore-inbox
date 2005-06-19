Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVFSUX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVFSUX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 16:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVFSUX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 16:23:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262271AbVFSUXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 16:23:39 -0400
Date: Sun, 19 Jun 2005 13:23:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: Matt Keenan <matthew.keenan@ntlworld.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bug #3054 madvise(MADV_WILLNEED,...) fix for exceeding rlimit rss
Message-ID: <20050619202333.GZ9153@shell0.pdx.osdl.net>
References: <42B5A21B.5030300@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B5A21B.5030300@ntlworld.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Keenan (matthew.keenan@ntlworld.com) wrote:
> --- linux-2.6.11.7/mm/madvise.c 2005-04-12 15:58:30.000000000 +0100
> +++ linux/mm/madvise.c  2005-06-19 17:20:56.000000000 +0100
> @@ -61,6 +61,7 @@ static long madvise_willneed(struct vm_a
>                             unsigned long start, unsigned long end)
> {
>        struct file *file = vma->vm_file;
> +       struct task_struct *tsk = current;

Looks like you've got some tab/whitespace damage going on here.

>        if (!file)
>                return -EBADF;
> @@ -70,6 +71,28 @@ static long madvise_willneed(struct vm_a
>                end = vma->vm_end;
>        end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
> 
> +       /*
> +        * This code below checks to see if mapping the requested
> +        * readahead would make the task's rss exceed the task's
> +        * rlimit rss.
> +        *
> +        * This doesn't account for pages that may already be mapped
> +        * due to readahead, but since this is merely a hint to the
> +        * kernel no harm should be done, it won't unmap anything
> +        * already mapped if it fails. N.B. This won't affect the
> +        * kernel's internal automatic readahead which doesn't check
> +        * (or honour) rlimit rss.
> +        */
> +
> +       spin_lock(&tsk->mm->page_table_lock);
> +       if (((max_sane_readahead(end-start) << PAGE_SHIFT) +
> +           tsk->mm->_rss) > tsk->signal->rlim[RLIMIT_RSS].rlim_cur)

I doubt this one would overflow, but we recenly made changes in similar
tests to use page count rather than byte count.  I belive this should
use get_mm_counter().  Isn't _rss counting pages rather than bytes,
so I think the math is off here.  Something like:

	if ((max_sane_readahead(end - start) + get_mm_counter(tsk->mm, rss)) >
	    tsk->signal->rlim[RLIMIT_RSS].rlim_cur >> PAGE_SHIFT)

thanks,
-chris
