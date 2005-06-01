Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVFAOYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVFAOYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVFAOYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:24:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34707 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261394AbVFAOUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:20:03 -0400
Date: Wed, 1 Jun 2005 16:19:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601141919.GA9282@elte.hu>
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601135154.GF5413@g5.random>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> I've a bug in my queue that definitely would break preempt-RT:
>
>       BUG xxx : spends excessive time with interrupts disabled on large memory>
       systems
>
> workaround:
>
>       #define MAX_ITERATION 100000
>       if ((nr_pages > MAX_ITERATION) && !(nr_pages % MAX_ITERATION)) {
>               spin_unlock_irq(&zone->lru_lock);
>               spin_lock_irq(&zone->lru_lock);
>       }

you are wrong. This codepath is not running with interrupts disabled on 
PREEMPT_RT. irqs-off spinlocks dont turn off interrupts on PREEMPT_RT.  
And yes, it is still fully correct because all IRQs are threaded - so 
all the scheduling has been 'flattened' and can be controlled. That's 
one reason why IRQ and softirq threading is central to the design of 
PREEMPT_RT.

that's also how PREEMPT_RT can reach sub-20-usec _worst-case_ 
rescheduling latencies using generic workloads (i.e. system swapping to 
death doing heavy IDE IO and DMA and networking and _still_ not having 
larger than 10 usecs worst-case latencies!). This is also why your 
earlier 'driver latencies' arguments are wrong as well. Think about it 
Andrea, this is a key property of PREEMPT_RT.

(there are still some ways to introduce latencies into PREEMPT_RT, but 
they are not common and we are working on ways to cover them all.)

[ I'd really prefer if some of the armchair RT experts would actually
  check out PREEMPT_RT, would contribute code, testing or ideas, and 
  generally would attempt to be productive, would attempt to be nice to 
  each other - instead of blasting a project they first saw a few days
  ago when a flamewar got large enough on lkml.  I've not said (or even
  thought) a single bad thing about any other project, i'm just running
  my own. So get a life, date a girl and have some fun and stuff =:-) ]

	Ingo
