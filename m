Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUFBV3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUFBV3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUFBV3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:29:16 -0400
Received: from mail.homelink.ru ([81.9.33.123]:28813 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S264226AbUFBVZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:25:37 -0400
Date: Thu, 3 Jun 2004 01:25:31 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Greg KH <greg@kroah.com>
Cc: tpoynor@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: two patches - request for comments
Message-Id: <20040603012531.41e00846.zap@homelink.ru>
In-Reply-To: <20040602171542.GL7829@kroah.com>
References: <20040529012030.795ad27e.zap@homelink.ru>
	<40B7B659.9010507@mvista.com>
	<20040529121059.3789c355.zap@homelink.ru>
	<40BCE28A.1050601@mvista.com>
	<20040602010036.440fc5b4.zap@homelink.ru>
	<20040602171542.GL7829@kroah.com>
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

On Wed, 2 Jun 2004 10:15:42 -0700
Greg KH <greg@kroah.com> wrote:

> > In theory, if we would use the standard power interface, it could use the
> > different levels of power saving, e.g. 0 - controller and LCD on, 1,2 -
> > LCD off, controller on, 3,4 - both off.
> Please use the standard power interface, and use the standard levels of
> power state.  That's why we _have_ this driver model in the first
> place...
The problem is that I cannot use the standard power interface because I don't
know how. The patch in question implements class devices, not regular devices.
Class devices don't use the standard power management scheme. Here:

/sys # ls devices/platform/
detach_state    power           pxa2xx_udc0
mq11xx0         pxa2xx-pcmcia0  pxafb0
mq11xx_udc0     pxa2xx_serial0  pxamci0

None of the above devices implement the backlight and LCD; they use bits from
different devices; in my case several GPIO pins from the mq11xx0 device, a
couple of CPU' GPIO pins (which aren't present in sysfs at all).

Now the mq11xx0 device (which is a System-On-Chip, e.g. a single chip
encomprising a lot of somehow-independent-functions) has a lot of subdevices:

/sys # ls devices/platform/mq11xx0/
detach_state  mq11xx_i2s0   mq11xx_spi0   mq11xx_uhc0
mq11xx_fb0    mq11xx_lcd0   mq11xx_udc0   power

The backlight is controlled by a few spare bits from the mq11xx_spi0 device
(which is a SPI bus controller). I don't think it makes sense to create the
backlight device node under /sys/devices/platform/mq11xx0/mq11xx_spi0/;
besides that's on my PDA; on other PDAs they could be located anywhere else,
thus the software will have a major headache to find the backlight/lcd power
controls.

Right now it works this way:

/sys # ls class/backlight/mq11xx_fb0/
brightness      max_brightness  power
/sys # ls class/lcd/mq11xx_fb0/
contrast      enable        max_contrast  power

I could unify lcd's 'power' and 'enable' attributes into one (they already use
the 'standard' 0-4 power levels), like I stated in one of my previous
messages, but it anyways would be quite different from the current power
management structure.

> > Well, the power interface under drivers/ is available for framebuffer.
> > If it would handle it properly (the framebuffer drivers I've tried
> > don't, alas)
> Then they need to be fixed to do so.
Doh, you don't want me to fix the whole kernel in one patch, don't you? :-)

--
Greetings,
   Andrew
