Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVCPQEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVCPQEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVCPQEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:04:12 -0500
Received: from radius8.csd.net ([204.151.43.208]:50327 "EHLO
	bastille.tuells.org") by vger.kernel.org with ESMTP id S262658AbVCPQEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:04:06 -0500
Date: Wed, 16 Mar 2005 10:10:09 -0700
From: marcus hall <marcus@tuells.org>
To: linux-kernel@vger.kernel.org
Subject: 8259 PIC overwrite problems
Message-ID: <20050316171009.GA6665@bastille.tuells.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello..

I am having a problem with a 2.4.20 kernel running on a Geode processor.
I think I am seeing a problem with the ICW2 of the primary 8259 PIC
being overwritten...

The kernel is configured with APIC enabled, although the geode actually
has the old-standard 8259A equivalents cascaded together.  The immediately
visable symptom I see is the message "unexpected IRQ trap at vector a8",
which is in apic.c in the ack_none() function.  If I un-configure APIC,
I get the similar (but less informative) message from head.S
"Unknown interrupt".  I sometimes see vectors like "cc" or "c8" instead of
"a8".

What I believe is happening is that the ICW2 register in the PIC is being
somehow overwritten with "a8", "cc", or "c8", then on the next interrupt, it
sends out that vector which takes me to IRQ0xa8_interrupt (or whichever
vector), which reports the bogus interrupt, but the real interrupt has been
lost, so I never get an ack to the PIC and interrupts cease.  Actually, I
suspect that the "cc", "c8", etc values are probably interrupt masks being
written to 0x21 after somebody accidently writes something to 0x20 that
looks like an ICW1 (bit 4==1).

Now, experimenting around, I have put in some test code called from ack_none()
to look at the PICs, and I see various reasonable interrupts pending (eth0,
sound, timer, etc.).  So, I tried calling interrupt[irq]() after receiving
the bogus interrupt, and I subsequently get another bogus interrupt, and
so on (my printk() calls bog things down and I die pretty soon afterwards,
but it does look like every interrupt is using the bogus vector).  This has
me pretty well convinced that the ICW2 has somehow been overwritten.

Has anything like this been seen elsewhere?  I seem to always see this
problem show up when dealing with the sound driver, so I'm thinking that
something may very well have some outb() arguments reversed or something,
but since the OCW2 register is write-only, I can't readily check the sanity
until I start getting bogus interrupts.

I'm trying to generate a work-around to re-program the 8259 when the bogus
interrupts occur (unfortunately, this seems to also reset the edge detect),
but I'd really rather find the source of the problem, so any suggestions on
strategies to find the culprit would be most welcomed!

Thanks in advance!

Marcus Hall
CorAccess Systems
