Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbTAXTx0>; Fri, 24 Jan 2003 14:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbTAXTx0>; Fri, 24 Jan 2003 14:53:26 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:52486 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S264903AbTAXTxZ>; Fri, 24 Jan 2003 14:53:25 -0500
Date: Fri, 24 Jan 2003 15:00:06 -0500
From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@redhat.com>, willy@debian.org,
       linux-kernel@vger.kernel.org, Jeff Wiedemeier <Jeff.Wiedemeier@hp.com>
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
Message-ID: <20030124150006.A2882@dsnt25.mro.cpqcorp.net>
References: <20030124212748.C25285@jurassic.park.msu.ru> <20030124193135.GA30884@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030124193135.GA30884@gtf.org>; from jgarzik@pobox.com on Fri, Jan 24, 2003 at 02:31:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 02:31:35PM -0500, Jeff Garzik wrote:
> On Fri, Jan 24, 2003 at 09:27:48PM +0300, Ivan Kokshaysky wrote:
> > --- 2.5.59/drivers/net/tg3.c	Fri Jan 17 05:22:16 2003
> > +++ linux/drivers/net/tg3.c	Fri Jan 24 19:28:44 2003
> > @@ -3096,7 +3096,12 @@ static void tg3_chip_reset(struct tg3 *t
> >  		val |= PCISTATE_RETRY_SAME_DMA;
> >  	pci_write_config_dword(tp->pdev, TG3PCI_PCISTATE, val);
> >  
> > -	pci_restore_state(tp->pdev, tp->pci_cfg_state);
> > +	pci_restore_extended_state(tp->pdev, tp->pci_cfg_state);
> > +
> > +	/* Make sure MSGINT_MODE is set if MSI is configured. */
> > +	pci_read_config_dword(tp->pdev, TG3PCI_MSI_CAP_ID, &val);
> > +	if ((val >> 16) & PCI_MSI_FLAGS_ENABLE)
> > +		tw32(MSGINT_MODE, MSGINT_MODE_ENABLE);
> >  
> >  	/* Make sure PCI-X relaxed ordering bit is clear. */
> >  	pci_read_config_dword(tp->pdev, TG3PCI_X_CAPS, &val);
> 
> hmmmm.  We don't use MSI in the driver anymore, unless I am missing
> something.
> 
> So, the above patch is probably the wrong thing to do.  I'll need to
> check to be sure, but I think that h/w reset clears MSGINT_MODE_ENABLE,
> so we wouldn't want to be randomly enabling it when it is purposefully
> disabled.
> 
> DaveM/Jeff, corrections?

The problem is that if the chip is configured for MSI (through config
space) and the platform's irq mapping code therefore filled in
pci_dev->irq with an appropriate vector for the MSI interrupt the chip
is assigned instead of the LSI interrupt it may also be assigned, then
unless MSGINT_MODE matches PCI_MSI_FLAGS_ENABLE, the driver will grab
wrong interrupt.

/jeff
