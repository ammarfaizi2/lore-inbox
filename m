Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132009AbRCYOn4>; Sun, 25 Mar 2001 09:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132008AbRCYOnq>; Sun, 25 Mar 2001 09:43:46 -0500
Received: from [195.63.194.11] ([195.63.194.11]:5382 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S132006AbRCYOn0>;
	Sun, 25 Mar 2001 09:43:26 -0500
Message-ID: <3ABE0105.4155F5CD@evision-ventures.com>
Date: Sun, 25 Mar 2001 16:30:29 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jonathan Morton <chromi@cyberspace.org>
CC: Doug Ledford <dledford@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3ABCE547.DD5E78B9@redhat.com>
	 <Pine.LNX.4.33.0103241039590.2310-100000@mikeg.weiden.de> <l0313031ab6e2b9537342@[192.168.239.101]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton wrote:
> 
> >Right now my best approximation is to make the OOM test be as optimistic as
> >it is safe to be, and the vm_enough_memory() test as pessimistic as
> >sensible.  Expect a test patch to appear on this list soon.
> 
> ...and here it is!
> 
> This fixes a number of small but linked problems:
> 
> - malloc() never returned 0 when the system ran out of memory, instead the OOM killer was triggered.  Now, malloc() will return 0 if the calling process is more than 4 times the size of the amount of free memory.  As a speedup, available swap space is not considered unless physical memory is not sufficient to contain the process.  Note that if overcommit_memory is switched on, malloc() will never return 0 anyway.
> 
> - OOM killer was triggered too early - now takes account of buffer and cache memory, which can be cannibalised before the system has completely run out.
> 
> - OOM killer badness() factors readjusted in favour of Oracle-like processes (consuming 10's of MB of RAM but up for 3 days or so and with a low-order UID?  Now less likely to be killed...)
> 
> --- begin oom-patch.diff ---
> diff -u linux-2.4.1.orig/mm/mmap.c linux/mm/mmap.c
> --- linux-2.4.1.orig/mm/mmap.c  Mon Jan 29 16:10:41 2001
> +++ linux/mm/mmap.c     Sat Mar 24 19:29:51 2001
> @@ -54,6 +54,7 @@
>          */
> 
>         long free;
> +       struct sysinfo swp_info;
> 
>          /* Sometimes we want to use more memory than we have. */
>         if (sysctl_overcommit_memory)
> @@ -62,8 +63,32 @@
>         free = atomic_read(&buffermem_pages);
>         free += atomic_read(&page_cache_size);
>         free += nr_free_pages();
> -       free += nr_swap_pages;
> -       return free > pages;
> +
> +       /* Attempt to curtail memory allocations before hard OOM occurs.
> +        * Based on current process size, which is hopefully a good and fast heuristic.
> +        * Also fix bug where the real OOM limit of (free == freepages.min) is not taken into account.
> +        * In fact, we use freepages.high as the threshold to make sure there's still room for buffers+cache.
> +        *
> +        * -- Jonathan "Chromatix" Morton, 24th March 2001
> +        */
> +
> +       if(current && current->mm)
> +         free -= (current->mm->total_vm / 4);
> +
> +       free -= freepages.high;
> +
> +       /* Since getting swap info is expensive, see if our allocation can happen in physical RAM */
> +       if(free > pages)
> +         return 1;
> +
> +       /* Use the number of FREE swap pages, not the total */
> +       si_swapinfo(&swp_info);
> +       free += swp_info.freeswap;
> +
> +       if(free > pages)
> +         return 1;
> +
> +       return 0;
>  }
> 
>  /* Remove one vm structure from the inode's i_mapping address space. */
> Only in linux/mm/: mmap.c~
> diff -u linux-2.4.1.orig/mm/oom_kill.c linux/mm/oom_kill.c
> --- linux-2.4.1.orig/mm/oom_kill.c      Tue Nov 14 18:56:46 2000
> +++ linux/mm/oom_kill.c Sat Mar 24 20:35:20 2001
> @@ -76,7 +76,9 @@
>         run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
> 
>         points /= int_sqrt(cpu_time);
> -       points /= int_sqrt(int_sqrt(run_time));
> +
> +       /* Long-running processes are *very* important, so don't take the 4th root */
> +       points /= run_time;
> 
>         /*
>          * Niced processes are most likely less important, so double
> @@ -93,6 +95,10 @@
>                                 p->uid == 0 || p->euid == 0)
>                 points /= 4;
> 
> +       /* Much the same goes for processes with low UIDs */
> +       if(p->uid < 100 || p->euid < 100)
> +         points /= 2;
> +
>         /*
>          * We don't want to kill a process with direct hardware access.
>          * Not only could that mess up the hardware, but usually users
> @@ -192,12 +198,20 @@
>  int out_of_memory(void)
>  {
>         struct sysinfo swp_info;
> +       long free;
> 
>         /* Enough free memory?  Not OOM. */
> -       if (nr_free_pages() > freepages.min)
> +       free = nr_free_pages();
> +       if (free > freepages.min)
> +               return 0;
> +
> +       if (free + nr_inactive_clean_pages() > freepages.low)
>                 return 0;
> 
> -       if (nr_free_pages() + nr_inactive_clean_pages() > freepages.low)
> +       /* Buffers and caches can be freed up (Jonathan "Chromatix" Morton) */
> +       free += atomic_read(&buffermem_pages);
> +       free += atomic_read(&page_cache_size);
> +       if (free > freepages.low)
>                 return 0;

Ahh this will make the oom killer robust against misbalanced
MM. I will assimiliate this idea.
