Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271242AbTHLX7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 19:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271245AbTHLX7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 19:59:31 -0400
Received: from fmr06.intel.com ([134.134.136.7]:12755 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S271242AbTHLX72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 19:59:28 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Updated MSI Patches
Date: Tue, 12 Aug 2003 16:59:21 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AE9A@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcNhCkV9no52QJ/iQ4Kcsv5CURLBfAADWmBg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
X-OriginalArrivalTime: 12 Aug 2003 23:59:22.0335 (UTC) FILETIME=[C04006F0:01C3612D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the platform_irq thing is the issue, we can remove it by having like

#ifdef PCI_USE_VECTOR
static struct hw_interrupt_type ioapic_edge_vector_type = {
        .typename       = "IO-APIC-edge",
        .startup        = startup_edge_ioapic_vector,
        .shutdown       = shutdown_edge_ioapic_vector,
        .enable         = enable_edge_ioapic_vector,
        .disable        = disable_edge_ioapic_vector,
        .ack            = ack_edge_ioapic_vector,
        .end            = end_edge_ioapic_vector,
        .set_affinity   = set_ioapic_affinity,
};

static struct hw_interrupt_type ioapic_level_vector_type = {
...

#else
...

They (startup_edge_ioapic_vector, etc.) convert the vector to IRQ when
needed. Note that we need that because interrupt controller(s) still
needs IRQ info for the conventional interrupts when we use vector-based
do_IRQ(). 

For example, startup_edge_ioapic_vector() looks like this:

static unsigned int startup_edge_ioapic_vector(unsigned int vector)
{
	int was_pending = 0;
	unsigned long flags;
	int irq = vector_to_irq (vector);

	spin_lock_irqsave(&ioapic_lock, flags);
	if (irq < 16) {
		disable_8259A_irq(irq);
		if (i8259A_irq_pending(irq))
			was_pending = 1;
	}
	__unmask_IO_APIC_irq(irq);
	spin_unlock_irqrestore(&ioapic_lock, flags);

	return was_pending;
}

Thanks,
Jun

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com]
> Sent: Tuesday, August 12, 2003 12:45 PM
> To: Zwane Mwaikambo
> Cc: Nakajima, Jun; Nguyen, Tom L; Linux Kernel; long
> Subject: Re: Updated MSI Patches
> 
> Zwane Mwaikambo wrote:
> > On Tue, 12 Aug 2003, Jeff Garzik wrote:
> >
> >
> >>So, IMO, do_IRQ is one special case where copying code may be
preferred
> >>over common code.
> >>
> >>And I also feel the same way about do_MSI().  However, I have not
looked
> >>at non-ia32 MSI implementations to know what sort of issues exist.
> >
> >
> > The main reason i have a preference for a seperate MSI handling path
is
> so
> > that we don't have to do the platform_irq thing in do_IRQ and we
know
> > what to expect wrt irq or vector. If platform_irq stays we should at
> > least try and pick up on what the IA64 folks have done, But that
would
> be
> > even harder to get done right now.
> 
> 
> Oh, I definitely prefer a separate MSI handling path too.
> 
> In the future we'll be writing drivers that _require_ MSI interrupt
> handling, and we'll be optimizing the various MSI hot paths to reclaim
> even the most minute amount of CPU cycles.  And we want to escape any
> shackles the evil phrase "legacy interrupts" dares to try to lay upon
us.
> 
> But there is a flip side to that:  do_IRQ is not solely hardware
> interrupts.  That area of code is central dispatcher for
> softirq/tasklet/timer delivery as well.  So a separate do_MSI() needs
to
> take that stuff into account.
> 
> Overall, I'm pretty happy with how Tom's MSI patches are going so far,
> and he seems to be responding to feedback.  So, we'll get there.
> 
> 	Jeff
> 
> 

