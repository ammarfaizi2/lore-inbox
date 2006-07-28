Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161349AbWG1WtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161349AbWG1WtJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 18:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbWG1WtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 18:49:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:11443 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161349AbWG1WtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 18:49:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HQk/pamx61lzqtlKcrFnVOy0qOwb1SUG5KxG+wv4SdY3XgXeTfYx2ypKgFIMONR5XlrXFw0gC4da7jB5c5XIakB6KVH23AkOe6xa94CHeyjfSgtrSzuq0F+ZxVMPTXt1Q+umWB6EcL7iTF/FM0ezQIg2SdbCka+dWUW5UCgoW7A=
Message-ID: <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
Date: Sat, 29 Jul 2006 01:48:34 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Generic battery interface
Cc: "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@suse.cz>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       "Henrique de Moraes Holschuh" <hmh@debian.org>
In-Reply-To: <20060728202359.GB5313@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	 <20060728202359.GB5313@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:

> Not that much. The difference then remains only on a tickless system.

And even then, only when apps use excessive poll rates (way above
1Hz), in which case the apps are broken; and broken apps can eat power
in ways much worse than msleep(10) on a tickless system.


> No I2C. LPC is so much faster than I2C (8 MHz 8-bit vs 100 kHz serial).

Ack.


> > >NOTE: I'm arguing event-based vs poll-based here. This is orthogonal to
> > >the /dev vs /sys - both can supply or not supply events.
> >
> > >        fd = open("/dev/bat0", O_RDONLY);
> > >        ioctl(fd, BATCGVOLTAGE, &voltage);
> >
> > So you *are* proposing polling fo rthe /dev interface too? I thought
> > the main argument for the /dev
>
> I'm not proposing polling. I'm proposing that there be a way how to read
> the immediate values, in addition to the event notifications.
>
> Yes, this means polling would be possible.

So your /dev proposal is equivalent, functionality-wise, to sysfs +
attribute change uevent, right? The only question is if we do it
through /dev+ioctls or /sysfs+fscanf.


> > And then we have to maintain both a kernel side and a userspace side.
> > And what do I, poor author of tp_smapi, do if I want to add a
> > non-standard attribute? Tell people to patch and overwrite their
> > disto's batstate binary too?
>
> How often do you plan to do that?

With tp_smapi, I did it about 10 times over half a year. And there's
probably more to come.


> Anyway, the answer is yes, it's not a big deal to do.

Practically, it's much messier. As a developer/tester you have two
components to juggle instead of one, and it's a mess when they get out
of sync.


> As Dmitry pointed out, all the info (except for the events) is in sysfs,
> too.

And as I pointed out in reply, matching up devices in /sys and /dev is
extremely cumbersome (and prone to race conditions).


> > Meanwhile, here's another issue with the accelerometer input device
> > (and by analogy, with batteries): client-specific event rate and fuzz.
> > Neverball only needs "a big change has happened" events, maybe 10-20
> > times per second. The disk parking daemon needs a perfectly accurate
> > readouts at 50Hz or better, plus it needs to know whenever a sample is
> > taken (even if it didn't change since the previous sample). How can
> > this be handled without multiple input devices?
>
> You need at least 50 Hz for reasonable game control, too. I remember
> that analog joysticks sampled at 10 Hz were unusable.

If you rattle your ThinkPad this badly, latency in Neverball is going
to be the least of your problems. :-)

The mainline hdaps driver does 20Hz, BTW.


> The input layer was designed for input devices that control applications
> by actions of the user. The fuzz filtering was designed with that in
> mind and is expected to be set once at boot either by an educated guess
> of a kernel driver or by the system administrator. Because it's designed
> for input devices, it has these properties:
>
>         * It ignores minor noise
>         * It slowly reacts to continuous drift of the values
>         * It reacts immediately to large changes
>
> This would be likely completely unsuitable for batteries and may be bad
> for a drive parking daemon, too. If the daemon can't use it, it'll need
> another interface.

There's a pattern here. Maybe what we need is a generic scheme for
publishing continuous readouts, that will work for both hdaps and
batteries (despite a X100 difference in typical time magnitudes).
Doubtless there are other uses for such a scheme. We want it to
support clients with different desired rates, data sources with
different update frequencies, use minimum CPU and avoid unnecesary
timer interrupts on tickless kernels.

Here's one approach: use a syscall (e.g., ioctl) saying "block until
there's new data on this fd, or N milliseconds have passed, whichever
is *later*". This way each client declares the update rate it wants
and can change it on the fly. The driver sees all the requests and can
perform the minimum hardware quering -- for example, it won't query
the hardware at all if no client has submitted a request with
parameter N more than N milliseconds go. And there's no excessive work
or interrupts. Some (simple) kernel code infrastructure is needed to
help drivers manage the pending requests.

Extending this approach, we can have a call for "block until the
readout has changed by M, or N milliseconds have passed, whichever is
later". This may not reduce query rate for polling-based hardware, but
will reduce the event rate.

I suppose these calls should also have a (normal) timeout, for the
usual reasons.

  Shem
