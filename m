Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUIOSJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUIOSJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUIOSJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:09:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:3808 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267304AbUIOSHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:07:04 -0400
Date: Wed, 15 Sep 2004 11:06:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
In-Reply-To: <Pine.LNX.4.58.0409151045530.2333@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0409151059010.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org> <20040915173236.GE6158@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0409151045530.2333@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Sep 2004, Linus Torvalds wrote:
> 
>    In short: if you don't go "ooh, that will simplify XXX", then you 
>    should just ignore the new interfaces.

Btw, to get an example of what _is_ simplified, look at 
drivers/scsi/libata-core.c:

	void ata_tf_load(struct ata_port *ap, struct ata_taskfile *tf)
	{
	        if (ap->flags & ATA_FLAG_MMIO)
	                ata_tf_load_mmio(ap, tf);
	        else
	                ata_tf_load_pio(ap, tf);
	}

and realize that "ata_tf_load_mmio()" and "ata_tf_load_pio()" are exactly 
the SAME FUNCTION. Except one uses MMIO, the other uses PIO. With the new 
setup, it literally collapses into one function, and code size goes down 
pretty dramatically. Not to mention making the code more readable.

For another example of this (of the static kind), look at something like 
drivers/net/8139too.c:

	#ifdef USE_IO_OPS

	#define RTL_R8(reg)             inb (((unsigned long)ioaddr) + (reg))
	#define RTL_R16(reg)            inw (((unsigned long)ioaddr) + (reg))
	#define RTL_R32(reg)            ((unsigned long) inl (((unsigned long)ioaddr) + (reg)))
	...

	#else

	...
	/* read MMIO register */
	#define RTL_R8(reg)             readb (ioaddr + (reg))
	#define RTL_R16(reg)            readw (ioaddr + (reg))
	#define RTL_R32(reg)            ((unsigned long) readl (ioaddr + (reg)))

see? In this case, USE_IO_OPS depends on a static configuration variable, 
namely CONFIG_8139TOO_PIO. So the user at _compile_ time has to decide 
whether he wants to use MMIO or PIO. See the Kconfig help file:

          This instructs the driver to use programmed I/O ports (PIO) instead 
          of PCI shared memory (MMIO).  This can possibly solve some problems
          in case your mainboard has memory consistency issues.  If unsure,
          say N.

In other words, the new interface is not designed to replace the old ones,
it's designed to help drivers like these, that either go to a lot of extra
pain in order to support both methods, or then have a _static_ config
option that makes it really hard for system vendors to just release one
driver that knows when it needs to use PIO and when it needs MMIO.

		Linus
