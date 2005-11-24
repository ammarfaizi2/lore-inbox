Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbVKXAV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbVKXAV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbVKXAV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:21:58 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:7132 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030539AbVKXAVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:21:54 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix USB suspend/resume crasher
Date: Thu, 24 Nov 2005 01:22:45 +0100
User-Agent: KMail/1.8.3
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>
References: <1132715288.26560.262.camel@gaston>
In-Reply-To: <1132715288.26560.262.camel@gaston>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WfQhD7FJYP64jhu"
Message-Id: <200511240122.46125.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_WfQhD7FJYP64jhu
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Wednesday, 23 of November 2005 04:08, Benjamin Herrenschmidt wrote:
> This is my latest patch against current linus -git, it closes the IRQ
> race and makes various other OHCI & EHCI code path safer vs.
> suspend/resume. I've been able to (finally !) successfully suspend and
> resume various Mac models, with or without USB mouse plugged, or
> plugging while asleep, or unplugging while asleep etc... all without a
> crash. There are still some races here or there in the USB code, but at
> least the main cause of crash is now fixes by this patch (access to a
> controller that has been suspended, due to either shared interrupts or
> other code path).
> 
> I haven't fixed UHCI as I don't have any HW to test, though I hope I
> haven't broken it neither. Alan, I would appreciate if you could have a
> look.
> 
> This patch applies on top of the patch that moves the PowerMac specific
> code out of ohci-pci.c to hcd-pci.c where it belongs. This patch isn't
> upstream yet for reasons I don't fully understand (why does USB stuffs
> has such a high latency for going upstream ?), I'm sending it as a reply
> to this email for completeness.
> 
> Without this patch, you cannot reliably sleep/wakeup any recent Mac, and
> I suspect PCs have some more sneaky issues too (they don't frankly crash
> with machine checks because x86 tend to silently swallow PCI errors but
> that won't last afaik, at least PCI Express will blow up in those
> situations, but the USB code may still misbehave).

Unfortunately with this patch the EHCI controller in my box (Asus L5D,
x86-64 kernel) does not resume from suspend.  Appended is the relevant
snippet from the serial console log (EHCI is the only device using IRQ #5).

Greetings,
Rafael


PM: Image restored successfully.
ohci_hcd 0000:00:02.0: PCI D0, from previous PCI D3
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.1: PCI D0, from previous PCI D3
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS1] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.2: PCI D0, from previous PCI D3
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUS2] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: lost power, restarting
usb usb3: root hub lost power or was reset
ehci_hcd 0000:00:02.2: reset command 080b02 park=3 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: capability 1000001 at a0
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: reset command 080b02 park=3 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:02.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LAUI] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:06.0 to 64
irq 5: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff80250c3e>{add_preempt_count+94} <ffffffff8015a878>{__report_bad_irq+56}
       <ffffffff8015aab4>{note_interrupt+484} <ffffffff8015a317>{__do_IRQ+199}
       <ffffffff801110f7>{do_IRQ+55} <ffffffff8010f100>{ret_from_intr+0}
       <ffffffff8010fb02>{call_softirq+30} <ffffffff80138714>{__do_softirq+68}
       <ffffffff801386ff>{__do_softirq+47} <ffffffff8010fb02>{call_softirq+30}
       <ffffffff801110b5>{do_softirq+53} <ffffffff8013849f>{irq_exit+63}
       <ffffffff801110fc>{do_IRQ+60} <ffffffff8010f100>{ret_from_intr+0}
        <EOI> <ffffffff802c183a>{serial8250_console_write+186}
       <ffffffff80132dad>{release_console_sem+333} <ffffffff80133587>{vprintk+775}
       <ffffffff80133682>{printk+162} <ffffffff80133682>{printk+162}
       <ffffffff8036003d>{_spin_unlock_irqrestore+29} <ffffffff80252c31>{pci_bus_read_config_byte+113}
       <ffffffff802ed6fe>{pcibios_set_master+110} <ffffffff80255415>{pci_set_master+85}
       <ffffffff88180eb7>{:snd_intel8x0:intel8x0_resume+39}
       <ffffffff8812a9e7>{:snd:snd_card_pci_resume+55} <ffffffff80256c74>{pci_device_resume+36}
       <ffffffff802d5cdd>{resume_device+157} <ffffffff802d5e23>{dpm_resume+147}
       <ffffffff802d5e90>{device_resume+32} <ffffffff80153508>{pm_suspend_disk+296}
       <ffffffff80150f10>{enter_state+112} <ffffffff80151147>{state_store+119}
       <ffffffff801bfdd4>{subsys_attr_store+36} <ffffffff801c025a>{sysfs_write_file+202}
       <ffffffff8017fb09>{vfs_write+233} <ffffffff8017fcb0>{sys_write+80}
       <ffffffff8010eb5e>{system_call+126}
---------------------------
| preempt count: 00010103 ]
| 3 level deep critical section nesting:
----------------------------------------
.. [<ffffffff801332a4>] .... vprintk+0x24/0x360
.....[<ffffffff80133682>] ..   ( <= printk+0xa2/0xb0)
.. [<ffffffff80360176>] .... _spin_lock+0x16/0x30
.....[<ffffffff8015a2fc>] ..   ( <= __do_IRQ+0xac/0x120)
.. [<ffffffff80360176>] .... _spin_lock+0x16/0x30
.....[<ffffffff8015a2fc>] ..   ( <= __do_IRQ+0xac/0x120)

handlers:
[<ffffffff80260970>] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #5


--Boundary-00=_WfQhD7FJYP64jhu
Content-Type: text/x-log;
  charset="utf-8";
  name="lspci-v.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci-v.log"

0000:00:00.0 Host bridge: nVidia Corporation nForce3 Host Bridge (rev a4)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80c5
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

0000:00:01.0 ISA bridge: nVidia Corporation nForce3 LPC Bridge (rev f6)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80c5
	Flags: bus master, 66Mhz, fast devsel, latency 0

0000:00:01.1 SMBus: nVidia Corporation nForce3 SMBus (rev a4)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80c5
	Flags: 66Mhz, fast devsel
	I/O ports at 5000 [size=64]
	I/O ports at 5040 [size=64]
	Capabilities: <available only to root>

0000:00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1858
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 11
	Memory at febfb000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1858
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 11
	Memory at febfc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1859
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 5
	Memory at febfdc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1853
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 10
	I/O ports at e800 [size=256]
	I/O ports at ec00 [size=128]
	Memory at febff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 185a
	Flags: bus master, 66Mhz, fast devsel, latency 0
	I/O ports at ffa0 [size=16]
	Capabilities: <available only to root>

0000:00:0a.0 PCI bridge: nVidia Corporation nForce3 PCI Bridge (rev a2) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=128
	I/O behind bridge: 0000b000-0000dfff
	Memory behind bridge: f8a00000-feafffff
	Prefetchable memory behind bridge: 40000000-43ffffff

0000:00:0b.0 PCI bridge: nVidia Corporation nForce3 AGP Bridge (rev a4) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: f6900000-f89fffff
	Prefetchable memory behind bridge: c6800000-e67fffff

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: <available only to root>

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel

0000:01:00.0 VGA compatible controller: nVidia Corporation NV31M [GeForce FX Go5650] (rev a1) (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1852
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	Memory at f7000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Expansion ROM at f89e0000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Ethernet Controller (rev 13)
	Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit Ethernet Controller (Asus)
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
	Memory at feaf8000 (32-bit, non-prefetchable) [size=16K]
	I/O ports at d800 [size=256]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ab)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1854
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at fd200000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 40000000-41fff000 (prefetchable)
	Memory window 1: fc600000-fd1ff000
	I/O window 0: 0000b000-0000b0ff
	I/O window 1: 0000b400-0000b4ff
	16-bit legacy interface ports at 0001

0000:02:01.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ab)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1854
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at fa200000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 42000000-43fff000 (prefetchable)
	Memory window 1: f9600000-fa1ff000
	I/O window 0: 0000b800-0000b8ff
	I/O window 1: 0000bc00-0000bcff
	16-bit legacy interface ports at 0001

0000:02:01.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1857
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at feafd000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: <available only to root>

0000:02:01.3 System peripheral: Ricoh Co Ltd: Unknown device 0576 (rev 01)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 185b
	Flags: medium devsel, IRQ 11
	Memory at feafd800 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:02:01.4 System peripheral: Ricoh Co Ltd: Unknown device 0592
	Subsystem: ASUSTeK Computer Inc.: Unknown device 185c
	Flags: medium devsel, IRQ 11
	Memory at feafdc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:02:02.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 120f
	Flags: bus master, fast devsel, latency 64, IRQ 11
	Memory at feafe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: <available only to root>


--Boundary-00=_WfQhD7FJYP64jhu--
