Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422677AbWA0XVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWA0XVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWA0XVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:21:09 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:2727 "EHLO smtp.cegetel.net")
	by vger.kernel.org with ESMTP id S1422677AbWA0XVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:21:08 -0500
Message-ID: <43DAAAE3.2030107@cosmosbay.com>
Date: Sat, 28 Jan 2006 00:21:07 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <43DA9EFF.1020200@cosmosbay.com> <20060127225036.GC3565@localhost.localdomain>
In-Reply-To: <20060127225036.GC3565@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai a écrit :
> On Fri, Jan 27, 2006 at 11:30:23PM +0100, Eric Dumazet wrote:
>> There are several issues here :
>>
>> alloc_percpu() current implementation is a a waste of ram. (because it uses 
>> slab allocations that have a minimum size of 32 bytes)
> 
> Oh there was a solution for that :).  
> 
> http://lwn.net/Articles/119532/
> 
> I can quickly revive it if there is interest.
> 

Well, nice work ! :)

Maybe a litle bit complicated if expected percpu space is 50 KB per cpu ?

Why not use a boot time allocated percpu area (as done today in 
setup_per_cpu_areas()), but instead of reserving extra space for module's 
percpu data, being able to serve alloc_percpu() from this reserved area (ie no 
kmalloced data anymore), and keeping your

#define per_cpu_ptr(ptr, cpu)  ((__typeof__(ptr))         \
	(RELOC_HIDE(ptr,  PCPU_BLKSIZE * cpu)))

Some code from kernel/module.c could be reworked to serve both as an allocator 
when a module percpudata must be relocated (insmod)/freed (rmmod), and serve 
alloc_percpu() for 'dynamic allocations'

Eric
