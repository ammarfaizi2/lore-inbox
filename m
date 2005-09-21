Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbVIUSim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVIUSim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVIUSil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:38:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:55729 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751368AbVIUSil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:38:41 -0400
Message-ID: <4331A88C.4080109@engr.sgi.com>
Date: Wed, 21 Sep 2005 11:38:04 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, zh-tw, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@frankvm.com>
CC: Christoph Lameter <clameter@engr.sgi.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.62.0509211000470.10480@schroedinger.engr.sgi.com> <43319AB5.8030103@engr.sgi.com> <20050921180621.GA17272@janus>
In-Reply-To: <20050921180621.GA17272@janus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:
> On Wed, Sep 21, 2005 at 10:39:01AM -0700, Jay Lan wrote:
> 
>>Frank's patch looks fine to me except one place:
>>diff -ru a/mm/mmap.c b/mm/mmap.c
>>--- a/mm/mmap.c	2005-09-21 11:07:40.000000000 +0200
>>+++ b/mm/mmap.c	2005-09-21 11:17:06.755572000 +0200
>>@@ -854,6 +854,7 @@
>> 		mm->stack_vm += pages;
>> 	if (flags & (VM_RESERVED|VM_IO))
>> 		mm->reserved_vm += pages;
>>+	update_mem_hiwater(mm);
>> }
>> #endif /* CONFIG_PROC_FS */
>>
>>I have a question of adding this call here. 'update_mem_hiwater'
>>does nothing unless mm->total_vm or rss gets updated.
>>I do not see total_vm get updates in __vm_stat_account()?
> 
> 
> Check the callers of __vm_stat_account(). It is called at various places
> after increasing (sometimes decreasing) vm_total.

Sounds good.

- jay


> 
> BTW, __vm_stat_account() itself is surrounded by #ifdef CONFIG_PROC_FS so
> I'd thought that that might be appropriate for hiwater_* too. So far they are
> set but are not read except by my patch for /proc/pid/status. >
> in 2.6.13.2:
> 
> $ find -type f|xargs grep hiwater_rss
> ./kernel/fork.c:        mm->hiwater_rss = get_mm_counter(mm,rss);
> ./include/linux/sched.h:        unsigned long hiwater_rss;      /* High-water RSS usage */
> ./mm/memory.c:          if (tsk->mm->hiwater_rss < rss)
> ./mm/memory.c:                  tsk->mm->hiwater_rss = rss;
> ./mm/nommu.c:           if (tsk->mm->hiwater_rss < rss)
> ./mm/nommu.c:                   tsk->mm->hiwater_rss = rss;
> 
> $ find -type f|xargs grep hiwater_vm 
> ./kernel/fork.c:        mm->hiwater_vm = mm->total_vm;
> ./include/linux/sched.h:        unsigned long hiwater_vm;       /* High-water virtual memory usage */
> ./mm/memory.c:          if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
> ./mm/memory.c:                  tsk->mm->hiwater_vm = tsk->mm->total_vm;
> ./mm/nommu.c:           if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
> ./mm/nommu.c:                   tsk->mm->hiwater_vm = tsk->mm->total_vm;
> 
> The matches in mm/memory.c and mm/nommu.c are in function update_mem_hiwater().
> 

