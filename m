Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267246AbSLKRfV>; Wed, 11 Dec 2002 12:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbSLKRfV>; Wed, 11 Dec 2002 12:35:21 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:59349 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267243AbSLKRfT>;
	Wed, 11 Dec 2002 12:35:19 -0500
Date: Wed, 11 Dec 2002 09:43:05 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, dahinds@users.sourceforge.net,
       davem@vger.kernel.org
Subject: Re: Status new-modules + 802.11b/IrDA
Message-ID: <20021211174305.GB11264@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20021211010512.GA5853@bougret.hpl.hp.com> <20021211093007.B58402C093@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211093007.B58402C093@lists.samba.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 07:34:53PM +1100, Rusty Russell wrote:
> In message <20021211010512.GA5853@bougret.hpl.hp.com> you write:
> > 	Hi,
> 
> Hi Jean!
> 
> 	Thanks for the report.

	Yes, for a change I'm trying to be helpful ;-)

> > Debian Boot :
> > -----------
> > 	o Din't pick up new modutils in the init scripts. Probably
> > because I used install option 1b in README (/usr/local/sbin).
> > 	o Re-install with option 1a (/sbin), works fine.
> > 	o Maybe this needs to be in README.
> 
> Debian have picked up the module-init-tools, so although they're a bit
> lagged as I type this, I expect this to become a less common occurrance.

	I'm using stable, which mean that I'm lagging behind Debian...

> > Pcmcia and airo_cs :
> > ------------------
> > 	o Loads with error below, airo_cs driver is functional.
> > 	o i82365 cannot be unloaded, it's unsafe.
> > 	o removal of airo_cs : "Uninitialised timer!/nThis is a
> > warning. Your computer is OK". Call trace on demand. Also, the module
> > airo not removed (probably due to problem with airo_cs).
> 
> That, in itself, should be harmless.

	Yes, but this is new and I don't really like it. I suspect
something is wrong in the Pcmcia code itself. Last I tried was 2.5.46
and I see some suspicious init_timer() added where I would not expect,
and some missing where they would be needed.
	Hum... Who is in charge ?

> > 	o re-insertion of the card : nothing happens. No messages.
> > 	o After reboot, /etc/init.d/pcmcia stop -> same thing + script
> > hang + a few [kmodule1? <defunct>]. This prevent the computer to
> > reboot or shutdown properly (== fsck at next boot).
> 
> Wierd.  The PCMCIA scripts make assumptions about layout of
> /lib/modules/`uname -r` which was broken by the removal of the
> directory hierarchy.  It's not the only thing (mkinitrd also wants
> this).  While relying on the layout of the kernel source tree is
> broken, no better alternatives have some up, so this is queued to be
> reverted once I test that it doesn't break the current tools (which
> *should* handle it).

	I personally believe the timer thingy is important and cause
of problems.

> There is a known bug where an *old* rmmod will hang (it has the effect
> of "rmmod --wait": I have a patch to differentiate the two
> effectively, but it requires everyone to upgrade to 0.9 or above,
> which they have probably done by now).

> > 	o af_irda, irda-usb & irtty-sir are "unsafe". I tracked that
> > down to the use of MOD_INC_USE_COUNT. The header file module.h give
> > hints on how I should convert that to the new world (use
> > try_module_get), however your FAQ seems to say something else (just
> > remove them, they are useless). I'm quite confused, because those
> > MOD_INC_USE_COUNT have a definite purpose... I would appreciate more
> > guidance.
> 
> Looking at these files:
> 
> idra-usb.c: add "netdev->owner = THIS_MODULE;" and get rid of the
> 	MOD_INC_USE_COUNT.

	This was the easy one.

> irtty-sir.c: The ldisc code needs an owner field, and it needs to use
> 	it.  Until then, this warning is best left where it is.

	Ok.

> af_irda: The caller needs to do something here, too.  Dave?

	Ok.

> Rusty.

	Thanks a lot !

	Jean
