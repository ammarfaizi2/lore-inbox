Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317416AbSFMCmI>; Wed, 12 Jun 2002 22:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317418AbSFMCmH>; Wed, 12 Jun 2002 22:42:07 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:62198 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317416AbSFMCmG>; Wed, 12 Jun 2002 22:42:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
In-Reply-To: Your message of "Wed, 12 Jun 2002 15:10:48 +0200."
             <15623.18520.760673.208158@kim.it.uu.se> 
Date: Thu, 13 Jun 2002 12:42:13 +1000
Message-Id: <E17IKYw-00032x-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15623.18520.760673.208158@kim.it.uu.se> you write:
> This means keeping a logical->physical map and iterating like this:
> 
>      for(i = 0; i < nr_online_cpus; ++i)
> 	   do_something_with(cpu_logical_map(i));
>
> (I care because my performance-monitoring counters driver by necessity
> is closely tied to CPU identities and the set of online CPUs.)

I disagreed, so I measured, and you are right 8(  I hate that.

Simply reading the performance monitors across all CPUs is a case
where the extra loop overhead is significant (although cache effects
may still dominate): 9 times slower on PPC if there are only 2 CPUs
and NR_CPUS is 32.

I'd definitely prefer a per-arch for_each_cpu() implementation to
exposing a mapping, eg:

	/* No hotplug cpus on this arch. */
	extern int max_cpu_num;
	#define for_each_cpu(__i) for (__i = 0; __i < max_cpu_num; __i++)

OR
	extern int cpu_next_map[NR_CPUS];
	#define for_each_cpu(__i) \
		for (__i = 0; __i < NR_CPUS; __i = cpu_next_map[__i])

[ Soapbox mode: cut here ]

My philosophy is that parts of infrastructure which is not used by >
90% of people tends to get misused.  Two recent concrete examples:

	cpu_logical_map() is currently a noop on x86
		=> Ingo fucked it up in his initial scheduler impl.
	copy_from_user() returns POSTIVE on failure
		=> 7% of uses of copy_from_user were buggy in 2.5.19.

My feeling is that kernel coding is becoming more challenging (SMP,
preemption, portability), and our bug count and time-to-kernel-mastery
is climbing as a result.  One method of countering this is by
carefully designing infrastructure to make the simplest method for
writing common operations also the correct one.

Sometimes old-timers don't see infrastructure they are used to as a
problem, but even they make mistakes.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
