Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264117AbRFNW3q>; Thu, 14 Jun 2001 18:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264121AbRFNW3g>; Thu, 14 Jun 2001 18:29:36 -0400
Received: from smtp-rt-13.wanadoo.fr ([193.252.19.223]:43248 "EHLO
	oxera.wanadoo.fr") by vger.kernel.org with ESMTP id <S264117AbRFNW3W>;
	Thu, 14 Jun 2001 18:29:22 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Going beyond 256 PCI buses
Date: Fri, 15 Jun 2001 00:29:01 +0200
Message-Id: <20010614222901.13715@smtp.wanadoo.fr>
In-Reply-To: <15145.14057.67940.752173@pizda.ninka.net>
In-Reply-To: <15145.14057.67940.752173@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It's funny you mention this because I have been working on something
>similar recently.  Basically making xfree86 int10 and VGA poking happy
>on sparc64.

Heh, world is small ;)

>But this has no real use in the kernel.  (actually I take this back,
>read below)

yup, fbcon at least... 

>You have a primary VGA device, that is the one the bios (boot
>firmware, whatever you want to call it) enables to respond to I/O and
>MEM accesses, the rest are configured to VGA pallette snoop and that's
>it.  The primary VGA device is the kernel console (unless using some
>fbcon driver of course), and that's that.

Yup, fbcon is what I have in mind here

>The secondary VGA devices are only interesting to things like the X
>server, and xfree86 does all the enable/disable/bridge-forward-vga
>magic when doing multi-head.

and multihead fbcon. 

>Perhaps, you might need to program the VGA resources of some device to
>use it in a fbcon driver (ie. to init it or set screen crt parameters,
>I believe the tdfx requires the latter which is why I'm having a devil
>of a time getting it to work on my sparc64 box).  This would be a
>seperate issue, and I would not mind at all seeing an abstraction for
>this sort of thing, let us call it:
>
>	struct pci_vga_resource {
>		struct resource io, mem;
>	};
>
>	int pci_route_vga(struct pci_dev *pdev, struct pci_vga_resource *res);
>	pci_restore_vga(void);
>
> [.../...]

Well... that would work for VGA itself (note that this semaphore
you are talking about should be shared some way with the /proc
interface so XFree can be properly sync'ed as well).

But I still think it may be useful to generalize the idea to 
all kind of legacy IO & PIOs. I definitely agree that VGA is a kind
of special case, mostly because of the necessary exclusion on
the VGA IO response.

But what about all those legacy drivers that will issue inx/outx
calls without an ioremap ? Should they call ioremap with hard-coded
legacy addresses ? There are chipsets containing things like legacy
timers, legacy keyboard controllers, etc... and in some (rare I admit)
cases, those may be scattered (or multiplied) on various domains. 
If we decide we don't handle those, then well, I won't argue more
(it's mostly an estethic rant on my side ;), but the problem of
wether they should call ioremap or not is there, and since the
ISA bus can be "mapped" anywhere in the bus space by the host bridge,
there need to be a way to retreive the ISA resources in general for
a given domain.

That's why I'd suggest something like 

pci_get_isa_mem(struct resource* isa_mem);
pci_get_isa_io(struct resource* isa_io);

(I prefer 2 different functions as some platforms like powermac just
don't provide the ISA mem space at all, there's no way to generate
a memory cycle in the low-address range on the PCI bus of those and
they don't have a PCI<->ISA bridge), so I like having the ability of
one of the functions returning an error and not the other.

Also, having the same ioremap() call for both mem IO and PIO means
that things like 0xc0000 cannot be interpreted. It's a valid ISA-mem
address in the VGA space and a valid PIO address on a PCI bus that
supports >64k of PIO space.

I beleive it would make things clearer (and probably implementation
simpler) to separate ioremap and pioremap.

Ben.

>So you'd go:
>
>	struct pci_vga_resource vga_res;
>	int err;
>
>	err = pci_route_vga(tdfx_pdev, &vga_res);
>
>	if (err)
>		barf();
>	vga_ports = ioremap(vga_res.io.start, vga_res.io.end-vga_res.io.start+1);
>	program_video_crtc_params(vga_ports);
>	iounmap(vga_ports);
>	vga_fb = ioremap(vga_res.mem.start, vga_res.mem.end-vga_res.mem.start+1);
>	clear_vga_fb(vga_fb);
>	iounmap(vga_fb);
>
>	pci_restore_vga();
>	
>pci_route_vga does several things:
>
>1) It saves the current VGA routing information.
>2) It configures busses and VGA devices such that PDEV responds to
>   VGA accesses, and other VGA devices just VGA palette snoop.
>3) Fills in the pci_vga_resources with
>   io: 0x320-->0x340 in domain PDEV lives, vga I/O regs
>   mem: 0xa0000-->0xc0000 in domain PDEV lives, video ram
>
>pci_restore_vga, as the name suggests, restores things back to how
>they were before the pci_route_vga() call.  Maybe also some semaphore
>so only one driver can do this at once and you can't drop the
>semaphore without calling pci_restore_vga().  VC switching into the X
>server would need to grab this thing too.

