Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266752AbUGLITl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266752AbUGLITl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 04:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266754AbUGLITl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 04:19:41 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:38834 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266752AbUGLITi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 04:19:38 -0400
Date: Mon, 12 Jul 2004 10:19:39 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: watchdog infrastructure
Message-ID: <20040712081939.GJ5726@infomag.infomag.iguana.be>
References: <200407011923.45226.arnd@arndb.de> <20040705093800.GB5726@infomag.infomag.iguana.be> <200407051454.48340.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407051454.48340.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,

sorry for the delay, but it's pretty busy at my work at the moment.

> > Did you have a look allready at the different watchdog operations in 
> > include/linux/watchdog.h ?
> 
> Yes, I already have a working driver, which does not use the
> experimental infrastructure code. I'm just not allowed to
> publish it until the hardware is available.
> 
> There are a couple of things I noticed about your new code:
> 
> - Is there any reason having an alloc_watchdogdev function in the
>   common code? Simply statically allocating the structure in each
>   device driver should be a lot simpler.

Oops: I forgot apparently: the experimental code is indeed more for
2.7 . Plan is to go in 2 stages: have a generic watchdog for v2.6
which is just generic code that can be used by any single watchdog.
This general code will contain the common things (basically the misc
device + reboot_notifier). The second stage (and that's what's
I actually created the experimetal directory) is to go to a general
watchdog driver that supports sysfs and multiple watchdog-drivers
(although only one driver will use /dev/watchdog). Because of the
fact that you can use multiple watchdog-driver (even multiple cards
of the same driver), you need to allocate it with alloc-watchdog.
The experimental code will get the notifier in it as a second step
and after that the sysfs support.
I'll putt the new 2.6 code in linux-2.6-watchdog-development (but
I'll be on holiday first :-) ).

> - Keeping watchdog_ops out of watchdog_device will simplify 
>   the lifetime rules. Just put them in the same structure, add an
>   owner field and get rid of the *private field.

I'll have a look at that. The *private fiels is for the 2.7 code
with multiple watchdogs.

> - watchdog_is_open_sem can just be an atomic_t, you never
>   actually down() it.

Hmmm, that's indeed a bug then. Will have a look at it later on.

> - You need to get the module reference count before calling any
>   watchdog operation, the best place for this is probably the
>   open() fop.

I don't see any reason why we should get the module reference
count. Could you enlighten why this would be necessary?
(This should only happen when you want to have a "nowayout").

> - Maybe its easier to always register the misc devices when
>   watchdog.ko is loaded, and then deny opening them when no
>   actual watchdog driver is registered to it.

Interesting idea. Although it's better now that we keep it like
it is because else the daemon that poll's /dev/watchdog will
will open something that's not there and think that everything
is fine and that the system is monitored (which it isn't). A
second problem you have is that this daemon absolutely doesn't
know when it will need to reopen /dev/watchdog (to really start
the hardware watchdog) after you've loaded a "working" watchdog
device driver.

> - Why do you need seperate operations for start and keepalive?

Some watchdog devices/cards have seperate functions for starting
their internal counters and for keeping the watchdog alive. Thus
you need 2 different operations. For other cards this function
is the same and thus the start and keepalive code is the same.

> - the reboot notifier and the nowayout parameter are probably
>   common enough to be put into the generic module.

The reboot notifier was the next step. That's indeed common.
the nowayout parameter should stay together with the watchdog
driver in my opinion (because if you would use more then 1
watchdog device, you might want to set this for each device
independently).

Greetings,
Wim.



