Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVFEOgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVFEOgk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 10:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVFEOgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 10:36:40 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:49538 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261574AbVFEOg2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 10:36:28 -0400
Date: Sun, 5 Jun 2005 16:35:53 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, plist fixes
In-Reply-To: <20050605134916.GA20721@elte.hu>
Message-Id: <Pine.OSF.4.05.10506051602010.4252-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 5 Jun 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > [...] In extreme load situations we could end up with a lot of waiters 
> > on mmap_sem forinstance.
> 
> what do you mean by extreme load. Extreme number of RT tasks, or extreme 
> number of tasks altogether? The sorted-list implementation i had in -RT 
> had all non-RT tasks handled in an O(1) way - the O(N) component was for 
> adding RT tasks (removal was O(1)).
> 
> so the question is - can we have an extreme (larger than 140) number of 
> RT tasks? If yes, why are they all RT - they can have no expectation of 
> good latencies with a possible load factor of 140!

I can't really imagine a properly working application having more than 140
RT tasks pounding on the same lock - except maybe if someone tries to run
an RT application on one of those Altrix thingies (#CPUS>140 :-).

But as I said I could imagine a situation where you have some really
important RT tasks you would like to survive even if your low priority RT
tasks does something bad - like keep spawning RT tasks which all waits on
the same lock. 

Actually this test would make the difference:

thread1:
 lock(&badlock);
 block_on_some_event_which_might_never_arrive();
 unlock(&badlock);

func:
 lock(&badlock);
 unlock(&badlock);
 done=1;

thread2:
 while(!done) {
   create_thread(func,RTprio=50);
   create_thread(func,RTprio=51);
   if(done) break;
   sleep(1);
 }   

If you have enough memory for all the tasks, this kind of code would not
be a problem with plists - it will only take a lot of memory. On the other
hand with sorted lists each thread will take longer time inside raw
spinlocks. At some point it will take the whole 1 sec and basicly nothing
else can run.

Ofcourse you can prevent this with ulimits...

What I would do in this discussion is to abstract the interface:
The rt_mutex code should not care if plists, sorted lists or what ever are
used. It should just have a prio_queue structure and prio_queue_add(),
prio_queue_first(), a prio_queue_for_each macro etc. Then Daniel can play
along with his plists and have it as a config-option for now. Someone who
doesn't care about the memory consumption, could even choose to use the
prio_array from the scheduler!
 
> 
> 	Ingo

Esben

