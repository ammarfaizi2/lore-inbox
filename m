Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTEIRCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTEIRCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:02:20 -0400
Received: from franka.aracnet.com ([216.99.193.44]:33240 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263354AbTEIRCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:02:15 -0400
Date: Fri, 09 May 2003 08:00:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 693] New: boot hang early, probably because of shared IRQ not handled correctly by hcd.c / usb_hcd_irq
Message-ID: <36070000.1052492435@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=693

           Summary: boot hang early, probably because of shared IRQ not
                    handled correctly by hcd.c / usb_hcd_irq
    Kernel Version: 2.5.69-bk4
            Status: NEW
          Severity: blocking
             Owner: greg@kroah.com
         Submitter: stephane.loeuillet@tiscali.fr


Distribution: Mandrake 9.1 x86

Hardware Environment: NForce2 chipset (no IGP but has 2 built in ETH100 + AC97 +
OHCI + EHCI) + external USB2-IDE disk drive

Problem Description:

quite early in the boot process (/root not yet mounted, so hardware/pci
probing), it hangs, repeating me the now usual 'irq 10 : nobody noticed!'
several times (looking at arch/i386/kernel/irq.c: handle_IRQ_event, i would say
it displayed it 100 times)

then system is frozen.

as there has been some IRQ changes not long ago in 2.5 kernel, i think this bug
is quite new. but i saw another bug report with "irq 5 : nobody noticed!" but
this time in ISApnp probe (which i haven't compiled in)

the other bug report : http://bugzilla.kernel.org/show_bug.cgi?id=615
perhaps a related one :
http://www.ussg.iu.edu/hypermail/linux/kernel/0305.0/0521.html

=============================================================================
partial trace (hand made, from numbers displayed and System.map content)

c010c4f0 T handle_IRQ_event
c010c730 T do_IRQ
c010acf0 t common_interrupt
c01208b0 T do_softirq
c010c730 T do_IRQ
c010acf0 t common_interrupt
c010cd50 T setup_irq
c02319e0 T usb_hcd_irq
c010c880 T request_irq
c02340e0 T usb_deregister_dev
c01c80e0 t pci_device_probe
c02002d0 t bus_match
c02003e0 t driver_attach
c0200b30 T driver_register
c01c8230 T pci_register_driver
c01c8230 T pci_register_driver
=============================================================================
here is the function i suppose to be the guilty one : 

drivers/usb/core/hcd.c : 

irqreturn_t usb_hcd_irq (int irq, void *__hcd, struct pt_regs * r)
{
	struct usb_hcd		*hcd = __hcd;
	int			start = hcd->state;

	if (unlikely (hcd->state == USB_STATE_HALT))	/* irq sharing? */
		return IRQ_NONE;

	hcd->driver->irq (hcd, r);
	if (hcd->state != start && hcd->state == USB_STATE_HALT)
		usb_hc_died (hcd);
	return IRQ_HANDLED;
}

unfortunatly, my C knowlegde is quite limited, so i don't know how to fix it myself.

=============================================================================
partial lspci -vv output (only hardware using IRQ 10 when booting my 2.4.21) :

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
(prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e8085000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio
Controler (MCP) (rev a1)
	Subsystem: Asustek Computer, Inc.: Unknown device 8095
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at c000 [size=256]
	Region 1: I/O ports at c400 [size=128]
	Region 2: Memory at e8086000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated Fast
Ethernet Controller (rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ab
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b000 [size=128]
	Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


