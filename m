Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274825AbRIUVcY>; Fri, 21 Sep 2001 17:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274843AbRIUVcG>; Fri, 21 Sep 2001 17:32:06 -0400
Received: from hermes.toad.net ([162.33.130.251]:6323 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S274825AbRIUVb6>;
	Fri, 21 Sep 2001 17:31:58 -0400
Message-ID: <3BABB1C2.97A988B7@yahoo.co.uk>
Date: Fri, 21 Sep 2001 17:31:46 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Summary of PnP BIOS problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been looking into the cause of my PnP BIOS woes recently
and FYI here is what I've found out.

1) setpnp contains a bug such that arguments of 0 given to the
   irq or dma command cause setpnp to disable the irq or dma.
   setpnp ought to (try to) set the irq or dma to zero.  The
   way to disable an irq or dma is to do this:
      setpnp -- 0b irq -1
   (The '--' is required so that the '-1' isn't mistaken for an
    option.)
   A patch has been submitted to the pcmcia-cs bug tracking
   system.

2) parport_pc.c contains a bit of mysterious code that rejects
   the assignment of DMA0.  parport_pc treats this as if it
   meant "disabled".  This was discussed in another thread.
   I suspect that the rejection of DMA0 is unnecessary, but
   I may well be wrong.  The current code should at least be 
   commented ... by someone who knows for sure why the code
   is there.

3) pnp_bios.c contained a bug (fixed in -ac13) such that the
   driver would report disabled irqs as IRQ0.  (It ought to
   report a disabled irq as irq -1.)

4) pnp_bios.c swaps the "boot" and "current" configurations.
   The result is that on my ThinkPad "setpnp -b 0b irq 7" changes
   the current configuration while "setpnp 0b irq 7" changes
   the boot configuration.  Also, "setpnp on" copies the current
   to the boot config instead of vice versa.  There may be 
   other strange side-effects of this.  I have just submitted
   a patch to fix this.

5) The pnpbios driver queries the BIOS for all PnP devices at
   init time, then it acts as if the configurations of these
   devices never change, whereas setpnp does change the
   configurations.  Code is needed that will fix this, but 
   only for machines whose BIOSes won't crash the machine if
   they are called later than init time.  Once the preceding
   issues have been addressed (in a couple of weeks) I'll try
   to implement this fix ... unless someone more competent than
   myself wants to volunteer.  :)

6) There remains a problem that I haven't yet figured out:
   On my ThinkPad 600, running the recent -ac kernels (at
   least since 2.4.7) does something to the PnP BIOS such
   that on a subsequent reboot, the current configuration
   of all configurable devices is set to "disable".  I am
   currently working around this problem by running setpnp
   during my boot sequence (which is why I have been so 
   interested in the pnpbios driver of late).  The bug
   should be fixed properly, but I have no idea where the
   bug might be.  Anyone have any ideas?

7) While I'm at it I might as well ask a question that I asked
   before: Would it be possible to connect the isa-pnp driver
   to the pnpbios driver in such a way that device drivers
   would not have to query both in order to determine the
   hardware config.  What I have in mind is that the isa-pnp
   driver would call pnpbios if PnP setup was done by the
   BIOS; otherwise it would go ahead and do the PnP configuration
   itself, as usual.  If this could be implemented then it
   would save us having to make all the device drivers pnpbios-
   aware.

Thomas Hood
