Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937609AbWLFUSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937609AbWLFUSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937611AbWLFUSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:18:16 -0500
Received: from hu-out-0506.google.com ([72.14.214.235]:43657 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937609AbWLFUSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:18:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J/EvTSqJqg0wlNegaRJp57Jw7Lma6vo5nYk8d3JlZRF1rXpX4QL5640txdviGVSEOXz2DdlDcRI3reBsBqNrcP3wFkIzMWysIfl5kgAZjJDbiz80rkLNWODu4U87bwcEKdI//LiEKzzfbZPgc3K3h5skOk/+XvLDnP4qwrUvJ+A=
Message-ID: <d120d5000612061218x4eac87e0jc18409f82bb7c99c@mail.gmail.com>
Date: Wed, 6 Dec 2006 15:18:12 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Ivo van Doorn" <ivdoorn@gmail.com>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "John Linville" <linville@tuxdriver.com>, "Jiri Benc" <jbenc@suse.cz>,
       "Lennart Poettering" <lennart@poettering.net>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Larry Finger" <Larry.Finger@lwfinger.net>
In-Reply-To: <200612062031.57148.IvDoorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612031936.34343.IvDoorn@gmail.com>
	 <200612050027.15253.IvDoorn@gmail.com>
	 <d120d5000612060637s69ff235fo85a2db923a728a00@mail.gmail.com>
	 <200612062031.57148.IvDoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, Ivo van Doorn <ivdoorn@gmail.com> wrote:
> On Wednesday 06 December 2006 15:37, Dmitry Torokhov wrote:
> > On 12/4/06, Ivo van Doorn <ivdoorn@gmail.com> wrote:
> > > > I am still not sure that tight coupling of input device with rfkill
> > > > structure is such a good idea. Quite often the button is separated
> > > > from the device itself and radio control is done via BIOS SMM (see
> > > > wistron driver) or there is no special button at all and users might
> > > > want to assign one of their standard keyboard buttons to be an RF
> > > > switch.
> > >
> > > Making sure rfkill supports keys that are not handled by the driver
> > > is a bit hard. Just as drivers that can only check if the button is
> > > toggled and not what the current state is.
> > > The problem is that it is hard to make a clean split between the
> > > 2 different button controls. Not all drivers allow the radio to be
> > > enabled while the button status are indicating the radio should
> > > be off.
> >
> > If they do not allow controlling the state of the radio
> > programmatically then it should not be part of rfkill I am afraid. It
> > is like the power switch - if you hold it for so long it kills the
> > power to the box and there is nothing you can do about it.
>
> Ok, this will give rfkill more possibilities as I could in that case
> also allow the user to toggle the radio to the state that is different
> than indicated by the key.
> Currently this was not possible since I had to keep in mind that there
> were keys that would directly control the radio.
>
> > > The buttons that are already integrated into the keyboard,
> > > by example by using a Fn key combo don't control the device
> > > directly. So the driver cannot offer anything to the rfkill driver.
> > > Such buttons should be mapped in userspace without the help of rfkill,
> > > since the kernel cannot detect if that key belonged to a radio
> > > control key or not.
> > >
> >
> > That is my point. Given the fact that there are keys that are not
> > directly connected with the radio switch userspace will have to handle
> > them (wait for events then turn off radios somehow). You are
> > advocating that userspace should also implement 2nd method for buttons
> > that belong to rfkill interface. I do not understand the need for 2nd
> > interface. If you separate radio switch from button code then
> > userspace only need to implement 1st interface and be done with it.
> > You will have set of cards that provide interface to enable/disable
> > their transmitters and set of buttons that signal userspace desired
> > state change. If both switch and button is implemented by the same
> > driver then the driver can implement automatic button handling.
> > Otherwise userspace help is necessary.
>
> Well there are 3 possible hardware key approaches:
>
>  1 - Hardware key that controls the hardware radio, and does not report anything to userspace

Can't do anything here so just ignore it.

>  2 - Hardware key that does not control the hardware radio and does not report anything to userspace

Kind of uninteresting button ;)

>  3 - Hardware key that does not control the hardware radio and reports the key to userspace
>
> So rfkill should not be used in the case of (1) and (3), but we still need something to support (2)
> or should the keys not be handled by userspace and always by the driver?
> This is making rfkill moving slowly away from the generic approach for all rfkill keys as the initial
> intention was.
>

I my "vision" rfkill would represent userspace namageable radio
switch. We have the followng possible configurations:

1. A device that does not allow controlling its transmitter from
userspace. The driver should not use/register with rfkill subsystem as
userspace can't do anyhting with it. If device has a button killing
the transmitter the driver can still signal userspace appropriate
event (KEY_WIFI, KEY_BLUETOOTH, etc) if it can detect that button was
presssed so userspace can monitor state of the transmitter and
probably shut down other transmitters to keep everything in sync.

2. A device that does allow controlling its transmitter. The driver
may (should) register with rfkill subsystem. Additionally, if there is
a button, the driver should register it with input subsystem. Driver
should manage transmitter state in response to button presses unless
userspace takes over the process.

3. A device without transmitter but with a button - just register with
input core. Userspace will have to manage state of other devices with
transmitters in response to button presses.

Does this make sense?

> > > > attribute should be a tri-state on/off/auto, "auto" meaning the driver
> > > > itself manages radio state. This would avoid another tacky IMHO point
> > > > that in your implementation mere opening of an input device takes over
> > > > RF driver. Explicit control allow applications "snoop" RF state
> > > > without disturbing it.
> > >
> > > Currently userspace can always check the state of the button whenever
> > > they like by checking the sysfs entry.
> > >
> >
> > Unless the key is not directly connected to the driver (so there is no
> > sysfs entry). Again you force 2 different interfaces.
>
> Ok, so input device opening should not block the rfkill signal and the rfkill handler
> should still go through with its work unless a different config option indicates that
> userspace wants to handle the event.
>

I don't think a config option is a good idea unless by config option
you mean a sysfs attribute.

-- 
Dmitry
