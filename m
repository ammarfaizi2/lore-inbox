Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281059AbRKPEdP>; Thu, 15 Nov 2001 23:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281069AbRKPEdG>; Thu, 15 Nov 2001 23:33:06 -0500
Received: from hermes.toad.net ([162.33.130.251]:63918 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S281059AbRKPEc4>;
	Thu, 15 Nov 2001 23:32:56 -0500
Subject: Re: Constant oops when PnP OS set to 'Y' in BIOS
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Cave-Ayland <mca198@ecs.soton.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 15 Nov 2001 23:33:16 -0500
Message-Id: <1005885198.2971.10.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reason you are having these problems is this:

To set the "Plug and Play OS" firmware option to "yes"
is to tell the firmware not to configure any ISA-PnP-
configurable devices except for those required
to boot the OS.

When you do this, Linux oopses at boot time because some
of your devices are in an uninitialized state when Linux
tries to access them.

There are several solutions to this, the more straightforward
of which is to un-set the "Plug and Play OS" option.

Linux sets the "PnP OS" bootflag when it starts; then
subsequent boots of Linux (or other operating systems)
will occur without the firmware configuring devices.  I
believe that this is a Bad Idea.  First of all, the
reason for setting the bootflag seems to be the belief
that it speeds up the boot process; but I think that
what takes a significant amount of time is POST, not
configuration, and POST is disabled using an entirely
different bootflag.  Second, even if PnP configuration
takes time, it's safer than not configuring, as your
experience proves.  Configured devices can always be
reconfigured, but unconfigured devices cause oopses.
Leaving the "PnP OS" bootflag unset should be the
default option.  Third, it makes no sense for Linux
to set the bootflag anyway, because it cannot possibly
know what operating system will boot *next* time!

A further problem is that the bootflag-setting code in
arch/i386/kernel/bootflag.c is compiled in conditionally
upon the definition of CONFIG_PNPBIOS.  This is wrong.
It is not the pnpbios driver that makes Linux a PnP OS.
If anything, it is the isa-pnp driver that makes it so---
i.e., that gives Linux the ability to do what the BIOS
doesn't do when the "PnP OS" bootflag is set, namely,
configure devices by PnP methods.  Indeed, if one is
making use of the pnpbios driver it means that the OS
is going to use the firmware to configure devices and
so presumably is *not* a PnP OS!

I presented these arguments in an earlier thread, but
the reply I got was that if I don't like the way the
flag is set then I should clear it myself after Linux
boots.  Unfortunately I have no utility program that can
do that.  Once such a program is available, Linux 
should cease to futz with the PnP OS bootflag and leave
it up to the user to decide if s/he wants to set it.

I worked around the problem by masking the PnP OS
boot flag; my firmware setup program gives me the
option to do that.

Thomas Hood


