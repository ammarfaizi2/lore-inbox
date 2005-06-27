Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVF0Xe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVF0Xe5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVF0Xbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:31:51 -0400
Received: from nome.ca ([65.61.200.81]:54675 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S262141AbVF0XZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:25:59 -0400
Date: Mon, 27 Jun 2005 16:26:00 -0700
From: Mike Bell <kernel@mikebell.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050627232559.GA7690@mikebell.org>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20050624081808.GA26174@kroah.com> <20050625234305.GA11282@kroah.com> <20050627071907.GA5433@mikebell.org> <200506271735.50565.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506271735.50565.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 05:35:50PM -0500, Dmitry Torokhov wrote:
> AFAIK there is no requirement in input subsystem that devices should be
> created under /dev/input. When devfs is activated they are created there
> by default, but that's it.

Things which accept a path to an event file as an argument will work
just fine. But anything which tries autodiscovery HAS to be able to find
the device nodes. Think directfb, most (but not all) of the X patches,
any user-space driver that wants to find the hardware it owns, etc.

This illustrates nicely my reasons for preferring devfs.

1) Predictable, canonical device names are a Good Thing.

2) If you accept that, exporting the device names from the kernel is the
most sensible way to do it.

For point one, how do you do autodiscovery otherwise? You can look at
sysfs or /proc/bus/input/devices to find out what input devices are on
the system, but if the device nodes can be named anything then how do
you find them? Grep over all of /dev and find the guy with the right
major/minor? Or create your own private device node using the dev sysfs
parameter? Or use some crazy interface to udev's configuration files to
find out what the hell it decided to name the node?

For point two, without doubting the need for a userspace utility to do
chown and symlinks to meaningful names, I cannot conceive of how anyone
could say "I need a device node named /dev/input/event0 with this
major/minor created and deleted according to in-kernel events. The best
way to do this is to export an empty ram-backed filesystem and mount it
on /dev from userspace, use a second kernel-generated filesystem to
export a file called /sys/class/input/event0/dev with the major and
minor in it, use a second kernel->userspace interface to send an event
to a userspace helper which will read that value, look up that it's
supposed to be named /dev/input/event0, and mknod the corresponding
device file". Not if the node is always going to be named
/dev/input/event0.

udev can do lots of amazing things, but ONE of the things it does,
creating device nodes, could be done much better in the kernel IMHO. The
only thing udev offers over a devfs-like solution in this regard is the
ability to have those device nodes use all sorts of wacky, random names.
And that's not a feature in my book, it's a colossal bug. If you want
wacky, random names, make them symlinks. And please don't confuse hatred
for ide/host0/bus0/target0/lun0/part1 versus hda1 with hatred of
standardized names. Picking a dumb standard one time doesn't mean
standards are dumb.

