Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315050AbSENCO7>; Mon, 13 May 2002 22:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315091AbSENCO6>; Mon, 13 May 2002 22:14:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43275 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315050AbSENCO5>;
	Mon, 13 May 2002 22:14:57 -0400
Message-ID: <3CE073FA.57DAC578@zip.com.au>
Date: Mon, 13 May 2002 19:18:34 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] iowait statistics
In-Reply-To: <Pine.LNX.4.44L.0205132214480.32261-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> Hi,
> 
> the following patch implements iowait statistics in a simple way:
> 
> 1) if we go to sleep while waiting on a page or buffer, we
>    increment nr_iowait_tasks, note that this is done only in
>    the slow path so overhead shouldn't even be measurable
> 
> 2) if no process is running, the timer interrupt adds a jiffy
>    to the iowait time
> 
> 3) iowait time is counted separately from user/system/idle and
>    can overlap with either system or idle (when no process is
>    running the system can still be busy processing interrupts)
> 
> 4) on SMP systems the iowait time can be overestimated, no big
>    deal IMHO but cheap suggestions for improvement are welcome

I suspect that a number of these statistical accounting mechanisms
are going to break.  The new irq-affinity code works awfully well.

The kernel profiler in 2.5 doesn't work very well at present.
When investigating this, I ran a busy-wait process.  It attached
itself to CPU #3 and that CPU received precisely zero interrupts
across a five minute period.  So the profiler cunningly avoids profiling
busy CPUs, which is rather counter-productive.  Fortunate that oprofile
uses NMI.

> ...
> ===== fs/buffer.c 1.64 vs edited =====
> --- 1.64/fs/buffer.c    Mon May 13 19:04:59 2002
> +++ edited/fs/buffer.c  Mon May 13 19:16:57 2002
> @@ -156,8 +156,10 @@
>         get_bh(bh);
>         add_wait_queue(&bh->b_wait, &wait);
>         do {
> +               atomic_inc(&nr_iowait_tasks);
>                 run_task_queue(&tq_disk);
>                 set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> +               atomic_dec(&nr_iowait_tasks);
>                 if (!buffer_locked(bh))
>                         break;
>                 schedule();

Shouldn't the atomic_inc cover the schedule()?


-
