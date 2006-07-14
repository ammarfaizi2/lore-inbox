Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161137AbWGNPy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161137AbWGNPy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 11:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbWGNPy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 11:54:28 -0400
Received: from mailgate.terastack.com ([195.173.195.66]:26889 "EHLO
	uk-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1161137AbWGNPy1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 11:54:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Date: Fri, 14 Jul 2006 16:54:25 +0100
Message-ID: <89E85E0168AD994693B574C80EDB9C270464C6DC@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Thread-Index: AcamZU83D6YFwDlPRZGLtXEmxZel2wAJqNMgADRqY7A=
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > On Thu, 13 Jul 2006 08:56:01 +0100
> > "Andy Chittenden" <AChittenden@bluearc.com> wrote:
> > 
> > > > On Wed, 12 Jul 2006 08:58:52 +0100
> > > > "Andy Chittenden" <AChittenden@bluearc.com> wrote:
> > > > 
> > > > > I tried to install the linux-image-2.6.17-1-amd64-k8-smp 
> > > > debian package
> > > > > on a ASUS M2NPV-VM motherboard based system and it hung 
> > > > during boot. The
> > > > > last message on the console was:
> > > > > 
> > > > >  io scheduler cfq registered
> > > > 
> > > > Suggest you add initcall_debug to the kernel boot command 
> > > > line.  That'll
> > > > tell us which initcall got stuck.
> > > 
> > > I was only able to scrounge 5 minutes on this system this morning.
> > > Here's the last few messages output with initcall_debug on:
> > > 
> > > Calling initcall .... init+0x0/0xc()
> > > Calling initcall .... noop_init+0x0/0xc()
> > > io scheduler noop registered
> > > Calling initcall .... as_init+0x0/0x4f()
> > > io scheduler anticipatory registered (default)
> > > Calling initcall .... deadline_init+0x0/0x4f()
> > > io scheduler deadline registered
> > > Calling initcall .... cfq_init+0x0/0xcc()
> > > io scheduler cfq registered
> > > Calling initcall .... pci_init+0x0/0x2b()
> > > 
> > > What other info can I grab? (Although I have to fit in with that
> > > system's production schedule so I may not be able to come 
> > back with that
> > > until later on today/tomorrow).
> > 
> > Seems one of the quirks has gone bad.  The below should tell 
> > us which one. 
> > You'll need to correlate it with the machine's lspci output please.
> > 
> > 
> > --- a/drivers/pci/pci.c~a
> > +++ a/drivers/pci/pci.c
> > @@ -925,6 +925,7 @@ static int __devinit pci_init(void)
> >  	struct pci_dev *dev = NULL;
> >  
> >  	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, 
> > dev)) != NULL) {
> > +		printk("%s: fix up %s\n", __FUNCTION__, pci_name(dev));
> >  		pci_fixup_device(pci_fixup_final, dev);
> >  	}
> >  	return 0;
> 
> Having applied that patch, I get:
> 
> pci_init: fix up 0000:00:00.0
> pci_init: fix up 0000:00:00.1
> pci_init: fix up 0000:00:00.2
> pci_init: fix up 0000:00:00.3
> pci_init: fix up 0000:00:00.4
> pci_init: fix up 0000:00:00.5
> pci_init: fix up 0000:00:00.6
> pci_init: fix up 0000:00:00.7
> pci_init: fix up 0000:00:02.0
> pci_init: fix up 0000:00:03.0
> pci_init: fix up 0000:00:04.0
> pci_init: fix up 0000:00:05.0
> pci_init: fix up 0000:00:09.0
> pci_init: fix up 0000:00:0a.0
> pci_init: fix up 0000:00:0a.1
> pci_init: fix up 0000:00:0a.2
> pci_init: fix up 0000:00:0b.0
> 
> lspci -v gives:
> 
> 00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         Capabilities: [44] HyperTransport: Slave or Primary Interface
>         Capabilities: [e0] HyperTransport: MSI Mapping
> 
> 00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 
> 0 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
> 
> 00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 
> 1 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
> 
> 00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 
> 5 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
> 
> 00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 
> 4 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
> 
> 00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         Capabilities: [44] #00 [00fe]
>         Capabilities: [fc] #00 [0000]
> 
> 00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 
> 3 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
> 
> 00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 
> 2 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
> 
> 00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge 
> (rev a1) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000a000-0000afff
>         Memory behind bridge: fd800000-fd8fffff
>         Prefetchable memory behind bridge: 
> 00000000fd700000-00000000fd700000
>         Capabilities: [40] #0d [0000]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 
> 64bit+ Queue=0/1 Enable+
>         Capabilities: [60] HyperTransport: MSI Mapping
>         Capabilities: [80] Express Root Port (Slot+) IRQ 0
>         Capabilities: [100] Virtual Channel
> 
> 00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge 
> (rev a1) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>         I/O behind bridge: 00008000-00008fff
>         Memory behind bridge: fde00000-fdefffff
>         Prefetchable memory behind bridge: 
> 00000000fdd00000-00000000fdd00000
>         Capabilities: [40] #0d [0000]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 
> 64bit+ Queue=0/1 Enable+
>         Capabilities: [60] HyperTransport: MSI Mapping
>         Capabilities: [80] Express Root Port (Slot+) IRQ 0
>         Capabilities: [100] Virtual Channel
> 
> 00:04.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge 
> (rev a1) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>         I/O behind bridge: 0000b000-0000bfff
>         Memory behind bridge: fdc00000-fdcfffff
>         Prefetchable memory behind bridge: 
> 00000000fd900000-00000000fd900000
>         Capabilities: [40] #0d [0000]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 
> 64bit+ Queue=0/1 Enable+
>         Capabilities: [60] HyperTransport: MSI Mapping
>         Capabilities: [80] Express Root Port (Slot+) IRQ 0
>         Capabilities: [100] Virtual Channel
> 
> 00:05.0 VGA compatible controller: nVidia Corporation C51PV 
> [GeForce 6150] (rev a2) (prog-if 00 [VGA])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81cd
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 58
>         Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at e0000000 (64-bit, prefetchable) [size=256M]
>         Memory at fb000000 (64-bit, non-prefetchable) [size=16M]
>         [virtual] Expansion ROM at dc000000 [disabled] [size=128K]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 
> 64bit+ Queue=0/0 Enable-
> 
> 00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         Capabilities: [44] HyperTransport: Slave or Primary Interface
>         Capabilities: [e0] HyperTransport: MSI Mapping
> 
> 00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a3)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
> 
> 00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel, IRQ 255
>         I/O ports at 4c00 [size=64]
>         I/O ports at 4c40 [size=64]
>         Capabilities: [44] Power Management version 2
> 
> 00:0a.2 RAM memory: nVidia Corporation MCP51 Memory 
> Controller 0 (rev a3)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
> 
> 00:0b.0 USB Controller: nVidia Corporation MCP51 USB 
> Controller (rev a3) (prog-if 10 [OHCI])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 233
>         Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [44] Power Management version 2
> 
> 00:0b.1 USB Controller: nVidia Corporation MCP51 USB 
> Controller (rev a3) (prog-if 20 [EHCI])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
>         Memory at fe02e000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [44] Debug port
>         Capabilities: [80] Power Management version 2
> 
> 00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev a1) 
> (prog-if 8a [Master SecP PriP])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         I/O ports at f400 [size=16]
>         Capabilities: [44] Power Management version 2
> 
> 00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA 
> Controller (rev a1) (prog-if 85 [Master SecO PriO])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 50
>         I/O ports at 09f0 [size=8]
>         I/O ports at 0bf0 [size=4]
>         I/O ports at 0970 [size=8]
>         I/O ports at 0b70 [size=4]
>         I/O ports at e000 [size=16]
>         Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [44] Power Management version 2
>         Capabilities: [b0] Message Signalled Interrupts: 
> 64bit+ Queue=0/2 Enable-
>         Capabilities: [cc] HyperTransport: MSI Mapping
> 
> 00:0f.0 IDE interface: nVidia Corporation MCP51 Serial ATA 
> Controller (rev a1) (prog-if 85 [Master SecO PriO])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
>         I/O ports at 09e0 [size=8]
>         I/O ports at 0be0 [size=4]
>         I/O ports at 0960 [size=8]
>         I/O ports at 0b60 [size=4]
>         I/O ports at cc00 [size=16]
>         Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [44] Power Management version 2
>         Capabilities: [b0] Message Signalled Interrupts: 
> 64bit+ Queue=0/2 Enable-
>         Capabilities: [cc] HyperTransport: MSI Mapping
> 
> 00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev 
> a2) (prog-if 01 [Subtractive decode])
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         Bus: primary=00, secondary=04, subordinate=04, sec-latency=128
>         I/O behind bridge: 00009000-00009fff
>         Memory behind bridge: fdb00000-fdbfffff
>         Prefetchable memory behind bridge: fda00000-fdafffff
>         Capabilities: [b8] #0d [0000]
>         Capabilities: [8c] HyperTransport: MSI Mapping
> 
> 00:10.1 Audio device: nVidia Corporation MCP51 High 
> Definition Audio (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81cb
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225
>         Memory at fe024000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [44] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 
> 64bit+ Queue=0/0 Enable-
>         Capabilities: [6c] HyperTransport: MSI Mapping
> 
> 00:14.0 Bridge: nVidia Corporation MCP51 Ethernet Controller (rev a3)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 816a
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225
>         Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
>         I/O ports at c800 [size=8]
>         Capabilities: [44] Power Management version 2
> 
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 
> [Athlon64/Opteron] HyperTransport Technology Configuration
>         Flags: fast devsel
>         Capabilities: [80] HyperTransport: Host or Secondary Interface
> 
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 
> [Athlon64/Opteron] Address Map
>         Flags: fast devsel
> 
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 
> [Athlon64/Opteron] DRAM Controller
>         Flags: fast devsel
> 
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 
> [Athlon64/Opteron] Miscellaneous Control
>         Flags: fast devsel
>         Capabilities: [f0] #0f [0010]
> 
> 04:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
> IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
>         Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
>         Flags: bus master, medium devsel, latency 32, IRQ 209
>         Memory at fdbff000 (32-bit, non-prefetchable) [size=2K]
>         Memory at fdbf8000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [44] Power Management version 2
> 
> So I guess there's something awry with the USB controller driver?
> 

Is there any other info that someone wants to track this down? Or has
someone got a fix?
 
-- 
Andy, BlueArc Engineering
