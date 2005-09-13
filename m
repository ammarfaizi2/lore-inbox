Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVIMFzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVIMFzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVIMFzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:55:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:58780 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932309AbVIMFzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:55:54 -0400
Date: Mon, 12 Sep 2005 22:55:33 -0700
From: Greg KH <greg@kroah.com>
To: Edgar Toernig <froese@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [udev/vcs] tons of creating/removing /dev/vcs* during boot
Message-ID: <20050913055533.GA7206@kroah.com>
References: <20050912170618.69e18341.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912170618.69e18341.froese@gmx.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 05:06:18PM +0200, Edgar Toernig wrote:
> Hi,
> 
> switching from SuSE's 2.6.11.4 to vanilla 2.6.13 I noticed
> that I get tons of these lines in the log during boot:
> 
> udev[2124]: configured rule in '/etc/udev/rules.d/50-udev.rules[98]' ...
> udev[2121]: creating device node '/dev/vcs5'
> udev[2124]: creating device node '/dev/vcsa3'
> udev[2140]: configured rule in '/etc/udev/rules.d/50-udev.rules[98]' ...
> udev[2144]: configured rule in '/etc/udev/rules.d/50-udev.rules[98]' ...
> udev[2140]: creating device node '/dev/vcs3'
> udev[2144]: creating device node '/dev/vcsa6'
> udev[2147]: removing device node '/dev/vcs6'
> udev[2149]: configured rule in '/etc/udev/rules.d/50-udev.rules[98]' ...
> udev[2158]: removing device node '/dev/vcs4'
> udev[2157]: removing device node '/dev/vcsa3'
> udev[2149]: creating device node '/dev/vcsa5'
> udev[2172]: configured rule in '/etc/udev/rules.d/50-udev.rules[98]' ....
> udev[2171]: removing device node '/dev/vcsa2'
> udev[2172]: creating device node '/dev/vcs5'
> 
> It's caused by various loadkeys, setleds, etc performed early in an
> init script.  It seems, that every open/close of a tty generates
> a hotplug event for the appropriate vcs/vcsa device.  It stops at
> the moment gettys are spawned.
> 
> Looking at the 2.6.11.4 source of drivers/char/vc_screen.c I see
> that hotplug events are explicitly disabled for the vcs and vcsa
> devices (not sure whether this was done by SuSE).

Yes, this was a SUSE change, that's never been in mainline.

> In 2.6.13 all of that code is gone, including the class_simple that
> was used to disable hotplug events.

Well, consider it "never present" instead of gone :)

> How can I avoid all of these hotplug events?

Why do you want to?  You need them in order to create the proper device
node for the virtual terminal, right?

And, if you use the latest versions of udev, no hotplug events need
cause a program execute, udev can watch the hotplug netlink socket and
just act on it, _very_ quickly.  So quickly you will not even care I
bet...

> Best would be of course to generate only a single event at the same
> time the tty device is create.

That's what you are seeing.  And then watching as it's being destroyed.
And then created.  And then destroyed.  And so on (virtual ttys are
nasty at times..)

> But I could also live with no hotplug events for vcs* at all.

You would not be able to use them if you use udev then :(

Seriously, try the latest udev, with the netlink socket, and see if it
still matters anymore.

thanks,

greg k-h
