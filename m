Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVLEPjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVLEPjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 10:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVLEPjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 10:39:11 -0500
Received: from tim.rpsys.net ([194.106.48.114]:12731 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751371AbVLEPjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 10:39:10 -0500
Subject: Re: [RFC PATCH 1/8] LED: Add LED Class
From: Richard Purdie <rpurdie@rpsys.net>
To: David Vrabel <dvrabel@cantab.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>
In-Reply-To: <439455BC.4080908@cantab.net>
References: <1133788166.8101.125.camel@localhost.localdomain>
	 <439455BC.4080908@cantab.net>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 15:38:26 +0000
Message-Id: <1133797107.8101.191.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 14:59 +0000, David Vrabel wrote: 
> This LED subsystem isn't usable with LEDs that are controlled by I2C
> GPIO devices.  Getting rid of (struct led_device).lock would go some way
> to making it work.  It's not clear to me why it's needed anyway.

The lock is so no two code paths try and change led_device at once. This
is particularly apparent when triggers are considered as you could
otherwise end up with two calls trying to change an led to different
triggers or other equally bizarre circumstances. We need to guarantee
any trigger init and exit calls are made, other wise we'd have memory
leaks (and worse). Locking the brightness calls is just an extension of
that so the practise is fully evident.

For i2c devices to use this, the devices will have to use a workqueue
for brightness changes, lock or no lock. The reason is that trigger
events can come from undetermined kernel contexts and therefore the
brightness changing function should not sleep.

> Suspend and resume probably needs to be LED specific.

The core functions are probably applicable in 95% of cases and any LED
driver has the option of not using them if it so wishes.

Out of interest, what would an LED device wish to do instead of this?
Corgi/Spitz already don't suspend one of the leds under certain
circumstances as a device specific trigger (charging) is know to be
suspend aware.

> > +
> > +menu "LED devices"
> > +
> > +config NEW_LEDS
> 
> Is there a better name than NEW_LEDS?  It won't be 'new' for very long...

I'd prefer LEDS but this will clash with ARM. I'll wait for Russell's
comments but I'm open to alternative suggestions.


> 0-255 is probably a better range to use.  Might be worth having an enum
> like.
> 
> enum led_brightness {
> 	LED_OFF = 0, LED_HALF_BRIGHT = 127, LED_FULL_BRIGHT = 255,
> };

Yes, that's probably not a bad idea.

Cheers,

Richard

