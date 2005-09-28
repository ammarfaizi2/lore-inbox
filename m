Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVI1T6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVI1T6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 15:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVI1T6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 15:58:53 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:19745 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750753AbVI1T6v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 15:58:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e4Vq1XBaDkTZmKnCi8MpeH4PcYecgfknVQzAr2Yeyti7i7w4+zZHN35nwAdX82sx+01QKMxMPYlmtcZlz6oYIgbXNeVzBpU427j1+v90fsMJ5jOi2gk48RfxssOZShEs0Ef/jGC7qGMWE5Kt7S/QLaJl5Mnp6/PI0tGdsty0s20=
Message-ID: <355e5e5e0509281258536e4be4@mail.gmail.com>
Date: Wed, 28 Sep 2005 15:58:50 -0400
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: Lukasz Kosewski <lkosewsk@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #5
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <433AEB4F.7010502@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <355e5e5e050926180156e58f59@mail.gmail.com>
	 <433AEB4F.7010502@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> > +/* Mask hotplug interrupts for one channel (ap) */
> > +static inline void pdc_disable_channel_hotplug_interrupts(struct ata_port *ap)
<snip>
> > +/* Clear and unmask hotplug interrupts for one channel (ap) */
> > +static inline void pdc_enable_channel_hotplug_interrupts(struct ata_port *ap)

> Rather than two functions, I prefer one function that takes an 'enable'
> boolean argument, just like pci_intx()
>
> Also, the function names are way too long.

OK, I'll change that.

> > -     sata_phy_reset(ap);
> > +     if (ap->flags & ATA_FLAG_SATA_RESET) {
> > +             pdc_disable_channel_hotplug_interrupts(ap);
> > +             sata_phy_reset(ap);
> > +             pdc_enable_channel_hotplug_interrupts(ap);
> > +     } else
> > +             sata_phy_reset(ap);
>
> I don't see the point of this.  Might as well unconditionally disable
> hotplug interrupts.

Sure.

> > +     if (plugdata) {
> > +             writeb(plugdata, mmio_base + hotplug_offset);
> > +             for (i = 0; i < host_set->n_ports; ++i) {
> > +                     ap = host_set->ports[i];
> > +                     if (!(ap->flags & ATA_FLAG_SATA))
> > +                             continue;  //No PATA support here... yet
> > +                     // Check unplug flag
> > +                     if (plugdata & 0x1) {
> > +                             /* Do stuff related to unplugging a device */
> > +                             ata_hotplug_unplug(ap);
> > +                             handled = 1;
> > +                     } else if ((plugdata >> 4) & 0x1) {  //Check plug flag
> > +                             /* Do stuff related to plugging in a device */
> > +                             ata_hotplug_plug(ap);
> > +                             handled = 1;
>
> What happens if both bits are set?  Seems like that could happen, if a
> plug+unplug (cable blip?) occurs in rapid succession.

What IF both bits are set?  This is why we have a debounce timer to
take care of the problem :P

The way this is set up, unplugging will win out (plugging will come
first, unplugging will come and destroy 'plug's timer, and then the
unplug action will be performed on timer expiry).  Personally, I like
it this way, but I can reverse the order of these two to make plugging
the default action.  Which do you prefer?

> The rest seems OK to me.

Excellent.  I'll repost when the issues you point out have been addressed.

Luke
