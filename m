Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311353AbSCLVqs>; Tue, 12 Mar 2002 16:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311351AbSCLVqh>; Tue, 12 Mar 2002 16:46:37 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:11793 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S311352AbSCLVqR>; Tue, 12 Mar 2002 16:46:17 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76F4@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'alexisr'" <alexisr@host.alphalink.fr>
Cc: "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: about the Oxford 16pci952
Date: Tue, 12 Mar 2002 13:46:15 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Mar 12, 2002, alexisr@host.alphalink.fr wrote:
> 
> Is someone know howto change, in the serial sources, the frequency 
> of the Oxford's oscillator that is set to 14,7456 Mhz

Assuming the rev 5.05 serial driver package on SourceForge (I think that's
what you said you were using last time), in file serial.c at line 4341,
change the 16PCI952 table entry from this:

	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
		PCI_ANY_ID, PCI_ANY_ID,
		SPCI_FL_BASE0 , 2, 115200 },

To this:

	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
		PCI_ANY_ID, PCI_ANY_ID,
		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE , 2, 921600 },

The SPCI_FL_BASE_TABLE flag means that the second port is addressed by the
next BAR instead of at a higher address in the first BAR. According to the
data sheet, the OX16PCI952 has port 0 in BAR0 and port 1 in BAR1. (unlike
the OX16C954, BTW) The 921600 base baud value is your oscillator rate
divided by the default oversample rate, 16. 

This is valid if the prescalar is not used. It is enabled by setting bit
MCR[7] to 1. The MCR value is initialized to zero at line 1360. I looked
through the driver for any code that would set bit MCR[7] and did not find
any. That means the prescalar is not used, so the only scale factor on your
oscillator rate would be the x16 oversample rate. 

In file serial_compat.h at line 394, an incorrect PCI device ID is defined.
Change this line:

#define PCI_DEVICE_ID_OXSEMI_16PCI952	0x950A

to this:

#define PCI_DEVICE_ID_OXSEMI_16PCI952	0x9521

Also check your kernel file /usr/src/linux/include/linux/pci_ids.h for this
same define. If it is present, it must also be changed to 0x9521. 

Good Luck.

Best regards,
---------------------------------------------------------------- 
Ed Vance              serial24@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

