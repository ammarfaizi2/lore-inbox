Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272869AbTG3Med (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272875AbTG3Mdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:33:31 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20867
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272869AbTG3Mca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:32:30 -0400
Date: Wed, 30 Jul 2003 14:34:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linas@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730123458.GM23835@dualathlon.random>
References: <20030730111639.GI23835@dualathlon.random> <Pine.LNX.4.44.0307301342260.17411-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307301342260.17411-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 01:49:52PM +0200, Ingo Molnar wrote:
> 
> On Wed, 30 Jul 2003, Andrea Arcangeli wrote:
> 
> > in del_timer, list_del can be reordered after the timer->base = NULL,
> > the C compiler can do that. so list_del will run at the same time of
> > internal_add_timer(base, timer) that does the list_add_tail.
> 
> no, it cannot run at the same time. The add_timer() will first lock the
> current CPU's base, before touching the list. Any parallel del_timer() can
> only do the list_del() if it first has locked timer->base. timer->base can
> only have the base of the CPU where it_real_fn is running, or be NULL. In
> the NULL case del_timer() wont do a thing but return. In the other case
> the timer->base value observed by the del_timer()-executing CPU will be
> the same base as where it_real_fn is running, so both the add_timer() and
> the del_timer() will serialize on the same base => no parallel list
> handling possible. How the compiler (or even the CPU, on non-x86) orders
> the writes within the locked section is irrelevant in this scenario.

so if it was really the itimer, it had to be on ppc s390 or ia64, not on
x86.  I never reproduced this myself. I will ask more info on bugzilla,
because I thought it was x86 but maybe it wasn't. As said in the
previous email, only non x86 archs can run the timer irq on a cpu
different than the one where it was inserted.

As Andrew, noted the same race could happen in 2.6 with add_timer_on.
But apparently you're right that the setitimer couldn't trigger on 2.6
or 2.4-aa x86.

Still it could be something else that broke related to
add_timer/del_timer_sync in drivers reproducible in x86 too. As said I
didn't debug or reproduce it myself. It simply looked correct to allow
add_timer to run in parallel of del_timer_sync (no matter which cpu
they're running on, if add_timer runs from inside the timer itself, of
course it can't trigger because the base won't change in add_timer and
del_timer will be a reader falling in the same base, but that's a kind
of special case, and it fails too if you use add_timer_on).

Andrea
