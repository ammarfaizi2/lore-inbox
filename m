Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136674AbREARd7>; Tue, 1 May 2001 13:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136676AbREARdw>; Tue, 1 May 2001 13:33:52 -0400
Received: from jalon.able.es ([212.97.163.2]:10729 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S136674AbREARdh>;
	Tue, 1 May 2001 13:33:37 -0400
Date: Tue, 1 May 2001 19:33:29 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 sluggish under fork load
Message-ID: <20010501193329.C1246@werewolf.able.es>
In-Reply-To: <20010430195149.F19620@athlon.random> <Pine.LNX.4.21.0104302335490.19012-100000@imladris.rielhome.conectiva> <20010501071849.A16474@athlon.random> <20010501185517.A31373@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010501185517.A31373@athlon.random>; from andrea@suse.de on Tue, May 01, 2001 at 18:55:17 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.01 Andrea Arcangeli wrote:
> 
> And if you fork off a child with its p->policy SCHED_YIELD set it will
> never get scheduled in.
> 
> Only "just" running tasks can have SCHED_YIELD set.
> 
> So the below lines are the *right* and most robust approch as far I can
> tell. (plus counter needs to be volatile, as every variable that can
> change under the C code, even while it's probably not required by the
> code involved with current->counter)
> 
> > +	{
> > +		int counter = current->counter >> 1;
> > +		current->counter = p->counter = counter;
> > +		p->policy &= ~SCHED_YIELD;
> > +		current->policy |= SCHED_YIELD;
> > +		current->need_resched = 1;
> > +	}
> 
> Alan, the patch you merged in 2.4.4ac2 can fail like mine, but it may fail in
> a much more subtle way, while I notice if ksoftirqd never get scheduled
> because I synchronize on it and I deadlock, your kupdate/bdflush/kswapd
> may be forked off correctly but they can all have SCHED_YIELD set and
> they will *never* get scheduled. You know what can happen if kupdate
> never gets scheduled... I recommend to be careful with 2.4.4ac2.
> 

It looks like this is related to my problem (see thread [Re: Linux-2.4.4-ac2]).
Funtions __start_kernel called kernel_thread(init,...), and seems to hang
on cpu_idle().

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.4-ac1 #1 SMP Tue May 1 11:35:17 CEST 2001 i686

