Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWA1HTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWA1HTR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 02:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWA1HTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 02:19:17 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:23177 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S964869AbWA1HTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 02:19:16 -0500
Message-ID: <43DB1AF0.8040108@cosmosbay.com>
Date: Sat, 28 Jan 2006 08:19:12 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <20060127224433.GB3565@localhost.localdomain> <43DAA586.5050609@cosmosbay.com> <20060127151635.3a149fe2.akpm@osdl.org> <43DABAA4.8040208@cosmosbay.com> <43DABC37.6070603@cosmosbay.com> <20060128045248.GA3584@localhost.localdomain>
In-Reply-To: <20060128045248.GA3584@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------000909030506090805000509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000909030506090805000509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Ravikiran G Thirumalai a écrit :
> On Sat, Jan 28, 2006 at 01:35:03AM +0100, Eric Dumazet wrote:
>> Eric Dumazet a écrit :
>>> Andrew Morton a écrit :
>>>> Eric Dumazet <dada1@cosmosbay.com> wrote:
>>>
>>> long percpu_counter_read_accurate(struct percpu_counter *fbc)
>>> {
>>> 	long res = 0;
>>> 	int cpu;
>>> 	atomic_long_t *pcount;
>>>
>>> 	for_each_cpu(cpu) {
>>> 		pcount = per_cpu_ptr(fbc->counters, cpu);
>>> 		/* dont dirty cache line if not necessary */
>>> 		if (atomic_long_read(pcount))
>>> 			res += atomic_long_xchg(pcount, 0);
> 				--------------------------->  (A)
>>> 	}
> 
>> 	atomic_long_add(res, &fbc->count);
> 				--------------------------->  (B)
>> 	res = atomic_long_read(&fbc->count);
>>
>>> 	return res;
>>> }
> 
> The read is still theoritically FBC_BATCH * NR_CPUS inaccurate no?
> What happens when other cpus update  their local counters at (A) and (B)?

Well, after  atomic_read(&some_atomic) or percpu_counter_read_accurate(&s) the 
  'value' you got may be inaccurate by whatever... You cannot 'freeze the 
atomic / percpu_counter and gets its accurate value'. All you can do is 
'atomically add/remove some value from this counter (atomic or percpu_counter))

See percpu_counter_read_accurate() as an attempt to collect all local offset 
(and atomically set them to 0) and atomically reajust the central fbc->count 
to with the sum of all these offsets. Kind of a consolidation that might be 
driven by a user request (read /proc/sys/...) or a periodic timer.



> 
> (I am hoping we don't need percpu_counter_read_accurate anywhere yet and
> this is just demo ;).  I certainly don't want to go on all cpus for read / 
> add cmpxchg on the write path for the proto counters that started this 
> discussion)

As pointed by Andrew (If you decode carefully its short sentences :) ), all 
you really need is atomic_long_xchg() (only in slow path), and 
atomic_long_{read/add} in fast path)


Eric

--------------000909030506090805000509
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
        long new;
	atomic_long_t *pcount;

	pcount = per_cpu_ptr(fbc->counters, get_cpu());

        new = atomic_long_read(pcount) + amount;
 
	if (new >= FBC_BATCH || new <= -FBC_BATCH) {
                new = atomic_long_xchg(pcount, 0) + amount;
                if (new)
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
        atomic_long_add(res, &fbc->count);
        return atomic_long_read(&fbc->count);
}
EXPORT_SYMBOL(percpu_counter_read_accurate);
#endif /* CONFIG_SMP */


--------------000909030506090805000509--
