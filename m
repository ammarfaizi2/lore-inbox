Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268575AbTCCRQa>; Mon, 3 Mar 2003 12:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268576AbTCCRQ3>; Mon, 3 Mar 2003 12:16:29 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:42889 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S268575AbTCCRQ1>; Mon, 3 Mar 2003 12:16:27 -0500
Date: Mon, 3 Mar 2003 12:26:54 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: David Hinds <dhinds@sonic.net>
cc: David Hinds <dahinds@users.sourceforge.net>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fallback to PCI IRQs for TI bridges
In-Reply-To: <20030301093814.A6700@sonic.net>
Message-ID: <Pine.LNX.4.50.0303031203300.17551-100000@marabou.research.att.com>
References: <Pine.LNX.4.50.0302281944470.6367-100000@marabou.research.att.com>
 <20030301093814.A6700@sonic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David!

> > yenta_socket in 2.5.63 knows different models of the bridges and sets IRQ
> > routing to PCI for certain models.  I don't really like this approach.
>
> I have not looked at the most recent 2.5.* kernels but if that is true
> then you're right, it is ill conceived.

I'm not aware of the "political" situation around PCMCIA drivers, but I
think it's sad that the kernel drivers are pushed (e.g. by Red Hat) in the
hope that they will get more visibility and will be improved, but the
people who have the best expertize still use pcmcia-cs drivers and work on
improving them.

I just found that my patch for checking SOCKET_PRESENT flag in
access_configuration_register() and many other functions has not been
propagated to the kernel (I'll send a separate patch), so removing a card
using e.g. the HostAP driver still results in a kernel oops.

> > The chip can be integrated into the motherboard, and we don't know if the
> > ISA IRQ lines are connected or not.  The architecture may not support ISA
> > bus (e.g. PowerPC), then there will be no ISA interrupts, no matter what
> > chip is used.
>
> Which raises an issue I've been wondering about, how to tell when a
> kernel is being built for a system with ISA bus capabilities.  The
> current code checks CONFIG_ISA but that's probably a bad idea.

I think it CONFIG_ISA is meant to be that.  The "ISA support" is so
trivial from the kernel perspective, that the line between systems with
and without ISA is somewhat blurred.

I have an Geode-based embedded system that has no ISA slots, but it has
ISA devices (like serial ports) on the southbridge chip, and it also has
an integrated Ricoh Cardbus/PCMCIA controller, which can use both ISA and
PCI interrupts for cards.

If ISA is disabled, then the PCMCIA socket driver shouldn't even probe ISA
interrupts.  Also, the serial ports and probably the PS/2 keyboard should
be disabled.  This still leaves a working system if USB keyboard is used.
On the other hand, I don't know if it's such a good idea for an i386-based
system and whether it will save any significant amount of memory.

>From the practical point of view, ISA interrupts should be probed if there
are necessary functions for that.  Leave it to the architecture-specific
functions, like probe_irq_on() to decide whether they want to try
something for real or not.

-- 
Regards,
Pavel Roskin
