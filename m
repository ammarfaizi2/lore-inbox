Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUBJSAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUBJR5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:57:08 -0500
Received: from ns.suse.de ([195.135.220.2]:16778 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266120AbUBJRzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:55:15 -0500
Date: Tue, 10 Feb 2004 18:49:03 +0100
From: Karsten Keil <kkeil@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, kkeil@suse.de,
       kai.germaschewski@gmx.de,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
Message-ID: <20040210174903.GA27891@pingi3.kke.suse.de>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, kkeil@suse.de,
	kai.germaschewski@gmx.de,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <10763689362321@kroah.com> <Pine.GSO.4.58.0402101702420.2261@waterleaf.sonytel.be> <20040210164612.GB27221@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210164612.GB27221@kroah.com>
User-Agent: Mutt/1.4.1i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-166-default i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Feb 10, 2004 at 08:46:12AM -0800, Greg KH wrote:
> On Tue, Feb 10, 2004 at 05:03:17PM +0100, Geert Uytterhoeven wrote:
> > On Mon, 9 Feb 2004, Greg KH wrote:
> > > ChangeSet 1.1500.11.2, 2004/01/30 16:34:48-08:00, ambx1@neo.rr.com
> > >
> > > [PATCH] PCI: Remove uneeded resource structures from pci_dev
> > >
> > > The following patch remove irq_resource and dma_resource from pci_dev.  It
> > > appears that the serial pci driver depends on irq_resource, however, it may be
> > > broken portions of an old quirk.  I attempted to maintain the existing behavior
> > > while removing irq_resource.  I changed FL_IRQRESOURCE to FL_NOIRQ.  Russell,
> > > could you provide any comments?  irq_resource and dma_resource are most likely
> > > remnants from when pci_dev was shared with pnp.
> > 
> > FYI, at least one ISDN driver seems to need it as well:
> > 
> > | drivers/isdn/hardware/avm/b1isa.c: In function `b1isa_init':
> > | drivers/isdn/hardware/avm/b1isa.c:183: structure has no member named `irq_resource'
> 
> Ick, I don't really think we want users trying to override the irq
> number of their pci cards...

No but this driver use the PCI struct to deliver IO/IRQ values
to the card init routines (used by ISA and PCI)
also for old (not PnP) ISA cards.

The bug is to use irq_resource[0].start here, it must be isa_dev[i].irq
instead, allready fixed in last night patch.

> 
> Here's the patch that fixes this, and one other isdn driver up.  ISDN
> people, feel free to add this to your huge patch :)
> 
> thanks,
> 
> greg k-h
> 
> 
> ===== b1isa.c 1.9 vs edited =====
> --- 1.9/drivers/isdn/hardware/avm/b1isa.c	Tue Jul 15 03:01:29 2003
> +++ edited/b1isa.c	Tue Feb 10 08:43:39 2004
> @@ -180,7 +180,6 @@
>  			break;
>  
>  		isa_dev[i].resource[0].start = io[i];
> -		isa_dev[i].irq_resource[0].start = irq[i];
>  
>  		if (b1isa_probe(&isa_dev[i]) == 0)
>  			found++;
> ===== t1isa.c 1.11 vs edited =====
> --- 1.11/drivers/isdn/hardware/avm/t1isa.c	Tue Jul 15 03:01:29 2003
> +++ edited/t1isa.c	Tue Feb 10 08:44:01 2004
> @@ -519,7 +519,6 @@
>  			break;
>  
>  		isa_dev[i].resource[0].start = io[i];
> -		isa_dev[i].irq_resource[0].start = irq[i];
>  
>  		if (t1isa_probe(&isa_dev[i], cardnr[i]) == 0)
>  			found++;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Karsten Keil
SuSE Labs
ISDN development
