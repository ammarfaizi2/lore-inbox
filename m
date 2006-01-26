Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWAZUYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWAZUYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWAZUYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:24:41 -0500
Received: from palrel10.hp.com ([156.153.255.245]:11953 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751417AbWAZUYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:24:40 -0500
Date: Thu, 26 Jan 2006 12:24:47 -0800
From: Grant Grundler <iod00d@hp.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Problems with MSI-X on ia64
Message-ID: <20060126202447.GB15440@esmail.cup.hp.com>
References: <D4CFB69C345C394284E4B78B876C1CF10B848090@cceexc23.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10B848090@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 11:14:22AM -0600, Miller, Mike (OS Dev) wrote:
> Hello,
> Has anyone tested MSI-X on ia64 based platforms?

IIRC, Martine Silberman did some of the developement for
ia64 support. At least she provided the original documentation
for 2.6.4 kernel. So this is mostly not new code.
	http://www.ussg.iu.edu/hypermail/linux/kernel/0402.2/1543.html

I've also posted 2.6.10 tg3 patch to enable MSI:
        http://www.gelato.unsw.edu.au/archives/linux-ia64/0503/13332.html

I've been using MSI-X on ia64 with OpenIB for over a year.
My guess is that was also starting with 2.6.10.
Here's current output with 2.6.15:
grundler@gsyprf3:/usr/src/linux-2.6.15$ fgrep MSI /proc/interrupts 
 70: 1067582561          0       PCI-MSI-X  ib_mthca (comp)
 71:         10          0       PCI-MSI-X  ib_mthca (async)
 72:      41279          0       PCI-MSI-X  ib_mthca (cmd)


> We're using a 2.6.9 variant and a cciss driver with MSI/MSI-X support.
> The kernel has MSI enabled. On ia64 the MSI-X table is all zeroes.

Could you post the debug output you've collected so far?

> On Intel x86_64 platforms the table contains valid data and
> everything works as expected.

It should look similar for ia64 since both use 0xfeeXXXXX
Processor Interrupt Block address and similar intr vectors.

> If I understand how this works the Linux kernel is supposed to program
> up the table based on the HW platform. I can't find anything in the ia64
> code that does this. For x86_64 and i386 it looks like the magic address
> is 
> 
> 	#define APIC_DEFAULT_BASE	0xfee00000
> 
> Anybody know why this isn't defined for ia64? Any answers, input, or
> flames are appreciated.

APIC_DEAFULT_BASE isn't used.  See 

fgrep MSI_ADDRESS_HEADER drivers/pci/*
drivers/pci/msi.c:      dest_id = (MSI_ADDRESS_HEADER << MSI_ADDRESS_HEADER_SHIFT);
drivers/pci/msi.h:#define MSI_ADDRESS_HEADER            0xfee
drivers/pci/msi.h:#define MSI_ADDRESS_HEADER_SHIFT      12
drivers/pci/msi.h:#define MSI_ADDRESS_HEADER_MASK       0xfff000

This is one of the things that Mark Maule/SGI needs to change
to support MSI on SN2.

grant
