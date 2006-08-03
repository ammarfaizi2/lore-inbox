Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWHCN5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWHCN5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 09:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWHCN5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 09:57:04 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:18156 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932475AbWHCN5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 09:57:02 -0400
Date: Thu, 3 Aug 2006 09:55:58 -0400
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, Chris Boot <bootc@bootc.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
Message-ID: <20060803135558.GO13639@csclub.uwaterloo.ca>
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de> <44CFC6CC.8020106@gmail.com> <20060802175834.GA13641@csclub.uwaterloo.ca> <44D10FA1.2010206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D10FA1.2010206@gmail.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 02:48:33PM -0600, Jim Cromie wrote:
> pc8736x_gpio and scx200_gpio appear here:
> 
> soekris:/sys/devices/platform# ls pc8736x_gpio.0/
> Display all 292 possibilities? (y or n)
> 
> soekris:/sys/devices/platform# ls scx200_gpio.0/
> Display all 532 possibilities? (y or n)
> 
> 
> soekris:/sys/devices/platform# ls scx200_gpio.0/bit_0.0_*
> scx200_gpio.0/bit_0.0_current_output  scx200_gpio.0/bit_0.0_pullup_enabled
> scx200_gpio.0/bit_0.0_debounced       scx200_gpio.0/bit_0.0_status
> scx200_gpio.0/bit_0.0_locked          scx200_gpio.0/bit_0.0_totem
> scx200_gpio.0/bit_0.0_output_enabled  scx200_gpio.0/bit_0.0_value

Hmm, that certainly is different than the old /dev/... interface.  Could
be nice.

> Did you mean to ask that question of Robert ?

I might have. :)

> I'll rephrase my Q here.
> 
> /sys/class/gpio/gpio63/
> 
> this suggests that either
> - only 1 GPIO device can register (bad)

Unacceptably bad.  I currently use anywhere from 2 to 4 different
devices with GPIOs.

> - reservations might be taken in module-load order, and assigned 
> numerically (bad-subtle)

Too messy.

> Using another path (like /sys/devices/platform/scx200_gpio.%d/ )
> which names the driver (or some other structural info) seems much more
> stable in the face of combinations of GPIO hardware.

That I think is perfectly easy to work with, as long as I can somehow
find which device (usually on PCI bus in my case) goes to which
directory.  I suspect that would be the case.

> FWIW, I didnt add the .0 to the directories, I think that was added for 
> me by the device-core,
> (warmfuzzy) so Id expect it to handle .1,2,3 etc..

That sounds nice and convinient.

> Both GPIO chips Ive touched have port-wide read and write.
> I consider it an essential minimum feature in the driver, for hardware 
> that supports it.
> Other pin features (OE, etc) are only controllable per-pin.
> If we synthesize port-wide from per-pin, then we get a bit/port agnostic 
> interface.
> ( driver users must still be cognizant of the limitations of synthetic 
> OutputEnable,
> where tri-stating would take many bus cycles )

I only consider the change of state on output pins, or reading state of
input pins to be a requirement for port-wide.  Changing between
input/output, and enable and tristate and such, I have no problem with
doing bit by bit, since that is setup stuff.

> - pc8736x_gpio , scx200_gpio went thru mm into mainline-rc - they 
> support the legacy gpio-bit
> access via char-device-file.  They expose port-wide read/write inside 
> the kernel, via struct nsc_gpio_ops,
> but it seems a bad idea to expose them as device-files. ;-)

Well I haven't seen a gpio driver that did port wide yet.  I treat the
ppdev as 8 gpio pins, so at least for that I get port wide.

> - This thread is about a new interface, I think we're all tacitly 
> agreeing on :
>    a sysfs based GPIO-attr representation
>    some of us want/demand a port-interface where hardware has portwide 
> read/write
>    a reservation scheme.

Sounds lovely to me.

> - Im working on a patch, which rendered the ls output I pasted above.
>    bits_ and ports_ agnostic
>    interfaces are nearly identical - its 0/1 vs 0xFF (hw dependent width)
>    no reservations yet :-/

I look forward to seeing it.

> char-dev interfaces in scx200_gpio 18-rc are compatible with legacy, 
> pc87360 is new (and same).
> my sysfs-gpio patch actually has a half-baked compatibly hack on the 
> _status attr,
> platform# more scx200_gpio.0/bit_0.0_status
> io00: 0x0044 TS OD PUE  EDGE LO DEBOUNCE        io:1/1

Keeping the legacy for at least a while is probably a requirement since
people are already using those interfaces on that hardware.

> not yet on these:  patches/clues welcome.
> >generate interrupt
> >edge/level trigger
> >high or low level/leading or trailing edge trigger

Well tying into interrupt handlers would be tricky I suspect.  On the
other hand someone might have a use for the feature.  I just mentioned
them because it is a feature of some of the devices I use, although I
don't use them for anything other than input/output myself.

--
Len Sorensen
