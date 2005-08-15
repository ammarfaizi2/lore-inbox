Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVHOTju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVHOTju (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 15:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVHOTjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 15:39:49 -0400
Received: from loihi.boulder.swri.edu ([65.241.78.2]:7386 "EHLO
	perseus.boulder.swri.edu") by vger.kernel.org with ESMTP
	id S964910AbVHOTjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 15:39:49 -0400
Message-ID: <4300EF7C.9020500@skyrush.com>
Date: Mon, 15 Aug 2005 13:39:40 -0600
From: Joe Peterson <joe@skyrush.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to drivers/input/evdev.c to add mixer device "/dev/input/events"
References: <4300D09C.4030702@skyrush.com> <20050815174558.GB1450@ucw.cz> <4300D845.8070605@skyrush.com> <20050815185729.GA1450@ucw.cz>
In-Reply-To: <20050815185729.GA1450@ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
>>>>I am using evtouch, but I had read that X itself has an issue with
>>>>devices that are not "always there" and that X does not [yet] seem to be
>>>>designed to handle hotplugging well (for example, device names need to
>>>>be hard-coded in xorg.conf, so a changing device name on plugging will
>>>>not work).
>
>>
>>
>> You just need to list all the possible names, as far as I know, which
>> isn't too bad. And udev takes care of it anyway.


One problem is that with a touch-screen closed (physically, as in a car
in-dash model), the USB interface is off, so when Linux boots, it will
not see the device, since it does not exist yet.  X actually will hang
if you give it a device that is not there when X starts - pretty ugly.

In a car environment (just as an example) you often want to start up
with the screen closed, but when you pop open the screen, you want the
system to be waiting for your input.  Now, in the present situation with
devices, the system will be hung, and even if it were not, X would not
see the device appear, since it does not like to see devices go away and
come back.


>>>>Perhaps this could be fixed, but it might be a lot more
>>>>involved.  Why was /dev/input/mice created?
>
>>
>>
>> To make 2.6 work with existing applications. It's scheduled to be
>> removed. I definitely don't want to add more workarounds for X
>> limitations to the kernel - that only defers fixing X.


Yes, I agree that X should behave better, and you should not need hacks
to work around these issues.

There is another issue though: if you look at any web site about touch
screens or tablets, they will tell you to see what event device shows up
for the device, and put that in xorg.conf.  This involves looking at
/proc/bus/input/devices by hand (could be different for each system and
order of things that happen during boot) and locating the device by
vendor name, etc.  This works and is predictable only if devices are
never plugged or unplugged.

Udev has the great feature of letting one define the name or symlink for
a particular device, but this does not solve the problem with X, which
will never see the device again if it detaches and re-attaches.

I think that, for input devices, there is a fundamental issue, in that
unpredictable device names and intermittent devices are hard to deal
with for programs looking for them, and udev is not the easiest to
configure to fix the naming issue, unless you know what you are doing.
Programs should be able to operate even without an input device
connected (it would just not see events).  Perhaps this means fixed
pseudo-devices that represent the different kinds of input devices
possible or configured and are always present (and just start talking
once a device hooks up)...  I could imagine a config file that lets a
user list devices they want on the system all the time, as well as info
about how the system would identify the real hardware.  I know udev does
this partially, but it does not make the device itself persistent - only
the name.


>>>>It does correct the issue of unplugging and plugging mice (as well as
>>>>its obvious feature of allowing multiple mice, of course)?  It keeps X
>>>>happy by shielding it from the plugging/unplugging.
>
>>
>>
>> Yes. But X really needs to start caring about hotplug. I've heard that
>> latest builds are moving into that direction (though I didn't try myself
>> yet).


I agree...  And there maybe be situations in which a user program or X
should be able to get notified of disconnects and reconnects and do the
right thing.  But maybe a pseudo-device layer that presents a
predictable interface to X would prevent X from having to deal with this
- maybe user programs (including X) should not have to deal with
disconnect and connect events with regard to hotplugging.  I can see all
sorts of bugs involving this mechanism.  Centralizing the hotplug issue
might be more stable (it already exists as the hotplug and udev
systems).  If there were simply a way to flag a device as "always should
exist and stay there," the problem could be solved this way.  My hack
basically does this for my case.


>>>>If the mixing of event devices is problematic, what about simply the
>>>>idea of a persistent event device that always "exists" to the user of
>>>>the events but will reattach if the HW is plugged/unplugged (the device
>>>>name assigned could be made constant using a udev symlink)?  This could
>>>>solve the problem without mixing all events.  In my case, I have one
>>>>touch screen only (as most people would), so the mixing works in my
>>>>case, of course.
>
>>
>>
>> The event device always exists until it's closed. It'll return -ENODEV on
>> any operation, but is discarded only after the last application closes
>> it.


It looked to me like the event dev file disappeared from the /dev/input
dir once the USB turned off.  Are you saying that if it is then
re-plugged, it should come back as the same name if the program did not
close it?  I saw it coming back as, e.g., "event2" after being "event1".
This is all with X running.  The X driver ("evtouch") also got a
disconnect event, but it never seemed to get the subsequent connect -
not sure what was at fault).


>> What exact change of behavior do you need? If you want the kernel to
>> match the newly plugged-in device to the existing, open, unattached,
>> evdev node, well, that's near impossible to do solely in the kernel.


The big problem that I ran into (and there a bunch of other touchscreen
users frustrated by this) is that I needed X to accept the device name I
gave it even if the device was not present at boot.  Also, even if the
device unplugs and replugs, the device X attached to needed to stay
there the whole time so X and/or its drivers didn't give up on it and
never listen or attach again.  That's why I created /dev/input/events,
which is there at boot and always there (like /dev/input/mice).  The
event layer takes care of attaching the real device to this mixer, and X
never knows anything was happening with plugging/unplugging.

So, overall, I agree that we should not invent hacks to make up for
another software package's problems, but perhaps input devices,
especially ones that sometimes are not there at boot or not there all
the time, should be treated in a way that lets programs stay ignorant of
the intermittent nature of the devices.  It does not sound right to push
the handling of the intermittent nature to each user program.  If the
kernel could handle that aspect, it would make all programs more stable.
And most of those "plug and unplug" events, even if handled by X or
other programs, would really be unnecessary in most cases.  In the case
of a touchscreen, there is no need for X to know it switched off and
back on again - it just needs to keep listening for touch events.  For X
to be "hotplug aware" in this sense only adds complication, I would
think.  At least if there were a mode in the device/hotplug/udev stuff
to make a "permanent" device (from boot, and always), you could spare
the program all of that.

Interesting discussion!
						-Joe
