Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWA0Wai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWA0Wai (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWA0Wai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:30:38 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:30077 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751567AbWA0Wag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:30:36 -0500
Message-ID: <43DA9EFF.1020200@cosmosbay.com>
Date: Fri, 27 Jan 2006 23:30:23 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
References: <20060126185649.GB3651@localhost.localdomain>	<20060126190357.GE3651@localhost.localdomain>	<43D9DFA1.9070802@cosmosbay.com>	<20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org>
In-Reply-To: <20060127121602.18bc3f25.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>> On Fri, Jan 27, 2006 at 09:53:53AM +0100, Eric Dumazet wrote:
>>> Ravikiran G Thirumalai a écrit :
>>>> Change the atomic_t sockets_allocated member of struct proto to a 
>>>> per-cpu counter.
>>>>
>>>> Signed-off-by: Pravin B. Shelar <pravins@calsoftinc.com>
>>>> Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
>>>> Signed-off-by: Shai Fultheim <shai@scalex86.org>
>>>>
>>> Hi Ravikiran
>>>
>>> If I correctly read this patch, I think there is a scalability problem.
>>>
>>> On a big SMP machine, read_sockets_allocated() is going to be a real killer.
>>>
>>> Say we have 128 Opterons CPUS in a box.
>> read_sockets_allocated is being invoked when when /proc/net/protocols is read,
>> which can be assumed as not frequent.  
>> At sk_stream_mem_schedule(), read_sockets_allocated() is invoked only 
>> certain conditions, under memory pressure -- on a large CPU count machine, 
>> you'd have large memory, and I don't think read_sockets_allocated would get 
>> called often.  It did not atleast on our 8cpu/16G box.  So this should be OK 
>> I think.
> 
> That being said, the percpu_counters aren't a terribly successful concept
> and probably do need a revisit due to the high inaccuracy at high CPU
> counts.  It might be better to do some generic version of vm_acct_memory()
> instead.

There are several issues here :

alloc_percpu() current implementation is a a waste of ram. (because it uses 
slab allocations that have a minimum size of 32 bytes)

Currently we cannot use per_cpu(&some_object, cpu), so a generic version of 
vm_acct_memory() would need a rework of percpu.h and maybe this is not 
possible on every platform ?

#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))

-->

#define per_cpu_name(var) per_cpu__##var
#define per_cpu_addr(var) &per_cpu_name(var)
#define per_cpu(var, cpu) (*RELOC_HIDE(per_cpu_addr(var), __per_cpu_offset[cpu])


But this could render TLS migration difficult...

Eric
