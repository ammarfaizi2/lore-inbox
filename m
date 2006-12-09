Return-Path: <linux-kernel-owner+w=401wt.eu-S1761340AbWLICNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761340AbWLICNn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 21:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761338AbWLICNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 21:13:43 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:58939 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761341AbWLICNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 21:13:42 -0500
Subject: Re: [PATCH] PCI legacy resource fix
From: Ben Collins <ben.collins@ubuntu.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20061209012552.GA15216@linux-mips.org>
References: <20061206134143.GA6772@linux-mips.org>
	 <1165625178.7443.334.camel@gullible>
	 <20061209012552.GA15216@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 08 Dec 2006 21:13:30 -0500
Message-Id: <1165630410.7443.346.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 01:25 +0000, Ralf Baechle wrote:
> On Fri, Dec 08, 2006 at 07:46:18PM -0500, Ben Collins wrote:
> 
> > On Wed, 2006-12-06 at 13:41 +0000, Ralf Baechle wrote:
> > > Since commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f the kernel will try
> > > to update the non-writeable BAR registers 0..3 of PIIX4 IDE adapters if
> > > pci_assign_unassigned_resources() is used to do full resource assignment
> > > of the bus.  This fails because in the PIIX4 these BAR registers have
> > > implicitly assumed values and read back as zero; it used to work because
> > > the kernel used to just write zero to that register the read back value
> > > did match what was written.
> > > 
> > > The fix is a new resource flag IORESOURCE_PCI_FIXED used to mark a
> > > resource as non-movable.  This will also be useful to keep other import
> > > system resources from being moved around - for example system consoles
> > > on PCI busses.
> > 
> > I have a problem where an ich6 (SATA+PATA) is getting its port0 reserved
> > by the pci quirk for libata so that it gets picked up by ata_piix. In
> > current git, ata_piix complains:
> > 
> > [  124.507570] PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> > 
> > I bisected to the same commit, 368c73d4f689dae0807d0a2aa74c61fd2b9b075f,
> > however, your patch doesn't fix my problem.
> 
> Looks like a double reservation.  My patch doesn't deal with reservations
> at all.  I thought about resource reservations but decieded that should
> be dealt with elsewhere.

Checking the patch, my problem is that the old way, all BAR's were being
set at start = end = flags = 0. The patch makes it set all the BAR's to
the normal values. This is what it looks like in lspci, pre this patch:

        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>

So my device is not running in compatibility mode, and should not have
the BAR's set, as Alan's patch does.
