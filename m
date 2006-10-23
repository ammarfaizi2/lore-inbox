Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWJWXA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWJWXA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 19:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWJWXA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 19:00:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:63930 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932300AbWJWXAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 19:00:55 -0400
Date: Mon, 23 Oct 2006 15:59:05 -0700
From: Greg KH <greg@kroah.com>
To: David Zeuthen <davidz@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       olpc-dev@laptop.org, mjg59@srcf.ucam.org, len.brown@intel.com,
       sfr@canb.auug.org.au, benh@kernel.crashing.org
Subject: Re: Battery class driver.
Message-ID: <20061023225905.GA10977@kroah.com>
References: <1161627633.19446.387.camel@pmac.infradead.org> <1161641703.2597.115.camel@zelda.fubar.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161641703.2597.115.camel@zelda.fubar.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 06:15:03PM -0400, David Zeuthen wrote:
> 
> Hi,
> 
> On Mon, 2006-10-23 at 19:20 +0100, David Woodhouse wrote:
> > The idea is that all batteries should be presented to userspace through
> > this class instead of through the existing mess of PMU/APM/ACPI and even
> > APM _emulation_.
> 
> Yea, that would be nice, we've got code in HAL to handle all these three
> (and more) and provide one coherent interface. The battery class
> abstraction should probably be flexible enough to handle things such as
> 
>  - UPS's
>  - Bluetooth devices with batteries
>  - USB wireless mice / keyboards
>  - ... and so on.
> 
> if someone wants to write a kernel-space driver for these some day. We
> handle the latter in HAL using some user space code and to me it's still
> an open question (and not really a very interesting one) whether you
> want the code kernel- or user-side.
> 
> As an aside, you probably want some kind of device symlink for the
> "battery class" instance in sysfs such that it points to the "physical"
> device. For ACPI/PMU/APM etc. I guess it points to somewhere
> in /sys/devices/platform; for a Bluetooth device it might point to the
> Bluetooth device in sysfs (cf. Marcel's patch to do this) and so on.
> Otherwise it's hard for user space to figure out what the battery is
> used for. Perhaps the driver itself can contribute with some kind of
> sysfs file 'usage' that can assume values "laptop_battery", "ups" etc.,
> dunno if that's a good idea.

By using a real device for the battery, you will get this for free,
along with a symlink back from the sysfs class if you so desire.  I know
HAL can handle this properly, as we are doing this in the next opensuse
release (10.2) for almost all class devices.

Actually, using the hwmon class is probably the best, as you are doing
much the same thing.  I don't think a new class is probably needed here.

> I think that it requires some degree of documentation for the files you
> export including docs on the ranges. Probably worth sticking to *some*
> convention such as if you can't provide a given value then the file
> simply isn't there instead of just providing some magic value like
> charge=0 if you don't know the charge. That probably means you need some
> kind of 'sentinel' for each value that will make the generic battery
> class code omit presenting the file. 

Documentation/hwmon/sysfs-interface is the proper format for documenting
this to start with.  Documentation/ABI is probably the best place for it
to end up in eventually.

> (I'm not sure whether there are any general sysfs guidelines on this so
> forgive me if there is already.)

Yes, see above :)

> Please also avoid putting more than on value in a single file, e.g. I
> think we want to avoid e.g. this
> 
>  # cat /sys/class/battery/OLPC/state
>  present,low,charging
> 
> and rather have is_present, is_charging, is_discharging and so on; i.e.
> one value per file even if we're talking about flags. It's just less
> messy this way.

Agreed.

> > I think I probably want to make AC power a separate 'device' too, rather
> > than an attribute of any given battery. And when there are multiple
> > power supplies, there should be multiple such devices. So maybe it
> > should be a 'power supply' class, not a battery class at all?
> 
> So I happen to think they are different beasts. Some batteries may not
> be rechargable by the host / device (think USB wireless mice with normal
> AAA batteries) and some power supply units may not have a battery (think
> big iron with multiple PSU's). I think, in general, they have different
> characteristics (they share some though) so perhaps it would be good to
> have different abstractions? I'm not a domain expert here though.
> 
> How do we plan to get updates to user space? The ACPI code today
> provides updates via the ACPI socket but that is broken on some hardware
> so essentially HAL polls by reading /proc/acpi/battery/BAT0/state some
> every 30 secs on, and, on some boxen, that generates a SMBIOS trap or
> some other expensive operation. That's wrong.
> 
> So I think the generic battery class code should cache everything which
> has the nice side effect that any stupid user space app doesn't bring
> the system to it's knees just because it's re-reading the same file over
> and over again. 
> 
> So, perhaps the battery class should provide a file called 'timestamp'
> or something that is only writable by the super user. If you read from
> that file it gives the time when the information was last updated. If
> you write to the file it will force the driver query the hardware and
> update the other files. Reading any other file than 'timestamp' will
> just read cached information. 

You can poll the sysfs file, which means you just sleep until something
changes in it and then you wake up and read it.  Sound accepatble?

thanks,

greg k-h
