Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbSLKJWX>; Wed, 11 Dec 2002 04:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbSLKJWX>; Wed, 11 Dec 2002 04:22:23 -0500
Received: from dp.samba.org ([66.70.73.150]:2756 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267084AbSLKJWV>;
	Wed, 11 Dec 2002 04:22:21 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, dahinds@users.sourceforge.net,
       davem@vger.kernel.org
Subject: Re: Status new-modules + 802.11b/IrDA 
In-reply-to: Your message of "Tue, 10 Dec 2002 17:05:12 -0800."
             <20021211010512.GA5853@bougret.hpl.hp.com> 
Date: Wed, 11 Dec 2002 19:34:53 +1100
Message-Id: <20021211093007.B58402C093@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021211010512.GA5853@bougret.hpl.hp.com> you write:
> 	Hi,

Hi Jean!

	Thanks for the report.

> Debian Boot :
> -----------
> 	o Din't pick up new modutils in the init scripts. Probably
> because I used install option 1b in README (/usr/local/sbin).
> 	o Re-install with option 1a (/sbin), works fine.
> 	o Maybe this needs to be in README.

Debian have picked up the module-init-tools, so although they're a bit
lagged as I type this, I expect this to become a less common occurrance.

> hp100 (my Ethernet card) :
> ------------------------
> 	o When loading, module options (various hp100_XXX) are
> ignored, however they are necessary to get the card up and
> running. So, no network :-(
> 	o Seems that the section handling "param" support in the
> kernel is #if 0, so probably not finished up yet. I see that it's on
> your TODO list.

No, it's finished, it's just not merged 8(.  Testers welcome!  See:

	http://www.kernel.org/pub/linux/kernel/people/rusty/modules/2.5.51.patches.gz

> Pcmcia and airo_cs :
> ------------------
> 	o Loads with error below, airo_cs driver is functional.
> 	o i82365 cannot be unloaded, it's unsafe.
> 	o removal of airo_cs : "Uninitialised timer!/nThis is a
> warning. Your computer is OK". Call trace on demand. Also, the module
> airo not removed (probably due to problem with airo_cs).

That, in itself, should be harmless.

> 	o re-insertion of the card : nothing happens. No messages.
> 	o After reboot, /etc/init.d/pcmcia stop -> same thing + script
> hang + a few [kmodule1? <defunct>]. This prevent the computer to
> reboot or shutdown properly (== fsck at next boot).

Wierd.  The PCMCIA scripts make assumptions about layout of
/lib/modules/`uname -r` which was broken by the removal of the
directory hierarchy.  It's not the only thing (mkinitrd also wants
this).  While relying on the layout of the kernel source tree is
broken, no better alternatives have some up, so this is queued to be
reverted once I test that it doesn't break the current tools (which
*should* handle it).

There is a known bug where an *old* rmmod will hang (it has the effect
of "rmmod --wait": I have a patch to differentiate the two
effectively, but it requires everyone to upgrade to 0.9 or above,
which they have probably done by now).

> 	o af_irda, irda-usb & irtty-sir are "unsafe". I tracked that
> down to the use of MOD_INC_USE_COUNT. The header file module.h give
> hints on how I should convert that to the new world (use
> try_module_get), however your FAQ seems to say something else (just
> remove them, they are useless). I'm quite confused, because those
> MOD_INC_USE_COUNT have a definite purpose... I would appreciate more
> guidance.

Looking at these files:

idra-usb.c: add "netdev->owner = THIS_MODULE;" and get rid of the
	MOD_INC_USE_COUNT.

irtty-sir.c: The ldisc code needs an owner field, and it needs to use
	it.  Until then, this warning is best left where it is.

af_irda: The caller needs to do something here, too.  Dave?

> 	o When/if I will understand what's the best course of action,
> I can fix those myself.

Well, you can rmmod -f in the meantime.

> 	o Also, maybe you should put a pointer to your FAQ in the
> usual places (like in the README of module-init-tools-0.9.3), because
> it's only because I knew it existed that I've found it.

Hmm the contents of the FAQ are still in flux, which is why it's not
published.   The init stuff is still up for debate.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
