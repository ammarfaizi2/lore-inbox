Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbTIJS7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbTIJS7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:59:46 -0400
Received: from fed1mtao07.cox.net ([68.6.19.124]:1432 "EHLO fed1mtao07.cox.net")
	by vger.kernel.org with ESMTP id S265504AbTIJS7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:59:04 -0400
Date: Wed, 10 Sep 2003 11:59:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030910185902.GE4559@ip68-0-152-218.tc.ph.cox.net>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <3F5DBC1F.8DF1F07A@eyal.emu.id.au> <20030910110225.GC27368@fs.tum.de> <20030910155542.GD4559@ip68-0-152-218.tc.ph.cox.net> <20030910170610.GH27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910170610.GH27368@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 07:06:11PM +0200, Adrian Bunk wrote:
> On Wed, Sep 10, 2003 at 08:55:42AM -0700, Tom Rini wrote:
> >...
> > > --- linux-2.6.0-test4-mm5-modular-no-smp/drivers/input/keyboard/Kconfig.old	2003-09-04 19:03:45.000000000 +0200
> > > +++ linux-2.6.0-test4-mm5-modular-no-smp/drivers/input/keyboard/Kconfig	2003-09-04 19:04:49.000000000 +0200
> > > @@ -13,7 +13,8 @@
> > >  
> > >  config KEYBOARD_ATKBD
> > >  	tristate "AT keyboard support" if EMBEDDED || !X86 
> > > -	default y
> > > +	default y if INPUT=y && INPUT_KEYBOARD=y && SERIO=y
> > > +	default m
> > >  	depends on INPUT && INPUT_KEYBOARD && SERIO
> > >  	help
> > >  	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
> > > --- linux-2.6.0-test5+tr-modular-no-smp/drivers/input/serio/Kconfig.old	2003-09-10 12:52:22.000000000 +0200
> > > +++ linux-2.6.0-test5+tr-modular-no-smp/drivers/input/serio/Kconfig	2003-09-10 12:52:47.000000000 +0200
> > > @@ -20,7 +20,8 @@
> > >  
> > >  config SERIO_I8042
> > >  	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
> > > -	default y
> > > +	default y if SERIO=y
> > > +	default m
> > >  	depends on SERIO
> > >  	---help---
> > >  	  i8042 is the chip over which the standard AT keyboard and PS/2
> > 
> > A slightly better fix is for SERIO to default to Y on X86 and to
> > 'select SERIO_I8042 if X86'.  Then have INPUT_KEYBOARD similarly select
> > KEYBOARD_ATKBD.
> >...
> 
> That wouldn't be needed. AFAIK there are _no_ problems if SERIO=y, the 
> select you suggest is already implemented the other way round.

The problem is that SERIO==y means that SERIO_I8042 must be Y, as you
ran into.  If you have SERIO only asked on EMBEDDED || !X86, and on
similar conditions you then select SERIO_I8042, it just works.

> If SERIO is always y if !EMBEDDED || X86 my patch wouldn't be needed.

Correct.  I was suggesting that you do:
tristate "Serial i/o support (needed for keyboard and mouse)" if
!EMBEDDED || !X86  (or so)
select SERIO_I8042 if X86 && !EMBEDDED

and then remove the conditions on SERIO_I8042, which puts all of the
auto-select-this magic in one spot.

-- 
Tom Rini
http://gate.crashing.org/~trini/
