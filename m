Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311641AbSDCUZt>; Wed, 3 Apr 2002 15:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312392AbSDCUZm>; Wed, 3 Apr 2002 15:25:42 -0500
Received: from host216040.arnet.net.ar ([200.45.216.40]:8320 "EHLO
	inferno.inferno.linux-site.net") by vger.kernel.org with ESMTP
	id <S311641AbSDCUZe>; Wed, 3 Apr 2002 15:25:34 -0500
Subject: Re: [patch] Re: IRQ routing conflicts / Assigning IRQ 0 to ethernet
From: Luis Falcon <lfalcon@thymbra.com>
To: Dominik Brodowski <devel@brodo.de>
Cc: linux-kernel@vger.kernel.org, becker@scyld.com
In-Reply-To: <02040300075302.00816@sonnenschein>
Content-Type: multipart/mixed; boundary="=-w1ZaW7kYKjmNvhIPYaJ5"
X-Mailer: Ximian Evolution 1.0.3 
Date: 03 Apr 2002 17:24:08 -0300
Message-Id: <1017865448.1457.32.camel@inferno>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w1ZaW7kYKjmNvhIPYaJ5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Dominik.

Thanks for the patch !

The devices have been assigned the missing IRQs. The network card keeps
having some problems, but I believe is now a driver related issue.

This is what I get when activating the network card.I'm copying this
message to Donald Becker, the developer for the tulip driver.

Apr  3 12:28:47 inferno kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Apr  3 12:28:47 inferno kernel: eth0: Transmit timed out, status
fc674055, CSR12 00000000, resetting...

I'm attaching the latest dmesg and lspci so you can take a look at it
and check for possible hot-spots.

Thanks again for your help. 

Regards,
Luis
 


sues. Patch is against 
> acpi-20020329 + 2.5.7/2.4.18. Please test + tell me if it works.
> 
> Dominik
> 
> --- linux/arch/i386/kernel/pci-irq.c.original	Tue Apr  2 13:35:24 2002
> +++ linux/arch/i386/kernel/pci-irq.c	Tue Apr  2 13:47:23 2002
> @@ -576,10 +576,8 @@
>  	struct pci_dev *dev2;
>  	char *msg = NULL;
>  
> -	if (!pirq_table)
> -		return 0;
>  
> -	/* Find IRQ routing entry */
> +	/* Find IRQ pin */
>  	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>  	if (!pin) {
>  		DBG(" -> no interrupt pin\n");
> @@ -588,10 +586,17 @@
>  	pin = pin - 1;
>  
>  #ifdef CONFIG_ACPI_PCI
> +	/* Use ACPI to lookup IRQ */
> +
>  	if (pci_use_acpi_routing)
>  		return acpi_lookup_irq(dev, pin, assign);
>  #endif
>  	
> +	/* Find IRQ routing entry */
> +
> +	if (!pirq_table)
> +		return 0;
> +
>  	DBG("IRQ for %s:%d", dev->slot_name, pin);
>  	info = pirq_get_info(dev);
>  	if (!info) {
> 
> 
> On Tuesday,  2. April 2002 23:54, Luis Falcon wrote:
> > Bryan,
> >
> > Thanks a lot for your response.
> > In fact the IRQ routing conflict has been solved !
> >
> > What is still pending is the assignment of a valid IRQ to the Ethernet card
> > ( device 00:05.0 ) and Sound Card ( 00:07.5 ). So, at this point, the
> > ethernet card doesn't work.
> >  does not work.
> >
> > Here's the latest dmesg.
> >
> > Regards,
> > Luis
> ----
> 

> --- linux/arch/i386/kernel/pci-irq.c.original	Tue Apr  2 13:35:24 2002
> +++ linux/arch/i386/kernel/pci-irq.c	Tue Apr  2 13:47:23 2002
> @@ -576,10 +576,8 @@
>  	struct pci_dev *dev2;
>  	char *msg = NULL;
>  
> -	if (!pirq_table)
> -		return 0;
>  
> -	/* Find IRQ routing entry */
> +	/* Find IRQ pin */
>  	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>  	if (!pin) {
>  		DBG(" -> no interrupt pin\n");
> @@ -588,10 +586,17 @@
>  	pin = pin - 1;
>  
>  #ifdef CONFIG_ACPI_PCI
> +	/* Use ACPI to lookup IRQ */
> +
>  	if (pci_use_acpi_routing)
>  		return acpi_lookup_irq(dev, pin, assign);
>  #endif
>  	
> +	/* Find IRQ routing entry */
> +
> +	if (!pirq_table)
> +		return 0;
> +
>  	DBG("IRQ for %s:%d", dev->slot_name, pin);
>  	info = pirq_get_info(dev);
>  	if (!info) {


--=-w1ZaW7kYKjmNvhIPYaJ5
Content-Disposition: attachment; filename=lspci.patchirq
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=lspci.patchirq; charset=ISO-8859-1

00:00.0 Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=3D128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP] (prog-if 00 [=
Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e0100000-e01fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:05.0 Ethernet controller: Accton Technology Corporation: Unknown device =
1216 (rev 11)
	Subsystem: Accton Technology Corporation: Unknown device 2242
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1c00 [size=3D256]
	Region 1: Memory at 1f000000 (32-bit, non-prefetchable) [size=3D1K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D100mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:06.0 Communication controller: Lucent Microelectronics LT WinModem
	Subsystem: Askey Computer Corp.: Unknown device 4005
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [disabled] [size=
=3D256]
	Region 1: I/O ports at 1030 [disabled] [size=3D8]
	Region 2: I/O ports at 1400 [disabled] [size=3D256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D160mA PME(D0-,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (r=
ev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog=
-if 8a [Master SecP PriP])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1890
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1020 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 0=
0 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at 1000 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (re=
v 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Cont=
roller (rev 50)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1840
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1800 [size=3D256]
	Region 1: I/O ports at 103c [size=3D4]
	Region 2: I/O ports at 1038 [size=3D4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 1f001000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latency=3D176
	Memory window 0: 1f400000-1f7ff000 (prefetchable)
	Memory window 1: 1f800000-1fbff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 1f002000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D06, subordinate=3D09, sec-latency=3D176
	Memory window 0: 1fc00000-1ffff000 (prefetchable)
	Memory window 1: 20000000-203ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0d.0 FireWire (IEEE 1394): Lucent Microelectronics: Unknown device 5811 =
(rev 04) (prog-if 10 [OHCI])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1881
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 96 (3000ns min, 6000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0001000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d01 (rev 02) (p=
rog-if 00 [VGA])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1830
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e0100000 (32-bit, non-prefetchable) [size=3D512K]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=3D31 SBA- 64bit- FW- Rate=3D<none>
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>


--=-w1ZaW7kYKjmNvhIPYaJ5
Content-Disposition: attachment; filename=dmseg.patchirq
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmseg.patchirq; charset=ISO-8859-1

00:00.0 Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=3D128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP] (prog-if 00 [=
Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e0100000-e01fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:05.0 Ethernet controller: Accton Technology Corporation: Unknown device =
1216 (rev 11)
	Subsystem: Accton Technology Corporation: Unknown device 2242
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1c00 [size=3D256]
	Region 1: Memory at 1f000000 (32-bit, non-prefetchable) [size=3D1K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D100mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:06.0 Communication controller: Lucent Microelectronics LT WinModem
	Subsystem: Askey Computer Corp.: Unknown device 4005
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [disabled] [size=
=3D256]
	Region 1: I/O ports at 1030 [disabled] [size=3D8]
	Region 2: I/O ports at 1400 [disabled] [size=3D256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D160mA PME(D0-,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (r=
ev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog=
-if 8a [Master SecP PriP])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1890
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1020 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 0=
0 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at 1000 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (re=
v 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Cont=
roller (rev 50)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1840
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1800 [size=3D256]
	Region 1: I/O ports at 103c [size=3D4]
	Region 2: I/O ports at 1038 [size=3D4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 1f001000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latency=3D176
	Memory window 0: 1f400000-1f7ff000 (prefetchable)
	Memory window 1: 1f800000-1fbff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 1f002000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D06, subordinate=3D09, sec-latency=3D176
	Memory window 0: 1fc00000-1ffff000 (prefetchable)
	Memory window 1: 20000000-203ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0d.0 FireWire (IEEE 1394): Lucent Microelectronics: Unknown device 5811 =
(rev 04) (prog-if 10 [OHCI])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1881
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 96 (3000ns min, 6000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0001000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d01 (rev 02) (p=
rog-if 00 [VGA])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1830
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e0100000 (32-bit, non-prefetchable) [size=3D512K]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=3D31 SBA- 64bit- FW- Rate=3D<none>
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>


--=-w1ZaW7kYKjmNvhIPYaJ5--
