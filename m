Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWCSCkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWCSCkB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWCSCjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:39:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751367AbWCSCjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:39:23 -0500
Date: Sat, 18 Mar 2006 18:38:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: kernel-stuff@comcast.net, linux-kernel@vger.kernel.org,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <20060318165302.62851448.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Mar 2006, Andrew Morton wrote:
>
> Yes, uninlining merely first_cpu() shrinks my usual vmlinux by 2.5k.  I'll
> fix it up.

The thing is, we could do _so_ much better if we just fixed the "calling 
convention" for that loop.

In particular, if we instead of

	for_each_cpu_mask(cpu, mask) 
		.. do something with cpu ..

had

	for_each_cpu_mask(cpu, mask) {
		.. do something with cpu ..
	} end_for_each_online_cpu;

we could do

	#if NR_CPUS <= BITS_IN_LONG
	#define for_each_cpu_mask(cpu, mask) 				\
		{ unsigned long __cpubits = (mask)->bits[0];		\
		  for (cpu = 0; __cpubits; cpu++, cpubits >>= 1) {	\
			if (!(__cpubits & 1))				\
				continue;

	#define end_for_each_cpu_mask	} }

then the code we'd generate would be
 (a) tons smaller
 (b) lots faster
than what we do now. No uninlining necessary, because we'd simply not have 
any complex code to either inline or to call.

The reason the code sucks right now is that the interface is bad, and 
causes us to do insane things to make it work at all with that syntax.

(We already have this kind of thing for the "do_each_thread / 
while_each_thread" interface to make it work sanely. Also, anybody who has 
ever played with "sparse" has seen the wonderful and flexible 
FOR_EACH_PTR() .. END_FOR_EACH_PTR() interface that allows for efficient 
pointer list traversal).

			Linus
