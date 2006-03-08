Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWCHDYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWCHDYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWCHDYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:24:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27835 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932422AbWCHDYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:24:38 -0500
Date: Tue, 7 Mar 2006 19:22:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
       shai@scalex86.org
Subject: Re: [patch 2/4] net: percpufy frequently used vars -- struct
 proto.memory_allocated
Message-Id: <20060307192234.7efb1213.akpm@osdl.org>
In-Reply-To: <20060308030803.GF9062@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain>
	<20060308020118.GC9062@localhost.localdomain>
	<20060307181422.3e279ca1.akpm@osdl.org>
	<20060308030803.GF9062@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> On Tue, Mar 07, 2006 at 06:14:22PM -0800, Andrew Morton wrote:
> > Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > >
> > > -	if (atomic_read(sk->sk_prot->memory_allocated) < sk->sk_prot->sysctl_mem[0]) {
> > >  +	if (percpu_counter_read(sk->sk_prot->memory_allocated) <
> > >  +			sk->sk_prot->sysctl_mem[0]) {
> > 
> > Bear in mind that percpu_counter_read[_positive] can be inaccurate on large
> > CPU counts.
> > 
> > It might be worth running percpu_counter_sum() to get the exact count if we
> > think we're about to cause something to fail.
> 
> The problem is percpu_counter_sum has to read all the cpus cachelines.  If
> we have to use percpu_counter_sum everywhere, then might as well use plain
> per-cpu counters instead of  batching ones no?

I didn't say "use it everywhere" ;)

Just in places like this:

	if (percpu_counter_read(something) > something_else)
		make_an_application_fail();

in that case it's worth running percpu_counter_sum().  And bear in mind
that once we've done that, the following percpu_counter_read()s become
accurate, so we won't run the expensive percpu_counter_sum() again
for a while.  Unless we're really close to or over the limit, in which case
blowing a few cycles is relatively unimportant.

All that should be captured in library code (per_cpu_counter_exceeds(ptr,
threshold), for example) rather than open-coded everywhere.

> sysctl_mem[0] is about 196K  and on a 16 cpu box variance is 512 bytes, which 
> is OK with just percpu_counter_read I hope.

You mean a 16 CPU box with NR_CPUS=16 as well...

>  Maybe, on very large cpu counts, 
> we should just change the FBC_BATCH so that variance does not go quadratic.
> Something like 32.  So that variance is 32 * NR_CPUS in that case, instead
> of (NR_CPUS * NR_CPUS * 2) currently.  Comments?

Sure, we need to make that happen.  But it got all mixed up with the
spinlock removal and it does need quite some thought and testing and
documentation to help developers to choose the right settings and
appropriate selection of defaults, etc.

