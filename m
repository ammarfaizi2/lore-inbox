Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272266AbTG3VSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272267AbTG3VSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:18:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7647 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S272266AbTG3VSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:18:35 -0400
Date: Wed, 30 Jul 2003 16:18:10 -0500
From: linas@austin.ibm.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730161810.B28284@forte.austin.ibm.com>
References: <20030730111639.GI23835@dualathlon.random> <Pine.LNX.4.44.0307301342260.17411-100000@localhost.localdomain> <20030730123458.GM23835@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030730123458.GM23835@dualathlon.random>; from andrea@suse.de on Wed, Jul 30, 2003 at 02:34:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 02:34:58PM +0200, Andrea Arcangeli wrote:
> 
> so if it was really the itimer, it had to be on ppc s390 or ia64, not on
> x86.  I never reproduced this myself. I will ask more info on bugzilla,
> because I thought it was x86 but maybe it wasn't. As said in the
> previous email, only non x86 archs can run the timer irq on a cpu
> different than the one where it was inserted.

I think I started the thread, so let me backtrack.  I've got several
ppc64 boxes running 2.4.21.    They hang, they don't crash.  Sometimes
they're pingable, but that's all.  The little yellow button is wired 
up to KDB, so I can break in and poke around and see what's happening.

Here's what I find:

__run_timers() is stuck in a infinite loop, because there's a 
timer on the base.  However, this timer has timer->list.net == NULL,
and so it can never be removed.  (As a side effect, other CPU's get 
stuck in various places, sitting in spinlocks, etc. which is why the
machine goes unresponsive)  So the question becomes "how did this 
pointer get trashed?"

I thought I saw an "obvious race" in the 2.4 code, and it looked
identical to the 2.6 code, and thus the email went out.  Now, I'm
not so sure; I'm confused.  

However, given that its timer->list.net that is getting clobbered,
then locking all occurrances of list_add and list_del should cure the
problem.   I'm guessing that Andrea's patch to add a timer->lock 
will protect all of the list_add's, list_del's that matter.  

Given that I don't yet understand how timer->list.net got clobbered,
I can't yet say 'yes/no this fixes it'. 

--linas

