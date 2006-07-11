Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWGKJQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWGKJQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWGKJQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:16:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:57018 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750815AbWGKJQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:16:07 -0400
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m18xn0h99q.fsf@ebiederm.dsl.xmission.com>
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	 <m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
	 <1152571162.1576.122.camel@localhost.localdomain>
	 <m14pxolryw.fsf@ebiederm.dsl.xmission.com>
	 <1152595205.6346.26.camel@localhost.localdomain>
	 <m1veq4iri1.fsf@ebiederm.dsl.xmission.com>
	 <9ABD3384-5829-4365-988C-43310D374CE5@kernel.crashing.org>
	 <m18xn0h99q.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 19:15:46 +1000
Message-Id: <1152609347.6346.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Examples? details? patches?
> 
> Part of the problem with plain MSI is that you can't mask irqs at the
> source, in a generic way.

This is an interesting point, because this shows precisely the different
of approach between most HW PPC implementations vs what x86 does and
what the current code does...

Our MSIs are always routed as just additional sources to an existing IRQ
controller that will itself then handle things like masking, affinity,
etc...

Thus, we don't need nor want any kind of generic MSI code setting up an
irq_chip with enable/disable functions etc... Those should stay the ones
from the system's main PIC, maybe a different version of them, but
that's up to the system PIC to set that up.

That's one of the reason why I think we need to work the MSI arch side
API such that the MSI "controller" is the one to setup the irq_desc. The
"generic" mask/unmask/etc... using the MSI(X) config space can be
provided as optional helpers but it should be under arch, or more
specifically MSI controller control to pick up how to setup the irq_desc
and its associated irq_chip.

Another one is the fact that we have multiple different MSI mecanisms on
the same machines (like the Apple Quad G5 which have on one side an MSI
"register" that devices write to and that triggers sources on the MPIC,
and on the other side, HT interrupts which can be generated from MSIs by
the broadcom HT<->PCIe bridge). Thus that msi_ops stucture I've seen
around shall really be per PCI host bridge at the very least. One
propsal I have, but I didn't have time to actually implement it, was to
have the msi_ops pointer be a field in pci_bus that is inherited by
default. That is, the arch can call pci_set_msi_ops() on a given bus and
this will propagate to childs.

Anyway, as I said, I didn't have time to code that part. So it's mostly
food for thoughts.

Ben.


