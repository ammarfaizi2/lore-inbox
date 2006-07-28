Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161283AbWG1UYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161283AbWG1UYL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161281AbWG1UYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:24:11 -0400
Received: from styx.suse.cz ([82.119.242.94]:20895 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1161279AbWG1UYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:24:09 -0400
Date: Fri, 28 Jul 2006 22:23:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060728202359.GB5313@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 06:14:57PM +0300, Shem Multinymous wrote:

> >The load isn't the problem. The incurred latencies - both interrupt and
> >scheduling - are. Audio playback skips, mice losing sync, keyboards
> >losing keystrokes, these are the nasty effects I've seen so far.
> 
> ACK. But I still don't what difference it makes, in this respect, if
> apps poll the kernel which queries the hardware (maybe with caching)
> vs. kernel queries the kernel and informs apps.

Not that much. The difference then remains only on a tickless system.

> >The Analog Devices ADXL2xx sensors in the HDAPS are not implementing
> >I2C, only having analog and PWM outputs. I doubt they're connected over
> >I2C to the EC.
> 
> The ADXL320 accelerometer is sampled by the H8S/2161B embedded
> controller, and the host polls the controller over LPC.

No I2C. LPC is so much faster than I2C (8 MHz 8-bit vs 100 kHz serial).

> >The timer interrupt still has to happen every time their select() or
> >sleep() expires, with the system having to wake up, even when nothing
> >happened.
> 
> Yes, it becomes an issue with tickless. Tell them now to poll more
> often then they need, then...
> 
> Here's the thing. An event mechanism makes sense when discrete events
> happen at irregular interval determined by the data source. But here,
> you're trying to convert a (pontentially) continuous function like
> voltage to a sporadic stream of "the value changed a lot" events. So
> you need to "fuzz" the stream like in the input layer, but you have no
> idea what the applications need. One client may try to monitor power
> fluctuations with 10Hz updates, while another may log once per minute.


> The exception is "status goes critical"-type events. For sysfs, the
> attribute change uevent (mentioned by Greg KH) looks like a perfect
> solution for these.
> 
> 
> >NOTE: I'm arguing event-based vs poll-based here. This is orthogonal to
> >the /dev vs /sys - both can supply or not supply events.
> 
> >        fd = open("/dev/bat0", O_RDONLY);
> >        ioctl(fd, BATCGVOLTAGE, &voltage);
> 
> So you *are* proposing polling fo rthe /dev interface too? I thought
> the main argument for the /dev

I'm not proposing polling. I'm proposing that there be a way how to read
the immediate values, in addition to the event notifications. 

Yes, this means polling would be possible.

Reading immediate values is a must, if only to know the values at the
start of your monitoring applet.

> OK, I agree the issues are orthogonal (once sysfs attr change uevents
> are added, anyway). My take:
> 1. We need polling. We
> 
> >for the sysfs implementation (for comparison), you'll need (at minimum):
> >
> >        fd = open("/dev/bat0", O_RDONLY);
> >        read(fd, buf, MAX_LEN);
> >        voltage = strtol(buf, buf + MAX_LEN, 10);
> 
> No, you can use fscanf.

Correct.

> >If you want a shell script, you'd use a small utility supplied with the
> >reference implementation:
> >
> >        batstate -t voltage /dev/bat0
> >
> >And it'd of course give you the same output as the 'cat' line.
> 
> And then we have to maintain both a kernel side and a userspace side.
> And what do I, poor author of tp_smapi, do if I want to add a
> non-standard attribute? Tell people to patch and overwrite their
> disto's batstate binary too?

How often do you plan to do that? Anyway, the answer is yes, it's not a
big deal to do.

> >The current well known methods are:
> >
> >        1) udev/hotplug. It can create device nodes and symlinks based on 
> >        the
> >                capabilities and IDs of an input device.
> >        1a) HAL. It has all the info from hotplug as well.
> >        2) open them all and do the capability checks / IDs yourself.
> 
> Ooh, that's messy. I'll have to think about it.

As Dmitry pointed out, all the info (except for the events) is in sysfs,
too.

> Meanwhile, here's another issue with the accelerometer input device
> (and by analogy, with batteries): client-specific event rate and fuzz.
> Neverball only needs "a big change has happened" events, maybe 10-20
> times per second. The disk parking daemon needs a perfectly accurate
> readouts at 50Hz or better, plus it needs to know whenever a sample is
> taken (even if it didn't change since the previous sample). How can
> this be handled without multiple input devices?

You need at least 50 Hz for reasonable game control, too. I remember
that analog joysticks sampled at 10 Hz were unusable.

The input layer was designed for input devices that control applications
by actions of the user. The fuzz filtering was designed with that in
mind and is expected to be set once at boot either by an educated guess
of a kernel driver or by the system administrator. Because it's designed
for input devices, it has these properties:

	* It ignores minor noise
	* It slowly reacts to continuous drift of the values
	* It reacts immediately to large changes

This would be likely completely unsuitable for batteries and may be bad
for a drive parking daemon, too. If the daemon can't use it, it'll need
another interface. 

-- 
Vojtech Pavlik
Director SuSE Labs
