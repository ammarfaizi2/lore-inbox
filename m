Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWAZSEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWAZSEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWAZSEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:04:23 -0500
Received: from ns1.siteground.net ([207.218.208.2]:6325 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932380AbWAZSEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:04:22 -0500
Date: Thu, 26 Jan 2006 10:04:24 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Avoid use of spinlock for percpu_counter
Message-ID: <20060126180424.GA3651@localhost.localdomain>
References: <20060125231654.GB3658@localhost.localdomain> <43D8D9FF.1050409@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43D8D9FF.1050409@cosmosbay.com>
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

On Thu, Jan 26, 2006 at 03:17:35PM +0100, Eric Dumazet wrote:
> Ravikiran G Thirumalai a écrit :
> >The spinlock in struct percpu_counter protects just one counter.  It's
> >not obvious why it was done this way (I am guessing it was because earlier,
> >atomic_t was guaranteed 24 bits only on some arches).  Since we have
> >atomic_long_t now, I don't see why this cannot be replaced with an 
> >atomic_t.
> >
> >Comments?
> 
> Yes this makes sense.
> 
> Furthermore, we could try to fix 'struct percpu_counter' management (if 
> SMP) if alloc_percpu(long) call done in percpu_counter_init() fails. This 
> is currently ignored and can crash.
> Something like (hybrid patch, to get the idea) :
> 
> --- a/mm/swap.c 2006-01-26 15:58:42.000000000 +0100
> +++ b/mm/swap.c 2006-01-26 16:00:54.000000000 +0100
> @@ -472,9 +472,12 @@
>  {
>         long count;
>         long *pcount;
> -       int cpu = get_cpu();
> 
> -       pcount = per_cpu_ptr(fbc->counters, cpu);
> +       if (unlikely(fbc->counters == NULL)) {
> +               atomic_long_add(amount, &fbc->count);
> +               return;

I don't know if adding another branch to the fast path is a good idea, would
it not be better if this was handled by returning an error at
percpu_counter_init?  If we are in agreement, then I can make a patch for
the same.

Thanks,
Kiran
