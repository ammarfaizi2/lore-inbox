Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSG3SIB>; Tue, 30 Jul 2002 14:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSG3SIB>; Tue, 30 Jul 2002 14:08:01 -0400
Received: from [64.105.35.245] ([64.105.35.245]:31645 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316789AbSG3SH7>; Tue, 30 Jul 2002 14:07:59 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 30 Jul 2002 11:10:48 -0700
Message-Id: <200207301810.LAA02575@baldur.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org
Subject: Re: PATCH: 2.5.29 Fix cmd640 config locking
Cc: linux-kernel@vger.kernel.org, martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From drivers/ide/cmd640.c:

| /*
|  * The CMD640x chip does not support DWORD config write cycles, but some
|  * of the BIOSes use them to implement the config services.
| * Therefore, we must use direct IO instead.
| */

>From Alan's patch to cmd640, derived frmo Andre Hedrick's
"ide-2.4.19-p8-0ac1.all.covert.10.patch" posted on 2002-07-25 10;51:07 at
http://marc.theaimsgroup.com/?l=linux-kernel&m=102759487724962&w=2:

> static void put_cmd640_reg_pci1 (unsigned short reg, u8 val)

>-       outl_p((reg & 0xfc) | cmd640_key, 0xcf8);

>+       outb_p((reg & 0xfc) | cmd640_key, 0xcf8);



> static u8 get_cmd640_reg_pci1 (unsigned short reg)

>-       outl_p((reg & 0xfc) | cmd640_key, 0xcf8);

>+       outb_p((reg & 0xfc) | cmd640_key, 0xcf8);


	I do not understand turning the writes to the PCI
Configuration Address Port (0xcf8) from 32 bits to 8 bits
for what I assume is a PCI "Configuration Mechanism #1 transaction".

	"The Configuration Address Pot only latches information when
the processor performs a full 32-bit write to the port.  [...] Any
8- or 16-bit access within this IO dword is passed directly
onto the PCI bus as an 8- or 16-bit PCI IO access."

		PCI System Architecture, 4th edition
		by Tom Shanley and Don Anderson,
		Chapter 18: Configuration Transactions,
		page 325, Configuration Mechanism #1 Description

	Sorry I don't have the PCI standards from pcisig.org to quote.

	I believe that the writes to the PCI Configuration Address
Port are writes to the PCI bridge, not to the IDE controller.  Is it
the case the cmd640 is always built into a motherboard chipset, and
it's presence implies this PCI bridge bug?

	I am aware that the deprecated PCI configuration method #2
does a byte write to 0xcf8, but this is in code for the more standard
PCI configuration method #1.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
