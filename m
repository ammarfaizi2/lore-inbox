Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293400AbSCFJQF>; Wed, 6 Mar 2002 04:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293394AbSCFJP5>; Wed, 6 Mar 2002 04:15:57 -0500
Received: from gw-nl4.philips.com ([212.153.190.6]:6667 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP
	id <S293379AbSCFJPk>; Wed, 6 Mar 2002 04:15:40 -0500
From: fabrizio.gennari@philips.com
To: Ed Vance <EdV@macrolink.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'Andrey Panin'" <pazke@orbita1.ru>,
        "'Russell King'" <rmk@arm.linux.org.uk>
Subject: RE: Oxford Semiconductor's OXCB950 UART not recognized by serial.	c
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFEB6EFF7E.7F3A82B2-ONC1256B74.002DB609@diamond.philips.com>
Date: Wed, 6 Mar 2002 10:14:49 +0100
X-MIMETrack: Serialize by Router on hbg001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 06/03/2002 10:34:25,
	Serialize complete at 06/03/2002 10:34:25
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ed,

Thank you for the clear explanation.

As you probably have noticed, the last two entries of serial_pci_tbl[] 
match PCI_ANY_ID for both vendor and device, respectively for serial ports 
and modems. Therefore, any serial or modem PCI card is in 
serial_pci_tbl[]! The associated entry in pci_boards[] is pbn_default 
(=0). So, all "pbn_default" entries that match serial_pci_guess_board() 
are marked as redundant!

Probably, the right way could be to replace the message "Redundant entry" 
with something like:
"The settings of your serial card (vendor_id:dev_id) have been 
successfully guessed. In order help developers add a proper entry for your 
card, send this message along with the output of lspci -vv to 
an_address_where_somebody_reads_your_messages@unlike_serial_pci_info_where_nobody_cares_about_you".

By the way, here is a patch that adds OXCB950 properly to 
serial_pci_tbl[]. pbn_b0_bt_1_115200 has been used instead of 
pbn_b0_1_115200, because the latter is identical to pbn_default, and the 
effect should be the same since OXCB950 is single-port.

Another proposed change: why not create separate entries in pci_boards[] 
for pbn_b0_1_115200 and pbn_default?

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

Fabrizio Gennari
Philips Research Monza
via G.Casati 23, 20052 Monza (MI), Italy
tel. +39 039 2037816, fax +39 039 2037800




Ed Vance <EdV@macrolink.com>
06/03/2002 01.56

 
        To:     Fabrizio Gennari/MOZ/RESEARCH/PHILIPS@EMEA1
"'Andrey Panin'" <pazke@orbita1.ru>
        cc:     "'Russell King'" <rmk@arm.linux.org.uk>
"'linux-serial'" <linux-serial@vger.kernel.org>
"'linux-kernel'" <linux-kernel@vger.kernel.org>
        Subject:        RE: Oxford Semiconductor's OXCB950 UART not recognized by serial.       c
        Classification: 



Hi Fabrizio and Andrey,

About that function in serial.c, serial_pci_guess_board() ... 

On Wed, Feb 20, 2002 at 7:14 AM, Fabrizio Gennari wrote:
> But, when not using serial_cb, the function serial_pci_guess_board 
> in serial.c doesn't [recognize the 950 UART] (kernel 2.4.17 tested). 
> The problem is that the card advertises 3 i/o memory regions and 2 
> ports. If one replaces the line
> 
> if (num_iomem <= 1 && num_port == 1) {
> 
> with
> 
> if (num_port >= 1) {
> 
> in the function serial_pci_guess_board(), the card is detected and 
> works perfectly. Only, when inserting it, the kernel displays the 
> message:
> 
> Redundant entry in serial pci_table.  Please send the output of
> lspci -vv, this message (1415,950b,1415,0001)
> and the manufacturer and name of serial board or modem board
> to serial-pci-info@lists.sourceforge.net. 

I have dug deeper and found that the "port type guessing" functionality 
was broken when the driver was ported to the newer PCI interfaces. As 
it is, the probe function in serial.c (serial_init_one()) is *never* 
called for devices that do not already match an entry in the PCI id 
table (serial_pci_tbl[]). The probe function is coded as if non-matching 
devices would cause the probe to be called with a default table index of 
zero (pbn_default). This does not happen, because pci_announce_device() 
bypasses the probe call (pci.c:577) when the driver provides an id table 
and pci_match_device() cannot find a match in the id table. (pci.c:574)

There is not much point in trying to guess the type of a port that has 
already been identified. Devices that are not already in the table do 
not cause the probe and guess functions to be called. 

An older serial.c (rev 5.02 2000-08-09) checks each device against the 
PCI id table and only attempts a guess if there were no matches. 

At the very least, we could just rip out the guess function and not 
change the requirement of already being in the table. Or an attempt 
could be made to fix it to guess on devices that do not match the id 
table, as it used to work. This would move the id scan back to serial.c
from the PCI subsystem.

Your opinions please. How should this be fixed? Is there a "right" way?

Best regards,
Ed Vance                                 serial24@macrolink.com



