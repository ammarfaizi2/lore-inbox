Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUERXBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUERXBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 19:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUERXBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 19:01:07 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:30358 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S263713AbUERXBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 19:01:01 -0400
To: Roland Dreier <roland@topspin.com>
Cc: ebiederm@xmission.com (Eric W. Biederman), Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Robert.Picco@hp.com,
       linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com,
       Greg KH <greg@kroah.com>
Subject: Re: readq/writeq on 32bit machines
References: <40A3F805.5090804@hp.com> <40A40204.1060509@pobox.com>
	<40A93DA5.4020701@hp.com> <20040517160508.63e1ddf0.akpm@osdl.org>
	<20040517161212.659746db.akpm@osdl.org> <40A94857.9030507@pobox.com>
	<20040517163356.506a9c8f.akpm@osdl.org> <40A94DF7.30307@pobox.com>
	<20040517184621.0da52a3c.akpm@osdl.org> <40A96E11.5040000@pobox.com>
	<m1vfit3939.fsf_-_@ebiederm.dsl.xmission.com>
	<52fz9xpp5l.fsf@topspin.com>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 18 May 2004 17:01:14 -0600
In-Reply-To: <52fz9xpp5l.fsf@topspin.com>
Message-ID: <m3hdudtk5h.fsf@maxwell.lnxi.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> writes:

> Thanks for posting this Eric... I sent a less detailed reply yesterday
> (pointing out that atomic writeq is needed sometimes) but it seems to
> have gotten eaten.
> 
>     Eric> This issue came last night on the openib list.  The driver
>     Eric> currently rolls it's own version of writeq and in the case
>     Eric> where there is not an atomic 64bit write it needs to a
>     Eric> spinlock to make certain things don't get out of order.  The
>     Eric> driver fails with the current 2 writel() version.
> 
>     Eric> Here is an SSE version, that should not be to intrusive.
>     Eric> According to intel's docs a 64bit aligned 64bit write is
>     Eric> atomic all of the way back to the Pentium.  If
>     Eric> kernel_fpu_begin/kernel_fpu_end are safe in interrupt
>     Eric> context we can do an atomic/correct version of writeq for
>     Eric> x86 processors that don't support sse as well.  Although I
>     Eric> don't know if we want to.
> 
> 	static inline void __raw_writeq(u64 val, unsigned long dest)
> 	{
> 		unsigned long cr0;
> 		u64 xmmsave __attribute__((aligned(8));
> 		preempt_disable();
> 	        cr0 = read_cr0();
> 		clts();
> 	        asm volatile (
> 			"movlps %%xmm0,(%0); \n\t"
> 			"movlps (%2),%%xmm0; \n\t"
> 			"movlps %%xmm0,(%1); \n\t"
> 			"movlps (%0),%%xmm0; \n\t"
> 			: =m (&xmmsave), "=m" ((void *)dest)
> 			: "m" (&val)
> 			);
> 		write_cr0(cr0);
> 		preempt_enable();
> 	}
> 
> This is pretty much what I wrote in the above-mentioned openib
> driver.  However I'm worried about using 
> 
>         u64 xmmsave __attribute__((aligned(8));
> 
> for a stack variable.  I don't think gcc respects the alignment
> attribute for stack variables (I've had a problem in the past using
> movdqa to a stack variable, even if I do __attribute__((aligned(16))).
> If we're sure gcc aligns xmmsave properly, stick a comment in and
> leave out the __attribute__; if not then I think we have to do

I picked that up out of xor.h where the raid code does something similar,
so if there is a problem it needs to be fixed there as well.

> 
>         u8 xmmsave[8 + 7];
> 
> and then use ~7 & (xmmsave + 7).
> 
>     Eric> Thinking about this a little more we might be able to get
>     Eric> away with.
> 
> 	static inline void __raw_writeq(u64 val, unsigned long dest)
> 	{
> 		unsigned long flags;
> 	        local_irq_save(flags);
> 		writel(val & 0xffffffff, addr);
> 		writel(val >> 32, addr + 4);
> 	        irq_restore(flags);
> 	}
> 
> I don't think this is good enough on SMP.  In the openib case, it's
> entirely possible for one CPU to be ringing a (64-bit) work queue
> doorbell at the same time as another CPU is ringing a (64-bit)
> completion queue doorbell, and if the 32-bit halves of those doorbells
> get interleaved, the hardware gets confused.  Maybe there's some magic
> aspect of the PC hardware that ensures this can't happen but I'd hate
> to count on it without some very good documentation.

Right.  It does make the window incredibly small though.  I am even
nervous that the version with a spinlock might break, if something really
needs an atomic guarantee.  


Eric
