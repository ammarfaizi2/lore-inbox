Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbTFWEPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 00:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbTFWEPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 00:15:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:59308 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265401AbTFWEP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 00:15:28 -0400
Date: Sun, 22 Jun 2003 20:28:42 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-ID: <20030623032842.GA1167@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <133430000.1055448961@baldur.austin.ibm.com> <20030612134946.450e0f77.akpm@digeo.com> <20030612140014.32b7244d.akpm@digeo.com> <150040000.1055452098@baldur.austin.ibm.com> <20030612144418.49f75066.akpm@digeo.com> <184910000.1055458610@baldur.austin.ibm.com> <20030620001743.GI18317@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620001743.GI18317@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 02:17:43AM +0200, Andrea Arcangeli wrote:
> maybe I'm missing something silly but this fixes nothing IMHO. It's not
> a coincidence I used the seq_lock (aka frlock in 2.4-aa) in my fix, a
> single counter increment isn't nearly enough, you definitely need _both_
> an entry and exit point in do_truncate or you'll never know if
> vmtruncate has been running under you. The first increment is like the
> down_read, the second increment is the up_read. Both are necessary to
> trap any vmtruncate during the do_no_page.
> 
> Your patch traps this timing case:
> 
> 	CPU 0			CPU 1
> 	----------		-----------
> 				do_no_page
> 	truncate
> 				read counter
> 
> 	increment counter
> 	vmtruncate
> 				->nopage
> 				read counter again -> different so retry

Yep!

> but you can't trap this with a single counter increment in do_truncate:
> 
> 	CPU 0			CPU 1
> 	----------		-----------
> 				do_no_page
> 	truncate
> 	increment counter
> 				read counter
> 				->nopage
> 	vmtruncate
> 				read counter again -> different so retry
> 
> thanks to the second counter increment after vmtruncate in my fix, the
> above race couldn't happen.

The trick is that CPU 0 is expected to have updated the filesystem's
idea of what pages are available before calling vmtruncate,
invalidate_mmap_range() or whichever.  Thus, once the counter
has been incremented, ->nopage() will see the results of the
truncation and/or invalidation, and will either block waiting
for the page to come back from some other node, or hand back
an error, as appropriate.

Or am I missing something here?

> About the down(&inode->i_sem); up(), that you dropped under Andrew's
> suggestion, while that maybe ugly, it will have a chance to save cpu,
> and since it's a slow path such goto, it's definitely worthwhile to keep
> it IMHO. Otherwise one cpu will keep scheduling in a loop until truncate
> returns, and it can take time since it may have to do I/O or wait on
> some I/O semaphore. It wouldn't be DoSable, because the
> ret-from-exception will check need_resched, but still it's bad for cpu
> utilization and such a waste can be avoided trivially as in my fix.

If we really can get away with a single increment, then it wouldn't
loop unless there were several vmtruncate()s or invalidate_mmap_range()s
going on concurrently.

> I was chatting with Daniel about those hooks a few minutes ago, and he
> suggested to make do_no_page a callback itself (instead of having
> do_no_page call into a ->nopage further callback). And to provide by
> default a generic implementation that would be equivalent to the current
> do_no_page. As far as I can tell that will save both the new pointer to
> function for the DSM hook (that IMHO has to be taken twice, both before
> ->nopage and after ->nopage, not only before the ->nopage, for the
> reason explained above) and the ->nopage hook itself. So maybe that
> could be a cleaner solution to avoid the DSM hooks enterely, so we don't
> have more hooks but less, and a library call. This sounds the best for
> performance and flexibility. (talking only about 2.5 of course, 2.4 I
> think is just fine with my ""production"" 8) fix here:

Yep, I was chatting with Daniel earlier, and that chatting was what lead
to my earlier -- and more complex -- patch.

Of course, I would be happy to rediff it only current kernels, but Dave's
patch is much simpler, and has passed some fairly severe torture tests.
(As has my earlier one.)  At this point, however, Dave's looks better
to me.  Yes, the Linux tradition of simplicity is rubbing off even on
an old-timer like me.  ;-)

						Thanx, Paul

> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1/2.4.21rc8aa1/9999_truncate-nopage-race-1
> 
> )
> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
