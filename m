Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264204AbRFDLmT>; Mon, 4 Jun 2001 07:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264205AbRFDLl7>; Mon, 4 Jun 2001 07:41:59 -0400
Received: from pc7.prs.nunet.net ([199.249.167.77]:24339 "HELO
	pc7.prs.nunet.net") by vger.kernel.org with SMTP id <S264204AbRFDLlw>;
	Mon, 4 Jun 2001 07:41:52 -0400
Date: 4 Jun 2001 11:41:51 -0000
Message-ID: <20010604114151.21903.qmail@pc7.prs.nunet.net>
From: "Rico Tudor" <rico-linux-kernel@patrec.com>
To: linux-kernel@vger.kernel.org
Subject: IO-APIC, beaten with stick, routes USB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm another victim of the IOAPIC routing USB IRQs to the nearest
black hole.  Running 2.4.4, dual CPU, ServerWorks HE chipset.  IRQ 16
was wrongly assumed for the OHCI controller.  This generated the usual
sign of interrupt servicing gone AWOL:

	usb_control/bulk_msg: timeout
	usb-ohci.c: unlink URB timeout
	usb.c: USB device not accepting new address=2 (error=-110)
	hub.c: port 1, portstatus 100, change 3, 12 Mb/s
	hub.c: port 1 of hub 1 not enabled, trying reset again...
	hub.c: port 1, portstatus 100, change 3, 12 Mb/s
	hub.c: port 1 of hub 1 not enabled, trying reset again...
	hub.c: port 1, portstatus 100, change 3, 12 Mb/s
	hub.c: port 1 of hub 1 not enabled, trying reset again...
	hub.c: port 1, portstatus 100, change 3, 12 Mb/s
	hub.c: port 1 of hub 1 not enabled, trying reset again...
	hub.c: port 1, portstatus 101, change 3, 12 Mb/s
	hub.c: port 1 of hub 1 not enabled, trying reset again...
	hub.c: Cannot enable port 1 of hub 1, disabling port.
	hub.c: Maybe the USB cable is bad?

The problem can be side-stepped with "noapic", but that's wimping out.
After mucking fruitlessly with boot params like "pirq", I simply took a
hatchet to usb-ohci.c, and installed its interrupt handler at all IRQs.
Viola!  USB services now appear on IRQ 12.  After some CompactFlash
reading, /proc/interrupts looks like this:

	           CPU0       CPU1       
	  0:      29204      31652    IO-APIC-edge  timer
	  1:         27         41    IO-APIC-edge  keyboard
	  2:          0          0          XT-PIC  cascade
	  3:          0          0    IO-APIC-edge  usb-ohci
	  4:          0          0    IO-APIC-edge  usb-ohci
	  5:          0          0    IO-APIC-edge  usb-ohci
	  6:          2          1    IO-APIC-edge  usb-ohci
	  7:          0          0    IO-APIC-edge  usb-ohci
	  8:          0          0    IO-APIC-edge  usb-ohci
	  9:          0          0   IO-APIC-level  usb-ohci
	 10:          0          0    IO-APIC-edge  usb-ohci
	 11:          0          0    IO-APIC-edge  usb-ohci
	 12:       1537       1558    IO-APIC-edge  usb-ohci
	 13:          0          0    IO-APIC-edge  usb-ohci
	 14:         33         40    IO-APIC-edge  ide0, usb-ohci
	 15:          0          0    IO-APIC-edge  usb-ohci
	 16:          0          0   IO-APIC-level  usb-ohci, usb-ohci
	 17:          0          0   IO-APIC-level  usb-ohci
	 18:          0          0            none  usb-ohci
	 19:          0          0            none  usb-ohci
	 20:          0          0   IO-APIC-level  usb-ohci
	 21:          0          0            none  usb-ohci
	 22:          3          6   IO-APIC-level  eth1, usb-ohci
	 23:       1039        709   IO-APIC-level  eth0, usb-ohci
	 24:          0          0            none  usb-ohci
	 25:          0          0            none  usb-ohci
	 26:          0          0            none  usb-ohci
	 27:          0          0            none  usb-ohci
	 28:          0          0   IO-APIC-level  sym53c8xx, usb-ohci
	 29:        693        673   IO-APIC-level  sym53c8xx, usb-ohci
	 30:          0          0   IO-APIC-level  usb-ohci
	 31:          0          0            none  usb-ohci
	NMI:          0          0 
	LOC:      60727      60726 
	ERR:          0

Mucho elegant.  :-)

This method of IRQ determination is used by `setserial' with the
"autoconfig" option, and should be adopted within the kernel, at least
for PCI.  BIOS writers' adherence to MPS seems eternally lacking, and
the NDA cloud over chipset-land won't be going away soon.

Some mention of stray interrupts on the console might be helpful, too.

P.S. `setserial' actually fails to determine IRQ with IO-APIC active.
