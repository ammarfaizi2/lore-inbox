Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272339AbTG3Xnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272340AbTG3Xnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:43:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6290 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S272339AbTG3Xns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:43:48 -0400
Date: Wed, 30 Jul 2003 18:43:18 -0500
From: linas@austin.ibm.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, olh@suse.de, olof@austin.bim.com,
       linas@austin.ibm.com
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730184317.B23750@forte.austin.ibm.com>
References: <20030730082848.GC23835@dualathlon.random> <Pine.LNX.4.44.0307301223450.13299-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307301223450.13299-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Jul 30, 2003 at 12:31:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OK, I finally spent some time studying the timer code and am starting 
to grasp it.  I think I finally understand the bug.  Andrea's timer->lock 
patch will fix it for 2.4 and everybody says it can't happen in 2.6 so
ok.


On Thu, Jul 31, 2003 at 12:17:17AM +0200, Andrea Arcangeli wrote:
> So the best fix would be to nuke the run_all_timers thing from 2.4 too.

Yes.

>and to keep the timer->lock everywhere to make run_all_timers safe.

Or do that instead, yes.

> In short the stack traces I described today were all right but only for
> 2.4, and not for 2.6.

I see the bug in 2.4.  

On Wed, Jul 30, 2003 at 12:31:23PM +0200, Ingo Molnar wrote:
> 
> On Wed, 30 Jul 2003, Andrea Arcangeli wrote:
> 
> > 
> > 	cpu0			cpu1
> > 	------------		--------------------
> > 
> > 	do_setitimer
> > 				it_real_fn
> > 	del_timer_sync		add_timer	-> crash
> 
> would you mind to elaborate the precise race? I cannot see how the above
> sequence could crash on current 2.6:
 
I don't know enough about how 2.6 works to say, 
but here's more detail on what happened in 2.4:


cpu 0                                              cpu 3
-------                                          ---------
                                      previously,  timer->base = cpu 3 base
                                          (its task-struct->real_timer)
bh_action() {
__run_timers() {                          sys_setitimer() {
  it_real_fn() // called as fn()              del_timer_sync() {
    add_timer() {                               spinlock (cpu3 base)
      spinlock (cpu0 base)
        timer->base = cpu0 base                    detach_timer (timer)
          list_add(&timer->list)
                                                   timer->list.next = NULL;
  and now timer is vectored in but can't be unlinked.

And so either of Andrea's fixes should fix this race.

--linas
