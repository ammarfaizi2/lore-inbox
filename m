Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbTIMVie (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 17:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbTIMVie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 17:38:34 -0400
Received: from havoc.gtf.org ([63.247.75.124]:61845 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262200AbTIMVi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 17:38:29 -0400
Date: Sat, 13 Sep 2003 17:38:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: libata update posted
Message-ID: <20030913213828.GC21426@gtf.org>
References: <3F628DC7.3040308@pobox.com> <20030913211332.GC3478@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913211332.GC3478@werewolf.able.es>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 11:13:32PM +0200, J.A. Magallon wrote:
> 
> On 09.13, Jeff Garzik wrote:
> > Just some minor updates.  The main one is that ATA software reset is now 
> > considered reliable, so it is now the default. 
> > Execute-Device-Diagnostic bus reset method remains in place and can be 
> > easily re-enabled with a flag.
> > 
> > libata has also moved (slightly) to a new home:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/
> > 
> > The latest libata patches for 2.4.x and 2.6.x were uploaded to this URL, 
> > and future patches will appear in the same location.
> > 
> > Look for more updates this weekend, including bug fixes from Dell and 
> > Red Hat, and better MMIO support.  And maybe a special surprise.  :)
> > 
> 
> Any user documentation, like modules names and how to make it work ?
> I could write the Configure.help entries.
> I suppose you load the PIIX/VIA modules and you have one other scsi
> bus.

The 2.5 patch should have Configure.help entries.  Any assistance in
writing documentation is greatly appreciated, though :)  I hope to get
much more than just a dry API reference in
Documentation/Docbook/libata.tmpl, so any added information should
probably be noted in there.

No user documentation, but feel free to ask me questions.  Here's a
quick overview:

ata_piix, ata_via -- low-level driver modules
libata -- shared code module for the above

modprobe ata_piix or ata_via, and it will make your SATA devices appear
as a new SCSI bus.  Each SATA port is represented by a separate SCSI
bus.

Currently in 2.4 and 2.6, both ATA and ATAPI devices appear as SCSI
devices.  However in 2.7, ATA devices (i.e. hard drives) will not go
through the SCSI layer.  ATAPI devices will continue to use some of the
SCSI layer code in 2.7.

Currently only Intel ICH5 SATA is well tested.  VIA SATA was just added,
and Intel PATA support exists, but it is recommended that you use
drivers/ide for PATA support.

Current -ac and -pac kernels #if-0 the ICH5 SATA pci id from
drivers/ide/pci/piix.c, preferring to let libata drive that.
That's done not only to expose libata to testing, but also for
pragmatic reasons:  drivers/ide will hang on many ICH5 SATA hosts,
when they are in "native mode"[1].

	Jeff


[1] native mode is when a PCI IDE device is configured to obtain
all its resources from the PCI io space, and use PCI interrupts.
The other side of the coin is legacy mode, which uses legacy IDE
ports 0x1f0/0x170 and legacy ISA irqs 14/15.
