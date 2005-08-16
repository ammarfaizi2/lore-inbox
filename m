Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbVHPVGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbVHPVGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbVHPVGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:06:41 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:15039 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932714AbVHPVGl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:06:41 -0400
Date: Tue, 16 Aug 2005 23:14:24 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays
Message-ID: <20050816211424.GA14367@aitel.hist.no>
References: <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no> <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org> <43008C9C.60806@aitel.hist.no> <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org> <20050815221109.GA21279@aitel.hist.no> <21d7e99705081516182e97b8a1@mail.gmail.com> <21d7e99705081516241197164a@mail.gmail.com> <20050816165242.GA10024@aitel.hist.no> <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 10:00:50AM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 16 Aug 2005, Helge Hafting wrote:
> >
> > I tried rc6 with DRM turned off.  That kernel consistently _died_ when 
> > trying to start xdm. Xorg logs for both cards ended like this:
> > 
> > (II) LoadModule: "pcidata"
> > (II) Loading /usr/X11R6/lib/modules/libpcidata.a
> 
> Ok, it does sound like your X server is doing something nasty on the PCI 
> bus. 
> 
> > I can retry this with a syncronously mounted /var, if the last lines
> > of the Xorg logs might be interesting.
> 
> It would be even more interesting if you have a serial console, but if
> this is the X server stomping on the PCI bus, you might just have a total
> lockup - no oops, no nothing.
> 
Tricky - I have nothing to connect to the serial port.

> One thing that might be interesting is to see if the old working kernel
> has a different IO-map than the broken ones. A simple
> 
> 	cat /proc/ioports /proc/iomem > iomaps.kernel-version
> 
> and diffing the two might be an interesting thing to try. X has been known
> to sometimes just try to re-configure things on its own without telling
> (or asking) the kernel.

Diffing the iomaps thus obtained for 
2.6.13-rc4-6ade43fbbcc3c12f0ddba112351d14d6c82ae476
and 2.6.13-rc6 produce this:
ba112351d14d6c82ae476 iomaps.2.6.13-rc6
17a18
> 5000-5007 : viapro-smbus
52,53c53,54
<   00100000-0041a94c : Kernel code
<   0041a94d-00695337 : Kernel data
---
>   00100000-003fed39 : Kernel code
>   003fed3a-00662f77 : Kernel data

rc6 has a somewhat smaller kernel, and a viapro-smbus.

The X.org logs also got further, with the synchronous mount:

The radeon log ended like this:
        [31] -1 0       0x00009000 - 0x000090ff (0x100) IX[B]
        [32] -1 0       0x00009800 - 0x000098ff (0x100) IX[B](B)
        [33] 0  0       0x000003b0 - 0x000003bb (0xc) IS[B]
        [34] 0  0       0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) RADEON(0): MMIO registers at 0xf6000000
(II) RADEON(0): PCI bus 0 card 8 func 0
(**) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(**) RADEON(0): Option "EnablePageFlip" "off"
(**) RADEON(0): Option "DynamicClocks" "off"
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="X.Org Foundation"
        compiled for 6.8.2, module version = 0.1.0
        ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): vgaHWGetIOBase: hwp->IOBase is 0x03b0, hwp->PIOOffset is 0x0000
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/libint10.a
(II) RADEON(0): initializing int10
(**) RADEON(0): Option "InitPrimary" "on"

It stopped here, while it normally goes on with:
(II) Truncating PCI BIOS Length to 53248
(--) RADEON(0): Chipset: "ATI Radeon 9200SE 5964 (AGP)" (ChipID = 0x5964)
(--) RADEON(0): Linear framebuffer at 0xe0000000
(--) RADEON(0): BIOS at 0x1ff00000
(--) RADEON(0): VideoRAM: 131072 kByte (64 bit DDR SDRAM)
(II) RADEON(0): PCI card detected
(II) Loading sub module "ddc"
...

Seems like it died trying to perform int10 initialization?

The matrox log stopped inside a listing of resource ranges after preInit:
        [29] -1 0       0x0000ac00 - 0x0000ac0f (0x10) IX[B]
        [30] -1 0       0x0000a800 - 0x0000a803 (0x4) IX[B]
        [31] -1 0       0x0000a400 - 0x0000a407 (0x8) IX[B]
        [32] -1 0       0x0000a000 - 0x0000a003 (0x4) IX[B]
        [33] -1 0       0x00009c00 - 0x00009c07 (0x8) IX[B]
        [34] -1 0       0x00009400 - 0x000094ff (0x100) IX[B]
        [35] -1 0       0x00009000 - 0x000090ff (0x100) IX[B]
        [36] 0  0       0x000003b0 - 0x000003bb (0xc) IS[B]

Normally, this continues with:
        [37] 0  0       0x000003c0 - 0x000003df (0x20) IS[B](OprU)
(==) MGA(0): Write-combining range (0xf0000000,0x2000000)
(II) MGA(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(--) MGA(0): 16 DWORD fifo
(==) MGA(0): Default visual is TrueColor
(II) MGA(0): [drm] bpp: 16 depth: 16
(II) MGA(0): [drm] Sarea 2200+664: 2864
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 7, (OK)

I guess the radeon hung the machine, and the matrox xserver simply wasn't
scheduled after that.

The lockup wasn't total - the numlock LED responded to the numlock key
(and similar for capslock) until I did the sysrq+B.  There seemed to be
no reaction, other than no more LED responses. 
This kernel doesn't have ACPI so it can't turn the machine off
when doing a normal shutdown, but it is usually capable rebooting.
The console was black of course, no dumps of any kind.  

I can try running the radeon xserver only, as the vga console is on the matrox
card.

Helge Hafting
