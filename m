Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbVIAV1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbVIAV1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbVIAV1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:27:47 -0400
Received: from fmr22.intel.com ([143.183.121.14]:62086 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030397AbVIAV1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:27:46 -0400
Date: Thu, 1 Sep 2005 14:27:35 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       ananth@in.ibm.com, prasanna@in.ibm.com
Subject: Re: [PATCH]kprobes fix bug when probed on task and isr functions
Message-ID: <20050901142734.A29448@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20050901134937.A29041@unix-os.sc.intel.com> <20050901140938.69909683.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050901140938.69909683.akpm@osdl.org>; from akpm@osdl.org on Thu, Sep 01, 2005 at 02:09:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 02:09:38PM -0700, Andrew Morton wrote:
> Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
> >
> > 	This patch fixes a race condition where in system used to hang
> > or sometime crash within minutes when kprobes are inserted on 
> > ISR routine and a task routine.
> 
> It's desirable that the patch descriptions tell us _how_ a bug was fixed,
> as well as what the bug was.  It means that people don't have to ask
> questions like:
Sure, our current kprobes model is very serialized where in we serve only
one kprobe in the exception handler by holding this lock_kprobes() and
release this lock i.e unlock_kprobes() when we are done with single stepping

> 
> >  void __kprobes lock_kprobes(void)
> >  {
> > +	unsigned long flags = 0;
> > +
> > +	local_irq_save(flags);
> >  	spin_lock(&kprobe_lock);
> >  	kprobe_cpu = smp_processor_id();
> > + 	local_irq_restore(flags);
> >  }
> 
> what is this change trying to do?  If a lock is taken from both process and
> irq contexts then local IRQs must be disabled for the entire period when the
> lock is held, not just for a little blip like this.  If IRQ-context code is
> running this function then the code is deadlockable.

In the kprobe exception handling we relay on kprobe_cpu = smp_processor_id() to determine
whether we are inside the kprobe or not. It was so happeing that when we
take the lock and before kprobe_cpu gets updated if an H/W interrupt happens
and if kprobe is enabled on ISR routine, then in the kprobe execption handler
for isr, we miss the indication that we are already in kprobes(since interrupt
happened before we get to update kprobe_cpu) and we were trying to 
take the lock again and there by causing the deadlock. This deadlock is avoided
by disabling the ISR for a short period while we take the spin_lock() and update
the kprobe_cpu.

> 
> Now, probably there's deep magic happening here and I'm wrong.  If so then
> please explain the code's magic via a comment patch so the question doesn't
> arise again, thanks.
> 

This whole serialization will go away when we introduce the scalability patch.

-Anil
