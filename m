Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271284AbTHHKh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 06:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271287AbTHHKh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 06:37:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2293 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271284AbTHHKhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 06:37:24 -0400
Date: Fri, 8 Aug 2003 12:37:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: Problem multiple bool/tristate prompts
Message-ID: <20030808103717.GP16091@fs.tum.de>
References: <20030807235905.GO16091@fs.tum.de> <Pine.LNX.4.44.0308081135520.714-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308081135520.714-100000@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 12:03:45PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 8 Aug 2003, Adrian Bunk wrote:
> 
> > config BLK_DEV_PS2
> >         tristate "PS/2 ESDI hard disk support" if BROKEN_MODULAR
> >         bool "PS/2 ESDI hard disk support" if !BROKEN_MODULAR
> > 
> > 
> > Every "make *config" gives the warning
> > 
> >   drivers/block/Kconfig:45: prompt redefined
> >   drivers/block/Kconfig:45:warning: type of 'BLK_DEV_PS2' redefined from 
> >   'tristate' to 'boolean'
> > 
> > and the symbol is handled as tristate although BROKEN_MODULAR isn't
> > defined.
> 
> A symbol can have only a single type and the warning is a bit misleading, 
> the new type definition is simply ignored.
> I'm not sure what you're trying makes really sense, but you have to use a 

I made a patch that lets all broken drivers depend on an (undefined) 
BROKEN symbol and all drivers that don't compile on SMP on a 
BROKEN_ON_SMP symbol that is only defined if !SMP.

This (undefined) BROKEN_MODULAR was an attempt to express that a driver
compiles only statically.

> separate symbol:
> 
> config BLK_DEV_PS2_B
> 	bool "PS/2 ESDI hard disk support" if !BROKEN_MODULAR
> 
> config BLK_DEV_PS2
> 	tristate "PS/2 ESDI hard disk support" if BROKEN_MODULAR
> 	default BLK_DEV_PS2_B

It's too complicated to be actually useful, but it seems I'd then need a

config BLK_DEV_PS2_TRISTATE
	tristate "PS/2 ESDI hard disk support"
	depends on BROKEN_MODULAR
	default y if BLK_DEV_PS2=y
	default m if BLK_DEV_PS2=m

config BLK_DEV_PS2_BOOL
	bool "PS/2 ESDI hard disk support"
	depends on !BROKEN_MODULAR
	default y if BLK_DEV_PS2=y

config BLK_DEV_PS2
	default y if BLK_DEV_PS2_TRISTATE=y || BLK_DEV_PS2_BOOL
	default m if BLK_DEV_PS2_TRISTATE=m

Alternatively it might work with BLK_DEV_PS2_TRISTATE and
BLK_DEV_PS2_BOOL using select.

My problem isn't that important to satisfy such a complicated construct,
I can accept that there's no easy way to express this and live without
it.


> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

