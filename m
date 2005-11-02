Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVKBBDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVKBBDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 20:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVKBBDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 20:03:40 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:50598 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S932119AbVKBBDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 20:03:40 -0500
Message-ID: <55055.192.168.0.12.1130893399.squirrel@192.168.0.2>
In-Reply-To: <1130891953.8489.83.camel@localhost.localdomain>
References: <20051101234459.GA443@elf.ucw.cz>
    <1130891953.8489.83.camel@localhost.localdomain>
Date: Tue, 1 Nov 2005 19:03:19 -0600 (CST)
Subject: Re: best way to handle LEDs
From: "John Lenz" <lenz@cs.wisc.edu>
To: "Richard Purdie" <rpurdie@rpsys.net>
Cc: "Pavel Machek" <pavel@suse.cz>, vojtech@suse.cz,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Russell King" <rmk@arm.linux.org.uk>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, November 1, 2005 6:39 pm, Richard Purdie said:
> On Wed, 2005-11-02 at 00:44 +0100, Pavel Machek wrote:
>> Handheld machines have limited number of software-controlled status
>> LEDs. Collie, for example has two of them; one is labeled "charge" and
>> second is labeled "mail".
>
>> I think even slow blinking was used somewhere. I have some code from
>> John Lenz (attached); it uses sysfs interface, exports led collor, and
>> allows setting different frequencies.
>>
>> Is that acceptable, or should some other interface be used?
>
> This has been discussed before and I know there are several differing
> opinions.
>
> Based upon previous discussion both here, on linux-arm-kernel and in the
> handhelds community in general I came up with some ideas which I've yet
> to have time to code. I'll try and describe it though:
>
> The system would be in two sections (classes?), leds themselves and led
> triggers. The leds would be driven by something similar to John's driver
> Pavel attached. I think colour and other unchanging properties of the
> device should be something exported in the device name which could have
> some format like: device_name-colour-otherprops.

I believe that this can be built on top of my patch.  If you take a look
at the led patch Pavel posted, it allows for in kernel code to acquire the
led by calling leds_acquire. Once a led is acquired through leds_acquire
function, any input from userspace is ignored.

Any interested kernel code can also register an interface to watch for led
additions and removals.

>
> Led triggers would be kernel sources of led on/off events. Some
> examples:
>
> 2Hz Heartbeat - useful for debugging (and/or Generic Timer)

This is included already in the leds driver part, although it could be
removed I guess...

> CPU Load indicator
> Charging indicator
> HDD activity (useful for microdrive on handheld)
> Network activity
> no doubt many more

All these are great ideas for triggers.

>
> led triggers would be connected to leds via sysfs. Each trigger would
> probably have a number you could echo into an led's trigger attribute.
> Sensible default mappings could be had by assigning a default trigger to
> a device by name in the platform code that declares the led.

This would be part of the triggers module... passing the right stuff into
those sysfs options would cause the triggers module to call leds_acquire
on the right led_properties structure.

>
> A trigger of "0" would mean the led becomes under userspace control via
> sysfs for whatever userspace wishes to do with it.

A trigger of "0" would call leds_release, which would cause the input from
userspace in the leds driver to be accepted again.

>
> The underlying principle would be to keep this class as simple as
> possible whilst maximising the options open for triggering the leds from
> both the kernel and userspace.
>
> Does this sound like a sensible way forward?
>

I think it can already be done from my patch... all the functions are
already there for in kernel manipulation.

John

