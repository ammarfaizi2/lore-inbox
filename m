Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274875AbTGaW4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274885AbTGaW4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:56:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:46829 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S274875AbTGaW4Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:56:24 -0400
Date: Thu, 31 Jul 2003 17:56:06 -0500
From: linas@austin.ibm.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030731175605.A26460@forte.austin.ibm.com>
References: <20030729135643.2e9b74bc.akpm@osdl.org> <Pine.LNX.4.44.0307300733200.25010-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307300733200.25010-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Jul 30, 2003 at 07:57:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mingo,

On Wed, Jul 30, 2003 at 07:57:32AM +0200, Ingo Molnar wrote:
> 
> On Tue, 29 Jul 2003, Andrew Morton wrote:
> > Andrea says that we need to take the per-timer lock in add_timer() and
> > del_timer(), but I haven't yet got around to working out why.
> 
> this makes no sense - in 2.6 (and in 2.4) there's no safe add_timer() /
> del_timer() use without using external SMP synchronization. (There's one
> special timer use variant involving del_timer_sync() that was safe in 2.4
> but is unsafe in 2.6, see below.)

I don't understand why you don't like this, since your patch seems to 
acheive the same results as Andrea's patch (he uses timer->lock to 
serialize add_timer() and del_timer(), where as your patch modifies
add_timer so that it grabs locks on old_base as well as new_base;
either approach should fix the add_timer/del_timer race.)

> What i'd propose is the attached (tested, against 2.6.0-test2) patch
> instead. It unifies the functionality of add_timer() and mod_timer(), and
> makes any combination of the timer API calls completely SMP-safe.  
> del_timer() is still not using the timer lock.
> 
> this patch fixes the only timer bug in 2.6 i'm aware of: the
> del_timer_sync() + add_timer() combination in kernel/itimer.c is buggy.
> This was correct code in 2.4, because there it was safe to do an
> add_timer() from the timer handler itself, parallel to a del_timer_sync().  
> If we want to make this safe in 2.6 too (which i think we want to) then we
> have to make add_timer() almost equivalent to mod_timer(), locking-wise.
> And once we are at this point i think it's much cleaner to actually make
> add_timer() a variant of mod_timer(). (There's no locking cost for
> add_timer(), only the cost of an extra branch. And we've removed another
> commonly used function from the icache.)

Well, I'm confused by this a bit too, now.  I saw this bug in 2.4 and I 
thought that Andrea was implying that it couldn't happen in 2.6. 
He seemed to be saying that the del_timer_sync() + add_timer() race
can happen only in 2.4, where add_timer() is running on the 'wrong' cpu 
bacuase it got there through the evil run_all_timers()/TIMER_BH.  Since 
there's no run_all_timers() in 2.6, he seemed to imply that the race 
'couldn't happen'.  Is he right?  

So, to add to my 'stupid question' quota of the day: the only way that
a timer could run on a CPU other than what it was added on would be for 
a softirq to somehow get moved to a different cpu, and that is impossible,
right?

> Linas, could you please give this patch a go, does it make a difference to
> your timer list corruption problem? I've booted it on SMP and UP as well.

Still trying ... but after reading it, it looks like it will fix my 2.4 bug.  

--linas

