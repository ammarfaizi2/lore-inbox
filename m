Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWIAAae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWIAAae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 20:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWIAAae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 20:30:34 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:25249 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S964832AbWIAAac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 20:30:32 -0400
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM
	Improvements
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Brown, Len" <len.brown@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org
In-Reply-To: <200608311713.21618.bjorn.helgaas@hp.com>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
	 <20060830194317.GA9116@srcf.ucam.org>
	 <200608311713.21618.bjorn.helgaas@hp.com>
Content-Type: multipart/mixed; boundary="=-oPRQynYK1YqDxhxaX3GI"
Organization: OLPC
Date: Thu, 31 Aug 2006 20:30:16 -0400
Message-Id: <1157070616.7974.232.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oPRQynYK1YqDxhxaX3GI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-08-31 at 17:13 -0600, Bjorn Helgaas wrote:
> On Wednesday 30 August 2006 13:43, Matthew Garrett wrote:
> > That would be helpful. For the One Laptop Per Child project (or whatever 
> > it's called today), it would be advantageous to run without acpi.
> 
> Out of curiosity, what is the motivation for running without acpi?
> It costs a lot to diverge from the mainstream in areas like that,
> so there must be a big payoff.  But maybe if OLPC depends on acpi
> being smarter about power or code size or whatever, those improvements
> could be made and everybody would benefit.

Good question; I see Matthew beat me to part of the explanation, but
here is more detail:

Our screen consumes of order 1/10th the power of a conventional flat
panel, and can consume a half watt or so (yes, we now have working
screens; this is not mythological hardware; I got my own personal first
hand look at prototype display running this afternoon :-); I always do
line new toys...).  

Even though the base machine may take only a couple watts of power
(Geode GX + the rest of the base logic), 2-3 watts is too much power to
use; a small child can generate only 7-10 watts.  So if we want a decent
"learn" to "generate" ratio, we have to do better than the 2-4 to 1
ratio we might get conventionally.  In January, we saw this staring us
in the face, and knew we had to do better, or we'd have just told a good
fraction of the kids in the world they can't have the advantages of a
computer.  Our goal has always been a 10 to 1 ratio, for at least the
most important use cases (e.g. reading).

OK, what to do?  We built a chip that lets us suspend the processor and
keep the screen alive, and chose a wireless chip that will let us keep
the mesh network alive, and we intend to suspend/resume the processor
to/from RAM at the drop of a hat.  This gets our idle consumption from
about 2.5-3 watts (with screen and wireless on), to under one watt.
We'd need resume to be as close to imperceptible as possible; touch a
key or the touchpad, the machine resumes so fast as you don't notice.

In short, we have novel hardware: we can have our screen on, and suspend
the processor to RAM, and use a half a watt.  We can have our wireless
forwarding packets in our mesh networks, with the processor suspended,
consuming under 400mw (we hope 300mw by the time we ship).  Both on, and
we're still under one watt.

For keyboard activity, human perception is in the 100-200 millisecond
range; for some other stuff, it is even less much than that.  So that's
the necessity; now the invention.

I've done a straw pole among kernel gurus at OLS and elsewhere on how
fast Linux might be able to resume. I've gotten answers of typically
"one second".

But, on other platforms (see attached), I have data I've measured myself
showing Linux going from resume from RAM to *scheduling user level
processes* 100 times faster than that, on a wimpy 200mhz ARM processor.
Yes, Matilda, Linux can, on non-braindead hardware, resume all the way
to scheduling user processes in 10 milliseconds on a 200mhz processor.

This will, for most use cases (you are reading, or your machine is
sitting there between bursts of activity), likely double / triple /
quadruple our battery life depending on what you are doing.  Note that
on a conventional machine, with a conventional display, you'd not see
this large an improvement.  Worst case, of course, it will make no
difference at all (e.g. watching a video).

Clearly we can't do any better than what our hardware allows
(stabilization of power supplies, PLL's, etc).  I should have data on
that very shortly, now that I can measure it on LinuxBIOS pretty
directly.  For those of you building chips and systems: please make the
hardware restart time as fast as possible: it matters.  The CPU doesn't
have to go full speed instantly; just get it going at some speed as
quickly as you can.

Conventional PC's with conventional BIOS's using ACPI don't do anything
like as well. So, guess what?  We don't plan to use a conventional
commercial BIOS, (we're using LinuxBIOS and Linux as Bootloader) and
will do whatever it takes (including ignoring however much of ACPI turns
out to be necessary) to get our resume down to what we know is possible.
ACPI is mostly an x86 aberration; on most architectures it does not
exist.  So it does not require contorting Linux to not use ACPI, to the
extent we find it necessary.  Most of *real* power management is done by
Linux, and not by ACPI.

Boy, human powered machines really *do* focus the mind on power
management ;-).
                              Regards,
                                     - Jim Gettys

-- 
Jim Gettys
One Laptop Per Child


--=-oPRQynYK1YqDxhxaX3GI
Content-Disposition: inline
Content-Description: Attached message - Linux resume time on iPAQ (Linux
	resume can be *really* fast).
Content-Type: message/rfc822

Received: from gabe.freedesktop.org ([131.252.208.82]) by
	sccrmxc23.comcast.net (sccrmxc23) with ESMTP id
	<20060715002109s2300qcfcbe>; Sat, 15 Jul 2006 00:21:09 +0000
X-Originating-IP: [131.252.208.82]
Received: by gabe.freedesktop.org (Postfix) id 66DE29E92A; Fri, 14 Jul 2006
	17:21:09 -0700 (PDT)
Delivered-To: jg@freedesktop.org
Received: from pedal.laptop.org (pedal.laptop.org [18.85.2.148]) by
	gabe.freedesktop.org (Postfix) with ESMTP id 1C0A39E89D for
	<jg@freedesktop.org>; Fri, 14 Jul 2006 17:21:09 -0700 (PDT)
Received: by pedal.laptop.org (Postfix) id 8FA27EF8193; Fri, 14 Jul 2006
	20:21:08 -0400 (EDT)
Delivered-To: jg@laptop.org
Received: from rwcrmhc15.comcast.net (rwcrmhc15.comcast.net
	[204.127.192.85]) by pedal.laptop.org (Postfix) with ESMTP id 4EA02EF8192;
	Fri, 14 Jul 2006 20:21:08 -0400 (EDT)
Received: from sipuraspa.gettys.org
	(c-24-218-178-107.hsd1.ma.comcast.net[24.218.178.107]) by comcast.net
	(rwcrmhc15) with SMTP id <20060715002107m1500ob2fme>; Sat, 15 Jul 2006
	00:21:07 +0000
Subject: Linux resume time on iPAQ (Linux resume can be *really* fast).
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: OLPC Developer's List <devel@laptop.org>
Content-Type: text/plain
Organization: OLPC
Date: Fri, 14 Jul 2006 20:21:05 -0400
Message-Id: <1152922866.6001.332.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-Evolution-Source: pop://Jim.Gettys@mail.comcast.net/
Content-Transfer-Encoding: 7bit


The iPAQ is by far the closest device we have to modeling the OLPC
system, though the one I chose is less than 1/2 the integer performance
of our machine. It has roughly comparable peripherals to the OLPC
system, and unified graphics as the Geode (just a dumb frame buffer on
the SA1100).

Here's the test:

I have a simple C program written for me by Joshua Wise that just writes
characters to /dev/tty.  It can either do so continuously, or open and
close the device between each character.  In the former case, you get
metronome like character output, as the characters are all interrupt
driven out of the kernel character buffers; in the latter case, the
close/open sequence enables the operating system to reschedule the
process as it sees fit.  This is a much more interesting test.

I reconfirmed the data with Mike Bove this afternoon.

A: suspend on the iPAQ is amazingly fast; we could see no significant
delay from emitting a character to power off of the machine.

B: resume is also very fast, if not quite so fast (of order a few up to
10 milliseconds).

Here's the the measurement methodology:

I suspend the iPAQ.

I wait some amount of time.

I resume the iPAQ.  Conveniently, there happens to be a debug message
emitted by the bootloader right when it transfers control to Linux.

1) The iPAQ does nothing for anywhere between 280-400ms after resume
starts; we do not know (or care) what the cause actually is. We theorize
that it has some built in delay on how long the power supply takes to
stabilize or some such strangeness.   This will be a combination of
whatever hardware delays force us + any bootloader/BIOS delays.

2) within some few milliseconds of actually resuming (like of order 10
ms), Linux is in user space executing code, and some characters again
appear on the serial port.

3) There then appears to be an approximately 180ms gap before characters
again start appearing on the output port.  

The resume is triggering processes in user space; if I kill the cardmgr
process, used for hotplug of PCMCIA, this gap goes away.  There may be
very simple solutions too: e.g. running those processes at reduced
priority, but probably better is to try to arrange hotplug to work in
some other fashion.

Conclusion
==========

Linux can resume *really, really, really* fast, if the hardware lets it,
and the device drivers don't have bad delays built into them.  

If they do have such bad delays, we might have to do Mark's fast
suspend/resume scheme, or something driver specific. I really like
Mark's fast suspend/resume idea, and on some big systems (or with really
bad hardware that has multiple very long delays, it may be a godsend). 

We *will* have to do something about this user space behavior, which is
not at all surprising. One option might be to only attempt hotplug when
the lid is closed, or when you invoke some application, rather than on
resume from save to RAM; or it may be possible to do this on USB
provided hotplug events (but I haven't read the Geode errata sheet for a
while).

So: 
  o we need to vet the drivers we are using to see if any of them have
long built in delays on resume.  If our hardware is really braindead, we
might still have to do something about parallelizing the resume code.
The most likely driver to have problems with is clearly going to be USB,
and we need USB to talk to the Marvell chip.
  o The iPAQ is running Linux 2.4 which does not have a
particularly decent scheduler; it doesn't follow that we'll necessarily
see the same complete starvation of the original process (though we very
well might). We certainly don't want to be triggering hotplug at the
rate we'd like to suspend/resume.

Next step: perform the same tests on the OLPC system and see what that
tells us.  This is just now to the point of becoming feasible.
                               Regards,
                                 - Jim

-- 
Jim Gettys
One Laptop Per Child



--=-oPRQynYK1YqDxhxaX3GI--

