Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVI0Vrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVI0Vrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbVI0Vrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:47:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15326 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965170AbVI0Vro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:47:44 -0400
Message-ID: <4339BDF6.3070706@engr.sgi.com>
Date: Tue, 27 Sep 2005 14:47:34 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com> <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com> <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus> <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com> <4339AED4.8030108@engr.sgi.com>
In-Reply-To: <4339AED4.8030108@engr.sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> Hugh Dickins wrote:
> 
>> On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
>>
>>> What about calling
>>>
>>> static inline void grow_total_vm(struct mm_struct *mm, unsigned long 
>>> increase)
>>> {
>>>     mm->total_vm += increase;
>>>     if (mm->total_vm > mm->hiwater_vm)
>>>         mm->hiwater_vm = mm->total_vm;
>>> }
>>>
>>> whenever total_vm is increased and possibly doing something similar 
>>> for rss at
>>> different places? If it is not on the fast path then it's not 
>>> necessary to
>>> #ifdef the thing anywhere.
>>
>>
>>
>> I think there's a good argument for separating hiwater_vm and hiwater_rss
>> completely (and you don't seem to be interested in hiwater_rss yourself).
>>
>> hiwater_rss is on some fast paths: well, I don't see them as fast paths
>> myself (the page faults), but they are of exceptional concern to 
>> Christoph,
>> and the less we have to mess with struct mm at those points the 
>> happier he
>> is.  I guess hiwater_rss should remain updated from the timer tick for 
>> now.
>>
>> But I think you're right that hiwater_vm is best updated where total_vm
>> is: I'm not sure if it covers all cases completely (I think there's one
>> or two places which don't bother to call __vm_stat_account because they
>> believe it won't change anything), but in principle it would make lots of
>> sense to do it in the __vm_stat_account which typically follows adjusting
>> total_vm, as you did, and if possible nowhere else; rather than adding
>> your inline above.

Just looked at the __vm_stat_account() code. It is enclosed inside
#ifdef CONFIG_PROC_FS.

If that is necessary, i can not put hiwater_vm update code in there. The
system accounting code should not be dependent on a config flag that has
nothing to do with system accounting.

Thanks,
  - jay

> 
> 
> While in the work on separating hiwater_vm from hiwater_rss, i noticed
> that __vm_stat_account() was not called in these functions where
> total_vm was updated:
>     mm/mmap.c                           do_brk
>     mm/nommu.c                          do_mmap_pgoff
>     mm/nommu.c                          do_munmap
>     arch/ppc64/kernel/vdso.c            arch_setup_additional_pages
>     arch/x86_64/ia32/syscall32.c        syscall32_setup_pages
> 
> Frank tried to touch the latter two in his proposed patch.
> Does it make sense we add __vm_stat_account() calls to the above
> routines?
> 
> - jay
> 
> 
>>
>> Would you be satisfied with that, Christoph?
>>
>> I should warn you that I'll shortly (shortly meaning in days rather
>> than hours) be sending Andrew a patch which will remove the "__" from
>> __vm_stat_account, since the old vm_stat_account is now hardly used.
>> I'm also rearranging the rss,anon_rss accounting.  Maybe come back
>> to the hiwaters later on?
>>
>> Hugh
> 
> 

