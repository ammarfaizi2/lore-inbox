Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272794AbTG3Hce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272795AbTG3Hce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:32:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5600
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272794AbTG3Hcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:32:32 -0400
Date: Wed, 30 Jul 2003 09:34:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linas@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730073458.GA23835@dualathlon.random>
References: <20030729233603.21ad2409.akpm@osdl.org> <Pine.LNX.4.44.0307300842550.29469-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307300842550.29469-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 09:07:59AM +0200, Ingo Molnar wrote:
> 
> On Tue, 29 Jul 2003, Andrew Morton wrote:
> 
> > Well Andrea did mention a problem with the interval timers.  But I am
> > not aware of the exact details of the race which he found, and I don't
> > understand why del_timer() and add_timer() would be needing the
> > per-timer locks.
> 
> hmm ... indeed i cannot see the 2.6 itimer race anymore. Andrea, can you
> see any SMP races in the current 2.6 timer code?
> 
> (in any case, i still think it would be safer to 'upgrade' the add_timer()  
> interface to be SMP-safe and to allow double-adds - but not for any bug
> reason anymore.)

The thing triggered simply by running setitimer in one function, while
the it_real_fn was running in the other cpu. I don't see how 2.6 can
have fixed this, it_real_fun can still trivially call add_timer while
you run inside do_setitimer in 2.6 too. It's simply that 2.6 isn't
running in production yet, so a bug that didn't showup in years of 2.5,
showsup in a month of 2.4. But even if you serialized some how
it_real_fn against do_setitimer (and I don't see any external
serialization in 2.6 in current bkcvs) I wouldn't trust 2.6 drivers not
to execute del_timer_sync in parallel anyways etc.. that's why I didn't
search for too many 2.6 timer bugs too much, and I still suggested to
apply the locking despite I only known about a single bug. The real
scalability optimization is probably only the fast path check in
mod_timer, and the cacheline bouncing avoidance in the timer global data
structures like the cascading queues, the per-timer lock should do well,
and I'd feel much safer with the whole timer API being smp safe w/o
requiring driver developers to add complicated external brainer locking.
This will provide a much more friendly abstraction.

I would be definitely against putting external locking in
do_setitimer/it_timer_fn in 2.6 since like you missed that place, there
can be still tons of other buggy drivers out there that don't trigger
simply because the userspace is still too small.

Andrea
