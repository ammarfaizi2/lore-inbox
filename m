Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbTIJR06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbTIJRZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:25:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28882 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265341AbTIJRZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:25:19 -0400
Date: Wed, 10 Sep 2003 19:06:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030910170610.GH27368@fs.tum.de>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <3F5DBC1F.8DF1F07A@eyal.emu.id.au> <20030910110225.GC27368@fs.tum.de> <20030910155542.GD4559@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910155542.GD4559@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 08:55:42AM -0700, Tom Rini wrote:
>...
> > --- linux-2.6.0-test4-mm5-modular-no-smp/drivers/input/keyboard/Kconfig.old	2003-09-04 19:03:45.000000000 +0200
> > +++ linux-2.6.0-test4-mm5-modular-no-smp/drivers/input/keyboard/Kconfig	2003-09-04 19:04:49.000000000 +0200
> > @@ -13,7 +13,8 @@
> >  
> >  config KEYBOARD_ATKBD
> >  	tristate "AT keyboard support" if EMBEDDED || !X86 
> > -	default y
> > +	default y if INPUT=y && INPUT_KEYBOARD=y && SERIO=y
> > +	default m
> >  	depends on INPUT && INPUT_KEYBOARD && SERIO
> >  	help
> >  	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
> > --- linux-2.6.0-test5+tr-modular-no-smp/drivers/input/serio/Kconfig.old	2003-09-10 12:52:22.000000000 +0200
> > +++ linux-2.6.0-test5+tr-modular-no-smp/drivers/input/serio/Kconfig	2003-09-10 12:52:47.000000000 +0200
> > @@ -20,7 +20,8 @@
> >  
> >  config SERIO_I8042
> >  	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
> > -	default y
> > +	default y if SERIO=y
> > +	default m
> >  	depends on SERIO
> >  	---help---
> >  	  i8042 is the chip over which the standard AT keyboard and PS/2
> 
> A slightly better fix is for SERIO to default to Y on X86 and to
> 'select SERIO_I8042 if X86'.  Then have INPUT_KEYBOARD similarly select
> KEYBOARD_ATKBD.
>...

That wouldn't be needed. AFAIK there are _no_ problems if SERIO=y, the 
select you suggest is already implemented the other way round.

If SERIO is always y if !EMBEDDED || X86 my patch wouldn't be needed.

Considering this, it seems the patch below is both the best and the
simplest solution for most users.

It doesn't obsolete the other patch since SERIO=m is still possible, but 
makes it more unlikely to accidentially set SERIO=m (or even SERIO=n).

> Tom Rini

cu
Adrian

--- linux-2.6.0-test5+tr-modular-no-smp/drivers/input/serio/Kconfig.old	2003-09-10 19:02:01.000000000 +0200
+++ linux-2.6.0-test5+tr-modular-no-smp/drivers/input/serio/Kconfig	2003-09-10 19:02:29.000000000 +0200
@@ -2,7 +2,7 @@
 # Input core configuration
 #
 config SERIO
-	tristate "Serial i/o support (needed for keyboard and mouse)"
+	tristate "Serial i/o support (needed for keyboard and mouse)" if EMBEDDED || !X86
 	default y
 	---help---
 	  Say Yes here if you have any input device that uses serial I/O to
