Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTBOQu2>; Sat, 15 Feb 2003 11:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTBOQu2>; Sat, 15 Feb 2003 11:50:28 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:24108
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264705AbTBOQu1>; Sat, 15 Feb 2003 11:50:27 -0500
Date: Sat, 15 Feb 2003 11:56:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH][2.5][8/14] smp_call_function_on_cpu - s390
In-Reply-To: <200302151604.RAA02344@faui11.informatik.uni-erlangen.de>
Message-ID: <Pine.LNX.4.50.0302151149150.16012-100000@montezuma.mastecende.com>
References: <200302151604.RAA02344@faui11.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Ulrich Weigand wrote:

> Hmm.  I think this code still has a problem.  If the caller
> passes in a mask containing bits for offline CPUs, those will
> be counted here

It would be a bug in the caller, this is a primitive really. If the caller 
is calling this with random bitmasks they are probably making errors 
elsewhere too. This is also the behaviour of the Alpha version, which has 
been around before this patch.

> > +	num_cpus = hweight32(mask);
> 
> but there will be no external interrupt generated for those,
> and thus this loop
> 
> > +	while (atomic_read(&data.started) != num_cpus)
> 
> will never terminate ...

The following cpu_online call only goes as far as avoiding IPI'ing to 
nonexistent cpus, anything more would be spoonfeeding the caller, i prefer 
garbage in, garbage out.

	for (i = 0; i < NR_CPUS; i++) {
		if (cpu_online(i) && ((1UL << i) & mask))
			smp_ext_bitcall(i, ec_call_function);
	}

Thanks,
	Zwane
-- 
function.linuxpower.ca
