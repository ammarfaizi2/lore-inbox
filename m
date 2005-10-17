Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVJQOys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVJQOys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 10:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVJQOys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 10:54:48 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:55479 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751313AbVJQOyr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 10:54:47 -0400
Message-ID: <4353BB10.7060703@cosmosbay.com>
Date: Mon, 17 Oct 2005 16:54:08 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: dipankar@in.ibm.com, Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RCU problem] was VFS: file-max limit 50044 reached
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <435394A1.7000109@cosmosbay.com> <20051017123655.GD6257@in.ibm.com> <4353A6F6.9050205@cosmosbay.com>
In-Reply-To: <4353A6F6.9050205@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 17 Oct 2005 16:54:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet a écrit :
> Dipankar Sarma a écrit :
> 
>> On Mon, Oct 17, 2005 at 02:10:09PM +0200, Eric Dumazet wrote:
>>
>>> Dipankar Sarma a écrit :
>>>
>>>> On Mon, Oct 17, 2005 at 11:10:04AM +0200, Eric Dumazet wrote:
>>>>
>>>> Agreed. It is not designed to work that way, so there must be
>>>> a bug somewhere and I am trying to track it down. It could very well
>>>> be that at maxbatch=10 we are just queueing at a rate far too high
>>>> compared to processing.
>>>>
>>>
>>> I can freeze my test machine with a program that 'only' use dentries, 
>>> no files.
>>>
>>> No message, no panic, but machine becomes totally unresponsive after 
>>> few seconds.
>>>
>>> Just greping for call_rcu in kernel sources gave me another 
>>> call_rcu() use from syscalls. And yes 2.6.13 has the same problem.
>>
>>
>>
>> Can you try it with rcupdate.maxbatch set to 10000 in boot
>> command line ?
>>
> 
> Changing maxbatch from 10 to 10000 cures the problem.
> Maybe we could initialize maxbatch to (10000000/HZ), considering no 
> current cpu is able to queue more than 10.000.000 items per second in a 
> list.
> 

Well... after one 90 minutes of stress, I got an OOM even with maxbatch=10000

Out of Memory : Killed process 1759 (mysqld)

Maybe because on this HT machine, all (timer and network) interrupts are taken 
by CPU0.

So if the user program is bound on CPU1, may be this cpu only performs 
syscalls and no rcu state change at all.


Oct 17 18:24:25 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Oct 17 18:24:25 localhost kernel: Mem-info:
Oct 17 18:24:25 localhost kernel: DMA per-cpu:
Oct 17 18:24:25 localhost kernel: cpu 0 hot: low 2, high 6, batch 1 used:5
Oct 17 18:24:25 localhost kernel: cpu 0 cold: low 0, high 2, batch 1 used:1
Oct 17 18:24:25 localhost kernel: cpu 1 hot: low 2, high 6, batch 1 used:2
Oct 17 18:24:25 localhost kernel: cpu 1 cold: low 0, high 2, batch 1 used:0
Oct 17 18:24:25 localhost kernel: Normal per-cpu:
Oct 17 18:24:25 localhost kernel: cpu 0 hot: low 62, high 186, batch 31 used:168
Oct 17 18:24:25 localhost kernel: cpu 0 cold: low 0, high 62, batch 31 used:55
Oct 17 18:24:25 localhost kernel: cpu 1 hot: low 62, high 186, batch 31 used:95
Oct 17 18:24:25 localhost kernel: cpu 1 cold: low 0, high 62, batch 31 used:33
Oct 17 18:24:25 localhost kernel: HighMem per-cpu:
Oct 17 18:26:17 localhost kernel: cpu 0 hot: low 62, high 186, batch 31 used:166
Oct 17 18:26:17 localhost kernel: cpu 0 cold: low 0, high 62, batch 31 used:29
Oct 17 18:26:17 localhost kernel: cpu 1 hot: low 62, high 186, batch 31 used:176
Oct 17 18:26:17 localhost kernel: cpu 1 cold: low 0, high 62, batch 31 used:13
Oct 17 18:26:17 localhost kernel: Free pages:     1136620kB (1129392kB HighMem)
Oct 17 18:26:17 localhost kernel: Active:8040 inactive:3876 dirty:1 
writeback:0 unstable:0 free:284155 slab:218548 mapped:8064 pagetables:130
Oct 17 18:26:17 localhost kernel: DMA free:3588kB min:68kB low:84kB high:100kB 
active:0kB inactive:0kB present:16384kB pages_scanned:246 all_unreclaimable? no
Oct 17 18:26:17 localhost kernel: lowmem_reserve[]: 0 880 2031
Oct 17 18:26:17 localhost kernel: Normal free:3640kB min:3756kB low:4692kB 
high:5632kB active:76kB inactive:24kB present:901120kB pages_scanned:8581 
all_unreclaimable? no
Oct 17 18:26:17 localhost kernel: lowmem_reserve[]: 0 0 9215
Oct 17 18:26:17 localhost kernel: HighMem free:1129392kB min:512kB low:640kB 
high:768kB active:32084kB inactive:15480kB present:1179520kB pages_scanned:0 
all_unreclaimable? no
Oct 17 18:26:17 localhost kernel: lowmem_reserve[]: 0 0 0
Oct 17 18:26:17 localhost kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3588kB
Oct 17 18:26:17 localhost kernel: Normal: 0*4kB 1*8kB 1*16kB 1*32kB 0*64kB 
0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3640kB
Oct 17 18:26:17 localhost kernel: HighMem: 518*4kB 301*8kB 119*16kB 54*32kB 
22*64kB 13*128kB 6*256kB 1*512kB 0*1024kB 1*2048kB 272*4096kB = 1129392kB
Oct 17 18:26:17 localhost kernel: Swap cache: add 0, delete 0, find 0/0, race 0+0
Oct 17 18:26:17 localhost kernel: Free swap  = 1012016kB
Oct 17 18:26:17 localhost kernel: Total swap = 1012016kB
Oct 17 18:26:17 localhost kernel: Free swap:       1012016kB
Oct 17 18:26:17 localhost kernel: 524256 pages of RAM
Oct 17 18:26:17 localhost kernel: 294880 pages of HIGHMEM
Oct 17 18:26:17 localhost kernel: 5472 reserved pages
Oct 17 18:26:17 localhost kernel: 11361 pages shared
Oct 17 18:26:18 localhost kernel: 0 pages swap cached
Oct 17 18:26:18 localhost kernel: 1 pages dirty
Oct 17 18:26:18 localhost kernel: 0 pages writeback
Oct 17 18:26:18 localhost kernel: 8064 pages mapped
Oct 17 18:26:18 localhost kernel: 218548 pages slab
Oct 17 18:26:18 localhost kernel: 130 pages pagetables
Oct 17 18:26:18 localhost kernel: Out of Memory: Killed process 1759 (mysqld).

Eric
