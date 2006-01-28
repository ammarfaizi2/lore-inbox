Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422740AbWA1A2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422740AbWA1A2Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbWA1A2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:28:24 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:47256 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1422736AbWA1A2X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:28:23 -0500
Message-ID: <43DABAA4.8040208@cosmosbay.com>
Date: Sat, 28 Jan 2006 01:28:20 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: kiran@scalex86.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
References: <20060126185649.GB3651@localhost.localdomain>	<20060126190357.GE3651@localhost.localdomain>	<43D9DFA1.9070802@cosmosbay.com>	<20060127195227.GA3565@localhost.localdomain>	<20060127121602.18bc3f25.akpm@osdl.org>	<20060127224433.GB3565@localhost.localdomain>	<43DAA586.5050609@cosmosbay.com> <20060127151635.3a149fe2.akpm@osdl.org>
In-Reply-To: <20060127151635.3a149fe2.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020103080003080607060501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020103080003080607060501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>> Ravikiran G Thirumalai a écrit :
>>> On Fri, Jan 27, 2006 at 12:16:02PM -0800, Andrew Morton wrote:
>>>> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>>>>> which can be assumed as not frequent.  
>>>>> At sk_stream_mem_schedule(), read_sockets_allocated() is invoked only 
>>>>> certain conditions, under memory pressure -- on a large CPU count machine, 
>>>>> you'd have large memory, and I don't think read_sockets_allocated would get 
>>>>> called often.  It did not atleast on our 8cpu/16G box.  So this should be OK 
>>>>> I think.
>>>> That being said, the percpu_counters aren't a terribly successful concept
>>>> and probably do need a revisit due to the high inaccuracy at high CPU
>>>> counts.  It might be better to do some generic version of vm_acct_memory()
>>>> instead.
>>> AFAICS vm_acct_memory is no better.  The deviation on large cpu counts is the 
>>> same as percpu_counters -- (NR_CPUS * NR_CPUS * 2) ...
>> Ah... yes you are right, I read min(16, NR_CPUS*2)
> 
> So did I ;)
> 
>> I wonder if it is not a typo... I mean, I understand the more cpus you have, 
>> the less updates on central atomic_t is desirable, but a quadratic offset 
>> seems too much...
> 
> I'm not sure whether it was a mistake or if I intended it and didn't do the
> sums on accuracy :(
> 
> An advantage of retaining a spinlock in percpu_counter is that if accuracy
> is needed at a low rate (say, /proc reading) we can take the lock and then
> go spill each CPU's local count into the main one.  It would need to be a
> very low rate though.   Or we make the cpu-local counters atomic too.

We might use atomic_long_t only (and no spinlocks)
Something like this ?


--------------020103080003080607060501
Content-Type: text/plain;
 name="functions"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="functions"

struct percpu_counter {
	atomic_long_t count;
	atomic_long_t *counters;
};

#ifdef CONFIG_SMP
void percpu_counter_mod(struct percpu_counter *fbc, long amount)
{
	long old, new;
	atomic_long_t *pcount;

	pcount = per_cpu_ptr(fbc->counters, get_cpu());
start:
	old = atomic_long_read(pcount);
	new = old + amount;
	if (new >= FBC_BATCH || new <= -FBC_BATCH) {
		if (unlikely(atomic_long_cmpxchg(pcount, old, 0) != old))
			goto start;
		atomic_long_add(new, &fbc->count);
	} else
		atomic_long_add(amount, pcount);

	put_cpu();
}
EXPORT_SYMBOL(percpu_counter_mod);

long percpu_counter_read_accurate(struct percpu_counter *fbc)
{
	long res = 0;
	int cpu;
	atomic_long_t *pcount;

	for_each_cpu(cpu) {
		pcount = per_cpu_ptr(fbc->counters, cpu);
		/* dont dirty cache line if not necessary */
		if (atomic_long_read(pcount))
			res += atomic_long_xchg(pcount, 0);
	}
	return res;
}
EXPORT_SYMBOL(percpu_counter_read_accurate);
#endif /* CONFIG_SMP */


--------------020103080003080607060501--
