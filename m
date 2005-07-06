Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVGFXxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVGFXxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVGFUGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:06:07 -0400
Received: from bay21-f20.bay21.hotmail.com ([65.54.233.109]:50647 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262383AbVGFSYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:24:33 -0400
Message-ID: <BAY21-F20B7CAAB5A3DD44D333948A0D90@phx.gbl>
X-Originating-IP: [4.21.76.141]
X-Originating-Email: [tbcrowley@hotmail.com]
From: "Thomas Crowley" <tbcrowley@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 64bit PCI IORESOURCE_MEM bugs
Date: Wed, 06 Jul 2005 14:24:32 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 06 Jul 2005 18:24:32.0344 (UTC) FILETIME=[F45D2D80:01C58257]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running linux 2.6.12.2 with the memmap patch, on an Intel 64 bit 
machine with 16 Gigs of RAM.  I have written a device driver that DMAs to 14 
Gigs of RAM.

I am attempting to give 1 Gig of RAM to the OS and 1Gig of address space for 
PCI addressing and 14 Gigs for my DMA.  I have added the following to my 
grub command line:
memmap=exactmap memmap=640K@0 memmap=1024M@1M memmap=2000M$2048M 
memmap=12000M$4048M

This does not seam to be working.  I think I have run into some bugs in the 
kernel unless I am mistaken how physical RAM addressing and the bus 
addressing work.

1) in arch/x86_64/kernel/e820.c    the e820_reserve_resources function the 
line if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL) makes it so 
any region that
     starts below the 4Gig mark but ends above 4Gig mark is ignored.  So I 
have been forced to reserve the 15 Gigs using two different memmap calls one 
that reserves memory below 4 Gigs and one that reserves the memory above 4 
Gigs.

2) I am unable to get all of my PCI devices to move there addressing from 
the default values to the hole I have given it.  I am getting several errors 
of the form: "PCI: Cannot allocate resource region 8 of bridge 
0000:00:07.0".  Some of my devices are moving to the proper location.
Neither the code in drivers/pci/probe.c pci_read_bases which gets the 
default addresses for the resources or /arch/i386/pci/i386.c 
pcibios_allocate_bus_resources check to see if the address that are being 
used are reserved.  They just attempt to allocate the memory and fail.  It 
seams like a check should be made in one of these functions and if the 
resources are reserved then the addresses should be changed. (Note: 64 bit 
uses the i386 pci code that is why I am pointing out potential errors in the 
i386 code)

I also noticed the reserve kernel param can only take ints so large 
addresses can not be reserved

Thank you,
Tom


