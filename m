Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVHAMSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVHAMSw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 08:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVHAMSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 08:18:35 -0400
Received: from isilmar.linta.de ([213.239.214.66]:30154 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261877AbVHAMQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 08:16:56 -0400
Date: Mon, 1 Aug 2005 14:16:55 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: torvalds@osdl.org, akpm@osdl.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Richard Purdie <rpurdie@rpsys.net>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] pcmcia: defer ide-cs initialization after other IDE drivers started up [Was: Re: Heads up for distro folks: PCMCIA hotplug differences (Re: -rc4: arm broken?)]
Message-ID: <20050801121655.GA3014@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	torvalds@osdl.org, akpm@osdl.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050730130406.GA4285@elf.ucw.cz> <1122741937.7650.27.camel@localhost.localdomain> <20050730201508.B26592@flint.arm.linux.org.uk> <20050730223628.M26592@flint.arm.linux.org.uk> <1122858068.15622.10.camel@localhost.localdomain> <20050801074831.A677@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801074831.A677@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 07:48:31AM +0100, Russell King wrote:
> On Mon, Aug 01, 2005 at 02:01:07AM +0100, Alan Cox wrote:
> > On Sad, 2005-07-30 at 22:36 +0100, Russell King wrote:
> > > Since PCMCIA cards are detected and drivers bound at boot time, we no
> > > longer get hotplug events to setup networking for PCMCIA network cards
> > > already inserted.  Consequently, if you are relying on /sbin/hotplug to
> > > setup your PCMCIA network card at boot time, triggered by the cardmgr
> > > startup binding the driver, it won't happen.
> > 
> > So eth0 now randomly changes between on board and PCMCIA depending upon
> > whether the PCMCIA card was inserted or not, and your disks re-order
> > themselves in the same situation. That'll be funny if anyone does a
> > mkswap to share their swap between Linux and Windows. Gosh look there
> > goes the root partition.
> > 
> > I'm hoping thats not what you are implying. Especially for disks,
> > network is much much less of an issue.
> 
> If you have the socket driver as a module, as some (most?) distros do,
> then of course such cards won't be detected at boot time.  If PCMCIA
> and the socket driver are built-in, along with the card driver, then
> I guess this possibility may well exist - it does for NE2K cards.

Linus, Andrew,

Please apply this for 2.6.13 - Thanks,

	Dominik


Avoid registering PCMCIA CF cards before other IDE stuff. This means the risk
of /dev/hd* being re-ordered is lessened. The _sane_ thing to assert any
ordering is to use udev, nameif and so on, of course.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: 2.6.13-rc4-git1/drivers/ide/legacy/ide-cs.c
===================================================================
--- 2.6.13-rc4-git1.orig/drivers/ide/legacy/ide-cs.c
+++ 2.6.13-rc4-git1/drivers/ide/legacy/ide-cs.c
@@ -508,5 +508,5 @@ static void __exit exit_ide_cs(void)
 	BUG_ON(dev_list != NULL);
 }
 
-module_init(init_ide_cs);
+late_initcall(init_ide_cs);
 module_exit(exit_ide_cs);
