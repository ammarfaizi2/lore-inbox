Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbUARTHn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 14:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUARTHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 14:07:43 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:8835
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263178AbUARTHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 14:07:41 -0500
Date: Sun, 18 Jan 2004 14:06:52 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Chris McDermott <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: RE: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch
 UP installer kernels
In-Reply-To: <7F740D512C7C1046AB53446D37200173618848@scsmsx402.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0401152200230.4208@montezuma.fsmlabs.com>
References: <7F740D512C7C1046AB53446D37200173618848@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004, Nakajima, Jun wrote:

> What happens first is you will see kernel data corruption as irq exceeds
> 224 (NR_IRQS).
>
> In setup_IO_APIC_irqs(), for example, we do
> 	if (IO_APIC_IRQ(irq)) {
>              vector = assign_irq_vector(irq);
>              entry.vector = vector;
>              ioapic_register_intr(irq, vector, IOAPIC_AUTO);
>
>              if (!apic && (irq < 16))
>                     disable_8259A_irq(irq);
>       }
>
> Then ioapic_register_intr() does:
>       if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
>                 trigger == IOAPIC_LEVEL)
>                         irq_desc[irq].handler = &ioapic_level_type;
>                 else
>                         irq_desc[irq].handler = &ioapic_edge_type;
>                 set_intr_gate(vector, interrupt[irq]);
>
> Now of course irq_desc_t irq_desc[NR_IRQS], and same with interrupt[].
>
> I think we need to add checking in IO_APIC_IRQ(irq) like from
> #define IO_APIC_IRQ(x) (((x) >= 16) || ((1<<(x)) & io_apic_irqs)) to
>
> #define IO_APIC_IRQ(x) (((x) < NR_IRQS) && ((x) >= 16) || ((1<<(x)) &
> io_apic_irqs))

That looks fine to me, early bailout is safest. James is this ok with you?

Thanks,
	Zwane
