Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWG1HmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWG1HmR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 03:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWG1HmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 03:42:16 -0400
Received: from styx.suse.cz ([82.119.242.94]:16351 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1030207AbWG1HmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 03:42:15 -0400
Date: Fri, 28 Jul 2006 09:42:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060728074202.GA4757@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 03:27:00AM +0300, Shem Multinymous wrote:

> >You're joking, right? On quite a number of laptops, it takes quite a
> >while to read the battery, spent in BIOS through SMI, polling the I2C
> >bus while talking to the battery. The less often this is done, the
> >better.
> 
> Yes, I know -- tp_smapi does that too. And it's still negligible,
> usually a few microseconds.

The load isn't the problem. The incurred latencies - both interrupt and
scheduling - are. Audio playback skips, mice losing sync, keyboards
losing keystrokes, these are the nasty effects I've seen so far.

> Heck, the hdaps driver polls that same I2C bus 50 times per seconds
> and still doesn't tickle the load average.

The Analog Devices ADXL2xx sensors in the HDAPS are not implementing
I2C, only having analog and PWM outputs. I doubt they're connected over
I2C to the EC.

> >The applets that were doing it (yes, up to 100 times per second)
> >corrected their ways pretty quickly, because some machines became
> >unusable with the applet enabled.
> 
> Exactly -- and they've been working merrily ever since.
> And if you don't want to trust applet developers, cache the latest
> reads and refresh them only if X jiffies have passed.

The timer interrupt still has to happen every time their select() or
sleep() expires, with the system having to wake up, even when nothing
happened. Polling from userspace is bad.

> >You could, trivially, mirror the behavior of current applets: Not report
> >the changes to the battery status more often than each N seconds, except
> >for critical events.
> 
> You're taking a polling-based hardware, exposing it as an event-based
> interface, and then and kludging it so that it behaves like polling
> again...

Every (I2C, direct ADC and more) sensor is polling-based by nature. The
eventization can happen in the EC, the BIOS, or later in the chain -
kernel or userspace. The earlier you stop it, the better for your power
consumption.

On event-based interface, the program using it doesn't have to use
events (it still can read the immediate values explicitly), on a
polling-based interface nobody can use events.

The event-based interface can even signal a certain device will not
supply any events and needs to be polled. This would the interface to
match the hardware better at the expense of making it more complex.

> So, in this scheme, how many lines of code does is the equivalent of
> "cat /sys/devices/platform/smapi/BAT0/voltage"?

NOTE: I'm arguing event-based vs poll-based here. This is orthogonal to
the /dev vs /sys - both can supply or not supply events.

It's two lines in C, if you omit error checking.

	fd = open("/dev/bat0", O_RDONLY);
	ioctl(fd, BATCGVOLTAGE, &voltage);

for the sysfs implementation (for comparison), you'll need (at minimum):

	fd = open("/dev/bat0", O_RDONLY);
	read(fd, buf, MAX_LEN);
	voltage = strtol(buf, buf + MAX_LEN, 10);

If you want a shell script, you'd use a small utility supplied with the
reference implementation:

	batstate -t voltage /dev/bat0

And it'd of course give you the same output as the 'cat' line.

> >> And you'll need to identify devices in a useful way, a problem that's
> >> not yet solved even for input devices... You see where it's going.
> >
> >May you be more specific here? I'm not aware of any problems in this
> >area. This may be my fault: What needs to be fixed there?
> 
> "Generic interface for accelerometers (AMS, HDAPS, ...)" on LKML, a
> few weeks ago, about moving accelerator-based hard disk parking from
> sysfs polling to the the input infrastructure. One unresolved issue
> was how to find which input device happens to be the relevant
> accelerometer.

The current well known methods are:

	1) udev/hotplug. It can create device nodes and symlinks based on the
		capabilities and IDs of an input device.
	1a) HAL. It has all the info from hotplug as well.
	2) open them all and do the capability checks / IDs yourself.
	3) (obsolete, deprecated) parse /proc/bus/input/devices, which
		lists all the input devices

Any problems with that?

-- 
Vojtech Pavlik
Director SuSE Labs
