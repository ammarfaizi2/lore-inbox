Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUBJQqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265933AbUBJQqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:46:31 -0500
Received: from mail.kroah.org ([65.200.24.183]:10458 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265745AbUBJQq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:46:28 -0500
Date: Tue, 10 Feb 2004 08:46:12 -0800
From: Greg KH <greg@kroah.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, kkeil@suse.de,
       isdn4linux@listserv.isdn4linux.de, kai.germaschewski@gmx.de
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
Message-ID: <20040210164612.GB27221@kroah.com>
References: <10763689362321@kroah.com> <Pine.GSO.4.58.0402101702420.2261@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402101702420.2261@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 05:03:17PM +0100, Geert Uytterhoeven wrote:
> On Mon, 9 Feb 2004, Greg KH wrote:
> > ChangeSet 1.1500.11.2, 2004/01/30 16:34:48-08:00, ambx1@neo.rr.com
> >
> > [PATCH] PCI: Remove uneeded resource structures from pci_dev
> >
> > The following patch remove irq_resource and dma_resource from pci_dev.  It
> > appears that the serial pci driver depends on irq_resource, however, it may be
> > broken portions of an old quirk.  I attempted to maintain the existing behavior
> > while removing irq_resource.  I changed FL_IRQRESOURCE to FL_NOIRQ.  Russell,
> > could you provide any comments?  irq_resource and dma_resource are most likely
> > remnants from when pci_dev was shared with pnp.
> 
> FYI, at least one ISDN driver seems to need it as well:
> 
> | drivers/isdn/hardware/avm/b1isa.c: In function `b1isa_init':
> | drivers/isdn/hardware/avm/b1isa.c:183: structure has no member named `irq_resource'

Ick, I don't really think we want users trying to override the irq
number of their pci cards...

Here's the patch that fixes this, and one other isdn driver up.  ISDN
people, feel free to add this to your huge patch :)

thanks,

greg k-h


===== b1isa.c 1.9 vs edited =====
--- 1.9/drivers/isdn/hardware/avm/b1isa.c	Tue Jul 15 03:01:29 2003
+++ edited/b1isa.c	Tue Feb 10 08:43:39 2004
@@ -180,7 +180,6 @@
 			break;
 
 		isa_dev[i].resource[0].start = io[i];
-		isa_dev[i].irq_resource[0].start = irq[i];
 
 		if (b1isa_probe(&isa_dev[i]) == 0)
 			found++;
===== t1isa.c 1.11 vs edited =====
--- 1.11/drivers/isdn/hardware/avm/t1isa.c	Tue Jul 15 03:01:29 2003
+++ edited/t1isa.c	Tue Feb 10 08:44:01 2004
@@ -519,7 +519,6 @@
 			break;
 
 		isa_dev[i].resource[0].start = io[i];
-		isa_dev[i].irq_resource[0].start = irq[i];
 
 		if (t1isa_probe(&isa_dev[i], cardnr[i]) == 0)
 			found++;
