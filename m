Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSKXOnD>; Sun, 24 Nov 2002 09:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSKXOnD>; Sun, 24 Nov 2002 09:43:03 -0500
Received: from p0066.as-l043.contactel.cz ([194.108.242.66]:58362 "EHLO
	SnowWhite.SuSE.cz") by vger.kernel.org with ESMTP
	id <S261333AbSKXOnC> convert rfc822-to-8bit; Sun, 24 Nov 2002 09:43:02 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: PCI serial card with PCI 9052?
References: <m3smxx1aaf.fsf@Janik.cz> <20021120095618.GB319@pazke.ipt>
	<m3fztrcinh.fsf@Janik.cz>
	<20021124114307.A25408@flint.arm.linux.org.uk>
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Sun, 24 Nov 2002 15:49:36 +0100
Message-ID: <m3vg2naupr.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Sun, 24 Nov 2002 11:43:07 +0000

Hi,

   > On Sun, Nov 24, 2002 at 12:27:14PM +0100, Pavel Janík wrote:
   > > I have tried to cat /dev/ttyS5 after
   > > 
   > > setserial /dev/ttyS5 port 0xd800 irq 11
   > 
   > I think you actually want:
   > 
   > setserial /dev/ttyS5 port 0xd800 irq 11 autoconfig
   > 
   > and then cat /proc/tty/driver/serial and see if the 5: line has changed
   > from uart:unknown.

yes, that's it:

mirka:~ # grep ^5: /proc/tty/driver/serial
5: uart:unknown port:1A8 irq:9
mirka:~ # setserial /dev/ttyS5 port 0x9800 irq 11 autoconfig
mirka:~ # grep ^5: /proc/tty/driver/serial
5: uart:16550A port:9800 irq:11 baud:9600 tx:0 rx:0 

So, adding this patch should help me. I can not test it right now, because
I do not have any serial device here at home, but will test it on monday.

Thank you for your help.

--- linux-2.4.19.orig/drivers/char/serial.c	Sun Nov 24 14:32:19 2002
+++ linux-2.4.19/drivers/char/serial.c	Sun Nov 24 15:15:54 2002
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
+		0x400},
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
-- 
Pavel Janík

I can't make such predictions--my crystal ball is cloudy today.
                  -- Richard Stallman in emacs-devel
