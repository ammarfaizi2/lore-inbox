Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292355AbSBUMXM>; Thu, 21 Feb 2002 07:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292354AbSBUMXE>; Thu, 21 Feb 2002 07:23:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46855 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292356AbSBUMW5>;
	Thu, 21 Feb 2002 07:22:57 -0500
Message-ID: <3C74E698.D3A0BFEB@mandrakesoft.com>
Date: Thu, 21 Feb 2002 07:22:48 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christer Weinigel <wingel@acolyte.hack.org>
CC: wingel@nano-system.com, zwane@linux.realnet.co.sz, roy@karlsbakk.net,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.44.0202211134080.7649-100000@netfinity.realnet.co.sz> <3C74C8C7.25D7BCD@mandrakesoft.com> <20020221111910.57235F5B@acolyte.hack.org> <20020221115916.9FD5AF5B@acolyte.hack.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:
> static int margin = 60;         /* in seconds */
> MODULE_PARM(margin, "i");
> 
> static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;
> MODULE_PARM(nowayout, "i");

MODULE_PARM_DESC would be nice

> static void scx200_watchdog_update_margin(void)
> {
>         printk(KERN_INFO "%s: timer margin %d seconds\n", name, margin);
>         wdto_restart = 32768 / 1024 * margin;
>         scx200_watchdog_ping();
> }

if you can turn multiplication and division of powers-of-2 into left and
right shifts, other simplications sometimes follow.  Certainly you want
to avoid division especially and multiplication also if possible.

> static int scx200_watchdog_open(struct inode *inode, struct file *file)
> {
>         /* only allow one at a time */
>         if (down_trylock(&open_sem))
>                 return -EBUSY;
>         scx200_watchdog_enable();
>         expect_close = 0;
> 
>         return 0;
> }

now, a policy question -- do you want to fail or simply put to sleep
multiple openers?  if you want to fail, this should be ok I think.  if
you want to sleep, you can look at sound/oss/* in 2.5.x or
drivers/sound/* in 2.4.x for some examples of semaphore use on open(2).

> static int scx200_watchdog_release(struct inode *inode, struct file *file)
> {
>         if (!expect_close) {
>                 printk(KERN_WARNING "%s: watchdog device closed unexpectedly, "
>                        "will not disable the watchdog timer\n", name);

I wonder why 'name' is not simply a macro defining a string constant? 
Oh yeah, it matters very little.  You might want to make 'name' const,
though.

> static struct notifier_block scx200_watchdog_notifier =
> {
>         scx200_watchdog_notify_sys,
>         NULL,
>         0
> };

use name:value style of struct initialization, and omit any struct
members which are 0/NULL (that's implicit).

> static int __init scx200_watchdog_init(void)
> {
>         int r;

Here's a big one, I still don't like this lack of probing in the
driver.  Sure we have "probed elsewhere", but IMO each driver like this
one needs to check -something- to ensure that SC1200 hardware is
present.  Otherwise, a random user from a distro-that-builds-all-drivers
might "modprobe sc1200_watchdog" and things go boom.

If the upper levels have set up resources correctly, for example, then
there should be a resource for the watchdog that is -not- marked busy,
which the watchdog subsequently calls request_region on.  Or, the
resource is already marked busy (this is present state, as you
indicated) and you peek at the resource strings for the one you want.

Tiny drivers for hardware embedded on some larger device tends to need
little hacks like that to check for the presence of hardware... but you
need that sanity check somewhere in each driver.

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
