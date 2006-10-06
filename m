Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWJFMGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWJFMGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 08:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWJFMGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 08:06:07 -0400
Received: from demail.cyclades.de ([62.225.173.196]:35235 "EHLO
	demail.cyclades.de") by vger.kernel.org with ESMTP id S1422636AbWJFMGF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 08:06:05 -0400
Date: Fri, 6 Oct 2006 14:05:35 +0200 (CEST)
From: Thomas Hoehn <thomas.hoehn@avocent.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH] Perle multimodem card (PCI-RAS) detection, kernel 2.6.18
Message-ID: <Pine.LNX.4.64.0610061133410.7912@muc-thoehn.cyclades.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on DEMail/Cyclades(Release 6.5.1|January 21, 2004) at
 10/06/2006 02:06:03 PM,
	Serialize by Router on DEMail/Cyclades(Release 6.5.1|January 21, 2004) at
 10/06/2006 02:06:05 PM,
	Serialize complete at 10/06/2006 02:06:05 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

this patch is to get the Perle quad-modem PCI card (PCI-RAS4) detected by
current serial driver code in 2.6 kernel. It may also get the PCI-RAS8
(Perle 8-port modem PIC card) running, but I can't guarantee as I only
have a PCI-RAS4 for testing.

Here are the pci infos about the card (lspci -vn):

0000:02:07.0 0700: 10b5:9030 (prog-if 02)
         Subsystem: 155f:f001
         Flags: medium devsel, IRQ 10
         Memory at d0100400 (32-bit, non-prefetchable) [size=128]
         I/O ports at 3800 [size=128]
         I/O ports at 3400 [size=32]

i.e.:
Vendor ID: 10b5 (PLX Technology, Inc.)
Device ID: 9030 (PLX PCI <-> IOBus Bridge Hot Swap)
Subvendor ID: 155f (Perle Systems Ltd)
Subdevice ID: f001 (PCI-RAS4), f010 (PCI-RAS8)
Uses BAR: 2 (IO port 0x3400)

The PCI card has a TI TL16C754BPN (Texas Instruments) Quad-UART with 64 Byte
Rx/Tx-FIFO onboard, which is compatible to ST16654 so it should be detected
by the serial driver code.

Actually the autoconf() in 8250.c bails out because the IER test fails.
It turns out that bit 4 is set on my card regardless what is written to IER.

Looking in the TL16C754B datasheet gives the clue that EFR is involved
(see http://focus.ti.com/docs/prod/folders/print/tl16c754b.html, pdf p.30):
"NOTE: IER[7:4] can only be modified if EFR[4] is set, i.e. EFR[4] is a write
enable:". So I and'ed the IER read-back-value in scratch2 and scratch3 with
0x0f in order to test only bit 0-3 (but I'm not sure if that is fine for
general case). Whith that UART type ST16654 is found.

It was also neccessary to add vendor/device ID's for PLX chip 9030 and Perles
subsystem components in pci_ids.h.

The "(Maximum) number of 8250/16550 serial ports" in the kernel config should
also be set properly (4 internal + 4/8 on Perle card).

Would be glad if someone could test and confirm the patch below.

Regards,

Thomas Hoehn
Avocent Germany
(formerly Cyclades)

Web: www.avocent.com
Email: thomas.hoehn@avocent.com

=== 8< ============================================================================

diff -ur linux-2.6.18.orig/drivers/serial/8250.c linux/drivers/serial/8250.c
--- linux-2.6.18.orig/drivers/serial/8250.c	2006-09-20 05:42:06.000000000 +0200
+++ linux/drivers/serial/8250.c	2006-10-04 17:40:22.000000000 +0200
@@ -920,12 +920,12 @@
  #ifdef __i386__
  		outb(0xff, 0x080);
  #endif
-		scratch2 = serial_inp(up, UART_IER);
+		scratch2 = serial_inp(up, UART_IER) & 0x0f;
  		serial_outp(up, UART_IER, 0x0F);
  #ifdef __i386__
  		outb(0, 0x080);
  #endif
-		scratch3 = serial_inp(up, UART_IER);
+		scratch3 = serial_inp(up, UART_IER) & 0x0f;
  		serial_outp(up, UART_IER, scratch);
  		if (scratch2 != 0 || scratch3 != 0x0F) {
  			/*
diff -ur linux-2.6.18.orig/drivers/serial/8250_pci.c linux/drivers/serial/8250_pci.c
--- linux-2.6.18.orig/drivers/serial/8250_pci.c	2006-09-20 05:42:06.000000000 +0200
+++ linux/drivers/serial/8250_pci.c	2006-10-04 17:40:22.000000000 +0200
@@ -679,6 +679,13 @@
  	 */
  	{
  		.vendor		= PCI_VENDOR_ID_PLX,
+		.device		= PCI_DEVICE_ID_PLX_9030,
+		.subvendor	= PCI_SUBVENDOR_ID_PERLE,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_PLX,
  		.device		= PCI_DEVICE_ID_PLX_9050,
  		.subvendor	= PCI_SUBVENDOR_ID_EXSYS,
  		.subdevice	= PCI_SUBDEVICE_ID_EXSYS_4055,
@@ -2353,6 +2360,15 @@
  		pbn_b2_2_115200 },

  	/*
+	 * Perle PCI-RAS cards
+	 */
+	{       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+		PCI_SUBVENDOR_ID_PERLE, PCI_SUBDEVICE_ID_PCI_RAS4,
+		0, 0, pbn_b2_4_921600 },
+	{       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+		PCI_SUBVENDOR_ID_PERLE, PCI_SUBDEVICE_ID_PCI_RAS8,
+		0, 0, pbn_b2_8_921600 },
+	/*
  	 * These entries match devices with class COMMUNICATION_SERIAL,
  	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
  	 */
diff -ur linux-2.6.18.orig/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- linux-2.6.18.orig/include/linux/pci_ids.h	2006-09-20 05:42:06.000000000 +0200
+++ linux/include/linux/pci_ids.h	2006-10-04 17:41:37.000000000 +0200
@@ -948,6 +948,7 @@
  #define PCI_DEVICE_ID_PLX_R753		0x1152
  #define PCI_DEVICE_ID_PLX_OLITEC	0x1187
  #define PCI_DEVICE_ID_PLX_PCI200SYN	0x3196
+#define PCI_DEVICE_ID_PLX_9030          0x9030
  #define PCI_DEVICE_ID_PLX_9050		0x9050
  #define PCI_DEVICE_ID_PLX_9080		0x9080
  #define PCI_DEVICE_ID_PLX_GTEK_SERIAL2	0xa001
@@ -1961,6 +1962,10 @@

  #define PCI_VENDOR_ID_CHELSIO		0x1425

+#define PCI_SUBVENDOR_ID_PERLE          0x155f
+#define PCI_SUBDEVICE_ID_PCI_RAS4       0xf001
+#define PCI_SUBDEVICE_ID_PCI_RAS8       0xf010 
+

  #define PCI_VENDOR_ID_SYBA		0x1592
  #define PCI_DEVICE_ID_SYBA_2P_EPP	0x0782

=== 8< ============================================================================
