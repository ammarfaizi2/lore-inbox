Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbTGLQCa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbTGLQCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:02:30 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49865 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265976AbTGLQAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:00:18 -0400
Date: Sat, 12 Jul 2003 18:14:40 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
cc: Samuel Flory <sflory@rackable.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       Steven Dake <sdake@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21,
 patchattached to fix
In-Reply-To: <200307121611.13863.ruth@ivimey.org>
Message-ID: <Pine.SOL.4.30.0307121754050.19333-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 12 Jul 2003, Ruth Ivimey-Cook wrote:

> Various people wrote:
> > >>Ignore FastTrak BIOS and configure controller for RAID
> > >>CONFIG_PDC202XX_FORCE
> > >>  Forces the driver to use the ATA-RAID capabilities, overriding the
> > >>  BIOS configuration of the controller. Do not enable if you are
> > >>  using Promise's binary module.  This option is compatible with the
> > >>  ataraid driver.
> > >What about this:
> > Much better, but
> > >Ignore FastTrak BIOS
> > >CONFIG_PDC202XX_FORCE
> > >  Forces the driver to use FastTrak controller even if it was disabled
> > >  by BIOS for Promise software RAID driver.
> > This one might confuse people thinking we mean the ataraid driver, and
> > not the binary only driver.
>
> My personal experience of the FastTrak device is that you must always "force"
> it if you just want JBOD. [Note: I have never used a promise device as the
> 1st controller, because the Southbridge ide controller always comes in
> first]. Now, I have never tried using ataraid or the promise bin-only driver,
> so I guess there are occasions when not forcing is a good thing. I assume
> from other comments that no-force is the right option for the Promise
> binary-only driver?

Yes.

> I am much of the opinion that "CONFIG_PDC202XX_FORCE" should be a run-time
> option so that it can be set up correctly for the user's machine even when
> the kernel is a vendor one with pre-selected config choices. If this doesn't
> happen, in some cases (e.g. installing a new kernel) the user's disks just
> disappear and there isn't much you can do about it :-(   See my comments at
> the end of the mail for more on this.

Agreed.

> > Maybe:
> > Forces the driver to use FastTrak controller even if it was disabled
> >  by BIOS for Promise's binary only software RAID driver.
> >
> > >  Say Y if you do not use Promise's software RAID or
> > >        if you want to use ataraid driver.
> > >
> > >  Say N if you want to use Promise's binary module.
>
> I don't like this one, as at least on first reading I completely misunderstood
> it -- it seemed as if you only had RAID choices, no non-RAID ones. I see now
> that Y gives you a (veiled) non-RAID choice. Is the following better?

There is "or" not "and", but I see your point.

> Don't reserve the FastTrak controller for the Promise proprietary RAID driver.
>   Say Y if you:
>     - want to use attached disks quite independently;
>     - want to use attached disks in a Linux Software RAID (mdX) array;
>     - want to use attached disks with the Linux 'ataraid' driver. You must
>       also enable the option CONFIG_BLK_DEV_ATARAID_PDC.

Better: no "Say Y" description et all :-).

>   Say N if you want to use Promise's proprietary, binary only, Software
>     RAID driver.

Above with "saying N will cause ide driver to skip Promise controllers"
should be sufficent.

> I think a better configuration setup than this would be a multiple- choice
> arrangement that subsumes CONFIG_PDC202XX_FORCE, CONFIG_BLK_DEV_ATARAID_PDC
> and CONFIG_PDC202XX_NEW option into one question, like this:
>
> Configuration of the FastTrak IDE controller
> CONFIG_PDC202XX_MODE
>   Please select the appropriate driver for this controller:
>     [  ]  Promise proprietary, binary only, Software RAID driver
>     [  ]  Linux GPL version of Promise Software RAID driver
>     [  ]  Standard IDE driver, for disks that can be used quite independently
>

No way! This will make it even uglier.
Command line parameter is a superior solution.

>  However, this still has the problem of what happens if you have multiple
> controllers and wish to use them in 2 or more different configurations (e.g.
> 2 disks on 1st controller ataraid, 2 disks on another controller as JBOD).
>
> Therefore, IMO the best setup would be to provide options that enable
> possibilities (e.g enable you to use ataraid by compiling the code) but that
> the actual use of the disks is defined in a module or command-line switch
> (e.g. "pdc_ide2=ataraid,pdc_ide3=jbod"). In this case, we will keep the
> CONFIG_BLK_DEV_ATARAID_PDC and CONFIG_PDC202XX_NEW options but they do not
> imply a purpose: they just ensure that code is compiled. The option
> CONFIG_PDC202XX_FORCE becomes a run-time only thing, and so disappears from
> the config.

I think you just need "pdc_ide=0,force" and "pdc_ide=0,noforce".
No need to complicate things.

Remember that ataraid is only software RAID driver and pdc202xx_new
is a chipset driver.

jbod/raid should be managed by ataraid driver not ide or pdc202xx_new.
And seriously, I don't care unless somebody ports ataraid to 2.5.
[ Hint, hint! ;-) ]

> Should I think about coding this?

No, think about porting ataraid and pdcraid to 2.5 first.

Regards,
--
Bartlomiej

> Regards,
>
> Ruth
>
> --
> Engineer, Author and Webweaver

