Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbRCNIF2>; Wed, 14 Mar 2001 03:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131328AbRCNIFT>; Wed, 14 Mar 2001 03:05:19 -0500
Received: from c1262263-a.grapid1.mi.home.com ([24.183.135.182]:41988 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S131324AbRCNIFC>;
	Wed, 14 Mar 2001 03:05:02 -0500
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
From: Brad Douglas <brad@neruo.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010313212529.16206@smtp.wanadoo.fr>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 14 Mar 2001 00:02:11 -0800
Mime-Version: 1.0
Message-Id: <20010314080510Z131324-406+251@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Mar 2001 22:25:29 +0100, Benjamin Herrenschmidt wrote:
> I'm working on improving some aspects of Power Management on the
> PowerBooks, and among other things, I have a problem with fbdevs.
> 
> Currently, each fbdev registers a power management callback to sleep/
> wakeup the device. We handle HW related things (shutting the backlight
> off, putting the chip to sleep when possible, backing up the frame buffer
> content, etc...) from there.
> 
> We do call the video sleep last during the sleep process, and wake it up
> first, to avoid any problem if something is beeing printed to the console
> while the chip is suspended.
> 
> However, this is not very safe. First, there's the cursor timer, which
> can screw us up. I have a hack in my tree where the fbdev driver calls a
> new routine in fbcon.c that stops/starts the cursor timer.
> 
> But I'm looking toward a more generic solution. By having a way to
> "suspend" the entire fbcon, maybe we can have all console output blocked
> & buffered until the fbcon is woken up. Also, a question is should we
> call that fbcon_suspend()/fbcon_resume() (currently only the cursor timer
> stuff) from the fbdev's or should the fbcon itself register as a power
> management client, and then call fbdev's suspend/resume routines ? I
> prefer the second solution as the fbdev's are often PCI devices (and so
> already have the ability of having PCI suspend/resume hooks).

I believe the second solution would be best.  We want to only have
hardware specific code in the fbdev drivers (well, as much as allows).

> Another solution would be to have all fbdev's have it's own suspend/
> resume hook (and maintain a "suspend" state that would tell fbdev to stop
> calling them or start working on a memory based backup image), and
> separately, fbdev's own suspend/resume (for the cursor, as it's not head-
> dependant but rather global to all fbdev's).

I think registering fbcon as a PM client and doing the above when the
fbdev suspend/resume hooks are called should work.  A memory backup is
worked on until the resume is run and the backup is restored to the
display.

So the fbdev drivers would register PM with fbcon, not PCI, correct?

Brad Douglas
brad@neruo.com
http://www.linux-fbdev.org


