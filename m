Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264111AbRFNWNO>; Thu, 14 Jun 2001 18:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264112AbRFNWND>; Thu, 14 Jun 2001 18:13:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41396 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264111AbRFNWM7>;
	Thu, 14 Jun 2001 18:12:59 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.14057.67940.752173@pizda.ninka.net>
Date: Thu, 14 Jun 2001 15:12:57 -0700 (PDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <20010614215709.23875@smtp.wanadoo.fr>
In-Reply-To: <15145.12584.339783.786454@pizda.ninka.net>
	<20010614215709.23875@smtp.wanadoo.fr>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt writes:
 > That would be fine for PIO on PCI, but still is an issue for
 > VGA-like devices that need to issue some "legacy" cycles on
 > a given domain. Currently, on PPC, inx/outx will only go to
 > one bus (arbitrarily choosen during boot) because of that,
 > meaning that we can't have 2 VGA cards on 2 different domains

It's funny you mention this because I have been working on something
similar recently.  Basically making xfree86 int10 and VGA poking happy
on sparc64.

But this has no real use in the kernel.  (actually I take this back,
read below)

You have a primary VGA device, that is the one the bios (boot
firmware, whatever you want to call it) enables to respond to I/O and
MEM accesses, the rest are configured to VGA pallette snoop and that's
it.  The primary VGA device is the kernel console (unless using some
fbcon driver of course), and that's that.

The secondary VGA devices are only interesting to things like the X
server, and xfree86 does all the enable/disable/bridge-forward-vga
magic when doing multi-head.

Perhaps, you might need to program the VGA resources of some device to
use it in a fbcon driver (ie. to init it or set screen crt parameters,
I believe the tdfx requires the latter which is why I'm having a devil
of a time getting it to work on my sparc64 box).  This would be a
seperate issue, and I would not mind at all seeing an abstraction for
this sort of thing, let us call it:

	struct pci_vga_resource {
		struct resource io, mem;
	};

	int pci_route_vga(struct pci_dev *pdev, struct pci_vga_resource *res);
	pci_restore_vga(void);

So you'd go:

	struct pci_vga_resource vga_res;
	int err;

	err = pci_route_vga(tdfx_pdev, &vga_res);

	if (err)
		barf();
	vga_ports = ioremap(vga_res.io.start, vga_res.io.end-vga_res.io.start+1);
	program_video_crtc_params(vga_ports);
	iounmap(vga_ports);
	vga_fb = ioremap(vga_res.mem.start, vga_res.mem.end-vga_res.mem.start+1);
	clear_vga_fb(vga_fb);
	iounmap(vga_fb);

	pci_restore_vga();
	
pci_route_vga does several things:

1) It saves the current VGA routing information.
2) It configures busses and VGA devices such that PDEV responds to
   VGA accesses, and other VGA devices just VGA palette snoop.
3) Fills in the pci_vga_resources with
   io: 0x320-->0x340 in domain PDEV lives, vga I/O regs
   mem: 0xa0000-->0xc0000 in domain PDEV lives, video ram

pci_restore_vga, as the name suggests, restores things back to how
they were before the pci_route_vga() call.  Maybe also some semaphore
so only one driver can do this at once and you can't drop the
semaphore without calling pci_restore_vga().  VC switching into the X
server would need to grab this thing too.

Later,
David S. Miller
davem@redhat.com
