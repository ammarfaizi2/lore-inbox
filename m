Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUHQOeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUHQOeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUHQOeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:34:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:34178 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268253AbUHQObs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:31:48 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 16:30:07 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171512.26568.bzolnier@elka.pw.edu.pl> <20040817140533.GB2019@devserv.devel.redhat.com>
In-Reply-To: <20040817140533.GB2019@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408171630.07979.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 August 2004 16:05, Alan Cox wrote:
> > > +
> > > +	hwif->chipset = ide_unknown;
> >
> > this breaks (half-working) HDIO_SCAN_HWIF ioctl
> > and can change ordering of IDE devices in some situations
> > - many host drivers look at hwif->chipset during init
>
> The existing code didn't allow reuse of the hwif. It leaked it forever
> each time because the chipset was left randomly set to pci. ide_unknown is
> used by the scanning code in various places to mean "reusable". It has no
> impact on ordering I can see because you don't hotplug ide until after
> the boot sequence is complete. Once you do hotplug well the order is

Also ide_unregister_hwif() still can be called on rare circumstances during 
boot sequence - see ide_register_hw() mail - it needs fixing first.

> already intriguing although it will preserve the pre setup legacy
> interfaces.

You forgot about the sad fact that most host drivers can be modular
thanks to prematuraly making them modular in 2.4. :/

ide_match_hwif() checks for hwif->chipset - ordering will not be the same
i.e. you load driver for some IDE PCI controller which doesn't have drives 
attached to it, unload it, load some other driver - hwifs will be reused - 
some sequence in 2.4 will possibly leave you with different ordering because 
hwif->chipset will stay as ide_pci not ide_unknown

There are other much more crazy scenerios when you consider using 
HDIO_SCAN_HWIF nad HDIO_UNREGISTER_HWIF ioctls. ;)

> > >  		kfree(setting);
> > >  	return -1;
> > > @@ -1058,7 +1282,7 @@
> > >  EXPORT_SYMBOL(ide_add_setting);
> >
> > this breaks locking for IDE device drivers which also call
> > ide_add_setting() but they are not holding ide_setting_sem
>
> No. Follow the locking. You have to move that locking outwards and I
> already did so. Remember ata_attach is only safe under the setting sem.
> The attach methods should always have ben called under setting_sem but
> were not. Now they are so they in turn call the setting functions safely.

Yep, you are right.

> > > -			ide_unregister(arg);
> > > -			return 0;
> > > +			if(arg > MAX_HWIFS || arg < 0)
> > > +				return -EINVAL;
> > > +			if(ide_hwifs[arg].pci_dev)
> > > +				return -EINVAL;
> >
> > Why this change?  It prohibits all IDE PCI drivers and ide-cs
> > from using HDIO_UNREGISTER_HWIF ioctl (which is half-working for IDE PCI
> > because next call to HDIO_SCAN_HWIF will clear hwif out due to hwif->hold
> > == 0 but it is not the case for ide-cs).
>
> It's unsafe for the PCI case. Its also unsafe for every other case. Thats
> why I have a fixme tagged on it 8)
>
> > I hate HDIO_SCAN_HWIF and HDIO_UNREGISTER_HWIF and I still think we
> > should remove them - I waited with such changes for 2.7 but this plan
> > failed becuase there won't be 2.7 soon. :/
>
> Once you have drive and controller hot plug you don't need them. Until then

Yep, please tell me how are you going to support drive hot plug?

> some laptop users rely on them. I'd prefer to ignore the issue (its a
> privileged code path) until the hotplug is there, or patch it up by
> allowing unregister only of SCAN_HWIF added hwifs ?

I prefer short deprecation -> removal -> forgetting about them. :)
