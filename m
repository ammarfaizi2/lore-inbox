Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbWHLVIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbWHLVIG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWHLVIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:08:06 -0400
Received: from mail1.cenara.com ([193.111.152.3]:45535 "EHLO
	kingpin.cenara.com") by vger.kernel.org with ESMTP id S932617AbWHLVIE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:08:04 -0400
From: Magnus =?iso-8859-15?q?Vigerl=F6f?= <wigge@bigfoot.com>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Re: input: evdev.c EVIOCGRAB semantics question
Date: Sat, 12 Aug 2006 23:06:58 +0200
User-Agent: KMail/1.9.1
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <200608121724.16119.wigge@bigfoot.com> <20060812165228.GA5255@aehallh.com>
In-Reply-To: <20060812165228.GA5255@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608122306.58228.wigge@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 August 2006 18:52, Zephaniah E. Hull wrote:
> On Sat, Aug 12, 2006 at 05:24:16PM +0200, Magnus Vigerlöf wrote:
> > Hi,
> >
> > What is the purpose of the EVIOCGRAB ioctl in evdev.c? Is it to prevent
> > the device driver from sending events to other event handlers? Is it to
> > prevent other applications from receiving events that has the device
> > handler open? First, last, or both?
>
> As things stand, both.

Ok, Wacom tablets needs the first one. But no harm appears to be done if the 
second one is skipped. What that means for other kinds of devices, I don't 
know.

> > I discovered the following behavior when I fired up a second X-server on
> > my machine with my Wacom tablet connected: The second X-server opened the
> > tablet as well and everything worked as it should. However when I
> > switched back to the first X-server the tablet didn't work at all. Only
> > when I stopped the second X-server did the tablet start working in the
> > first X-server again. If I changed the code in evdev to ignore the
> > EVIOCGRAB-ioctl the tablet works in both X-servers, but that caused other
> > problems.
>
> That is, unusual.  Unless each X server has it's own display, then when
> switching VCs away from an X server the driver should be turned off, and
> the device ungrabbed and possibly closed, at which point the other
> should be able to open and grab the device.
>
> The wacom X driver may not be handling that properly though, annoying.

Well, with only one X-server running I'd say it looks all right, but when I 
start two things starts to get strange. Don't know what happends really. But 
that was how I saw this, and...

> > Now, having two X-servers might not be the most common thing to have, but
> > having other applications that depends on the movement from the tablet
> > might be more common.

...this is a bigger problem when apps need the data directly from the 
event?-device and not from the XInput-device.

A mail was sent to the linuxwacom list where a guy tried to use mouseemu to 
emulate the scroll button of a mouse with the stylus and a keyboard 
qualifier. Nice idea and I would probably use if it works, however since the 
X-server grabs the device no event will ever be sent so this could work. 
Pity.

> > As is it now, it's useless (more or less) to run wacdump to display the
> > tablet specific events in a understandable manner. An application that
> > generates events through uinput based on tablet events and some other
> > qualifiers (mouseemu, simulating mouse scroll wheel) will not work
> > either.
>
> That one has been mentioned a few times, but rarely complained about
> loudly.
>
> When I drew up the first evdev grab patches I made a masking patch
> shortly later which helped divide things, however that never made it
> into code and that leaves us here.
>
> > And yes, the X-server must grab the tablet. Otherwise events will go
> > through /dev/input/mice as well and mess up applications that depend on
> > the tablet-specific absolute events.
>
> This is close to the original reason for grabbing, specificly that there
> was no safe way to use evdev for the keyboard at all without it.

Does safe in this case mean 'noone will be able to see what I'm typing', or is 
the reason the same as for the Wacom tablets?

Hmm.. What I'm asking is; Would there be a problem if grabbing only means that 
only that evdev-device will receive the input events, but all applications 
that has this device open will receive event whether or not if they have 
grabbed the device.

> I can dust off the masking patch sometime here if Dmitry thinks that
> he'd be willing to see a second method for this in addition to grabbing,
> adding support to xf86-input-evdev would be trivial, and the same could
> probably be said for the wacom driver that does grabbing at the moment.

I wouldn't mind having a look on the patch. It would be nice to see other ways 
of how this little could be solved as I don't know what 'masking' in this 
case would mean. It's not a problem if I can't apply it to the latest 
source..

> Regards.
> Zephaniah E. Hull.
> (Original author of the evdev grab patch and xf86-input-evdev
> maintainer, among other things.)

Thanks
 Magnus
