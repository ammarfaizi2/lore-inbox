Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUHPXJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUHPXJg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUHPXIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:08:09 -0400
Received: from maximus.kcore.de ([213.133.102.235]:21912 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S266451AbUHPXE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:04:56 -0400
Message-ID: <41213D66.1010909@gmx.net>
Date: Tue, 17 Aug 2004 01:04:06 +0200
From: Oliver Feiler <kiza@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Macintosh/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: eth*: transmit timed out since .27
References: <566B962EB122634D86E6EE29E83DD808182C3236@hdsmsx403.hd.intel.com>	 <1092678734.23057.18.camel@dhcppc4> <41210098.4080904@gmx.net>	 <41210649.4090008@gmx.net> <1092685821.23066.39.camel@dhcppc4>
In-Reply-To: <1092685821.23066.39.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

Len Brown wrote:
> 
> 
> You've got 3 ethernet controllers.
> 
> eth0: RealTek RTL-8029 found at 0xe800, IRQ 18, 00:00:E8:5C:2D:AA.
> eth1: SiS 900 PCI Fast Ethernet at 0xec00, IRQ 17, 00:c0:ca:16:4c:b6.
> eth2: VIA VT6102 Rhine-II at 0xd400, 00:0b:6a:2b:48:84, IRQ 23.

Correct.

> 
> And eth0 is failing.
> See if you can give its network cable and its IRQ to on of the other
> devices and see if the error follows the load and the wires,
> or stays with the device.

Doing that is a bit problematic. eth0 is a 10mbit NIC, eth1 and eth2 
must be 100mbit unfortunately. I can move around (two of) the NICs in 
the PCI slots however. The box is headless and a bit uncomfortable to 
work with, so I'd like to try software solutions first.

> 
> The quirks for this hardware look totally broken in IOAPIC mode:
> PCI: Via IRQ fixup for 00:10.2, from 10 to 5
> PCI: Via IRQ fixup for 00:10.1, from 10 to 5
> PCI: Via IRQ fixup for 00:10.0, from 11 to 5
> I have no idea if they're a nop or not, but you might exeriment with
> disabling them.  Sure isn't obvious that something called
> quirk_via_irqpic() should be running in IOAPIC mode.
> I'd try disabling quirk_via_acpi() too.

Ok, I've removed the quirks from quirks.c, compiled and rebooted. I hope 
I have done it right, I commented out these lines in quirks.c:

//      { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA, 
PCI_DEVICE_ID_VIA_82C586_3,     quirk_via_acpi },
//      { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA, 
PCI_DEVICE_ID_VIA_82C686_4,     quirk_via_acpi },
//      { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_VIA, 
PCI_DEVICE_ID_VIA_82C586_2,     quirk_via_irqpic },
//      { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_VIA, 
PCI_DEVICE_ID_VIA_82C686_5,     quirk_via_irqpic },
//      { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_VIA, 
PCI_DEVICE_ID_VIA_82C686_6,     quirk_via_irqpic },

The "Via IRQ fixup for dev:..." are gone from the boot messages. After 
transferring about 250 MB over eth0 the "Tx timed out" error reoccured.

/proc/interrupts looked like this:

            CPU0
   0:     191473    IO-APIC-edge  timer
   1:       1244    IO-APIC-edge  keyboard
   8:          1    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  14:      33547    IO-APIC-edge  ide0
  15:      23121    IO-APIC-edge  ide1
  17:       5699   IO-APIC-level  eth1
  18:     234589   IO-APIC-level  eth0
  21:          0   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
  22:          0   IO-APIC-level  via82cxxx
  23:     240873   IO-APIC-level  eth2
NMI:          0
LOC:     191481
ERR:          0
MIS:          8

What exactly is MIS? Something like "interrupt occured, but I have no 
idea what device caused it"? I don't know much about it, but it's always 
 >0 when the problem happens.

> 
> cheers,
> -Len
> 
> ps. to exchange IRQs, you'll need to physically exchange the slots
> of the cards, easy enough unless eth0 is soldered onto the
> motherboard;-)

Fortunately only eth2 (the VIA Rhine-II) is soldered onto the board. :)

I'll try reordering the NICs in the PCI slots. The system is used most 
of the time though, so I can't take it apart and test things all the 
time. I wonder if it makes sense to experiment with the IOAPIC further. 
Maybe the hardware is just plain broken? Or might there be a slight 
chance to get this to work the way it's intended to?

Btw, I don't know if I've ever mentioned it, it's an Asrock K7VM4 board. 
lspci output is here if it might be of interest:

kiza@spot:~> lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400] Chipset Host 
Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:09.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI 
Fast Ethernet (rev 02)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 
controller] (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 
controller] (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 
controller] (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 74)
01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8378 [S3 
UniChrome] Integrated Video (rev 01)

Thanks for your help with this. :)

Oliver

