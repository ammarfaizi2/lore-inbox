Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbVGIBYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbVGIBYp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbVGIBYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 21:24:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63238 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263012AbVGIBYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 21:24:04 -0400
Date: Sat, 9 Jul 2005 03:24:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [2.6 patch] SCSI_SATA has to be a tristate
Message-ID: <20050709012359.GO3671@stusta.de>
References: <20050708214802.GK3671@stusta.de> <Pine.LNX.4.61.0507090134040.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507090134040.3743@scrub.home>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 01:36:08AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 8 Jul 2005, Adrian Bunk wrote:
> 
> > --- linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig.old	2005-07-02 21:57:40.000000000 +0200
> > +++ linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig	2005-07-02 21:58:06.000000000 +0200
> > @@ -447,7 +447,7 @@
> >  source "drivers/scsi/megaraid/Kconfig.megaraid"
> >  
> >  config SCSI_SATA
> > -	bool "Serial ATA (SATA) support"
> > +	tristate "Serial ATA (SATA) support"
> >  	depends on SCSI
> >  	help
> >  	  This driver family supports Serial ATA host controllers
> 
> Did you verify that this works?
> Overwise "depends on SCSI=y" might also be correct.

Yes, I did.

The problem is that all the SATA drivers depend on SCSI_SATA.

With SCSI=m and SCSI_SATA=y this allows the static enabling of the SATA 
drivers with unwanted effects, e.g.:
- SCSI=m, SCSI_SATA=y, SCSI_ATA_ADMA=y
  -> SCSI_ATA_ADMA is built statically but scsi/built-in.o is not linked 
     into the kernel
- SCSI=m, SCSI_SATA=y, SCSI_ATA_ADMA=y, SCSI_SATA_AHCI=m
  -> SCSI_ATA_ADMA and libata are built statically but 
     scsi/built-in.o is not linked into the kernel,
     SCSI_SATA_AHCI is built modular (unresolved symbols due to missing 
                                      libata)

Making SCSI_SATA a tristate solves all these problems.

"depends on SCSI=y" would also solve these problems, but it would leave 
people with modular SCSI without SATA support...

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

