Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWADLNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWADLNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWADLNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:13:33 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:15342 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751246AbWADLNc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:13:32 -0500
Message-ID: <43BBADD5.3070706@cosmosbay.com>
Date: Wed, 04 Jan 2006 12:13:25 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
References: <20051108185349.6e86cec3.akpm@osdl.org>	<437226B1.4040901@cosmosbay.com>	<20051109220742.067c5f3a.akpm@osdl.org>	<4373698F.9010608@cosmosbay.com> <43BB1178.7020409@cosmosbay.com> <p733bk4z2z0.fsf@verdi.suse.de>
In-Reply-To: <p733bk4z2z0.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 04 Jan 2006 12:13:26 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> Eric Dumazet <dada1@cosmosbay.com> writes:
>> 1) Reduces the size of (struct fdtable) to exactly 64 bytes on 32bits
>> platforms, lowering kmalloc() allocated space by 50%.
> 
> It should be probably a kmem_cache_alloc() instead of a kmalloc
> in the first place anyways. This would reduce fragmentation.

Well in theory yes, if you really expect thousand of tasks running...
But for most machines, number of concurrent tasks is < 200, and using a 
special cache for this is not a win.

> 
>> +   * read mostly part
>> +   */
>>  	atomic_t count;
>>  	struct fdtable *fdt;
>>  	struct fdtable fdtab;
>> -	fd_set close_on_exec_init;
>> -	fd_set open_fds_init;
>> +  /*
>> +   * written part on a separate cache line in SMP
>> +   */
>> +	spinlock_t file_lock ____cacheline_aligned_in_smp;
>> +	int next_fd;
>> +	embedded_fd_set close_on_exec_init;
>> +	embedded_fd_set open_fds_init;
> 
> You didn't describe that change, but unless it's clear the separate cache lines
> are a win I would not do it and save memory again. Was this split based on
> actual measurements or more theoretical considerations? 

As it is a refinement on a previous patch (that was integrated in 2.6.15) that 
put spin_lock after the array[] (so cleary using a separate cache line), I 
omited to describe it.

Yes, this part is really important because some multi-threaded benchmarks get 
a nice speedup with this separation in two parts.

Threads that are doing read()/write() (reading the first part of files_struct) 
are not slowed by others that do open()/close() syscalls (writing the second 
part), no false sharing (and no locking thanks to RCU of course).

Big Apache 2.0 servers, database servers directly benefit from this.

Note that process that tend to create/destroy a lot of threads per second are 
writing into 'count' field and might dirty the 'read mostly' part, but we can 
expect that well writen high performance programs wont do this.

Eric
