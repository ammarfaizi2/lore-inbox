Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbUKVWNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbUKVWNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbUKVWLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:11:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:29420 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262399AbUKVWIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:08:31 -0500
Date: Mon, 22 Nov 2004 14:11:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: hugh@veritas.com, torvalds@osdl.org, benh@kernel.crashing.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: deferred rss update instead of sloppy rss
Message-Id: <20041122141148.1e6ef125.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> One way to solve the rss issues is--as discussed--to put rss into the
> task structure and then have the page fault increment that rss.
> 
> The problem is then that the proc filesystem must do an extensive scan
> over all threads to find users of a certain mm_struct.
> 
> The following patch does put the rss into task_struct. The page fault
> handler is then incrementing current->rss if the page_table_lock is not
> held.
> 
> The timer interrupt checks if task->rss is non zero (when doing
> stime/utime updates. rss is defined near those so its hopefully on the
> same cacheline and has a minimal impact).
> 
> If rss is non zero and the page_table_lock and the mmap_sem can be taken
> then the mm->rss will be updated by the value of the task->rss and
> task->rss will be zeroed. This avoids all proc issues. The only
> disadvantage is that rss may be inaccurate for a couple of clock ticks.
> 
> This also adds some performance (sorry only a 4p system):
> 
> sloppy rss:
> 
> Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>   4  10    1    0.593s     29.897s  30.050s 85973.585  85948.565
>   4  10    2    0.616s     42.184s  22.045s 61247.450 116719.558
>   4  10    4    0.559s     44.918s  14.076s 57641.255 177553.945
> 
> deferred rss:
>  Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>   4  10    1    0.565s     29.429s  30.000s 87395.518  87366.580
>   4  10    2    0.500s     33.514s  18.002s 77067.935 145426.659
>   4  10    4    0.533s     44.455s  14.085s 58269.368 176413.196

hrm.  I cannot see anywhere in this patch where you update task_struct.rss.

> Index: linux-2.6.9/kernel/exit.c
> ===================================================================
> --- linux-2.6.9.orig/kernel/exit.c	2004-11-22 09:51:58.000000000 -0800
> +++ linux-2.6.9/kernel/exit.c	2004-11-22 11:16:02.000000000 -0800
> @@ -501,6 +501,9 @@
>  	/* more a memory barrier than a real lock */
>  	task_lock(tsk);
>  	tsk->mm = NULL;
> +	/* only holding mmap_sem here maybe get page_table_lock too? */
> +	mm->rss += tsk->rss;
> +	tsk->rss = 0;
>  	up_read(&mm->mmap_sem);

mmap_sem needs to be held for writing, surely?

> +	/* Update mm->rss if necessary */
> +	if (p->rss && p->mm && down_write_trylock(&p->mm->mmap_sem)) {
> +		if (spin_trylock(&p->mm->page_table_lock)) {
> +			p->mm->rss += p->rss;
> +			p->rss = 0;
> +			spin_unlock(&p->mm->page_table_lock);
> +		}
> +		up_write(&p->mm->mmap_sem);
> +	}
>  }

I'd also suggest that you do:

	tsk->rss++;
	if (tsk->rss > 16) {
		spin_lock(&mm->page_table_lock);
		mm->rss += tsk->rss;
		spin_unlock(&mm->page_table_lock);
		tsk->rss = 0;
	}

just to prevent transient gross inaccuracies.  For some value of "16".
