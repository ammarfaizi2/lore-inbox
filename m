Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWBMTxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWBMTxY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWBMTxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:53:24 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:11528 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964827AbWBMTxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:53:23 -0500
Date: Mon, 13 Feb 2006 20:53:22 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060213195322.GB89006@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <20060212120450.GA93069@dspnet.fr.eu.org> <20060212164633.GA2941@kroah.com> <20060212211406.GA48606@dspnet.fr.eu.org> <20060213062412.GB2335@kroah.com> <20060213164911.GB75835@dspnet.fr.eu.org> <20060213175046.GA20952@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213175046.GA20952@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 09:50:46AM -0800, Greg KH wrote:
> On Mon, Feb 13, 2006 at 05:49:11PM +0100, Olivier Galibert wrote:
> > You mean root is mandatory to talk with devices, whatever they are?
> 
> Not at all.  You only have to be root to create a device node, nothing
> new there.

Ok, since I don't think you're being deliberately dense, please pick
up your beverage of choice in order to clear up your head and let's
start again calmly.

Problem: finding and talking to all the devices which have capability
<x>, as long as the system administrator allows.

Examples of <x> can be:
- Maxgate hard drive I can do firmware upgrades on
- Motokia phone I can exchange data with
- CD/DVD drive, with or without writing capabilities

The hard drive can be ide, sata or in a usb enclosure.  The phone can
be connected through serial-over-usb or serial-over-bluetooth, etc.

At that point, we get several answers:
1- You do not need to do device enumeration, the user has to know the
   devices names, period.
2- Hal knows it, ask him
3- Udev knows it, ask him
4- sysfs has all the information you need, just read it

Answer 1 gets a little tiring after a while.  Usability starts by not
asking the user things you can know automatically.

Answer 2 is a little annoying.  Hal/dbus are not at 1.0 at that point
yet, especially Hal.  The constraints they put on programs and
especially on libraries can be a little hard to swallow, mandatory
glib for a start.  It's a little too much for such low-level needs.
OTOH, it has the advantage of being able to tell you dynamically of
new devices being connected.

Answer 3 is even more annoying.  Udev is not very good at backwards
compatibility (udevinfo -d of fedora core 3, i.e. udev-039, is
udevinfo -e in later versions for instance).  Udev is obviously not
mandatory, and may be replaced in two years or less (remember
/sbin/hotplug's fate?).  And frankly, should programs that just want
to find devices have to know about the program-of-the-day for device
node creation?  It also has the problem of requiring a
fork()+exec()+output parsing, which from a library context can be
annoying at best.

Answer 4 would be very nice if it was correct.  sysfs is pretty much
mandatory at that point, and modulo some fixable incompleteness
provides all the capability information and model names and everything
needed to find the useful devices.  What it does not provide is the
mapping between a device as found in sysfs, and a device node you can
open to talk to the device.  You get the major/minor, which allows you
to create a temporary device node iff you're root.  Or you can scan
all the nodes in /dev to find the one to open, which is kinda
ridiculous and inefficient.  Or you have to go back to udev/hal to ask
for the sysfs node/device node path mapping, and then why use sysfs in
the first place.

At that point, sysfs would be the best choice for device enumeration
from a user program, from a point of view of resilience to userspace
fad changes and simplicity/weight of code.  Except that you can't use
it for that.  That's annoying.

  OG.
