Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbSKYVGT>; Mon, 25 Nov 2002 16:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265677AbSKYVGT>; Mon, 25 Nov 2002 16:06:19 -0500
Received: from p0279.as-l043.contactel.cz ([194.108.243.25]:40174 "EHLO
	SnowWhite.SuSE.cz") by vger.kernel.org with ESMTP
	id <S265667AbSKYVGR> convert rfc822-to-8bit; Mon, 25 Nov 2002 16:06:17 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: PCI serial card with PCI 9052?
References: <m3smxx1aaf.fsf@Janik.cz> <20021120095618.GB319@pazke.ipt>
	<m3fztrcinh.fsf@Janik.cz>
	<20021124114307.A25408@flint.arm.linux.org.uk>
	<m3vg2naupr.fsf@Janik.cz> <20021125094828.GA6016@pazke.ipt>
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Mon, 25 Nov 2002 21:47:37 +0100
In-Reply-To: <20021125094828.GA6016@pazke.ipt> (Andrey Panin's message of
 "Mon, 25 Nov 2002 12:48:28 +0300")
Message-ID: <m3hee55qc6.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrey Panin <pazke@orbita1.ru>
   Date: Mon, 25 Nov 2002 12:48:28 +0300

Hi Andrey,

   > patch looks good, but here is yet another thing to test.

I think that this will be additional thing to do. Right now, I have this:

--- linux-2.4.19/drivers/char/serial.c	Sat Aug  3 02:39:43 2002
+++ serial.c	Tue Nov 26 03:30:36 2002
@@ -139,8 +139,8 @@
 #undef SERIAL_DEBUG_OPEN
 #undef SERIAL_DEBUG_FLOW
 #undef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
-#undef SERIAL_DEBUG_PCI
-#undef SERIAL_DEBUG_AUTOCONF
+#define SERIAL_DEBUG_PCI
+#define SERIAL_DEBUG_AUTOCONF
 
 /* Sanity checks */
 
@@ -4181,7 +4181,7 @@
    
 #ifdef SERIAL_DEBUG_PCI
 	printk(KERN_DEBUG " Subsystem ID %lx (intel 960)\n",
-	       (unsigned long) board->subdevice);
+	       (unsigned long) dev->subsystem_device);
 #endif
 	/* is firmware started? */
 	pci_read_config_dword(dev, 0x44, (void*) &oldval); 
@@ -4340,6 +4340,7 @@
 	pbn_panacom2,
 	pbn_panacom4,
 	pbn_plx_romulus,
+	pbn_plx_9052,
 	pbn_oxsemi,
 	pbn_timedia,
 	pbn_intel_i960,
@@ -4425,6 +4426,8 @@
 		0x400, 7, pci_plx9050_fn },
 	{ SPCI_FL_BASE2, 4, 921600,			   /* pbn_plx_romulus */
 		0x20, 2, pci_plx9050_fn, 0x03 },
+	{ SPCI_FL_BASE2, 2, 115200,			   /* pbn_plx_9052 */
+		0x8 },
 		/* This board uses the size of PCI Base region 0 to
 		 * signal now many ports are available */
 	{ SPCI_FL_BASE0 | SPCI_FL_REGION_SZ_CAP, 32, 115200 }, /* pbn_oxsemi */
@@ -4707,6 +4710,9 @@
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_ROMULUS,
 		0x10b5, 0x106a, 0, 0,
 		pbn_plx_romulus },
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+		0xd841, 0x0200, 0, 0,
+		pbn_plx_9052 },
 	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSC100,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 		pbn_b1_4_115200 },


kernel boots with:

Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Testing ttyS0 (0x03f8, 0x0000)...
Testing ttyS1 (0x02f8, 0x0000)...
Testing ttyS2 (0x03e8, 0x0000)...
serial: ttyS2: simple autoconfig failed (ff, ff)
Testing ttyS3 (0x02e8, 0x0000)...
serial: ttyS3: simple autoconfig failed (ff, ff)
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Entered probe_serial_pci()
Setup PCI/PNP port: port fcf0, irq 9, type 0
Testing ttyS4 (0xfcf0, 0x0000)...
ttyS04 at port 0xfcf0 (irq = 9) is a 16550A
Setup PCI/PNP port: port fcf8, irq 9, type 0
Testing ttyS5 (0xfcf8, 0x0000)...
ttyS05 at port 0xfcf8 (irq = 9) is a 16550A
Leaving probe_serial_pci() (probe finished)

/proc/pci contains:

PCI devices found:
  Bus  0, device   0, function  0:
    Class 0000: PCI device 1106:0505 (rev 0).
  Bus  0, device  15, function  0:
    Class 0300: PCI device 5333:8811 (rev 0).
      Non-prefetchable 32 bit memory at 0xfe000000 [0xfe7fffff].
  Bus  0, device  18, function  0:
    Class 0280: PCI device 10b5:9050 (rev 2).
      IRQ 9.
      Non-prefetchable 32 bit memory at 0xfedffc00 [0xfedffc7f].
      I/O at 0xfc00 [0xfc7f].
      I/O at 0xfcf0 [0xfcf7].
      I/O at 0xfcf8 [0xfcff].


/proc/tty/driver/serial:

serinfo:1.0 driver:5.05c revision:2001-07-08
0: uart:16550A port:3F8 irq:4 baud:9600 tx:0 rx:0 RTS|DTR
1: uart:16550A port:2F8 irq:3 baud:9600 tx:0 rx:0 
4: uart:16550A port:FCF0 irq:9 baud:9600 tx:40 rx:57 brk:2 oe:1 RTS|DTR|DSR
5: uart:16550A port:FCF8 irq:9 baud:9600 tx:5 rx:0 RTS|DTR

There are two ports on that PCI card, ttyS4 and ttyS5. I have serial
printer and serial mouse. Flags are dependant on the status of the
port. Empty port: RTS | DTR. Printer plugged: RTS | CTS | DTR | DSR.
Mouse plugged:   RTS | DTR | DSR. So I think that the port is ready for
communication. But I do not see anything coming from it :-(

So the question now is: what should I do next? Trying to play with
setserial?
-- 
Pavel Janík

Avoid unnecessary branches.
                  --  The Elements of Programming Style (Kernighan & Plaugher)
