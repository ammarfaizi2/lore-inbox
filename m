Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268245AbUHQOHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268245AbUHQOHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUHQOHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:07:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8680 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265701AbUHQOGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:06:40 -0400
Date: Tue, 17 Aug 2004 10:05:33 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Message-ID: <20040817140533.GB2019@devserv.devel.redhat.com>
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171512.26568.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408171512.26568.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 03:12:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
> some other driver may accessing this hwif->hwgroup without holding ide_lock
> - probably will result in a crash few lines below when we try to free this 
> hwgroup

Will take a look. 
 
> > +
> > +	hwif->chipset = ide_unknown;
> 
> this breaks (half-working) HDIO_SCAN_HWIF ioctl
> and can change ordering of IDE devices in some situations
> - many host drivers look at hwif->chipset during init

The existing code didn't allow reuse of the hwif. It leaked it forever
each time because the chipset was left randomly set to pci. ide_unknown is
used by the scanning code in various places to mean "reusable". It has no
impact on ordering I can see because you don't hotplug ide until after
the boot sequence is complete. Once you do hotplug well the order is already
intriguing although it will preserve the pre setup legacy interfaces.

> hwif->key is not restored in ide_hwif_restore() so it will be
> always == 1 for once unregistered hwifs due to init_hwif_data()
> 
> Have you tested 'hwif->key' infrastructure?

I've done some basic testing on things like unload invalidate. It would
have missed the unload/reload one. As discussed earlier I'm trying some
alternatives - refcount turns out to get really horrible because unless
we switch to refcounting -everything- in one go we get unregisters that
can randomly fail as busy depending on /proc and other accesses, and
code that isnt meant to cope with this.

> >  		kfree(setting);
> >  	return -1;
> > @@ -1058,7 +1282,7 @@
> >  EXPORT_SYMBOL(ide_add_setting);
> 
> this breaks locking for IDE device drivers which also call ide_add_setting()
> but they are not holding ide_setting_sem

No. Follow the locking. You have to move that locking outwards and I
already did so. Remember ata_attach is only safe under the setting sem.
The attach methods should always have ben called under setting_sem but
were not. Now they are so they in turn call the setting functions safely.

> > -			ide_unregister(arg);
> > -			return 0;
> > +			if(arg > MAX_HWIFS || arg < 0)
> > +				return -EINVAL;
> > +			if(ide_hwifs[arg].pci_dev)
> > +				return -EINVAL;
> 
> Why this change?  It prohibits all IDE PCI drivers and ide-cs
> from using HDIO_UNREGISTER_HWIF ioctl (which is half-working for IDE PCI 
> because next call to HDIO_SCAN_HWIF will clear hwif out due to hwif->hold == 
> 0 but it is not the case for ide-cs).

It's unsafe for the PCI case. Its also unsafe for every other case. Thats
why I have a fixme tagged on it 8)

> I hate HDIO_SCAN_HWIF and HDIO_UNREGISTER_HWIF and I still think we should 
> remove them - I waited with such changes for 2.7 but this plan failed becuase 
> there won't be 2.7 soon. :/

Once you have drive and controller hot plug you don't need them. Until then
some laptop users rely on them. I'd prefer to ignore the issue (its a
privileged code path) until the hotplug is there, or patch it up by
allowing unregister only of SCAN_HWIF added hwifs ?

Alan

