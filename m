Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTFWHaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTFWHaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:30:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8599
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264394AbTFWH36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:29:58 -0400
Date: Mon, 23 Jun 2003 09:43:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: paulmck@us.ibm.com, dmccr@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-ID: <20030623074353.GE19940@dualathlon.random>
References: <133430000.1055448961@baldur.austin.ibm.com> <20030612134946.450e0f77.akpm@digeo.com> <20030612140014.32b7244d.akpm@digeo.com> <150040000.1055452098@baldur.austin.ibm.com> <20030612144418.49f75066.akpm@digeo.com> <184910000.1055458610@baldur.austin.ibm.com> <20030620001743.GI18317@dualathlon.random> <20030623032842.GA1167@us.ibm.com> <20030622233235.0924364d.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030622233235.0924364d.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 11:32:35PM -0700, Andrew Morton wrote:
> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> >
> > > but you can't trap this with a single counter increment in do_truncate:
> >  > 
> >  > 	CPU 0			CPU 1
> >  > 	----------		-----------
> >  > 				do_no_page
> >  > 	truncate
> 
>         i_size = new_i_size;
> 
> >  > 	increment counter
> >  > 				read counter
> >  > 				->nopage
> 
>                                 check i_size
> 
> >  > 	vmtruncate
> >  > 				read counter again -> different so retry
> >  > 
> >  > thanks to the second counter increment after vmtruncate in my fix, the
> >  > above race couldn't happen.
> > 
> >  The trick is that CPU 0 is expected to have updated the filesystem's
> >  idea of what pages are available before calling vmtruncate,
> >  invalidate_mmap_range() or whichever.
> 
> i_size has been updated, and filemap_nopage() will return NULL.

ok, I finally see your object now, so it's the i_size that was in theory
supposed to act as a "second" increment on the truncate side to
serialize against in do_no_page.

I was searching for any additional SMP locking, and infact there is
none.  No way the current code can serialize against the i_size.

The problem is that the last patch posted on l-k isn't guaranteeing
anything like what you wrote above.  What can happen is that the i_size
can be read still way before the counter.


 	CPU 0			CPU 1
	----------		-----------
				do_no_page
	truncate
 
                                specualtive read i_size into l2 cache
        i_size = new_i_size;

	increment counter
 				read counter
				->nopage
				check i_size from l2 cache
 

 	vmtruncate
 				read counter again -> different so retry


For the single counter increment patch to close the race using the
implicit i_size update as a second increment, you need to add an
absolutely necessary smb_rmb() here:

        sequence = atomic_read(&mapping->truncate_count);
+	smp_rmb();	
        new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);

And for non-x86 you need a smb_wmb() between the i_size = new_i_size and
the atomic_inc on the truncate side too, because advanced archs with
finegrined locking can implement a one-way barrier, where the counter
increment could pass the down(&mapping->i_shared_sem). Last but not the
least it was IMHO misleading and dirty to do the counter increment in
truncate after taking a completely unrelated semaphore just to take
advantage of the implicit barrier on the x86. So doing it with a proper
smp_wmb() besides fixing advanced archs will kind of make the code
readable, so you can understand the i_size update is the second
increment (actually decrement because it's the i_size).

Now that I see what the second increment was supposed to be, it's a cute
idea to use the i_size for that, and I can appreciate its beauty (I
mean, in purist terms, in practice IMHO the seq_lock was more obivously
correct code with all the smp reordering hidden into the lock semantics
and I'm 100% sure you couldn't measure any performance difference in
truncate due the second increment ;). But if you prefer to keep the most
finegrined approch of using the i_size with the explicit memory
barriers, I'm of course not against it after you add the needed fixed I
outlined above that will finally close the race.

thanks,

Andrea
