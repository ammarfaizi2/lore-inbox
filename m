Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWENAab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWENAab (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 20:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWENAaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 20:30:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:40871 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751185AbWENAa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 20:30:28 -0400
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
	userspace (Xorg) to enable devices without doing foul direct access
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Jones <pjones@redhat.com>
Cc: Martin Mares <mj@ucw.cz>, Jon Smirl <jonsmirl@gmail.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <1146778197.27727.26.camel@localhost.localdomain>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041309.53910.bjorn.helgaas@hp.com>
	 <445A51F1.9040500@linux.intel.com>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <1146778197.27727.26.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 14 May 2006 10:29:31 +1000
Message-Id: <1147566572.21291.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> By allowing tools to read the rom from the pci device itself, instead of
> whichever device's rom happens to be at 0xC0000.  libx86emul allows you
> to define routines that it uses for memory access, so you can copy the
> ROM out to normal memory, and map that memory to the appropriate address
> that way.  X and vbetool both already have to do this, but without
> copying the firmware image, to do DDC probing on x86_64.
> 
> > I agree with Arjan that the attribute could be useful for some special
> > tools, but using it in X is likely to be utterly wrong.
> 
> I'm actually talking about vbetool here, though X could use these
> methods.  Indeed, libx86emul comes from X itself.

There are reasons why you may have to read the image at c0000... There's
a bunch of laptops where it's in fact the only way to get to the video
BIOS as it doesn't have a ROM attached to the video chip (it's burried
in the main BIOS which thankfully copied it to c0000 when running it).
In some cases, the BISO ROM self-modifies it's c0000 and it's that
modified copy that the X (or fbdev) driver should get. Remeber that
drivers needs access to the ROM for more than just POSTing the chip...

In addition, we need to centralize VGA routing mecanism in the kernel
for other reasons. For example, because it might imply disabling MMIO or
IO access to other cards (currently, we have to disable _all_ other
cards on the same bus segment that claim to be VGA since we have no way
to know which ones might be able to simply be configured not to decode
legacy VGA accesses, though an appropriate arbiter ABI would allow to
handle that too). Thus am fbdev or X server currently running on another
card would explode in flames while something like vbetool is re-routing
VGA access to a card for POST'ing or other things vbetool can do.

It's a shitty problem, it's complicated, but there is no easy way out
thanks to PC manufacturers and Intel keeping absolutely disgusting VGA
"legacy" crap part of the PCI standard for so long.

Note that I posted various prototypes of what a VGA abiter could look
like a while ago. I have no time to resume work on that and my
prototypes weren't perfect, but that's something one interested party
could probably use as a starting point to a more complete solution.
 
Ben.

