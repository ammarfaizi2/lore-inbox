Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292690AbSCFA5E>; Tue, 5 Mar 2002 19:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292801AbSCFA44>; Tue, 5 Mar 2002 19:56:56 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:31748 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S292690AbSCFA4t>; Tue, 5 Mar 2002 19:56:49 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76D6@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'fabrizio.gennari@philips.com'" <fabrizio.gennari@philips.com>,
        "'Andrey Panin'" <pazke@orbita1.ru>
Cc: "'Russell King'" <rmk@arm.linux.org.uk>,
        "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Oxford Semiconductor's OXCB950 UART not recognized by serial.
	c
Date: Tue, 5 Mar 2002 16:56:48 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
Ed Vance		serial24@macrolink.com
