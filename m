Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbUBHTPC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 14:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUBHTPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 14:15:01 -0500
Received: from witte.sonytel.be ([80.88.33.193]:45528 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264433AbUBHTOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 14:14:53 -0500
Date: Sun, 8 Feb 2004 20:06:47 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 405] Amiga Hydra Ethernet new driver model
In-Reply-To: <20040208184705.GW7388@fs.tum.de>
Message-ID: <Pine.GSO.4.58.0402082000580.6076@waterleaf.sonytel.be>
References: <200402081528.i18FSTrV026999@callisto.of.borg>
 <20040208184705.GW7388@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Feb 2004, Adrian Bunk wrote:
> On Sun, Feb 08, 2004 at 04:28:29PM +0100, Geert Uytterhoeven wrote:
> > Hydra Ethernet: Convert to the new driver model
> >
> > --- linux-2.6.3-rc1/drivers/net/hydra.c	2004-02-08 10:19:34.000000000 +0100
> > +++ linux-m68k-2.6.3-rc1/drivers/net/hydra.c	2004-02-08 11:47:55.000000000 +0100
> >...
> > -static int __init hydra_init(unsigned long board);
> > +static int __devinit hydra_init_one(struct zorro_dev *z,
> > +				    const struct zorro_device_id *ent);
> > +static int __init hydra_init(struct zorro_dev *z);
> >...
> > +static int __devinit hydra_init_one(struct zorro_dev *z,
> > +				    const struct zorro_device_id *ent)
> > +{
> > +    int err;
> >
> > -    return err;
> > +    if (!request_mem_region(z->resource.start, 0x10000, "Hydra"))
> > +	return -EBUSY;
> > +    if ((err = hydra_init(z))) {
> > +	release_mem_region(z->resource.start, 0x10000);
> > +	return -EBUSY;
> > +    }
> > +    return 0;
> >  }
> >...
>
> __init hydra_init called from __devinit hydra_init_one ?
>
> This will break when compiling the driver statically into a kernel with
> CONFIG_HOTPLUG=y .

Thanks, you're right!

I checked the other drivers, and zorro8390.c has the same problem with
zorro8390_init(). I'll fix them and will resend after 2.6.3.

BTW, while verifying the rules w.r.t. the various __*it markers, I stumbled
across this in Documentation/pci.txt (while it's not really PCI-related):

| Tips:
|         The module_init()/module_exit() functions (and all initialization
|         functions called only from these) should be marked __init/exit.
|         The struct pci_driver shouldn't be marked with any of these tags.
|         The ID table array should be marked __devinitdata.
|         The probe() and remove() functions (and all initialization
|         functions called only from these) should be marked __devinit/exit.
|         If you are sure the driver is not a hotplug driver then use only
|         __init/exit __initdata/exitdata.
|
|         Pointers to functions marked as __devexit must be created using
|         __devexit_p(function_name).  That will generate the function
|         name or NULL if the __devexit function will be discarded.

But a quick look shows that very few drivers seem to mark their ID table array
__devinitdata...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
