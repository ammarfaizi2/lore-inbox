Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVAKJdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVAKJdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVAKJcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:32:45 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:51451 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262639AbVAKJcG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:32:06 -0500
Date: Tue, 11 Jan 2005 10:26:22 +0100 (CET)
To: pioppo@ferrara.linux.it, sensors@Stimpy.netroedge.com
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <YN0o4rkI.1105435582.0805630.khali@localhost>
In-Reply-To: <200501102341.44949.pioppo@ferrara.linux.it>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Jonas Munsin" <jmunsin@iki.fi>, djg@pdp8.net, "Greg KH" <greg@kroah.com>,
       "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-01-10, Simone Piunno wrote:

> Before loading it87:
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 11 00 00 00 37 ff 00 37 ff 07 00 5b 00 2a ff ff
> 10: ff ff ff 30 00 00 00 00 00 00 00 00 00 00 00 00
> (...)

The relevant registers are 0x13-0x17, and they are just what I expected.

The IT87xxF chips have three fan control modes: on/off, manual PWM
control and automatic (temperature-based) PWM control, the default being
on/off, all fans off. When switching to PWM mode, the default is manual
with 0% duty cycle (i.e. all fans off again).

What you have here is this default configuration, i.e. all fans are
supposedly off. Of course it isn't the case, I assume that your fans
are running at full speed when you turn your computer on. So how is this
possible? The IT87xxF chip have a fan polarity bit which defaults to
"Active low". Providing that your fans are meant to be driven active
high (and I'd guess all fans work that way without additional
electronics), they are on when the IT87xxF chip wants to set them off,
and off when the chip wants them on. This is why the fans apparently
work OK.

While it's OK at boot time and as long as we don't want to use PWM (the
fans are on even if the chip pretends they shouldn't be), the illusion
breaks when we attempt to control the fan speed through the it87 driver:

> After loading it87:
>
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>00: 11 03 60 00 37 ff 00 37 ff 07 00 5b 00 ff ff ff
>10: fe fe fe 31 07 7f 00 00 00 00 00 00 00 00 00 00

Here, configuration changed. Fans in on/off mode will now be on. While it
makes full sense from the driver's point of view, if breaks the fragile
equilibrium state your board was in.

Additionally, the first fan control output was turned to manual PWM
control mode, full speed. The driver supposedly doesn't do that, I
guess you did it yourself through the sysfs interface?

This configuration supposedly sets all fans to full speed, but in your
"inverted" hardware setup, this means all fans off, unfortunately, as
you noticed in the first place.

I would like to insist on the fact that the ones to blame here are:
1* ITE for their poor chip defauls.
2* Motherboard manufaturers for their poor BIOSes.
And in no way Jonas, whose code was correct, just not broken-config-proof.

> I've already coded a small fan controller daemon working around the
> problem and driving the fan to run at the minimum speed sufficient to
> keep the CPU cool enough.  Anyone interested can look here:
>   http://svn.ferrara.linux.it/view/just4fan
> or check it out from the subversion repository:
>   svn checkout http://svn.ferrara.linux.it/just4fan

Well, the lm_sensors project has tools to do that already. Look in
prog/pwm, there is a PWM configuration detection script (pwmconfig) and
two fan control scripts (original one in shell and a reimplementation in
perl). It might be more efficient to start from these and possibly
improve them if needed (and contribute back!) than writing something
completely new. Do as you prefer though :)

Although note that the ITxxF has an automatic PWM control mode as
explained above, so it probably can do in hardware what your software
daemon does. We have plans to add support for this to the it87 driver
soon (actually I think Jonas is already working on the code) but we
obviously cannot do that before manual mode is OK, which it isn't for
now.

> In fact, now I run the system with it87 always loaded... it's soooo
> quiet! Now that I'm used to this silence I can't live without it:
> I can't stand the fan screaming anymore!  I think for I won't move away
> from -mm until this single feature makes it into vanilla :)

Mind you, there is a reason why Jonas implemented this ;)

> > Do you know what kind of it87 chip you do have? There are three of them,
> > IT8705F, IT8712F and a SIS950 clone (mostly similar to the IT8705F).
>
> I'm sorry I don't know.  How I could check?

See /sys/bus/i2c/devices/0-0290/name. If it says it8712 it's an IT8712F,
if it says it87 it is a less featured IT8705F or clone. After looking at
the datasheets, it doesn't matter much anymore though, as both chips
have the same default values and have to be configured in the same way.

OK, so now we want to reintroduce manual PWM in the it87 driver, in a way
that will not cause fans to stop unexpectedly. Here is my proposed plan:

1* Jonas, please send a modified version of your original patch to Greg.
The only difference would be that you wouldn't force on/off mode to be
on at driver load time. Instead, disabling PWM for one fan control
output (echo 0 > pwmN_enable) would both set on/off mode to on for that
output (new) and turn that output to on/off mode (same as before).

One might argue that it doesn't solve the problem but merely moves it.
This is true, but this at least ensures that loading the driver will
*not* change any fan speed. I think it is an important rule for all
hardware monitoring chips to respect.

One might also argue that this adds some overhead (we end up writing
several times to the same register, possibly for nothing, at use time
instead of just once at init time) but frankly it doesn't matter much.
One doesn't disable PWM that often.

Of course, at this point, trying to play with PWM on a system such as
Simone's one will still break, but at least not at driver load time.

2* I would then add a check to the it87 driver, which completely disables
the fan speed control interface if the initial configuration looks weird
(all fans supposedly stopped and polarity set to "active low"). This
should protect users of the driver who have a faulty BIOS.

When a bogus configuration is detected, we would of course complain in
the logs and invite the user to complain to his/her motherboard maker
too.

At this point, Simone will complain that he likes the PWM feature and
wants it back ;)

3* Last, we would either add a module parameter allowing chip
reprogramming with active high polarity, or write a script which does
the same using i2cset or isaset. Not sure what is best. I don't much
like adding brokeness-workaround init code in the kernel, but OTOH an
external script might be harder to integrate into distributions etc...

At this point, Simone will have a prefectly working chip with manual PWM
and should be happy :)

And then Jonas will be able to go on with the automatic speed control.

Comments on the plan anyone?

Thanks,
--
Jean Delvare
