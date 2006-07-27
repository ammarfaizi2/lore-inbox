Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWG0WQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWG0WQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 18:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWG0WQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 18:16:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45548 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751375AbWG0WQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 18:16:47 -0400
Date: Fri, 28 Jul 2006 00:16:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Brown, Len" <len.brown@intel.com>
Cc: Shem Multinymous <multinymous@gmail.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060727221632.GE3797@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >So I've proposed /sys/class/battery/{acpi,apm,thinkpad}/BAT?/* 
> >as a comrpromise:
> >A userspace app that only needs a generic voltage readout will try
> >(all of) /sys/class/battery/*/BAT0/voltage. This is your generic
> >interface.
> 
> If we have to export all these totally different implementations
> via totally different paths, then we failed.

Agreed.

> sysfs is great for demos from a shell prompt,
> but isn't such a great programming interface, either
> from inside the kernel or from user-space.

Well, we have prior examples for /dev/XXX style interface (input), and
we have examples for /sys/XXX interface (LED subsystem). Each has its
advantages and disadvantages, and both are okay for programming
AFAICT.

> Please do not add more polling to user-space, else DaveJ
> will be putting it up as a further example of "Why userspace sucks"
> at the next OLS:-)

Let me clarify this: zaurus-style systems can read battery status as
often as someone asks, and do not really have events. If someone asks,
they read the status. If noone asks, they do not have to read status
_at all_. Event interface suits PC world where BIOS already does the
polling...

Anyway, let's compare /dev/XXX vs. /sys/XXX

/sys/XXX:
+ existing code uses similar scheme
+ easy to add very obscure features, such as 
	do_not_charge_battery_for_X_minutes
+ perhaps it would not need explicit maintainer, just assign names 
	carefully
- lack of maintainer mean people will probably not assign names
	carefully
- does not suit PC-style batteries which trigger events when data
	change (can be fixed by /sys/XXX/anything-new, which gives one
	byte when something changes)
- you are not getting atomic snapshot of battery state. For example
	you could read battery status okay, voltage 9.5V; while real
	states were (okay, 10.5V), (critical, 9.5V) and update
	happened between you reading status and voltage. (Is it
	problem?)
+ userspace UPS daemons can just create files somewhere else, battery
	applets can scan two directories easily

/dev/XXX
+ battery layer will need to be invented
- that layer will need maintainer
+ maintainer ensures this is not a mess, allocates numbers
- does not quite suit zaurus-style batteries, that can _only_ be
	polled. Can be worked-around by polling from kernel (and we
	are often doing that, anyway)
+ userspace backdoor interface will need to be invented, /dev/uinput style
- hard to handle obscure features
	(do_not_charge_battery_for_X_minutes), and we'll probably want
	to unify batteries a bit, probably loosing precision.

So... I'm not sure which one I prefer. If I had to do one _myself_,
I'd do /sys/XXX version, because it requires less maintainance, and
I'm lazy.

If I could clone vojtech, I'd prefer just doing that, then letting him
do /dev/XXX interface. It will be more work and painful transition.

Anyone volunteers write battery layer? If so, I'd go with /dev/XXX,
otherwise I'd go with /sys/XXX, because it is simpler to code, and I
believe it is also good enough...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
