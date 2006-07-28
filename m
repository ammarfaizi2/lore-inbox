Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752012AbWG1PPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbWG1PPH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWG1PPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:15:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:64739 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752012AbWG1PPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:15:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eTyiP9/0CRlA1LIaXH6t+OKeXPI1yghYi46IBNc1vxjuNXTzQGGGwMuNZbjSmRe5oDMTQ33ldUQ5K9blYIAKifdmqI6oCNYtbQFgK/POcMQFqBhwx5z5sxZEb5oXCXcD/Y0E6Fi9wMlimt+UOTaoEvFGHxPf0qmTxxwQegs5cV8=
Message-ID: <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
Date: Fri, 28 Jul 2006 18:14:57 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Generic battery interface
Cc: "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@suse.cz>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060728074202.GA4757@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Jul 28, 2006 at 03:27:00AM +0300, Shem Multinymous wrote:

> > Yes, I know -- tp_smapi does that too. And it's still negligible,
> > usually a few microseconds.
>
> The load isn't the problem. The incurred latencies - both interrupt and
> scheduling - are. Audio playback skips, mice losing sync, keyboards
> losing keystrokes, these are the nasty effects I've seen so far.

ACK. But I still don't what difference it makes, in this respect, if
apps poll the kernel which queries the hardware (maybe with caching)
vs. kernel queries the kernel and informs apps.


> The Analog Devices ADXL2xx sensors in the HDAPS are not implementing
> I2C, only having analog and PWM outputs. I doubt they're connected over
> I2C to the EC.

The ADXL320 accelerometer is sampled by the H8S/2161B embedded
controller, and the host polls the controller over LPC.


> > Exactly -- and they've been working merrily ever since.
> > And if you don't want to trust applet developers, cache the latest
> > reads and refresh them only if X jiffies have passed.
>
> The timer interrupt still has to happen every time their select() or
> sleep() expires, with the system having to wake up, even when nothing
> happened.

Yes, it becomes an issue with tickless. Tell them now to poll more
often then they need, then...

Here's the thing. An event mechanism makes sense when discrete events
happen at irregular interval determined by the data source. But here,
you're trying to convert a (pontentially) continuous function like
voltage to a sporadic stream of "the value changed a lot" events. So
you need to "fuzz" the stream like in the input layer, but you have no
idea what the applications need. One client may try to monitor power
fluctuations with 10Hz updates, while another may log once per minute.

The exception is "status goes critical"-type events. For sysfs, the
attribute change uevent (mentioned by Greg KH) looks like a perfect
solution for these.


> NOTE: I'm arguing event-based vs poll-based here. This is orthogonal to
> the /dev vs /sys - both can supply or not supply events.

>         fd = open("/dev/bat0", O_RDONLY);
>         ioctl(fd, BATCGVOLTAGE, &voltage);

So you *are* proposing polling fo rthe /dev interface too? I thought
the main argument for the /dev

OK, I agree the issues are orthogonal (once sysfs attr change uevents
are added, anyway). My take:
1. We need polling. We

> for the sysfs implementation (for comparison), you'll need (at minimum):
>
>         fd = open("/dev/bat0", O_RDONLY);
>         read(fd, buf, MAX_LEN);
>         voltage = strtol(buf, buf + MAX_LEN, 10);

No, you can use fscanf.


> If you want a shell script, you'd use a small utility supplied with the
> reference implementation:
>
>         batstate -t voltage /dev/bat0
>
> And it'd of course give you the same output as the 'cat' line.

And then we have to maintain both a kernel side and a userspace side.
And what do I, poor author of tp_smapi, do if I want to add a
non-standard attribute? Tell people to patch and overwrite their
disto's batstate binary too?


> The current well known methods are:
>
>         1) udev/hotplug. It can create device nodes and symlinks based on the
>                 capabilities and IDs of an input device.
>         1a) HAL. It has all the info from hotplug as well.
>         2) open them all and do the capability checks / IDs yourself.

Ooh, that's messy. I'll have to think about it.


Meanwhile, here's another issue with the accelerometer input device
(and by analogy, with batteries): client-specific event rate and fuzz.
Neverball only needs "a big change has happened" events, maybe 10-20
times per second. The disk parking daemon needs a perfectly accurate
readouts at 50Hz or better, plus it needs to know whenever a sample is
taken (even if it didn't change since the previous sample). How can
this be handled without multiple input devices?

  Shem
