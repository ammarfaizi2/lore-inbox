Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269576AbUINQSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269576AbUINQSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269574AbUINQSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:18:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5256 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269563AbUINQRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:17:05 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrea Arcangeli <andrea@novell.com>
Subject: Re: [profile] amortize atomic hit count increments
Date: Tue, 14 Sep 2004 09:16:48 -0700
User-Agent: KMail/1.7
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@sgi.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org> <20040914155103.GR9106@holomorphy.com> <20040914160531.GP4180@dualathlon.random>
In-Reply-To: <20040914160531.GP4180@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409140916.48786.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 14, 2004 9:05 am, Andrea Arcangeli wrote:
> It probably worth to measure it. The real bottleneck happens when all
> cpus tries to get an exclusive lock on the same cacheline at the *same*
> time. 1 second is a pretty long time, if there's no contention of the
> cacheline, things are normally ok.

Right, we want to avoid that heavy contention.

> this is basically the same issue we had with RCU since all timers fired
> at the same wall clock time, and all of them tried to change bits in the
> same cacheline at the same time, that is a workload that collapse a
> 512-way machine ;). The profile timer is no different.
>
> Simply removing the idle time accounting would fix it, however this
> cripple down functionality a little bit, but it'll be a very good way to
> test if my theory is correct, or if you truly need some per-cpu logic in
> the profiler.
>
> You could also fake it, have a per-cpu counter only for the current->pid
> case, and then once somebody reads /proc/profile, you flush the total
> per-cpu count to the counter in the buffer that corresponds to the EIP
> of the idle func.
>
> Before dedicidng I'd suggest to have a look and see how the below patch
> compares to your approch in performance terms.

It looks like the 512p we have here is pretty heavily reserved this week, so 
I'm not sure if I'll be able to test this (someone else might, John?).  I 
think the balance we're looking for is between simplicity and non-brokenness.  
Builtin profiling is *supposed* to be simple and dumb, and were it not for 
the readprofile times, I'd say per-cpu would be the way to go just because it 
retains the simplicity of the current approach while allowing it to work on 
large machines (as well as limiting the performance impact of builtin 
profiling in general).  wli's approach seems like a reasonable tradeoff 
though, assuming what you suggest doesn't work.

Thanks,
Jesse
