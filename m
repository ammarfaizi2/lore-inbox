Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSEXPRb>; Fri, 24 May 2002 11:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317174AbSEXPRa>; Fri, 24 May 2002 11:17:30 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:35251 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317170AbSEXPR2>;
	Fri, 24 May 2002 11:17:28 -0400
Date: Fri, 24 May 2002 17:17:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
Message-ID: <20020524171721.A14127@ucw.cz>
In-Reply-To: <Pine.SOL.4.30.0205241620440.16894-100000@mion.elka.pw.edu.pl> <20020524165021.B10656@ucw.cz> <3CEE4905.5010503@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 04:07:01PM +0200, Martin Dalecki wrote:
> Uz.ytkownik Vojtech Pavlik napisa?:
> > On Fri, May 24, 2002 at 04:29:39PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> >>Hi!
> >>
> >>I have a very quick look over patch/driver... looks quite ok...
> >>
> >>But it doesn't support multiple controllers.
> > 
> > 
> > Yes, right! That's a bug. Ahh, that's why all the drivers use the PCI
> > device id over and over and over in the sources ...
> > 
> > 
> >>We should add 'unsigned long private' to 'ata_channel struct' and
> >>store index in the chipset table there.
> > 
> > 
> > That'd be great. Though I prefer void*. Looks like "drive_data" is
> > intended for that purpose. Martin: How about renaming this to "private"
> > and a comment "solely for use by chip-specific drivers"?
> 
> Indeed strcut ata_channel should be virtualized this way.
> However you can't reuse drive_data for this purpose - that
> get's consumed by ide-scsi already if I remember correctly.
> (Will have to double check.)

If it does, it's a bug, imho, as chip drivers are using it.

> > A private member in the ata_pci_device[] struct would be also very
> > useful. Or is the "extra" field for that?
> 
> extra is it already for host chip driver specific flags.
> pdc202xx is the only one using it. Indeed this should be moved
> to a void *private as well.
> 
> But anyway principally I agree with all the suggestions.

Will you implement that or should I?

There is more to that: the initialization of the chip drivers still
won't work with the private fields - because chip_init won't know what
channels it is using, because it only gets pci_dev as a parameter, etc,
etc ... the functions in the chip drivers have very tough way keeping
information available between them.

In my opinion the chip_init function should detect what channels are
enabled and call an ata_register_channel function, which would tell the
above layer which functions to call when, etc, etc.

Furthermore, the PCI probing should be split and separated into the chip
drivers, but that can happen later. First the registration needs to be
done per-channel found (maybe per-controller) and not per-driver.

> BTW.> Please note that right now we have a bit
> of dichotomy about where the actual driver
> methods get stored, after I have generalized the registration
> of the driver. This should be unified at some point in time as well.
> (xxxproc and udma_xxx method famili is what I have in mind here.)

That isn't a problem for me at this very moment, fortunately.

> >>You can remove duplicate entries from module data table.
> > 
> > I wonder how they got there ...
> 
> Already gone in nr. 70.

Ahh, I may have started from a slightly older version.

> >>BTW: please don't touch pdc202xx.c I am playing with it...
> > 
> > 
> > Ok, I won't. Send it to me for comments later.
> 
> You guys are reducing me more and more to a spinnlock for
> synchronization ;-).

Isn't that nice? ;)

-- 
Vojtech Pavlik
SuSE Labs
