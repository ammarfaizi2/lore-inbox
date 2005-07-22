Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVGVTIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVGVTIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 15:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVGVTIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 15:08:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51361 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262138AbVGVTIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 15:08:40 -0400
Date: Fri, 22 Jul 2005 15:08:31 -0400
From: Neil Horman <nhorman@redhat.com>
To: =?iso-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>
Cc: nhorman@redhat.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Memory Management
Message-ID: <20050722190831.GE15660@hmsendeavour.rdu.redhat.com>
References: <42DF9646.5070806@latinsourcetech.com> <20050721131132.GB11327@hmsendeavour.rdu.redhat.com> <42DFA5E6.1080302@latinsourcetech.com> <20050722140227.GA15660@hmsendeavour.rdu.redhat.com> <42E10394.3090607@latinsourcetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42E10394.3090607@latinsourcetech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 11:32:52AM -0300, Márcio Oliveira wrote:
> Neil Horman wrote:
> 
> >On Thu, Jul 21, 2005 at 10:40:54AM -0300, Márcio Oliveira wrote:
> > 
> >
> >>>http://people.redhat.com/nhorman/papers/rhel3_vm.pdf
> >>>I wrote this with norm awhile back.  It may help you out.
> >>>Regards
> >>>Neil
> >>>
> >>>
> >>>     
> >>>
> >>Neil,
> >>
> >> Thanks.~10-12GB of total RAM (16GB) are
> >>
> >> How can Proc virtual memory parameters like inactive_clean_percent, 
> >>overcommit_memory, overcommit_ratio and page_cache help me to solve / 
> >>reduce Out Of Memory conditions on servers with 16GB RAM and lots of GB 
> >>swap?
> >>
> >>   
> >>
> >I wouldn't touch memory overcommit if you are already seeing out of memory
> >issues.  If you are using lots of pagecache, I would suggest increasing
> >inactive_clean percent, reducing the pagecahce.max value, and modifying the
> >bdflush parameters in the above document such that bdflush runs sooner, 
> >more
> >often, and does more work per iteration.  This will help you move data in
> >pagecache back to disk more aggressively so that memory will be available 
> >for
> >other purposes, like heap allocations. Also if you're using a Red Hat 
> >kernel and
> >you have 16GB of ram in your system, you're a good candidate for the 
> >hugemem
> >kernel.  Rather than a straightforward out of memory condition, you may be
> >seeing a exhaustion of your kernels address space (check LowFree in
> >/proc/meminfo).  In this even the hugemem kernel will help you in that it
> >increases your Low Memory address space from 1GB to 4GB, preventing some 
> >OOM
> >conditions.
> >
> >
> > 
> >
> >> Kernel does not free cached memory (~10-12GB of total RAM - 16GB). Is 
> >>there some way to force the kernel to free cached memory?
> >>
> >>   
> >>
> >Cached memory is freed on demand.  Just because its listed under the 
> >cached line
> >below doesn't mean it can't be freed and used for another purpose.  
> >Implement
> >the tunings above, and your situation should improve.
> >
> >Regards
> >Neil
> >
> > 
> >
> >>/proc/meminfo:
> >>
> >>            total:    used:    free:  shared: buffers:  cached:
> >>Mem:    16603488256 16523333632 80154624        0 70651904 13194563584
> >>Swap:   17174257664 11771904 17162485760
> >>MemTotal:     16214344 kB
> >>MemFree:         78276 kB
> >>Buffers:         68996 kB
> >>Cached:       12874808 kB
> >>
> >>Thanks to all.
> >>
> >>Marcio.
> >>   
> >>
> 
> Neil,
> 
>   Thanks for the answers!
> 
> The following lines are the Out Of Memory log:
> 
> Jul 20 13:45:44 server kernel: Out of Memory: Killed process 23716 (oracle).
> Jul 20 13:45:44 server kernel: Fixed up OOM kill of mm-less task
> Jul 20 13:45:45 server su(pam_unix)[3848]: session closed for user root
> Jul 20 13:45:48 server kernel: Mem-info:
> Jul 20 13:45:48 server kernel: Zone:DMA freepages:  1884 min:     0 
> low:     0 high:     0
> Jul 20 13:45:48 server kernel: Zone:Normal freepages:  1084 min:  1279 
> low:  4544 high:  6304
> Jul 20 13:45:48 server kernel: Zone:HighMem freepages:386679 min:   255 
> low: 61952 high: 92928
> Jul 20 13:45:48 server kernel: Free pages:      389647 (386679 HighMem)
> Jul 20 13:45:48 server kernel: ( Active: 2259787/488777, 
> inactive_laundry: 244282, inactive_clean: 244366, free: 389647 )
> Jul 20 13:45:48 server kernel:   aa:0 ac:0 id:0 il:0 ic:0 fr:1884
> Jul 20 13:45:48 server kernel:   aa:1620 ac:1801 id:231 il:15 ic:0 fr:1085
> Jul 20 13:45:48 server kernel:   aa:1099230 ac:1157136 id:488536 
> il:244277 ic:244366 fr:386679
> Jul 20 13:45:48 server kernel: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 
> 1*256kB 0*512kB 1*1024kB 1*2048kB 1*4096kB = 7536kB)Jul 20 13:45:48 
> server kernel: 55*4kB 9*8kB 19*16kB 9*32kB 0*64kB 1*128kB 1*256kB 
> 0*512kB 1*1024kB 1*2048kB 0*4096kB = 4340kB)
> Jul 20 13:45:48 server kernel: 291229*4kB 46179*8kB 711*16kB 1*32kB 
> 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1546716kB)
> Jul 20 13:45:48 server kernel: Swap cache: add 192990, delete 189665, 
> find 21145/90719, race 0+0
> Jul 20 13:45:48 server kernel: 139345 pages of slabcache
> Jul 20 13:45:48 server kernel: 1890 pages of kernel stacks
> Jul 20 13:45:48 server kernel: 0 lowmem pagetables, 274854 highmem 
> pagetables
> Jul 20 13:45:48 server kernel: Free swap:       16749720kB
> Jul 20 13:45:49 server kernel: 4194304 pages of RAM
> Jul 20 13:45:49 server kernel: 3899360 pages of HIGHMEM
> Jul 20 13:45:49 server kernel: 140718 reserved pages
> Jul 20 13:45:49 server kernel: 35350398 pages shared
> Jul 20 13:45:49 server kernel: 3325 pages swap cached
> 
> /proc/meminfo LowFree info:
> LowFree:         17068 kB    ------> Do you think this value is too low?
> 
No that should be plenty of lowFree, but that number can change quickly
depending on workload.

> Zone:Normal freepages:  1084 min:  1279 low:  4544 high:  6304   ---->  
> (freepages < min) It's normal?
> Zone:HighMem freepages:386679 min:   255 low: 61952 high: 92928  ----> 
> (freepages < min) It's normal?
> 
You're beneath your low water mark in the normal (lowmem) zone for free pages,
so your kernel is likely trying to get lots of data moved to disk.  Although
given that you're largest buddy list has a 2048K chunk free, I'm hard pressed to
see how you aren't able to get memory when you need it.  Do you have a module
loaded in your kernel that might require such large memory allocations.
Neil

> Thanks a lot Neil!
> 
> Márcio Oliveira.
> 
> 

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
