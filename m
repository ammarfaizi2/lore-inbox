Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265890AbUFXXlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265890AbUFXXlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUFXXlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:41:16 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:58636 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265890AbUFXXlN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:41:13 -0400
Date: Fri, 25 Jun 2004 09:40:44 +1000
To: Alan Stern <stern@rowland.harvard.edu>
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] PATCH: (as326) Add mb() during initialization of UHCI controller
Message-ID: <20040624234044.GA5452@gondor.apana.org.au>
References: <E1BdSOR-0000DJ-00@gondolin.me.apana.org.au> <Pine.LNX.4.44L0.0406241023300.1562-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0406241023300.1562-100000@ida.rowland.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 10:26:06AM -0400, Alan Stern wrote:
> > > ===== drivers/usb/host/uhci-hcd.c 1.115 vs edited =====
> > > --- 1.115/drivers/usb/host/uhci-hcd.c   Wed Jun 23 12:10:07 2004
> > > +++ edited/drivers/usb/host/uhci-hcd.c  Wed Jun 23 12:30:05 2004
> > > @@ -2261,6 +2261,11 @@
> > >                uhci->fl->frame[i] = cpu_to_le32(uhci->skelqh[irq]->dma_handle);
> > >        }
> > > 
> > > +       /*
> > > +        * Some architectures require a full mb() to enforce completion of
> > > +        * the memory writes above before the I/O transfers in start_hc().
> > > +        */
> > > +       mb();
> > >        start_hc(uhci);
> > > 
> > >        init_stall_timer(hcd);
> > 
> > Any reason why a wmb() is not sufficient?
> 
> See http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108759528909973&w=2

Well I think this is something that we should document.

The question is what is the appropriate mechanism for synchronising
a direct write to DMA coherent memory and a subsequent writel().

include/asm-ppc/system.h says that mb() should be used, while
include/asm-ppc64/system.h says that wmb() should be and is used by
many drivers.

So which is it? Or perhaps we need something else?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
