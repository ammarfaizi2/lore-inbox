Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbUCRR6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbUCRR6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:58:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59012
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262818AbUCRR6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:58:07 -0500
Date: Thu, 18 Mar 2004 18:58:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040318175855.GB2536@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random> <20040318093902.3513903e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318093902.3513903e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 09:39:02AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > > Worst of all we're now taking spinlocks earlier than needed,
> > > 
> > > Where?  CPU scheduler?
> > 
> > Everywhere, see the kmaps, we spinlock before instead of spinlock after,
> > the scheduler, lots of places. I mean, people don't call
> > 
> > 	preempt_disable()
> > 	kmap_atomic
> > 	spin_lock
> > 
> > they do:
> > 
> > 	spin_lock
> > 	kmap_atomic
> 
> They do?   kmap_atomic() disables preemption anyway.

dunno why but see:

	spin_lock(&mm->page_table_lock);
	page_table = pte_offset_map(pmd, address);

		pte_unmap(page_table);
		spin_unlock(&mm->page_table_lock);


etc...

maybe at some point in the past kmap_atomic didn't disable preempt? Just
guessing.

> > so they're effectively optimizing for PREEMPT=y and I don't think this
> > is optimal for the long term. One can aruge the microscalability
> > slowdown isn't something to worry about, I certainly don't worry about
> > it too much either, it's more a bad coding habit to spinlock earlier
> > than needed to avoid preempt_disable.
> > 
> > > > and the preempt_count stuff isn't optmized away by PREEMPT=n,
> > > 
> > > It should be.  If you see somewhere where it isn't, please tell us.
> > 
> > the counter is definitely not optimized away, see:
> > 
> > #define inc_preempt_count() \
> > do { \
> > 	preempt_count()++; \
> > } while (0)
> > 
> > #define dec_preempt_count() \
> > do { \
> > 	preempt_count()--; \
> > } while (0)
> > 
> > #define preempt_count()	(current_thread_info()->preempt_count)
> > 
> > those are running regardless of PREEMPT=n.
> 
> The macros are needed for kmap_atomic().
> 
> The task->preempt field is also used for tracking the hardirq and softirq
> depths (in_interrupt(), in_irq(), in_softirq()) so it cannot be removed
> with CONFIG_PREEMPT=n.
> 
> > > We unconditionally bump the preempt_count in kmap_atomic() so that we can
> > > use atomic kmaps in read() and write().  This is why four concurrent
> > > write(fd, 1, buf) processes on 4-way is 8x faster than on 2.4 kernels.
> > 
> > sorry, why should the atomic kmaps read the preempt_count? Are those ++
> > -- useful for anything more than debugging PREEMPT=y on a kernel
> > compiled with PREEMPT=n? I thought it was just debugging code with
> > PREEMPT=n.
> > 
> > I know why the atomic kmaps speedup write but I don't see how can
> > preempt_count help there when PREEMPT=n, the atomic kmaps are purerly
> > per-cpu and one can't schedule anyways while taking those kmaps (no
> > matter if inc_preempt_count or not).
> 
> We run inc_prempt_count() in kmap_atomic() so that we can perform
> copy_*_user() while holding an atomic kmap in read() and write(). 
> do_page_fault() will detect the elevated preempt count and will return a
> short copy.
> 
> This could be implemented with a separate task_struct field but given that
> preempt_count is always there and the infrastructure exists anyway, using
> preempt_count() is tidier.
> 

thanks for the detailed explanation, so I was definitely wrong about
claiming there was more stuff to optimize away with preempt=n, clearly
it's a great feature your atomic copy-user interrupted by the page
fault. Infact I wonder if we should try once more time and go atomic
again. what you're doing right now is:

	kmap_atomic()
	left = copy_user
	kunmap_atomic
	if (left) {
		kmap() <- persistent unscalable
		copy-user
		kunmap
	}
		
I would suggest we should be even more aggressive like this:

        kmap_atomic()
        left = copy_user
        kunmap_atomic
        if (left) {
		get_user()
        	kmap_atomic()
	        left = copy_user
	        kunmap_atomic
		if (left) {
	                kmap() <- persistent unscalable
        	        copy-user
                	kunmap
		}
        }


It's not going to trigger often anyways, but it's only a few bytecodes
more and it sounds more scalable.
