Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265963AbTFWGPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 02:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbTFWGP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 02:15:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:2701
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265963AbTFWGP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 02:15:26 -0400
Date: Mon, 23 Jun 2003 08:29:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-ID: <20030623062920.GC19940@dualathlon.random>
References: <133430000.1055448961@baldur.austin.ibm.com> <20030612134946.450e0f77.akpm@digeo.com> <20030612140014.32b7244d.akpm@digeo.com> <150040000.1055452098@baldur.austin.ibm.com> <20030612144418.49f75066.akpm@digeo.com> <184910000.1055458610@baldur.austin.ibm.com> <20030620001743.GI18317@dualathlon.random> <20030623032842.GA1167@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623032842.GA1167@us.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sun, Jun 22, 2003 at 08:28:42PM -0700, Paul E. McKenney wrote:
> On Fri, Jun 20, 2003 at 02:17:43AM +0200, Andrea Arcangeli wrote:
> > but you can't trap this with a single counter increment in do_truncate:
> > 
> > 	CPU 0			CPU 1
> > 	----------		-----------
> > 				do_no_page
> > 	truncate
> > 	increment counter
> > 				read counter
> > 				->nopage
> > 	vmtruncate
> > 				read counter again -> different so retry
> > 
> > thanks to the second counter increment after vmtruncate in my fix, the
> > above race couldn't happen.
> 
> The trick is that CPU 0 is expected to have updated the filesystem's
> idea of what pages are available before calling vmtruncate,
> invalidate_mmap_range() or whichever.  Thus, once the counter
> has been incremented, ->nopage() will see the results of the
> truncation and/or invalidation, and will either block waiting
> for the page to come back from some other node, or hand back
> an error, as appropriate.
> 
> Or am I missing something here?

Let me add the truncate_inode_pages too (it was implicit for me, but
it's more correct to make it explicit to better explain what is going on
and why the single increment in truncate can't fix the race). 

 	CPU 0			CPU 1
 	----------		-----------
 				do_no_page
 	truncate
 	increment counter
 				read counter
 				->nopage returns "page"
			
 	vmtruncate
	truncate_inode_pages()
	"page" becomes anonymous
	
 				read counter again -> still the same
				install "page" in the address space

IMHO the race you're missing (and the reason I had to use the seq_lock
and not just a single counter increment in truncate) is the above one.
there's no serialization at all between ->nopage and truncate.
Also single incrementing the counter inside the semaphore isn't needed
(could be outside the semaphore too). I very much considered the above
scenario while designing the seq_lock fix.

The issue is that while ->nopage will make sure to do the I/O on a page
inside the pagecache, there's no guarantee at all about what ->nopage
will return after the I/O has completed, and even if ->nopage returns a
page inside pagecache, the parallel truncate can still nuke it and make it
anonymous anytime under do_no_page (after ->nopage has returned). hence
the race above. truncate_inode_pages will convert the page to anonymous
and do_no_page has no way to trap it w/o the proper locking in my patch,
to know if any truncate is racing on the same inode. do_no_page simply
can't check the page->mapping, even if it loops for 10 minutes on
page->mapping it will never know if the other cpu has a truncate running
and it got stuck into an irq for 10 minutes too ;).

This is why I had to use the seq_lock to know if any truncate is running
in parallel, a single increment simply can't provide that info and it's
in turn still buggy.

If I'm missing some new locking of 2.5 that would prevent the
truncate_inode_pages to run after ->nopage returned let me know of
course of course, I just can't see it. 

Also note, here I'm focusing first on the local filesystem case, not on
the DSM yet. This is the bug in 2.4/2.2 etc.. that Dave was looking into
fixing (and I agree it needs fixing to provide proper VM semantics to
userspace).

> > About the down(&inode->i_sem); up(), that you dropped under Andrew's
> > suggestion, while that maybe ugly, it will have a chance to save cpu,
> > and since it's a slow path such goto, it's definitely worthwhile to keep
> > it IMHO. Otherwise one cpu will keep scheduling in a loop until truncate
> > returns, and it can take time since it may have to do I/O or wait on
> > some I/O semaphore. It wouldn't be DoSable, because the
> > ret-from-exception will check need_resched, but still it's bad for cpu
> > utilization and such a waste can be avoided trivially as in my fix.
> 
> If we really can get away with a single increment, then it wouldn't
> loop unless there were several vmtruncate()s or invalidate_mmap_range()s
> going on concurrently.

same goes for my "real" fix, it would never loop in practice, but since
the "retry" path is a slow path in the first place, IMHO we should do a
dummy down/up on the i_sem semaphore too to avoid wasting cpu in the
unlikely case. I agree on the layering violation, but that's just a
beauty issue, in practice the down()/up() makes perfect sense and in
turn I prefer it. Dropping it makes no technical sense to me.

Oh really in 2.4.22pre (and in 2.5 too after the i_alloc_sem gets
forward ported) I really need to change the down(i_sem) to a
down_read(i_alloc_sem), since I only need to serialize against truncate,
not anything else (not write etc..). (noted in my todo list, trivial
change, just must not forget it ;)

> 
> > I was chatting with Daniel about those hooks a few minutes ago, and he
> > suggested to make do_no_page a callback itself (instead of having
> > do_no_page call into a ->nopage further callback). And to provide by
> > default a generic implementation that would be equivalent to the current
> > do_no_page. As far as I can tell that will save both the new pointer to
> > function for the DSM hook (that IMHO has to be taken twice, both before
> > ->nopage and after ->nopage, not only before the ->nopage, for the
> > reason explained above) and the ->nopage hook itself. So maybe that
> > could be a cleaner solution to avoid the DSM hooks enterely, so we don't
> > have more hooks but less, and a library call. This sounds the best for
> > performance and flexibility. (talking only about 2.5 of course, 2.4 I
> > think is just fine with my ""production"" 8) fix here:
> 
> Yep, I was chatting with Daniel earlier, and that chatting was what lead
> to my earlier -- and more complex -- patch.
> 
> Of course, I would be happy to rediff it only current kernels, but Dave's
> patch is much simpler, and has passed some fairly severe torture tests.

did the single counter increment pass any torture tests? Maybe they're
all focused on the DSM and not at all on the local race that Dave
pointed out originally in l-k?

> (As has my earlier one.)  At this point, however, Dave's looks better
> to me.  Yes, the Linux tradition of simplicity is rubbing off even on
> an old-timer like me.  ;-)

;)

Andrea
