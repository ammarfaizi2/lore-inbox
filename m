Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWEKIIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWEKIIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 04:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbWEKIIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 04:08:22 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:29157 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965205AbWEKIIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 04:08:21 -0400
Message-ID: <4462F0F8.9010104@in.ibm.com>
Date: Thu, 11 May 2006 13:38:24 +0530
From: Suzuki <suzuki@in.ibm.com>
Organization: IBM Software Labs
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bron Gondwana <brong@fastmail.fm>
CC: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: OOM Killer firing when plenty of memory left and no swap used
References: <20060511020808.GA6126@brong.net> <1147322647.8432.59.camel@homer>
In-Reply-To: <1147322647.8432.59.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Thu, 2006-05-11 at 12:08 +1000, Bron Gondwana wrote:
> 
>>I hope someone can shed some light on what could possibly
>>have caused the oom-killer to engage with so much free
>>memory.
> 
> 
>>Log messages from the first failure:
>>May 10 19:57:00 heartbeat1 kernel: oom-killer: gfp_mask=0xd0, order=1
> 
> 
> A two page GFP_KERNEL allocation fails...
> 
> 
>>May 10 19:57:00 heartbeat1 kernel:  [out_of_memory+180/209] out_of_memory+0xb4/0xd1
>>May 10 19:57:00 heartbeat1 kernel:  [__alloc_pages+623/795] __alloc_pages+0x26f/0x31boom-killer: gfp_mask=0xd0, order=1
>>May 10 19:57:00 heartbeat1 kernel:  [out_of_memory+180/209] out_of_memory+0xb4/0xd1
>>May 10 19:57:00 heartbeat1 kernel:  [__alloc_pages+623/795] __alloc_pages+0x26f/0x31b
>>May 10 19:57:00 heartbeat1 kernel:  [kmem_getpages+52/155] kmem_getpages+0x34/0x9b
>>May 10 19:57:00 heartbeat1 kernel:  [cache_grow+190/375] cache_grow+0xbe/0x177
>>May 10 19:57:00 heartbeat1 kernel:  [cache_alloc_refill+354/523] cache_alloc_refill+0x162/0x20b
>>May 10 19:57:00 heartbeat1 kernel:  [kmem_cache_alloc+103/127] kmem_cache_alloc+0x67/0x7f
>>May 10 19:57:00 heartbeat1 kernel:  [dup_task_struct+69/153] dup_task_struct+0x45/0x99
>>May 10 19:57:00 heartbeat1 kernel:  [copy_process+94/3348] copy_process+0x5e/0xd14
>>May 10 19:57:00 heartbeat1 kernel:  [do_fork+105/395] do_fork+0x69/0x18b
>>May 10 19:57:00 heartbeat1 kernel:  [sys_rt_sigprocmask+161/256] sys_rt_sigprocmask+0xa1/0x100
>>May 10 19:57:00 heartbeat1 kernel:  [sys_clone+62/66] sys_clone+0x3e/0x42
>>May 10 19:57:00 heartbeat1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> 
> 
> ...for the slab allocator as it tries to expand it's cache to create
> space for a new task. 
> 
> 
>>May 10 19:57:00 heartbeat1 kernel: Normal free:24276kB min:26732kB low:33412kB high:40096kB active:2256kB inactive:1940kB present:901120kB pages_scanned:6457 all_unreclaimable? yes
> 
> 
> Zone normal is below min watermark, and GFP_HIGH isn't set, so no
> digging down into reserves is allowed.  Most of Zone Normal memory isn't
> on the LRU, and what is there is all unreclaimable, so swap can't help
> with the shortage.  Genuine oom situation.
> 
> Question is, where are all your Zone Normal pages hanging out?  If it
> happens again, take a look at /proc/slabinfo to see if it's there, and
> if so, in which cache[s].

If you think that, this can be reproduced within a fixed interval of 
time, it would be handy to try out the following script, which would 
gather the slabinformation at regular intervals. ( We have been using 
this script for such problems ). Hope it helps you too.


#!/bin/bash

FILE=/tmp/memdebug

exec 2>&1 > $FILE

while true
do
     date
     echo '==='; ps ax -o 'pid:6,vsize:6,rss:6,command'
     echo '==='; df -l
     echo '==='; cat /proc/meminfo
     echo '==='; cat /proc/slabinfo
     echo '==='; cat /proc/buddyinfo; echo '==='
     date
# modify the value according to your scenario.
     sleep 600
done






-Suzuki
> 
> If it's not there, somebody is leaking pages.  If that's the case, I'd
> take a close look at those out-of-tree patches.
> 
> 	-Mike
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
