Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUAOWmW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbUAOWmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:42:22 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:41859
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263595AbUAOWmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:42:15 -0500
Date: Thu, 15 Jan 2004 17:40:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: James Cleverdon <jamesclv@us.ibm.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Chris McDermott <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch
 UP installer kernels
In-Reply-To: <200401151357.16807.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0401151719460.4208@montezuma.fsmlabs.com>
References: <7F740D512C7C1046AB53446D3720017361883D@scsmsx402.sc.intel.com>
 <Pine.LNX.4.58.0401141815090.15331@montezuma.fsmlabs.com>
 <200401151357.16807.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004, James Cleverdon wrote:

> > In my opinion we should be breaking after we've exceeded the maximum
> > external vectors we can install. This will of course mean less than
> > the number of RTEs. James have you actually managed to use the devices
> > connected to the high (over ~224) RTEs?
>
> No, I haven't exceeded the available vectors, but wli has on a large NUMA-Q
> box.

Yes i believe the 8 node NUMA-Qs do this easily.

> The x440 and x445's problems are pre-reserving lots of bus numbers in the
> BIOS, more than one per PCI slot.  They must be anticipating PCI cards with
> bridge chips on them.

For some odd reason i thought we had dynamic allocated MP busses.

> I believe that the reason for irq_vector being so large is to allow IRQ (and
> eventually vector) sharing.  The array is to map from RTE to vector.

What i'm trying to say is that the current code will behave badly when you
actually do encounter a system with that many RTEs, the actual array
being that large isn't a problem, the problem is what's going on in
assign_irq_vector() and later on with set_intr_gate(). By that i mean;

- The interrupt[] stub in entry.S is written with 256 irqs in mind so it
wouldn't be able to pass higher irq numbers to do_IRQ in it's current
state.

- "Wrapping" in assign_irq_vector means that you overrite previously
assigned vector entries in the IDT with whatever interrupt[irq] you happen
to be installing at the time. To avoid this you should not be allowing
more than ~224 vectors to be handed out by assign_irq_vector(), with the
patch and the current code, this is possible.

Lastly i think we should avoid sharing vectors, going the IA64 route and
setting up irq handling domains of sorts would allow for easier scaling
both up and down.

Thanks,
	Zwane
