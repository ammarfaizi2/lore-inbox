Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVBXPPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVBXPPc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVBXPMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:12:03 -0500
Received: from aun.it.uu.se ([130.238.12.36]:60883 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262397AbVBXPJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:09:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16925.60927.49095.758660@alkaid.it.uu.se>
Date: Thu, 24 Feb 2005 16:08:47 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ppc32 weirdness with gcc-4.0 in 2.6.11-rc4
In-Reply-To: <1109210688.15027.2.camel@gaston>
References: <16924.59237.581247.498382@alkaid.it.uu.se>
	<1109210688.15027.2.camel@gaston>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:
 > > -Memory: 255872k available (1788k kernel code, 976k data, 144k init, 0k highmem)
 > > +Memory: 255872k available (1776k kernel code, 0k data, 144k init, 0k highmem)
 > 
 > That is weird... (0k data)
 > 
 > > AGP special page: 0xcffff000
 > >  Calibrating delay loop... 830.66 BogoMIPS (lpj=4153344)
 > >  Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
 > > @@ -132,13 +132,7 @@
 > >  VFS: Mounted root (ext3 filesystem) readonly.
 > >  Freeing unused kernel memory: 144k init 4k chrp 8k prep
 > >  usb 3-2: new full speed USB device using ohci_hcd and address 2
 > > -hub 3-2:1.0: USB hub found
 > > -hub 3-2:1.0: 3 ports detected
 > > -usb 3-2.1: new low speed USB device using ohci_hcd and address 3
 > > -input: USB HID v1.10 Mouse [Logitech Apple Optical USB Mouse] on usb-0001:10:1b.0-2.1
 > > -usb 3-2.3: new full speed USB device using ohci_hcd and address 4
 > > -input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:10:1b.0-2.3
 > > -input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:10:1b.0-2.3
 > > +usb 3-2: can't connect bus-powered hub to this port
 > >  EXT3 FS on hda5, internal journal
 > >  Adding 1048568k swap on /dev/hda3.  Priority:-1 extents:1
 > >  SCSI subsystem initialized
 > > 
 > > Note: "Memory: ... 0k data ..." !? Surely that can't be correct.
 > 
 > Not sure what's up, but it's probably something beeing miscompiled. Can
 > you check if the udelay/medlay loops are correct ?

Both __delay and a few test functions using udelay/mdelay look Ok.

_However_, the 0k data message is due to a gcc-4.0 bug, and below
you'll find a test program which illustrates it.

/Mikael

/* gcc4bug.c
 * Written by Mikael Pettersson <mikpe@csd.uu.se>, 2005-02-24.
 *
 * This program is abstracted from arch/ppc/mm/init.c in
 * the 2.6.11-rc4 Linux kernel sources.
 *
 * With gcc-3.4.3, gcc-3.3.5, or gcc-3.2.3, mem_init()
 * correctly returns 245.
 *
 * With gcc-4.0.0 20050220, mem_init() erroneously returns 0.
 * The error occurs with -O1, and -O2.
 * Compiling at -O0, or -O3 or higher, hides the error.
 *
 * All gcc versions were configured for powerpc-unknown-linux-gnu.
 */
#include <stdio.h>

#define PAGE_SIZE 4096
unsigned long PAGE_OFFSET;
unsigned long high_memory;
unsigned long etext;
unsigned long init_begin;
unsigned long init_end;
unsigned long klimit;

int mem_init(void)
{
	unsigned long addr;
	int codepages = 0;
	int datapages = 0;
	int initpages = 0;

	for (addr = PAGE_OFFSET; addr < high_memory; addr += PAGE_SIZE) {
		if (addr < etext)
			codepages++;
		else if (addr >= init_begin && addr < init_end)
			initpages++;
		else if (addr < klimit)
			datapages++;
	}
	printf("datapages == %d, initpages == %d, codepages == %d\n", datapages, initpages, codepages);
	return datapages;
}

int main(void)
{
    int datapages;

    PAGE_OFFSET	= 0xc0000000;
    etext	= 0xc01bb958;
    init_begin	= 0xc0264000;
    init_end	= 0xc0288000;
    klimit	= 0xc02d4378;
    high_memory	= 0xd0000000;
    datapages = mem_init();
    if (datapages != 245) {
	fprintf(stderr, "gcc bug! mem_init() returned %d\n", datapages);
	return 1;
    } else
	return 0;
}
