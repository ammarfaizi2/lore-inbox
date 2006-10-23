Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752039AbWJWWPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbWJWWPk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 18:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbWJWWPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 18:15:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752039AbWJWWPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 18:15:39 -0400
Subject: Re: Battery class driver.
From: David Zeuthen <davidz@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, olpc-dev@laptop.org, greg@kroah.com,
       mjg59@srcf.ucam.org, len.brown@intel.com, sfr@canb.auug.org.au,
       benh@kernel.crashing.org
In-Reply-To: <1161627633.19446.387.camel@pmac.infradead.org>
References: <1161627633.19446.387.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 18:15:03 -0400
Message-Id: <1161641703.2597.115.camel@zelda.fubar.dk>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Mon, 2006-10-23 at 19:20 +0100, David Woodhouse wrote:
> The idea is that all batteries should be presented to userspace through
> this class instead of through the existing mess of PMU/APM/ACPI and even
> APM _emulation_.

Yea, that would be nice, we've got code in HAL to handle all these three
(and more) and provide one coherent interface. The battery class
abstraction should probably be flexible enough to handle things such as

 - UPS's
 - Bluetooth devices with batteries
 - USB wireless mice / keyboards
 - ... and so on.

if someone wants to write a kernel-space driver for these some day. We
handle the latter in HAL using some user space code and to me it's still
an open question (and not really a very interesting one) whether you
want the code kernel- or user-side.

As an aside, you probably want some kind of device symlink for the
"battery class" instance in sysfs such that it points to the "physical"
device. For ACPI/PMU/APM etc. I guess it points to somewhere
in /sys/devices/platform; for a Bluetooth device it might point to the
Bluetooth device in sysfs (cf. Marcel's patch to do this) and so on.
Otherwise it's hard for user space to figure out what the battery is
used for. Perhaps the driver itself can contribute with some kind of
sysfs file 'usage' that can assume values "laptop_battery", "ups" etc.,
dunno if that's a good idea.

I think that it requires some degree of documentation for the files you
export including docs on the ranges. Probably worth sticking to *some*
convention such as if you can't provide a given value then the file
simply isn't there instead of just providing some magic value like
charge=0 if you don't know the charge. That probably means you need some
kind of 'sentinel' for each value that will make the generic battery
class code omit presenting the file. 

(I'm not sure whether there are any general sysfs guidelines on this so
forgive me if there is already.)

Please also avoid putting more than on value in a single file, e.g. I
think we want to avoid e.g. this

 # cat /sys/class/battery/OLPC/state
 present,low,charging

and rather have is_present, is_charging, is_discharging and so on; i.e.
one value per file even if we're talking about flags. It's just less
messy this way.

> I think I probably want to make AC power a separate 'device' too, rather
> than an attribute of any given battery. And when there are multiple
> power supplies, there should be multiple such devices. So maybe it
> should be a 'power supply' class, not a battery class at all?

So I happen to think they are different beasts. Some batteries may not
be rechargable by the host / device (think USB wireless mice with normal
AAA batteries) and some power supply units may not have a battery (think
big iron with multiple PSU's). I think, in general, they have different
characteristics (they share some though) so perhaps it would be good to
have different abstractions? I'm not a domain expert here though.

How do we plan to get updates to user space? The ACPI code today
provides updates via the ACPI socket but that is broken on some hardware
so essentially HAL polls by reading /proc/acpi/battery/BAT0/state some
every 30 secs on, and, on some boxen, that generates a SMBIOS trap or
some other expensive operation. That's wrong.

So I think the generic battery class code should cache everything which
has the nice side effect that any stupid user space app doesn't bring
the system to it's knees just because it's re-reading the same file over
and over again. 

So, perhaps the battery class should provide a file called 'timestamp'
or something that is only writable by the super user. If you read from
that file it gives the time when the information was last updated. If
you write to the file it will force the driver query the hardware and
update the other files. Reading any other file than 'timestamp' will
just read cached information. 

The mechanism to notify user space that something have been updated
would be either to make the timestamp file pollable or use an uevent or
something else (no input drivers please). 

If the hardware is able to generate an interrupt when certain data on
the battery has changed the driver simply updates the timestamp file.

With this scheme, user space simply does this

 10 poll on /sys/class/battery/BAT0/timestamp with timeout=30sec
 20 if timeout, write to 'timestamp' file to force polling
 30 read values from sysfs and update graphics for battery icon etc.
 40 goto 10

and we only poll when the hardware don't provide such interrupts /
hardware is broken so it don't provide interrupts.

Specifically, user space can decide to make the timeout infinite or
decide not to poll under certain conditions etc. etc.

How about that?

     David


