Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSFUTNI>; Fri, 21 Jun 2002 15:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316776AbSFUTNH>; Fri, 21 Jun 2002 15:13:07 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:26509 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316775AbSFUTNG>; Fri, 21 Jun 2002 15:13:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Optimisation for smp_num_cpus loop in hotplug 
In-reply-to: Your message of "Fri, 21 Jun 2002 11:31:44 -0400."
             <200206211531.g5LFViZ07396@localhost.localdomain> 
Date: Sat, 22 Jun 2002 05:17:19 +1000
Message-Id: <E17LTuK-0003HM-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200206211531.g5LFViZ07396@localhost.localdomain> you write:
> rusty@rustcorp.com.au said:
> > Yeah, it's simple, and none of the current ones are really critical.
> > But I think we're better off with:
> > 	for (i = first_cpu(); i < NR_CPUS; i = next_cpu(i)) {
> 
> > Which is simple enough not to need an iterator macro, and also has the
> > bonus of giving irq-balancing et al. an efficient, portable way of
> > looking for the "next" cpu. 
> 
> So you're thinking that next_cpu(i) is something like
> 
> __ffs((~(unsigned)((1<<i)-1) & cpu_online_map)
> 
> plus an extra exception piece to take next_cpu(i) above NR_CPUS if we have no
 
> remaining CPUs (because __ffs would be undefined)?  It's the exception piece 
> that I don't see how to do really efficiently.

find_next_bit already does this, but the generic one would look
something like:

	unsigned long mask = ~(unsigned long)((1<<(cpu+1))-1);
	if (mask & cpu_online_map)
		return _ffs(mask & cpu_online_map);
	return NR_CPUS;

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
