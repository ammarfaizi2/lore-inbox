Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754513AbWKHKz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbWKHKz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754515AbWKHKz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:55:28 -0500
Received: from SMT02001.global-sp.net ([193.168.50.54]:53941 "EHLO
	SMT02001.global-sp.net") by vger.kernel.org with ESMTP
	id S1754513AbWKHKz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:55:26 -0500
Message-ID: <4551B7B8.8080601@privacy.net>
Date: Wed, 08 Nov 2006 11:55:52 +0100
From: John <me@privacy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en, fr
MIME-Version: 1.0
To: auke-jan.h.kok@intel.com
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux.nics@intel.com,
       hpa@zytor.com, saw@saw.sw.com.sg
Subject: Re: Intel 82559 NIC corrupted EEPROM
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com> <45506C9A.5010009@privacy.net>
In-Reply-To: <45506C9A.5010009@privacy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2006 10:57:29.0753 (UTC) FILETIME=[AF441890:01C70324]
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck: 
X-MailScanner-From: me@privacy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

[ E-mail address is a bit-bucket. I *do* monitor the mailing lists. ]

I will try and summarize the problem as I understand it at this point.

I've written two messages so far:
http://groups.google.com/group/linux.kernel/msg/3a05d819c66474db
http://groups.google.com/group/linux.kernel/msg/391aebbb3dfd6039

And here is a link to the complete thread:
http://lkml.org/lkml/fancy/2006/11/3/124

I have a motherboard with three on-board 82559 NICs.

  o eepro100.ko properly initializes all three NICs
  o e100.ko fails to initialize one of them

NOTE: With kernel 2.6.14, e100.ko fails to initialize the NIC with MAC 
address 00:30:64:04:E6:E4. With kernel 2.6.18 e100.ko fails to 
initialize the NIC with MAC address 00:30:64:04:E6:E5.

The problem is not an incorrect checksum. (Donald Becker's dump utility 
reports a correct checksum for all three NICs.) The problem seems to be 
that e100.ko fails to read the contents of one of the EEPROMs.

Auke wrote:
> How did you do the first `ethtool` eeprom dump? did you have the
> `e100` module loaded at that time? Did you use the new `override`
> mechanism graciously donated by David M?

These tests were performed on a 2.6.14 kernel. I hacked
e100_eeprom_load() to return 0 even when the checksum
fails. Thus the driver did not refuse to load, and I was
able to use ethtool to dump the contents of the 3 EEPROMs.


Here are additional examples running a 2.6.18.1-hrt kernel.

'insmod e100.ko' reports:

e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 12 (level, 
low) -> IRQ 12
e100: eth0: e100_probe: addr 0xe5300000, irq 12, MAC addr 00:30:64:04:E6:E4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
e100: 0000:00:09.0: e100_eeprom_load: EEPROM corrupted
ACPI: PCI interrupt for device 0000:00:09.0 disabled
e100: probe of 0000:00:09.0 failed with error -11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
e100: eth1: e100_probe: addr 0xe5301000, irq 11, MAC addr 00:30:64:04:E6:E6


'insmod e100.ko eeprom_bad_csum_allow=1' reports:

e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 12 (level, 
low) -> IRQ 12
e100: eth0: e100_probe: addr 0xe5300000, irq 12, MAC addr 00:30:64:04:E6:E4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
e100: 0000:00:09.0: e100_eeprom_load: EEPROM corrupted
e100: 0000:00:09.0: e100_probe: Invalid MAC address from EEPROM, aborting.
ACPI: PCI interrupt for device 0000:00:09.0 disabled
e100: probe of 0000:00:09.0 failed with error -11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
e100: eth1: e100_probe: addr 0xe5301000, irq 11, MAC addr 00:30:64:04:E6:E6


'insmod e100.ko debug=16' reports:

e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 12 (level, 
low) -> IRQ 12
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=0, data_in=0x0000, 
data_out=0x18203000
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=1, data_in=0x0000, 
data_out=0x18217809
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=1, data_in=0x0000, 
data_out=0x18217809
e100: 0000:00:08.0: e100_phy_init: phy_addr = 1
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=0, reg=0, data_in=0x0400, 
data_out=0x14000400
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=0, data_in=0x0000, 
data_out=0x18203000
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=1, reg=0, data_in=0x3000, 
data_out=0x14203000
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=2, reg=0, data_in=0x0400, 
data_out=0x14400400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=3, reg=0, data_in=0x0400, 
data_out=0x14600400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=4, reg=0, data_in=0x0400, 
data_out=0x14800400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=5, reg=0, data_in=0x0400, 
data_out=0x14A00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=6, reg=0, data_in=0x0400, 
data_out=0x14C00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=7, reg=0, data_in=0x0400, 
data_out=0x14E00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=8, reg=0, data_in=0x0400, 
data_out=0x15000400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=9, reg=0, data_in=0x0400, 
data_out=0x15200400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=10, reg=0, data_in=0x0400, 
data_out=0x15400400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=11, reg=0, data_in=0x0400, 
data_out=0x15600400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=12, reg=0, data_in=0x0400, 
data_out=0x15800400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=13, reg=0, data_in=0x0400, 
data_out=0x15A00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=14, reg=0, data_in=0x0400, 
data_out=0x15C00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=15, reg=0, data_in=0x0400, 
data_out=0x15E00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=16, reg=0, data_in=0x0400, 
data_out=0x16000400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=17, reg=0, data_in=0x0400, 
data_out=0x16200400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=18, reg=0, data_in=0x0400, 
data_out=0x16400400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=19, reg=0, data_in=0x0400, 
data_out=0x16600400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=20, reg=0, data_in=0x0400, 
data_out=0x16800400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=21, reg=0, data_in=0x0400, 
data_out=0x16A00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=22, reg=0, data_in=0x0400, 
data_out=0x16C00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=23, reg=0, data_in=0x0400, 
data_out=0x16E00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=24, reg=0, data_in=0x0400, 
data_out=0x17000400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=25, reg=0, data_in=0x0400, 
data_out=0x17200400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=26, reg=0, data_in=0x0400, 
data_out=0x17400400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=27, reg=0, data_in=0x0400, 
data_out=0x17600400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=28, reg=0, data_in=0x0400, 
data_out=0x17800400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=29, reg=0, data_in=0x0400, 
data_out=0x17A00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=30, reg=0, data_in=0x0400, 
data_out=0x17C00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=31, reg=0, data_in=0x0400, 
data_out=0x17E00400
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=2, data_in=0x0000, 
data_out=0x182202A8
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=3, data_in=0x0000, 
data_out=0x18230154
e100: 0000:00:08.0: e100_phy_init: phy ID = 0x015402A8
e100: eth0: e100_probe: addr 0xe5300000, irq 12, MAC addr 00:30:64:04:E6:E4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
e100: 0000:00:09.0: e100_eeprom_load: EEPROM corrupted
ACPI: PCI interrupt for device 0000:00:09.0 disabled
e100: probe of 0000:00:09.0 failed with error -11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=0, data_in=0x0000, 
data_out=0x18203000
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=1, data_in=0x0000, 
data_out=0x18217809
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=1, data_in=0x0000, 
data_out=0x18217809
e100: 0000:00:0a.0: e100_phy_init: phy_addr = 1
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=0, reg=0, data_in=0x0400, 
data_out=0x14000400
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=0, data_in=0x0000, 
data_out=0x18203000
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=1, reg=0, data_in=0x3000, 
data_out=0x14203000
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=2, reg=0, data_in=0x0400, 
data_out=0x14400400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=3, reg=0, data_in=0x0400, 
data_out=0x14600400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=4, reg=0, data_in=0x0400, 
data_out=0x14800400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=5, reg=0, data_in=0x0400, 
data_out=0x14A00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=6, reg=0, data_in=0x0400, 
data_out=0x14C00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=7, reg=0, data_in=0x0400, 
data_out=0x14E00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=8, reg=0, data_in=0x0400, 
data_out=0x15000400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=9, reg=0, data_in=0x0400, 
data_out=0x15200400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=10, reg=0, data_in=0x0400, 
data_out=0x15400400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=11, reg=0, data_in=0x0400, 
data_out=0x15600400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=12, reg=0, data_in=0x0400, 
data_out=0x15800400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=13, reg=0, data_in=0x0400, 
data_out=0x15A00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=14, reg=0, data_in=0x0400, 
data_out=0x15C00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=15, reg=0, data_in=0x0400, 
data_out=0x15E00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=16, reg=0, data_in=0x0400, 
data_out=0x16000400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=17, reg=0, data_in=0x0400, 
data_out=0x16200400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=18, reg=0, data_in=0x0400, 
data_out=0x16400400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=19, reg=0, data_in=0x0400, 
data_out=0x16600400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=20, reg=0, data_in=0x0400, 
data_out=0x16800400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=21, reg=0, data_in=0x0400, 
data_out=0x16A00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=22, reg=0, data_in=0x0400, 
data_out=0x16C00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=23, reg=0, data_in=0x0400, 
data_out=0x16E00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=24, reg=0, data_in=0x0400, 
data_out=0x17000400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=25, reg=0, data_in=0x0400, 
data_out=0x17200400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=26, reg=0, data_in=0x0400, 
data_out=0x17400400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=27, reg=0, data_in=0x0400, 
data_out=0x17600400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=28, reg=0, data_in=0x0400, 
data_out=0x17800400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=29, reg=0, data_in=0x0400, 
data_out=0x17A00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=30, reg=0, data_in=0x0400, 
data_out=0x17C00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=31, reg=0, data_in=0x0400, 
data_out=0x17E00400
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=2, data_in=0x0000, 
data_out=0x182202A8
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=3, data_in=0x0000, 
data_out=0x18230154
e100: 0000:00:0a.0: e100_phy_init: phy ID = 0x015402A8
e100: eth1: e100_probe: addr 0xe5301000, irq 11, MAC addr 00:30:64:04:E6:E6


'insmod e100.ko eeprom_bad_csum_allow=1 debug=16' reports:

e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
PCI: Enabling device 0000:00:08.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 12 (level, 
low) -> IRQ 12
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=0, data_in=0x0000, 
data_out=0x18203000
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=1, data_in=0x0000, 
data_out=0x18217809
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=1, data_in=0x0000, 
data_out=0x18217809
e100: 0000:00:08.0: e100_phy_init: phy_addr = 1
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=0, reg=0, data_in=0x0400, 
data_out=0x14000400
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=0, data_in=0x0000, 
data_out=0x18203000
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=1, reg=0, data_in=0x3000, 
data_out=0x14203000
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=2, reg=0, data_in=0x0400, 
data_out=0x14400400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=3, reg=0, data_in=0x0400, 
data_out=0x14600400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=4, reg=0, data_in=0x0400, 
data_out=0x14800400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=5, reg=0, data_in=0x0400, 
data_out=0x14A00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=6, reg=0, data_in=0x0400, 
data_out=0x14C00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=7, reg=0, data_in=0x0400, 
data_out=0x14E00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=8, reg=0, data_in=0x0400, 
data_out=0x15000400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=9, reg=0, data_in=0x0400, 
data_out=0x15200400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=10, reg=0, data_in=0x0400, 
data_out=0x15400400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=11, reg=0, data_in=0x0400, 
data_out=0x15600400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=12, reg=0, data_in=0x0400, 
data_out=0x15800400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=13, reg=0, data_in=0x0400, 
data_out=0x15A00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=14, reg=0, data_in=0x0400, 
data_out=0x15C00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=15, reg=0, data_in=0x0400, 
data_out=0x15E00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=16, reg=0, data_in=0x0400, 
data_out=0x16000400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=17, reg=0, data_in=0x0400, 
data_out=0x16200400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=18, reg=0, data_in=0x0400, 
data_out=0x16400400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=19, reg=0, data_in=0x0400, 
data_out=0x16600400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=20, reg=0, data_in=0x0400, 
data_out=0x16800400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=21, reg=0, data_in=0x0400, 
data_out=0x16A00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=22, reg=0, data_in=0x0400, 
data_out=0x16C00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=23, reg=0, data_in=0x0400, 
data_out=0x16E00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=24, reg=0, data_in=0x0400, 
data_out=0x17000400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=25, reg=0, data_in=0x0400, 
data_out=0x17200400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=26, reg=0, data_in=0x0400, 
data_out=0x17400400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=27, reg=0, data_in=0x0400, 
data_out=0x17600400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=28, reg=0, data_in=0x0400, 
data_out=0x17800400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=29, reg=0, data_in=0x0400, 
data_out=0x17A00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=30, reg=0, data_in=0x0400, 
data_out=0x17C00400
e100: 0000:00:08.0: mdio_ctrl: WRITE:addr=31, reg=0, data_in=0x0400, 
data_out=0x17E00400
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=2, data_in=0x0000, 
data_out=0x182202A8
e100: 0000:00:08.0: mdio_ctrl: READ:addr=1, reg=3, data_in=0x0000, 
data_out=0x18230154
e100: 0000:00:08.0: e100_phy_init: phy ID = 0x015402A8
e100: eth0: e100_probe: addr 0xe5300000, irq 12, MAC addr 00:30:64:04:E6:E4
PCI: Enabling device 0000:00:09.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
e100: 0000:00:09.0: e100_eeprom_load: EEPROM corrupted
e100: 0000:00:09.0: mdio_ctrl: READ:addr=1, reg=0, data_in=0x0000, 
data_out=0x18203000
e100: 0000:00:09.0: mdio_ctrl: READ:addr=1, reg=1, data_in=0x0000, 
data_out=0x18217829
e100: 0000:00:09.0: mdio_ctrl: READ:addr=1, reg=1, data_in=0x0000, 
data_out=0x1821782D
e100: 0000:00:09.0: e100_phy_init: phy_addr = 1
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=0, reg=0, data_in=0x0400, 
data_out=0x14000400
e100: 0000:00:09.0: mdio_ctrl: READ:addr=1, reg=0, data_in=0x0000, 
data_out=0x18203000
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=1, reg=0, data_in=0x3000, 
data_out=0x14203000
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=2, reg=0, data_in=0x0400, 
data_out=0x14400400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=3, reg=0, data_in=0x0400, 
data_out=0x14600400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=4, reg=0, data_in=0x0400, 
data_out=0x14800400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=5, reg=0, data_in=0x0400, 
data_out=0x14A00400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=6, reg=0, data_in=0x0400, 
data_out=0x14C00400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=7, reg=0, data_in=0x0400, 
data_out=0x14E00400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=8, reg=0, data_in=0x0400, 
data_out=0x15000400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=9, reg=0, data_in=0x0400, 
data_out=0x15200400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=10, reg=0, data_in=0x0400, 
data_out=0x15400400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=11, reg=0, data_in=0x0400, 
data_out=0x15600400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=12, reg=0, data_in=0x0400, 
data_out=0x15800400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=13, reg=0, data_in=0x0400, 
data_out=0x15A00400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=14, reg=0, data_in=0x0400, 
data_out=0x15C00400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=15, reg=0, data_in=0x0400, 
data_out=0x15E00400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=16, reg=0, data_in=0x0400, 
data_out=0x16000400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=17, reg=0, data_in=0x0400, 
data_out=0x16200400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=18, reg=0, data_in=0x0400, 
data_out=0x16400400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=19, reg=0, data_in=0x0400, 
data_out=0x16600400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=20, reg=0, data_in=0x0400, 
data_out=0x16800400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=21, reg=0, data_in=0x0400, 
data_out=0x16A00400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=22, reg=0, data_in=0x0400, 
data_out=0x16C00400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=23, reg=0, data_in=0x0400, 
data_out=0x16E00400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=24, reg=0, data_in=0x0400, 
data_out=0x17000400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=25, reg=0, data_in=0x0400, 
data_out=0x17200400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=26, reg=0, data_in=0x0400, 
data_out=0x17400400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=27, reg=0, data_in=0x0400, 
data_out=0x17600400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=28, reg=0, data_in=0x0400, 
data_out=0x17800400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=29, reg=0, data_in=0x0400, 
data_out=0x17A00400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=30, reg=0, data_in=0x0400, 
data_out=0x17C00400
e100: 0000:00:09.0: mdio_ctrl: WRITE:addr=31, reg=0, data_in=0x0400, 
data_out=0x17E00400
e100: 0000:00:09.0: mdio_ctrl: READ:addr=1, reg=2, data_in=0x0000, 
data_out=0x182202A8
e100: 0000:00:09.0: mdio_ctrl: READ:addr=1, reg=3, data_in=0x0000, 
data_out=0x18230154
e100: 0000:00:09.0: e100_phy_init: phy ID = 0x015402A8
e100: 0000:00:09.0: e100_probe: Invalid MAC address from EEPROM, aborting.
ACPI: PCI interrupt for device 0000:00:09.0 disabled
e100: probe of 0000:00:09.0 failed with error -11
PCI: Enabling device 0000:00:0a.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=0, data_in=0x0000, 
data_out=0x18203000
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=1, data_in=0x0000, 
data_out=0x18217809
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=1, data_in=0x0000, 
data_out=0x18217809
e100: 0000:00:0a.0: e100_phy_init: phy_addr = 1
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=0, reg=0, data_in=0x0400, 
data_out=0x14000400
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=0, data_in=0x0000, 
data_out=0x18203000
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=1, reg=0, data_in=0x3000, 
data_out=0x14203000
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=2, reg=0, data_in=0x0400, 
data_out=0x14400400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=3, reg=0, data_in=0x0400, 
data_out=0x14600400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=4, reg=0, data_in=0x0400, 
data_out=0x14800400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=5, reg=0, data_in=0x0400, 
data_out=0x14A00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=6, reg=0, data_in=0x0400, 
data_out=0x14C00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=7, reg=0, data_in=0x0400, 
data_out=0x14E00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=8, reg=0, data_in=0x0400, 
data_out=0x15000400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=9, reg=0, data_in=0x0400, 
data_out=0x15200400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=10, reg=0, data_in=0x0400, 
data_out=0x15400400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=11, reg=0, data_in=0x0400, 
data_out=0x15600400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=12, reg=0, data_in=0x0400, 
data_out=0x15800400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=13, reg=0, data_in=0x0400, 
data_out=0x15A00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=14, reg=0, data_in=0x0400, 
data_out=0x15C00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=15, reg=0, data_in=0x0400, 
data_out=0x15E00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=16, reg=0, data_in=0x0400, 
data_out=0x16000400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=17, reg=0, data_in=0x0400, 
data_out=0x16200400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=18, reg=0, data_in=0x0400, 
data_out=0x16400400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=19, reg=0, data_in=0x0400, 
data_out=0x16600400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=20, reg=0, data_in=0x0400, 
data_out=0x16800400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=21, reg=0, data_in=0x0400, 
data_out=0x16A00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=22, reg=0, data_in=0x0400, 
data_out=0x16C00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=23, reg=0, data_in=0x0400, 
data_out=0x16E00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=24, reg=0, data_in=0x0400, 
data_out=0x17000400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=25, reg=0, data_in=0x0400, 
data_out=0x17200400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=26, reg=0, data_in=0x0400, 
data_out=0x17400400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=27, reg=0, data_in=0x0400, 
data_out=0x17600400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=28, reg=0, data_in=0x0400, 
data_out=0x17800400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=29, reg=0, data_in=0x0400, 
data_out=0x17A00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=30, reg=0, data_in=0x0400, 
data_out=0x17C00400
e100: 0000:00:0a.0: mdio_ctrl: WRITE:addr=31, reg=0, data_in=0x0400, 
data_out=0x17E00400
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=2, data_in=0x0000, 
data_out=0x182202A8
e100: 0000:00:0a.0: mdio_ctrl: READ:addr=1, reg=3, data_in=0x0000, 
data_out=0x18230154
e100: 0000:00:0a.0: e100_phy_init: phy ID = 0x015402A8
e100: eth1: e100_probe: addr 0xe5301000, irq 11, MAC addr 00:30:64:04:E6:E6


i.e. e100.ko initializes only two NICs:

# ip addr
1: lo: <LOOPBACK,UP,10000> mtu 16436 qdisc noqueue
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     inet 127.0.0.1/8 scope host lo
2: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop
     link/ether e2:18:f7:f8:88:4e brd ff:ff:ff:ff:ff:ff
6: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
     link/ether 00:30:64:04:e6:e4 brd ff:ff:ff:ff:ff:ff
7: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
     link/ether 00:30:64:04:e6:e6 brd ff:ff:ff:ff:ff:ff


Constrast this with eepro100.ko...

'insmod e100.ko debug=6' reports:

eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 12 (level, 
low) -> IRQ 12
Found Intel i82557 PCI Speedo at 0xe5300000, IRQ 12.
eth0: 0000:00:08.0, 00:30:64:04:E6:E4, IRQ 12.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
   General self-test: passed.
   Serial sub-system self-test: passed.
   Internal registers self-test: passed.
   ROM checksum self-test: passed (0x04f4518b).
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
Found Intel i82557 PCI Speedo at 0xe5302000, IRQ 10.
eth1: 0000:00:09.0, 00:30:64:04:E6:E5, IRQ 10.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
   General self-test: passed.
   Serial sub-system self-test: passed.
   Internal registers self-test: passed.
   ROM checksum self-test: passed (0x04f4518b).
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
Found Intel i82557 PCI Speedo at 0xe5301000, IRQ 11.
eth2: 0000:00:0a.0, 00:30:64:04:E6:E6, IRQ 11.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
   General self-test: passed.
   Serial sub-system self-test: passed.
   Internal registers self-test: passed.
   ROM checksum self-test: passed (0x04f4518b).

#ip addr
1: lo: <LOOPBACK,UP,10000> mtu 16436 qdisc noqueue
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     inet 127.0.0.1/8 scope host lo
2: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop
     link/ether e2:18:f7:f8:88:4e brd ff:ff:ff:ff:ff:ff
3: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
     link/ether 00:30:64:04:e6:e4 brd ff:ff:ff:ff:ff:ff
4: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
     link/ether 00:30:64:04:e6:e5 brd ff:ff:ff:ff:ff:ff
5: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
     link/ether 00:30:64:04:e6:e6 brd ff:ff:ff:ff:ff:ff

# eepro100-diag -aa -ee
eepro100-diag.c:v2.13 2/28/2005 Donald Becker (becker@scyld.com)
  http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82557/8/9 EtherExpressPro100 adapter at 0xd800.
i82557 chip registers at 0xd800:
   00000000 00000000 00000000 00080002 10000000 00000000
   No interrupt sources are pending.
    The transmit unit state is 'Idle'.
    The receive unit state is 'Idle'.
   This status is unusual for an activated interface.
EEPROM contents, size 64x16:
     00: 3000 0464 e4e6 0e03 0000 0201 4701 0000  _0d__________G__
   0x08: 7213 8310 40a2 0001 8086 0000 0000 0000  _r___@__________
       ...
   0x30: 0128 0000 0000 0000 0000 0000 0000 0000  (_______________
   0x38: 0000 0000 0000 0000 0000 0000 0000 92f7  ________________
  The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
   Station address 00:30:64:04:E6:E4.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
    Sleep mode is enabled.  This is not recommended.
    Under high load the card may not respond to
    PCI requests, and thus cause a master abort.
    To clear sleep mode use the '-G 0 -w -w -f' options.
Index #2: Found a Intel i82557/8/9 EtherExpressPro100 adapter at 0xdc00.
i82557 chip registers at 0xdc00:
   00000000 00000000 00000000 00080002 10000000 00000000
   No interrupt sources are pending.
    The transmit unit state is 'Idle'.
    The receive unit state is 'Idle'.
   This status is unusual for an activated interface.
EEPROM contents, size 64x16:
     00: 3000 0464 e5e6 0e03 0000 0201 4701 0000  _0d__________G__
   0x08: 7213 8310 40a2 0001 8086 0000 0000 0000  _r___@__________
       ...
   0x30: 0128 0000 0000 0000 0000 0000 0000 0000  (_______________
   0x38: 0000 0000 0000 0000 0000 0000 0000 91f7  ________________
  The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
   Station address 00:30:64:04:E6:E5.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
    Sleep mode is enabled.  This is not recommended.
    Under high load the card may not respond to
    PCI requests, and thus cause a master abort.
    To clear sleep mode use the '-G 0 -w -w -f' options.
Index #3: Found a Intel i82557/8/9 EtherExpressPro100 adapter at 0xe000.
i82557 chip registers at 0xe000:
   00000000 00000000 00000000 00080002 10000000 00000000
   No interrupt sources are pending.
    The transmit unit state is 'Idle'.
    The receive unit state is 'Idle'.
   This status is unusual for an activated interface.
EEPROM contents, size 64x16:
     00: 3000 0464 e6e6 0e03 0000 0201 4701 0000  _0d__________G__
   0x08: 7213 8310 40a2 0001 8086 0000 0000 0000  _r___@__________
       ...
   0x30: 0128 0000 0000 0000 0000 0000 0000 0000  (_______________
   0x38: 0000 0000 0000 0000 0000 0000 0000 90f7  ________________
  The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
   Station address 00:30:64:04:E6:E6.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
    Sleep mode is enabled.  This is not recommended.
    Under high load the card may not respond to
    PCI requests, and thus cause a master abort.
    To clear sleep mode use the '-G 0 -w -w -f' options.


On a related note, I am concerned by this message:

    Sleep mode is enabled.  This is not recommended.
    Under high load the card may not respond to
    PCI requests, and thus cause a master abort.
    To clear sleep mode use the '-G 0 -w -w -f' options.

Intel 82559 EEPROM Map and Programming Information (AP-394) states:
http://www.intel.com/design/network/applnots/ap394.htm

The Standby Enable bit enables the 82559 to enter standby mode. When 
this bit equals 1b, the 82559 is able to recognize an idle state and can 
enter standby mode (some internal clocks are stopped for power saving 
purposes). The 82559 does not require a PCI clock signal in standby 
mode. If this bit equals 0b, the idle recognition circuit is disabled 
and the 82559 always remains in an active state. Thus, the 82559 always 
requests PCI CLK using the Clockrun mechanism.

Auke, do you agree with Donald Becker's warning?

If I disable STB, the NICs will waste a bit more power when idle,
is that correct? Are there other implications?

Thanks for reading this far!

John
