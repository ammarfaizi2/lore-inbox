Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVE2Ims@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVE2Ims (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 04:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVE2Ims
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 04:42:48 -0400
Received: from [80.71.243.242] ([80.71.243.242]:13268 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261285AbVE2Imo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 04:42:44 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17049.32899.239673.489434@gargle.gargle.HOWL>
Date: Sun, 29 May 2005 12:42:43 +0400
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Subject: Re: spinaphore conceptual draft (was discussion of RT patch)
Newsgroups: gmane.linux.kernel
In-Reply-To: <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com>
References: <934f64a205052715315c21d722@mail.gmail.com>
	<A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett writes:

[...]

 > 
 > struct spinaphore {
 >      atomic_t queued;
 >      atomic_t hold_time;
 >      spinlock_t spinlock;
 >      unsigned long acquire_time;
 > };
 > 
 > void spinaphore_lock (struct spinaphore *sph) {
 >      unsigned long start_time = fast_monotonic_count();

fast_monotonic_count() should be per-cpu, otherwise spinaphore_lock()
would require two atomic operations in the best case (and be twice as
expensive as a spin-lock). Per-cpu counter is OK, as long as thread is
not allowed to schedule with spinaphore held.

 >      int queue_me = 1;
 >      until (likely(spin_trylock(&sph->spinlock))) {
 > 
 >          /* Get the queue count (And ensure we're queued in the  
 > process) */
 >          unsigned int queued = queue_me ?
 >                  atomic_inc_return(&sph->queued) :
 >                  queued = atomic_get(&sph->queued);
 >          queue_me = 0;
 > 
 >          /* Figure out if we should switch away */
 >          if (unlikely(CONFIG_SPINAPHORE_CONTEXT_SWITCH <
 >                  ( queued*atomic_get(&sph->hold_time) -
 >                    fast_monotonic_count() - start_time
 >                  ))) {
 >              /* Remove ourselves from the wait pool (remember to re- 
 > add later) */
 >              atomic_dec(&sph->queued);
 >              queue_me = 1;
 > 
 >              /* Go to sleep */
 >              cond_resched();
 >          }
 >      }
 > 
 >      /* Dequeue ourselves and update the acquire time */
 >      atomic_dec(&sph->queued);

atomic_dec() should only be done if atomic_inc_return() above was, i.e.,
not in contentionless fast-path, right?

[...]

 > 
 > void spinaphore_unlock (struct spinaphore *sph) {
 >      /* Update the running average hold time */
 >      atomic_set(&sph->hold_time, (4*atomic_get(&sph->hold_time) +
 >              (fast_monotonic_count() - sph->acquire_time))/5);
 > 
 >      /* Actually unlock the spinlock */
 >      spin_unlock(&sph->spinlock);
 > }

It is not good that unlock requires additional atomic operation. Why
->hold_time is atomic in the first place? It is only updated by the lock
holder, and as it is approximate statistics anyway, non-atomic reads in
spinaphore_lock() would be fine.

 > 
 > Cheers,
 > Kyle Moffett

Nikita.
