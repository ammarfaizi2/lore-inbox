Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVHOSAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVHOSAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVHOSAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:00:42 -0400
Received: from loihi.boulder.swri.edu ([65.241.78.2]:63950 "EHLO
	perseus.boulder.swri.edu") by vger.kernel.org with ESMTP
	id S964866AbVHOSAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:00:42 -0400
Message-ID: <4300D845.8070605@skyrush.com>
Date: Mon, 15 Aug 2005 12:00:37 -0600
From: Joe Peterson <joe@skyrush.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to drivers/input/evdev.c to add mixer device "/dev/input/events"
References: <4300D09C.4030702@skyrush.com> <20050815174558.GB1450@ucw.cz>
In-Reply-To: <20050815174558.GB1450@ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Mon, Aug 15, 2005 at 11:27:56AM -0600, Joe Peterson wrote:
> 
> 
>>I, and a growing number of others, have been having trouble with using
>>touch screen devices in Linux, particularly the motorized ones that fit
>>into car dashboards.  The problem is that these devices, which have a
>>USB touchscreen (often the eGalax brand), turn off when the screen is
>>retracted, causing Linux to remove and/or disconnect the event device
>>in /dev/input.
>>
>>Using udev to assign a persistent symlink to the device was the first
>>thing I tried, but it does not solve the problem, since X windows does
>>not see the device when it turns back on, even if it's the same name.  I
>>(and others) have tried hacks like changing virtual terminals, etc. to
>>get it back, but these are not elegant solutions are are problematic.
>>
>>Anyway, I finally decided the thing I needed was something like
>>/dev/input/mice, since it is always there for X to see, even if the
>>device is off during boot.  But the mousedev devices are not the
>>right data format for use with the touch screens (you need "event"
>>ones).  So I hacked evdev.c and added "/dev/input/events", which is a
>>mixer as well and catches all events from event0, event1, etc.
> 
> 
>>Anyway, I hope my change is valuable.  I (and others) would love to see
>>it appear in the official kernel source.  I attached the patch.
> 
> 
> I really think this is the wrong way to go. Much better would be to fix
> the X driver (are you using evtouch or something else?) to notice the
> disconnect of the device (it'll get -ENODEV) and connect of the device
> (a hotplug event is issued, a select() on /proc/bus/input/devices
> returns as readable) and re-open the device.
> 
> It's not really possible to mix the events from all devices together,
> namely touchscreens, since mixing of ABS_* events is undefined.
> 

I am using evtouch, but I had read that X itself has an issue with
devices that are not "always there" and that X does not [yet] seem to be
designed to handle hotplugging well (for example, device names need to
be hard-coded in xorg.conf, so a changing device name on plugging will
not work).  Perhaps this could be fixed, but it might be a lot more
involved.  Why was /dev/input/mice created?  It does correct the issue
of unplugging and plugging mice (as well as its obvious feature of
allowing multiple mice, of course)?  It keeps X happy by shielding it
from the plugging/unplugging.

If the mixing of event devices is problematic, what about simply the
idea of a persistent event device that always "exists" to the user of
the events but will reattach if the HW is plugged/unplugged (the device
name assigned could be made constant using a udev symlink)?  This could
solve the problem without mixing all events.  In my case, I have one
touch screen only (as most people would), so the mixing works in my
case, of course.

	-Joe
