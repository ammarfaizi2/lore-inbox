Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWCHDHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWCHDHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWCHDHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:07:23 -0500
Received: from ns1.siteground.net ([207.218.208.2]:42148 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964889AbWCHDHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:07:22 -0500
Date: Tue, 7 Mar 2006 19:08:03 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
       shai@scalex86.org
Subject: Re: [patch 2/4] net: percpufy frequently used vars -- struct proto.memory_allocated
Message-ID: <20060308030803.GF9062@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain> <20060308020118.GC9062@localhost.localdomain> <20060307181422.3e279ca1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307181422.3e279ca1.akpm@osdl.org>
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

On Tue, Mar 07, 2006 at 06:14:22PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > -	if (atomic_read(sk->sk_prot->memory_allocated) < sk->sk_prot->sysctl_mem[0]) {
> >  +	if (percpu_counter_read(sk->sk_prot->memory_allocated) <
> >  +			sk->sk_prot->sysctl_mem[0]) {
> 
> Bear in mind that percpu_counter_read[_positive] can be inaccurate on large
> CPU counts.
> 
> It might be worth running percpu_counter_sum() to get the exact count if we
> think we're about to cause something to fail.

The problem is percpu_counter_sum has to read all the cpus cachelines.  If
we have to use percpu_counter_sum everywhere, then might as well use plain
per-cpu counters instead of  batching ones no?
 
sysctl_mem[0] is about 196K  and on a 16 cpu box variance is 512 bytes, which 
is OK with just percpu_counter_read I hope.  Maybe, on very large cpu counts, 
we should just change the FBC_BATCH so that variance does not go quadratic.
Something like 32.  So that variance is 32 * NR_CPUS in that case, instead
of (NR_CPUS * NR_CPUS * 2) currently.  Comments?
