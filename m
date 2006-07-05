Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWGEHfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWGEHfU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 03:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWGEHfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 03:35:20 -0400
Received: from styx.suse.cz ([82.119.242.94]:20120 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932234AbWGEHfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 03:35:20 -0400
Date: Wed, 5 Jul 2006 09:34:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Henrique de Moraes Holschuh <hmh@debian.org>, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net,
       Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060705073455.GA6027@suse.cz>
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <20060704162346.GE9447@khazad-dum.debian.net> <20060704235717.GD11872@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704235717.GD11872@elf.ucw.cz>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 01:57:17AM +0200, Pavel Machek wrote:

> > Anyway, the input infrastructure is good to emulate a mouse/joystick, but we
> > probably want to support the following generic data channels:
> > 
> > 1. Absolute acceleration output stream (either in hardware units, or
> >    normalized to G or mG if at all possible) for X, Y, Z.  Does the input
> >    infrastructure work well for reporting absolute numbers in a reasonably
> >    constant rate?
> >    
> >    This is what HD head unload policy daemons want to know, and the stream
> >    usually needs to offer datapoints somewhere between 20Hz and 100Hz
> >    without excessive jitter to be useful for more advanced filtering (like
> >    masking-off periodic movement such as the one caused by train tracks).

Yes, this is what the input subsystem normally works with - 32-bit
absolute (and relative) numbers at rates around 100 Hz. It's how the
data from joysticks (and mice) look like.

> > 2. As easy-to-use as possible joystick and mouse emulation (for toys and 
> >    gaming), which probably means auto-calibrating ones when possible
> >    and thus making them unsuitable channels for (1) above.
> 
> Well, I'd just provide 1. Providing 2 seems like task for some
> userspace filtering library.

Assuming you use the ABS_X, ABS_Y, and ABS_Z for the acceleration (which
is not necessarily ideal), you'll get a joystick emulation automagically
through the input subsystem without any additional coding.

> > 3. Control of accelerometer parameters:
> >    3a. Report of accelerometer type (hdaps, ams, etc) and other metadata
> >        (name, location, what it is measuring (system accel, hd-bay 
> >        accel...))
> 
> Well, if your system is accelerating at different speed than hd-bay,
> then your machine is either _way_ too big, or you are in bad trouble.
> 
> Ask Dmitry or vojtech, I believe input can provide such metadata. (I
> left most of the quoted text so that vojtech can reply easily).

It currently doesn't. It reports the device ID as a couple of 16-bit
integers, and how the input subsystem sees it. There is currently no way
to get at device-specific data, although this could be reasonably easily
done through sysfs I believe.

> >    3b. Accelerometer polling frequency

Module parameter, changeable via sysfs?

> >    3c. Enable/disable joystick and mouse emulation control
> >    etc.
> > 
> > And, of course, userspace must be able to easily find the accelerometer
> > outputs and diferentiate them from other joystick/mouse interfaces.  This is
> > a task for udev, I suppose.

Yup.

> > It is also very helpful to be able to know when something is using any of
> > the accelerometer output channels, so as to shut it down (or stop talking to
> > it) when it is uneeded. 

This is done automatically by the input subsystem. When the last user
close()s any of the related devices, the driver gets notified that it
can stop the hardware.

> > I don't know about AMS, but talking to HDAPS when
> > you don't need to does waste enough system resources and power to actually
> > justify implementing this.

I'd doubt any of the accelerometer implementations would consume much
power or CPU.

> > If we cannot detect automatically when userspace is paying attention to the
> > accelerometer through the input layer, then that means we will need the
> > enable/disable functionality already provided by the device model through
> > sysfs.
> > 
> > > Only piece of puzzle missing is marking that input device as "this
> > > accelerometer actually watches the whole device".
> > 
> > Well, it is very important to be able to easily find all data and channels
> > pertaining for a given accelerometer, and the accelerometer metadata should
> > indeed give userspace an idea of WHAT it is measuring the acceleration of

-- 
Vojtech Pavlik
Director SuSE Labs
