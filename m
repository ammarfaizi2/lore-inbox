Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbTBOSyo>; Sat, 15 Feb 2003 13:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbTBOSyo>; Sat, 15 Feb 2003 13:54:44 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:52531
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264875AbTBOSyn>; Sat, 15 Feb 2003 13:54:43 -0500
Date: Sat, 15 Feb 2003 14:01:06 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH][2.5][8/14] smp_call_function_on_cpu - s390
In-Reply-To: <200302151804.TAA04500@faui11.informatik.uni-erlangen.de>
Message-ID: <Pine.LNX.4.50.0302151351580.16012-100000@montezuma.mastecende.com>
References: <200302151804.TAA04500@faui11.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Ulrich Weigand wrote:

> ... this test is quite pointless as the routine will hang shortly
> anyway.  In fact is appears to be rather misleading as it can give
> the casual reader the impression that offline CPUs are properly
> cared for.  I'd suggest to either
> 
> - make the routine really safe by doing something like
>     mask &= cpu_online_mask;
>   at the beginning

If the caller is calling smp_call_function_on_cpu directly (in 
contrast to calling it via smp_call_function) they probably 
are targetting a specific group of processors so they have also probably 
done a check of some sort for cpus online, or are explicitely targeting 1 
cpu.

> or else
> 
> - lose the cpu_online test

This could be achieved if s390 (or if we had a generic one, this is 
another story...) had a for_each_cpu type iterator, which would also 
cover aforementioned mask &= cpu_online_map issue, but as an aside, it is 
harder to track down lockups from things like IPIs to invalid cpus than a busy loop 
waiting for num_cpus.

> But apart from this cosmetic issue, there is still a real problem:
> smp_ext_bitcall can fail due to SIGP returning a busy condition;
> smp_ext_bitcall_others would have retried until the busy condition
> is gone.  This means your version can actually lose signals and
> deadlock.  You should do something like
> 
> 	while (smp_ext_bitcall(i, ec_call_function) == sigp_busy)
> 		udelay(10);

Thanks i wasn't aware of that, i'll add that.

> B.t.w as you are removing the only caller of smp_ext_bitcall_others,
> you might as well delete the function itself.
> 
> All those comments apply likewise to the s390x version.

Thanks,
	Zwane
-- 
function.linuxpower.ca
