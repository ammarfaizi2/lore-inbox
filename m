Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272342AbTG3X4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272356AbTG3X4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:56:19 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29642
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272342AbTG3X4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:56:11 -0400
Date: Thu, 31 Jul 2003 01:56:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linas@austin.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, olh@suse.de, olof@austin.bim.com
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730235607.GC322@dualathlon.random>
References: <20030730082848.GC23835@dualathlon.random> <Pine.LNX.4.44.0307301223450.13299-100000@localhost.localdomain> <20030730184317.B23750@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730184317.B23750@forte.austin.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 06:43:18PM -0500, linas@austin.ibm.com wrote:
> Hi,
> 
> OK, I finally spent some time studying the timer code and am starting 
> to grasp it.  I think I finally understand the bug.  Andrea's timer->lock 
> patch will fix it for 2.4 and everybody says it can't happen in 2.6 so
> ok.
> 
> 
> On Thu, Jul 31, 2003 at 12:17:17AM +0200, Andrea Arcangeli wrote:
> > So the best fix would be to nuke the run_all_timers thing from 2.4 too.
> 
> Yes.
> 
> >and to keep the timer->lock everywhere to make run_all_timers safe.
> 
> Or do that instead, yes.
> 
> > In short the stack traces I described today were all right but only for
> > 2.4, and not for 2.6.
> 
> I see the bug in 2.4.  
> 
> On Wed, Jul 30, 2003 at 12:31:23PM +0200, Ingo Molnar wrote:
> > 
> > On Wed, 30 Jul 2003, Andrea Arcangeli wrote:
> > 
> > > 
> > > 	cpu0			cpu1
> > > 	------------		--------------------
> > > 
> > > 	do_setitimer
> > > 				it_real_fn
> > > 	del_timer_sync		add_timer	-> crash
> > 
> > would you mind to elaborate the precise race? I cannot see how the above
> > sequence could crash on current 2.6:
>  
> I don't know enough about how 2.6 works to say, 
> but here's more detail on what happened in 2.4:
> 
> 
> cpu 0                                              cpu 3
> -------                                          ---------
>                                       previously,  timer->base = cpu 3 base
>                                           (its task-struct->real_timer)
> bh_action() {
> __run_timers() {                          sys_setitimer() {
>   it_real_fn() // called as fn()              del_timer_sync() {
>     add_timer() {                               spinlock (cpu3 base)
>       spinlock (cpu0 base)
>         timer->base = cpu0 base                    detach_timer (timer)
>           list_add(&timer->list)
>                                                    timer->list.next = NULL;
>   and now timer is vectored in but can't be unlinked.
> 
> And so either of Andrea's fixes should fix this race.

exactly. If you want to nuke the run_all_timers from the 2.4 backport
feel free, then we could drop the additional locking from
add_timer/del_timer* and leave it only in mod_timer like 2.6 does, that
will avoid cacheline bouncing in the small window when the local timer
irq run on top of an irq handler. In the meantime the kernel is already
solid (again ;).

2.6 will kernel crash like we did in 2.4 only if it calls
add_timer_on from timer context (of course with a cpuid != than the
smp_processor_id()), that would be fixed by the timer->lock everywhere
that we've in 2.4 right now.  (but there's no add_timer_on in 2.4
anyways)

BTW, it's reassuring it wasn't lack of 2.6 stress testing, I apologize
for claiming that.

Andrea
