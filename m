Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVGVUzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVGVUzu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVGVUzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:55:50 -0400
Received: from host27-37.discord.birch.net ([65.16.27.37]:50547 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S262168AbVGVUzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:55:47 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "=?iso-8859-1?Q?'M=E1rcio_Oliveira'?=" 
	<moliveira@latinsourcetech.com>,
       "'Neil Horman'" <nhorman@redhat.com>
Cc: <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Memory Management
Date: Fri, 22 Jul 2005 15:58:31 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <42E14BED.40508@latinsourcetech.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
thread-index: AcWO7W3FAf6KMLW8TD+46SAd7nfP+AAEh/ww
Message-ID: <EXCHG2003gbLYluLCTa000004d6@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 22 Jul 2005 19:53:49.0110 (UTC) FILETIME=[13DACD60:01C58EF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have seen RH3.0 crash on 32GB systems because it has too
much memory tied up in write cache.  It required update 2 
(this was a while ago) and a change of a parameter in /proc
to prevent the crash, it was because of a overagressive
write caching change RH implemented in the kernel resulted
in the crash.  This crash was an OOM related crash.  To
duplicate the bug, you booted the machine and ran a dd
to create a very large file filling the disk.

We did test and did determine that it did not appear to have
the issue if you had less than 28GB of ram, this was on an
itanium machine, so I don't know if it occurs on other arches,
and if it occurs at the same memory limits on the other arches
either.

                        Roger

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Márcio Oliveira
> Sent: Friday, July 22, 2005 2:42 PM
> To: Neil Horman
> Cc: arjanv@redhat.com; linux-kernel@vger.kernel.org
> Subject: Re: Memory Management
> 
> Neil Horman wrote:
> 
> >On Fri, Jul 22, 2005 at 11:32:52AM -0300, Márcio Oliveira wrote:
> >  
> >
> >>Neil Horman wrote:
> >>
> >>    
> >>
> >>>On Thu, Jul 21, 2005 at 10:40:54AM -0300, Márcio Oliveira wrote:
> >>>
> >>>
> >>>      
> >>>
> >>>>>http://people.redhat.com/nhorman/papers/rhel3_vm.pdf
> >>>>>I wrote this with norm awhile back.  It may help you out.
> >>>>>Regards
> >>>>>Neil
> >>>>>
> >>>>>
> >>>>>    
> >>>>>
> >>>>>          
> >>>>>
> >>>>Neil,
> >>>>
> >>>>Thanks.~10-12GB of total RAM (16GB) are
> >>>>
> >>>>How can Proc virtual memory parameters like 
> inactive_clean_percent, 
> >>>>overcommit_memory, overcommit_ratio and page_cache help 
> me to solve 
> >>>>/ reduce Out Of Memory conditions on servers with 16GB 
> RAM and lots 
> >>>>of GB swap?
> >>>>
> >>>>  
> >>>>
> >>>>        
> >>>>
> >>>I wouldn't touch memory overcommit if you are already 
> seeing out of 
> >>>memory issues.  If you are using lots of pagecache, I 
> would suggest 
> >>>increasing inactive_clean percent, reducing the 
> pagecahce.max value, 
> >>>and modifying the bdflush parameters in the above document 
> such that 
> >>>bdflush runs sooner, more often, and does more work per 
> iteration.  
> >>>This will help you move data in pagecache back to disk more 
> >>>aggressively so that memory will be available for other purposes, 
> >>>like heap allocations. Also if you're using a Red Hat 
> kernel and you 
> >>>have 16GB of ram in your system, you're a good candidate for the 
> >>>hugemem kernel.  Rather than a straightforward out of memory 
> >>>condition, you may be seeing a exhaustion of your kernels address 
> >>>space (check LowFree in /proc/meminfo).  In this even the hugemem 
> >>>kernel will help you in that it increases your Low Memory address 
> >>>space from 1GB to 4GB, preventing some OOM conditions.
> >>>
> >>>
> >>>
> >>>
> >>>      
> >>>
> >>>>Kernel does not free cached memory (~10-12GB of total RAM 
> - 16GB). Is 
> >>>>there some way to force the kernel to free cached memory?
> >>>>
> >>>>  
> >>>>
> >>>>        
> >>>>
> >>>Cached memory is freed on demand.  Just because its listed 
> under the 
> >>>cached line
> >>>below doesn't mean it can't be freed and used for another 
> purpose.  
> >>>Implement
> >>>the tunings above, and your situation should improve.
> >>>
> >>>Regards
> >>>Neil
> >>>
> >>>
> >>>
> >>>      
> >>>
> >>>>/proc/meminfo:
> >>>>
> >>>>           total:    used:    free:  shared: buffers:  cached:
> >>>>Mem:    16603488256 16523333632 80154624        0 
> 70651904 13194563584
> >>>>Swap:   17174257664 11771904 17162485760
> >>>>MemTotal:     16214344 kB
> >>>>MemFree:         78276 kB
> >>>>Buffers:         68996 kB
> >>>>Cached:       12874808 kB
> >>>>
> >>>>Thanks to all.
> >>>>
> >>>>Marcio.
> >>>>  
> >>>>
> >>>>        
> >>>>
> >>Neil,
> >>
> >>  Thanks for the answers!
> >>
> >>The following lines are the Out Of Memory log:
> >>
> >>Jul 20 13:45:44 server kernel: Out of Memory: Killed 
> process 23716 (oracle).
> >>Jul 20 13:45:44 server kernel: Fixed up OOM kill of mm-less task
> >>Jul 20 13:45:45 server su(pam_unix)[3848]: session closed 
> for user root
> >>Jul 20 13:45:48 server kernel: Mem-info:
> >>Jul 20 13:45:48 server kernel: Zone:DMA freepages:  1884 min:     0 
> >>low:     0 high:     0
> >>Jul 20 13:45:48 server kernel: Zone:Normal freepages:  1084 
> min:  1279 
> >>low:  4544 high:  6304
> >>Jul 20 13:45:48 server kernel: Zone:HighMem 
> freepages:386679 min:   255 
> >>low: 61952 high: 92928
> >>Jul 20 13:45:48 server kernel: Free pages:      389647 
> (386679 HighMem)
> >>Jul 20 13:45:48 server kernel: ( Active: 2259787/488777, 
> >>inactive_laundry: 244282, inactive_clean: 244366, free: 389647 )
> >>Jul 20 13:45:48 server kernel:   aa:0 ac:0 id:0 il:0 ic:0 fr:1884
> >>Jul 20 13:45:48 server kernel:   aa:1620 ac:1801 id:231 
> il:15 ic:0 fr:1085
> >>Jul 20 13:45:48 server kernel:   aa:1099230 ac:1157136 id:488536 
> >>il:244277 ic:244366 fr:386679
> >>Jul 20 13:45:48 server kernel: 0*4kB 0*8kB 1*16kB 1*32kB 
> 1*64kB 0*128kB 
> >>1*256kB 0*512kB 1*1024kB 1*2048kB 1*4096kB = 7536kB)Jul 20 13:45:48 
> >>server kernel: 55*4kB 9*8kB 19*16kB 9*32kB 0*64kB 1*128kB 1*256kB 
> >>0*512kB 1*1024kB 1*2048kB 0*4096kB = 4340kB)
> >>Jul 20 13:45:48 server kernel: 291229*4kB 46179*8kB 711*16kB 1*32kB 
> >>1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 
> 1546716kB)
> >>Jul 20 13:45:48 server kernel: Swap cache: add 192990, 
> delete 189665, 
> >>find 21145/90719, race 0+0
> >>Jul 20 13:45:48 server kernel: 139345 pages of slabcache
> >>Jul 20 13:45:48 server kernel: 1890 pages of kernel stacks
> >>Jul 20 13:45:48 server kernel: 0 lowmem pagetables, 274854 highmem 
> >>pagetables
> >>Jul 20 13:45:48 server kernel: Free swap:       16749720kB
> >>Jul 20 13:45:49 server kernel: 4194304 pages of RAM
> >>Jul 20 13:45:49 server kernel: 3899360 pages of HIGHMEM
> >>Jul 20 13:45:49 server kernel: 140718 reserved pages
> >>Jul 20 13:45:49 server kernel: 35350398 pages shared
> >>Jul 20 13:45:49 server kernel: 3325 pages swap cached
> >>
> >>/proc/meminfo LowFree info:
> >>LowFree:         17068 kB    ------> Do you think this 
> value is too low?
> >>
> >>    
> >>
> >No that should be plenty of lowFree, but that number can 
> change quickly
> >depending on workload.
> >
> >  
> >
> >>Zone:Normal freepages:  1084 min:  1279 low:  4544 high:  
> 6304   ---->  
> >>(freepages < min) It's normal?
> >>Zone:HighMem freepages:386679 min:   255 low: 61952 high: 
> 92928  ----> 
> >>(freepages < min) It's normal?
> >>
> >>    
> >>
> >You're beneath your low water mark in the normal (lowmem) 
> zone for free pages,
> >so your kernel is likely trying to get lots of data moved to 
> disk.  Although
> >given that you're largest buddy list has a 2048K chunk free, 
> I'm hard pressed to
> >see how you aren't able to get memory when you need it.  Do 
> you have a module
> >loaded in your kernel that might require such large memory 
> allocations.
> >Neil
> >
> >  
> >
> >>Thanks a lot Neil!
> >>
> >>Márcio Oliveira.
> >>
> >>
> >>    
> >>
> >
> >  
> >
> Neil,
> 
>    Thanks for the help.
> 
>    I have a storage attached to the server. Maybe the storage module 
> require lots of memory.
>    Maybe the "LowFree" be wrong (out of OOM time), so there 
> is possible 
> that "LowFree" value be too small on the OOM condition.
> 
>   Is there a way to identify if the Low Memory is too small?  (some 
> program, command, daemon...)
> 
>   The server has 16GB RAM and 16GB swap. When the OOM kill conditions 
> happens, the system has ~6GB RAM used, ~10GB RAM cached and 16GB free 
> swap. Is that indicate that the server can't allocate Low Memory and 
> starts OOM conditions? Because the High Memory is OK, right?
> 
> Thanks again!
> 
> Márcio.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

