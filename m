Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbVIAVkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbVIAVkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbVIAVkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:40:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49547 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030410AbVIAVkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:40:06 -0400
Date: Thu, 1 Sep 2005 14:42:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       ananth@in.ibm.com, prasanna@in.ibm.com
Subject: Re: [PATCH]kprobes fix bug when probed on task and isr functions
Message-Id: <20050901144211.5bf5ded6.akpm@osdl.org>
In-Reply-To: <20050901142734.A29448@unix-os.sc.intel.com>
References: <20050901134937.A29041@unix-os.sc.intel.com>
	<20050901140938.69909683.akpm@osdl.org>
	<20050901142734.A29448@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
>
> > >  void __kprobes lock_kprobes(void)
> > >  {
> > > +	unsigned long flags = 0;
> > > +
> > > +	local_irq_save(flags);
> > >  	spin_lock(&kprobe_lock);
> > >  	kprobe_cpu = smp_processor_id();
> > > + 	local_irq_restore(flags);
> > >  }
> > 
> > what is this change trying to do?  If a lock is taken from both process and
> > irq contexts then local IRQs must be disabled for the entire period when the
> > lock is held, not just for a little blip like this.  If IRQ-context code is
> > running this function then the code is deadlockable.
> 
> In the kprobe exception handling we relay on kprobe_cpu = smp_processor_id() to determine
> whether we are inside the kprobe or not. It was so happeing that when we
> take the lock and before kprobe_cpu gets updated if an H/W interrupt happens
> and if kprobe is enabled on ISR routine, then in the kprobe execption handler
> for isr, we miss the indication that we are already in kprobes(since interrupt
> happened before we get to update kprobe_cpu) and we were trying to 
> take the lock again and there by causing the deadlock. This deadlock is avoided
> by disabling the ISR for a short period while we take the spin_lock() and update
> the kprobe_cpu.

OK.

Are you sure that other CPUs can safely read kprobe_cpu without taking the
lock?  I don't see any memory barriers in there...

> > 
> > Now, probably there's deep magic happening here and I'm wrong.  If so then
> > please explain the code's magic via a comment patch so the question doesn't
> > arise again, thanks.
> > 
> 
> This whole serialization will go away when we introduce the scalability patch.

Yes, it does look rather unscalable.
