Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUE2ILH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUE2ILH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 04:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbUE2ILG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 04:11:06 -0400
Received: from mail.homelink.ru ([81.9.33.123]:34774 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S263980AbUE2ILC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 04:11:02 -0400
Date: Sat, 29 May 2004 12:10:59 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: two patches - request for comments
Message-Id: <20040529121059.3789c355.zap@homelink.ru>
In-Reply-To: <40B7B659.9010507@mvista.com>
References: <20040529012030.795ad27e.zap@homelink.ru>
	<40B7B659.9010507@mvista.com>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2004 14:59:53 -0700
Todd Poynor <tpoynor@mvista.com> wrote:

> Hi, you're adding new interfaces for power management of LCD and 
> backlight devices.  Since there's already LDM/sysfs interfaces for 
> reading and writing power state of generic devices, is it necessary to 
> add ones particular to these devices or device classes?  In other words, 
> is /sys/devices/<bus>/<device>/power/state not suitable for these purposes?
Well, first liquid crystal displays and backlight are not connected to any
specific bus. They could, on some platforms, and could not on other. For
example, on some PDAs backlight is controlled via the programmed I/O CPU pins
(GPIO), on other they are connected to some weird companion chips, on third
they could be controlled via the PCI bus (on large PCs, I mean) and so on. So
there will be no easy way for an application to find the backlight devices
and control them. In our case that's easy: opendir ("/sys/class/backlight")
and you found all of them.

On the other hand, the lcd and backlight modules will be used by the
framebuffer device, which in most cases will be itself on a certain bus. And
when the framebuffer device will be powered off, it contacts the corresponding
lcd and backlight devices to power them off as well.

On the third hand (:-) the lcd device class, for example, actually has *two*
power switches: the 'power' and the 'enable' attribute. The first powers off
the liquid crystal display, and seconds powers off the lcd controller. These
are different things and it would be wise to leave them apart, as having finer
grained control is always better. Also they have attributes that are in no way
part of power management: contrast, brightness etc. So these attributes would
have to be spreaded out across the entire sysfs.

On the fourth hand (oh no), what would be the code sequence for a framebuffer
device to find the corresponding lcd and backlight devices? For now that's
done by searching the 'backlight' and 'lcd' device classes for a device with
the same name as the framebuffer device; if we place every device on its own
bus, the framebuffer device will have to search all the buses in the system.
Not speaking that the code will be substantially larger (current code is
already 2-3k for each class, which is alot if we're speaking of embedded
systems).

> And if a PM interface for device classes is needed that ties into the 
> device driver suspend/resume callbacks, perhaps it can be modeled more 
> closely on the existing interfaces?  These new interfaces seem to be 
> intended to define: 0 == power off, 1 ==  power on.  The existing 
> ACPI-inspired interfaces use: 0 == power on/full-power, 1/2/3/4 == 
> low-power/off state.
Um, well, this could be implemented. Although I don't see much reason for a
backlight to be in a "semi-enabled state"; besides if it will remain a
separate class device, it doesn't matter much. But if someone cares, it could
be changed now since there is not much code which depends on that.

> New files don't have GPL license comments.
Indeed, I forgot to add them. Initially they weren't designed to be compiled
as modules.

--
Greetings,
   Andrew
