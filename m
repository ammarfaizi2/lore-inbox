Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266423AbUFZUV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266423AbUFZUV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 16:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUFZUV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 16:21:57 -0400
Received: from mail.homelink.ru ([81.9.33.123]:58547 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S266423AbUFZUVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 16:21:54 -0400
Date: Sun, 27 Jun 2004 00:21:52 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [1]
Message-Id: <20040627002152.20e2da7d.zap@homelink.ru>
In-Reply-To: <20040624213452.GC2477@kroah.com>
References: <20040617223514.2e129ce9.zap@homelink.ru>
	<20040617194739.GA15983@kroah.com>
	<20040618015504.661a50a9.zap@homelink.ru>
	<20040617220510.GA4122@kroah.com>
	<20040618095559.20763766.zap@homelink.ru>
	<20040624213452.GC2477@kroah.com>
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

On Thu, 24 Jun 2004 14:34:52 -0700
Greg KH <greg@kroah.com> wrote:

> How about just having every l/b driver containing a pointer to the
> fbinfo that it is associated with?  Isn't there some way you can keep
> the pointer that you need around within the place that you need to use
> it from eventually?
It's not a question of b/l driver needing the framebuffer driver; it's the
other way around: the framebuffer driver needs the b/l drivers (needs so
much that it can fail initialization in some cases if it doesn't find the
corresponding b/l device). Framebuffer interface has some functionality that
is directly related to b/l, notably the 'un/blank screen' method, and also
at initialization it would be very nice to turn on lcd and the backlight,
otherwise the user wouldn't see anything.

One possible solution would be to place the b/l pointers in the
'platform_data' field of the framebuffer device, but it's usable only for
platform devices, and even there not very handy (because the code registering
the framebuffer platform device would need to know about the b/l drivers, what
if b/l is a module that's not yet loaded?). In the case where devices are
registered by the bus enumerator the things are even worse.

After some discussion on IRC here's a slightly different proposal: During
framebuffer driver initialization it calls lcd_find_device(struct device*),
passing him the 'struct device' of the framebuffer device. The lcd or the
backlight driver looks inside the struct device (notably at the bus, bus_id
and other related fields) and compares them with whatever it expects them to
be (for example, a platform device-based lcd driver could compare
dev->bus_type with &platform_bus_type, a PCI driver could study the PCI device
ids and so on). And it returns either 0 (success) or -ENODEV (failure).

Reasoning: There isn't any static way to find out which b/l device corresponds
to a given framebuffer device. This is something that only the b/l driver
knows. For example, the b/l controls for a PCI video card could be embedded
into the PCI card; for palmtops they are implemented absolutely differently
(e.g. through auxiliary GPIOs, controlled by unrelated ASICs and so on). So
deciding the correspondence between the b/l driver and the framebuffer device
is the responsability of b/l driver: there is simply no other driver that
knows that.

If you'll ask why not embed the b/l controls directly into the framebuffer
drivers, the reason is simple: some video controllers just don't have a
predefined way of controlling the b/l, so in every implementation it's
different. Example: many PDAs use the PXA2xx CPU embedded video controller
(drivers/video/pxafb.c), but every PDA has his own way of controlling the
backlight and lcd. So the only solution here is to make pxafb ask "who knows
how to handle the backlight/lcd for *this* device" and get a pointer to the
b/l drivers.

--
Greetings,
   Andrew
