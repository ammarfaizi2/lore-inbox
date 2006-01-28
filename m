Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWA1Ews@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWA1Ews (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 23:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWA1Ews
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 23:52:48 -0500
Received: from ns1.siteground.net ([207.218.208.2]:6062 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932512AbWA1Ewr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 23:52:47 -0500
Date: Fri, 27 Jan 2006 20:52:48 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Message-ID: <20060128045248.GA3584@localhost.localdomain>
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <20060127224433.GB3565@localhost.localdomain> <43DAA586.5050609@cosmosbay.com> <20060127151635.3a149fe2.akpm@osdl.org> <43DABAA4.8040208@cosmosbay.com> <43DABC37.6070603@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DABC37.6070603@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 01:35:03AM +0100, Eric Dumazet wrote:
> Eric Dumazet a écrit :
> >Andrew Morton a écrit :
> >>Eric Dumazet <dada1@cosmosbay.com> wrote:
> >
> >#ifdef CONFIG_SMP
> >void percpu_counter_mod(struct percpu_counter *fbc, long amount)
> >{
> >	long old, new;
> >	atomic_long_t *pcount;
> >
> >	pcount = per_cpu_ptr(fbc->counters, get_cpu());
> >start:
> >	old = atomic_long_read(pcount);
> >	new = old + amount;
> >	if (new >= FBC_BATCH || new <= -FBC_BATCH) {
> >		if (unlikely(atomic_long_cmpxchg(pcount, old, 0) != old))
> >			goto start;
> >		atomic_long_add(new, &fbc->count);
> >	} else
> >		atomic_long_add(amount, pcount);
> >
> >	put_cpu();
> >}
> >EXPORT_SYMBOL(percpu_counter_mod);
> >
> >long percpu_counter_read_accurate(struct percpu_counter *fbc)
> >{
> >	long res = 0;
> >	int cpu;
> >	atomic_long_t *pcount;
> >
> >	for_each_cpu(cpu) {
> >		pcount = per_cpu_ptr(fbc->counters, cpu);
> >		/* dont dirty cache line if not necessary */
> >		if (atomic_long_read(pcount))
> >			res += atomic_long_xchg(pcount, 0);
				--------------------------->  (A)
> >	}
> 

> 	atomic_long_add(res, &fbc->count);
				--------------------------->  (B)
> 	res = atomic_long_read(&fbc->count);
> 
> >	return res;
> >}

The read is still theoritically FBC_BATCH * NR_CPUS inaccurate no?
What happens when other cpus update  their local counters at (A) and (B)?

(I am hoping we don't need percpu_counter_read_accurate anywhere yet and
this is just demo ;).  I certainly don't want to go on all cpus for read / 
add cmpxchg on the write path for the proto counters that started this 
discussion)

Thanks,
Kiran
