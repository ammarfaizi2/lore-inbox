Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310300AbSCAK5n>; Fri, 1 Mar 2002 05:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310435AbSCAKzi>; Fri, 1 Mar 2002 05:55:38 -0500
Received: from gw-nl4.philips.com ([212.153.190.6]:31507 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP
	id <S310433AbSCAKxU>; Fri, 1 Mar 2002 05:53:20 -0500
From: fabrizio.gennari@philips.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] OXCB950 support (was RE: Oxford Semiconductor's OXCB950 UART not
 recognized by serial.	c)
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFE6A68C06.9A968E6D-ONC1256B6F.003B8572@diamond.philips.com>
Date: Fri, 1 Mar 2002 11:52:39 +0100
X-MIMETrack: Serialize by Router on hbg001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 01/03/2002 12:12:07,
	Serialize complete at 01/03/2002 12:12:07
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (tested on 2.4.17) includes OXCB950 in serial_pci_tbl[]. 
pbn_b0_bt_1_115200 is used instead of pbn_b0_1_115200: the effect is the 
same since the OXCB950 is single-port, but pbn_b0_bt_1_115200 is different 
from pbn_default.

Fabrizio Gennari
Philips Research Monza
via G.Casati 23, 20052 Monza (MI), Italy
tel. +39 039 2037816, fax +39 039 2037800

diff -ruN linux/drivers/char/serial.c linux-new/drivers/char/serial.c
--- linux/drivers/char/serial.c Fri Dec 21 18:41:54 2001
+++ linux-new/drivers/char/serial.c     Fri Mar  1 09:43:42 2002
@@ -4658,6 +4658,9 @@
        {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
                PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
                pbn_b0_2_115200 },
+       {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_OXCB950,
+               PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+               pbn_b0_bt_1_115200 },
 
        /* Digitan DS560-558, from jimd@esoft.com */
        {       PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
diff -ruN linux/include/linux/pci_ids.h linux-new/include/linux/pci_ids.h
--- linux/include/linux/pci_ids.h       Fri Dec 21 18:42:03 2001
+++ linux-new/include/linux/pci_ids.h   Fri Mar  1 09:43:52 2002
@@ -1458,6 +1458,7 @@
 #define PCI_DEVICE_ID_OXSEMI_12PCI840  0x8403
 #define PCI_DEVICE_ID_OXSEMI_16PCI954  0x9501
 #define PCI_DEVICE_ID_OXSEMI_16PCI952  0x950A
+#define PCI_DEVICE_ID_OXSEMI_OXCB950   0x950B
 #define PCI_DEVICE_ID_OXSEMI_16PCI95N  0x9511
 #define PCI_DEVICE_ID_OXSEMI_16PCI954PP        0x9513
 




Ed Vance <EdV@macrolink.com>
21/02/2002 01.05

 
        To:     Fabrizio Gennari/MOZ/RESEARCH/PHILIPS@EMEA1
        cc:     rmk@arm.linux.org.uk
linux-kernel@vger.kernel.org
        Subject:        RE: Oxford Semiconductor's OXCB950 UART not recognized by serial.       c
        Classification: 



fabrizio.gennari@philips.com wrote:
> 
> We have 32-bit CardBus cards with OXCB950 CardBus (PCI ID 1415:950b) 
UART 
> chips on them (OXCB950 is the CardBus version of 16C950) . The module 
> serial_cb in the pcmcia-cs package recognizes them correctly. But, when 
> not using serial_cb, the function serial_pci_guess_board in serial.c 
> doesn't (kernel 2.4.17 tested). The problem is that the card advertises 
3 
> i/o memory regions and 2 ports. If one replaces the line
> 
> if (num_iomem <= 1 && num_port == 1) {
> 
> with
> 
> if (num_port >= 1) {
> 
> in the function serial_pci_guess_board(), the card is detected and works 

> perfectly. Only, when inserting it, the kernel displays the message:
> 
> Redundant entry in serial pci_table.  Please send the output of
> lspci -vv, this message (1415,950b,1415,0001)
> and the manufacturer and name of serial board or modem board
> to serial-pci-info@lists.sourceforge.net. 

The "Redundant entry" message comes out of serial.c when a card is found 
in
the PCI ID board list, but which function serial_pci_guess_board() also
detects as a generic single UART card (and overwrites the card's
board->flags field in the pci_boards[] array). 

Does anybody think this is a feature? Did I misunderstand?

I suspect that the thought was to detect and eventually remove 
pci_boards[]
entries for generic single-port cards that could also be detected by the
serial_pci_guess_board() function. Can anybody confirm or deny? 

Shouldn't the detection process be considered done when the PCI IDs match?
Why should the "guess" function even be called when the card has already
been found in the PCI board table?

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------



