Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281192AbRKPFaM>; Fri, 16 Nov 2001 00:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKPFaD>; Fri, 16 Nov 2001 00:30:03 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:2062 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S281192AbRKPF3u>; Fri, 16 Nov 2001 00:29:50 -0500
Date: Fri, 16 Nov 2001 00:29:42 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: <linux-kernel@vger.kernel.org>
Subject: ALi pIRQ, HP Notebook PCI IRQ quiks...
Message-ID: <Pine.LNX.4.33.0111152302440.28098-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A little while ago (a month?), I posted a message here asking what I could
do to get USB working on my laptop.  All indications appeared that this
was an IRQ problem.  I recieved only one response telling me I was most
likely screwed... undaunted I pressed on, and managed to get USB to work..
My question now is WHY??? I did some very unholy things to PCI setup, and
I'd like to know the "right way" of doing this..

Warning, long explination follows:

System is an HP Pavilion N5430 laptop (Mobile Duron, ALi Magik1 chipset.).
USB is the standard ALi OHCI USB controller.  USB works under windows, and
shows up as IRQ 9 (however, it "skips" every now and then.. ie, like it
need to do a bus reset every 5 minutes or so). Under Linux, usb shows up
on IRQ 9 (shared with ACPI), and never works (no interrupts get through.)

lspci shows PCI config space always has the USB device configured to IRQ
9 (both regular and bus view).  Everything points to both the BIOS and PCI
space thinking that USB should be on IRQ 9.... All, that is, except the
pIRQ table..

Using the dump_pirq utility from the pcmcia-cs package, you get the
following output:

Interrupt routing table found at address 0xfdf40:
  Version 1.0, size 0x00a0
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x10b9 device 0x1533

Device 00:0f.0 (slot 0): IDE interface

Device 00:02.0 (slot 0): USB Controller
  INTA: link 0x59, irq mask 0x0800 [11]

Device 00:08.0 (slot 1): Multimedia audio controller
  INTA: link 0x49, irq mask 0x0020 [5]

Device 00:04.0 (slot 0): CardBus bridge
  INTA: link 0x48, irq mask 0x0800 [11]
  INTB: link 0x48, irq mask 0x0800 [11]

Device 00:10.0 (slot 0): Ethernet controller
  INTA: link 0x48, irq mask 0x0800 [11]

Device 00:07.0 (slot 0): ISA bridge
  INTA: link 0x48, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTB: link 0x48, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTC: link 0x49, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTD: link 0x49, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]

Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x48, irq mask 0x0800 [11]

Device 01:00.0 (slot 0): VGA compatible controller
  INTA: link 0x48, irq mask 0x0800 [11]

Interrupt router at 00:07.0: AcerLabs Aladdin M1533 PCI-to-ISA bridge
  INT1 (link 1): irq 11
  INT2 (link 2): irq 11
  INT3 (link 3): unrouted
  INT4 (link 4): unrouted
  INT5 (link 5): unrouted
  INT6 (link 6): unrouted
  INT7 (link 7): unrouted
  INT8 (link 8): unrouted
  Serial IRQ: [enabled] [continuous] [frame=21] [pulse=12]

As you can see, according to the pIRQ routing table, the sound card is
wired to IRQ 5, and everything else, including USB, -can only be- IRQ 11.

So, doing some evil hackery, using the fact that in this laptop there's
only one PCI device on IRQ 9, I changed the PCI IRQ probing code to change
all PCI devices on IRQ 9 to IRQ 11.. the attached patch implements this...
yet even with this patch, i still need to call "setpci" to change the USB
IRQ in PCI config space to irq 11 (0xb)... then, and only then, can I
modprobe the usb-ohci driver, have it come up on IRQ 11, and it works
fine.

So, now I can use USB.. but I have many more questions for those PCI
experts out there...

	1) Why does this work?  It appears that the pIRQ table is right,
but the BIOS and PCI config space are wrong.  If this is the case, how
(should?) we teach linux to use the pIRQ table as it's guide over
everything else?

	2) Why does it work under windows on IRQ9?

	3) Shouldn't the call to pci_write_config_byte change the IRQ in
PCI config space?  why do I need to call setpci to set the IRQ again from
user space to get lspci et al to report IRQ11?

	4) Why does linux seem to be ignoring the pIRQ table?

	5) Where is the "correct" place to put a hack like this?

	6) is there any way to make USB work on IRQ 9?, or are we talking
about an obnoxiously braindead bios?

More details available (I've been fooling with this for a little bit), but
i'm trying to keep this pretty brief. If anyone has any ideas, i'd be very
interested in hearing them.

john.c
--
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens

diff -u --recursive linux-2.4.13-pre6/arch/i386/kernel/pci-i386.h linux/arch/i386/kernel/pci-i386.h
--- linux-2.4.13-pre6/arch/i386/kernel/pci-i386.h	Wed Jun 20 14:21:33 2001
+++ linux/arch/i386/kernel/pci-i386.h	Tue Oct 23 23:13:08 2001
@@ -4,7 +4,7 @@
  *	(c) 1999 Martin Mares <mj@ucw.cz>
  */

-#undef DEBUG
+#define DEBUG

 #ifdef DEBUG
 #define DBG(x...) printk(x)
diff -u --recursive linux-2.4.13-pre6/arch/i386/kernel/pci-irq.c linux/arch/i386/kernel/pci-irq.c
--- linux-2.4.13-pre6/arch/i386/kernel/pci-irq.c	Thu Nov 15 21:18:03 2001
+++ linux/arch/i386/kernel/pci-irq.c	Thu Oct 25 12:47:56 2001
@@ -588,9 +588,9 @@
 		irq = pirq & 0xf;
 		DBG(" -> hardcoded IRQ %d\n", irq);
 		msg = "Hardcoded";
-	} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq))) {
+	/*} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq))) {
 		DBG(" -> got IRQ %d\n", irq);
-		msg = "Found";
+		msg = "Found";*/
 	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
 		DBG(" -> assigning IRQ %d", newirq);
 		if (r->set(pirq_router_dev, dev, pirq, newirq)) {
@@ -673,6 +673,10 @@
 		if (dev->irq >= 16) {
 			DBG("%s: ignoring bogus IRQ %d\n", dev->slot_name, dev->irq);
 			dev->irq = 0;
+		}
+		if (dev->irq == 9) {
+			pci_write_config_byte(dev, PCI_INTERRUPT_PIN, 0x0b);
+			dev->irq=11;
 		}
 		/* If the IRQ is already assigned to a PCI device, ignore its ISA use penalty */
 		if (pirq_penalty[dev->irq] >= 100 && pirq_penalty[dev->irq] < 100000)



