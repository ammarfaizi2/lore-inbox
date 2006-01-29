Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWA2GyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWA2GyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 01:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWA2GyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 01:54:18 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:52672 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1750814AbWA2GyR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 01:54:17 -0500
Message-ID: <43DC6691.9000001@cosmosbay.com>
Date: Sun, 29 Jan 2006 07:54:09 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, kiran@scalex86.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <20060127224433.GB3565@localhost.localdomain> <43DAA586.5050609@cosmosbay.com> <20060127151635.3a149fe2.akpm@osdl.org> <43DABAA4.8040208@cosmosbay.com> <20060129004459.GA24099@kvack.org>
In-Reply-To: <20060129004459.GA24099@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise a écrit :
> On Sat, Jan 28, 2006 at 01:28:20AM +0100, Eric Dumazet wrote:
>> We might use atomic_long_t only (and no spinlocks)
>> Something like this ?
> 
> Erk, complex and slow...  Try using local_t instead, which is substantially 
> cheaper on the P4 as it doesn't use the lock prefix and act as a memory 
> barrier.  See asm/local.h.
> 

Well, I think that might be doable, maybe RCU magic ?

1) local_t are not that nice on all archs.

2) The consolidation phase (summing all the cpus local offset to consolidate 
the central counter) might be more difficult to do (we would need kind of 2 
counters per cpu, and a index that can be changed by the cpu that wants a 
consolidation (still 'expensive'))

struct cpu_offset {
	local_t   offset[2];
	};

struct percpu_counter {
	atomic_long_t count;
	unsigned int offidx;
	spinlock_t   lock; /* to guard offidx changes */
	cpu_offset *counters;
};

void percpu_counter_mod(struct percpu_counter *fbc, long amount)
{
         long val;
	struct cpu_offset *cp;
	local_t *l;

	cp = per_cpu_ptr(fbc->counters, get_cpu());
	l = &cp[fbc->offidx];

         local_add(amount, l);
	val = local_read(l);
	if (new >= FBC_BATCH || new <= -FBC_BATCH) {
                 local_set(l, 0);
                 atomic_long_add(val, &fbc->count);
	}
	put_cpu();
}

long percpu_counter_read_accurate(struct percpu_counter *fbc)
{
	long res = 0, val;
	int cpu;
	struct cpu_offset *cp;
	local_t *l;

	spin_lock(&fbc->lock);
	idx = fbc->offidx;
	fbc->offidx ^= 1;
	mb();
	/*
	 * FIXME :
	 *	must 'wait' other cpus dont touch anymore their old local_t
	 */
	for_each_cpu(cpu) {
		cp = per_cpu_ptr(fbc->counters, cpu);
		l = &cp[idx];
		val = local_read(l);
		/* dont dirty alien cache line if not necessary */
		if (val)
			local_set(l, 0);
		res += val;
	}
	spin_unlock(&fbc->lock);
         atomic_long_add(res, &fbc->count);
         return atomic_long_read(&fbc->count);
}



3) Are the locked ops so expensive if done on a cache line that is mostly in 
exclusive state in cpu cache ?

Thank you
Eric

