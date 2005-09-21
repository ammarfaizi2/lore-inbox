Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVIUSGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVIUSGX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVIUSGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:06:23 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:57507 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751340AbVIUSGW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:06:22 -0400
Date: Wed, 21 Sep 2005 20:06:21 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>, Hugh Dickins <hugh@veritas.com>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
Message-ID: <20050921180621.GA17272@janus>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.62.0509211000470.10480@schroedinger.engr.sgi.com> <43319AB5.8030103@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43319AB5.8030103@engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 10:39:01AM -0700, Jay Lan wrote:
> 
> Frank's patch looks fine to me except one place:
> diff -ru a/mm/mmap.c b/mm/mmap.c
> --- a/mm/mmap.c	2005-09-21 11:07:40.000000000 +0200
> +++ b/mm/mmap.c	2005-09-21 11:17:06.755572000 +0200
> @@ -854,6 +854,7 @@
>  		mm->stack_vm += pages;
>  	if (flags & (VM_RESERVED|VM_IO))
>  		mm->reserved_vm += pages;
> +	update_mem_hiwater(mm);
>  }
>  #endif /* CONFIG_PROC_FS */
> 
> I have a question of adding this call here. 'update_mem_hiwater'
> does nothing unless mm->total_vm or rss gets updated.
> I do not see total_vm get updates in __vm_stat_account()?

Check the callers of __vm_stat_account(). It is called at various places
after increasing (sometimes decreasing) vm_total.

BTW, __vm_stat_account() itself is surrounded by #ifdef CONFIG_PROC_FS so
I'd thought that that might be appropriate for hiwater_* too. So far they are
set but are not read except by my patch for /proc/pid/status.

in 2.6.13.2:

$ find -type f|xargs grep hiwater_rss
./kernel/fork.c:        mm->hiwater_rss = get_mm_counter(mm,rss);
./include/linux/sched.h:        unsigned long hiwater_rss;      /* High-water RSS usage */
./mm/memory.c:          if (tsk->mm->hiwater_rss < rss)
./mm/memory.c:                  tsk->mm->hiwater_rss = rss;
./mm/nommu.c:           if (tsk->mm->hiwater_rss < rss)
./mm/nommu.c:                   tsk->mm->hiwater_rss = rss;

$ find -type f|xargs grep hiwater_vm 
./kernel/fork.c:        mm->hiwater_vm = mm->total_vm;
./include/linux/sched.h:        unsigned long hiwater_vm;       /* High-water virtual memory usage */
./mm/memory.c:          if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
./mm/memory.c:                  tsk->mm->hiwater_vm = tsk->mm->total_vm;
./mm/nommu.c:           if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
./mm/nommu.c:                   tsk->mm->hiwater_vm = tsk->mm->total_vm;

The matches in mm/memory.c and mm/nommu.c are in function update_mem_hiwater().

-- 
Frank
