Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbRBIP7P>; Fri, 9 Feb 2001 10:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbRBIP7E>; Fri, 9 Feb 2001 10:59:04 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:62468 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130015AbRBIP6w>;
	Fri, 9 Feb 2001 10:58:52 -0500
Date: Fri, 9 Feb 2001 16:58:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Byron Stanoszek <gandalf@winds.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [preview] VIA IDE 4.0 and AMD IDE 2.0 with automatic PCI clock detection
Message-ID: <20010209165847.C2567@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0102090959530.582-100000@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0102090959530.582-100000@winds.org>; from gandalf@winds.org on Fri, Feb 09, 2001 at 10:05:44AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2001 at 10:05:44AM -0500, Byron Stanoszek wrote:

> > I've decided that too much trouble has been caused by a wrong PCI clock
> > specified to the IDE drivers (which in turn compute wrong IDE timings).
> > 
> > I've made the VIA and AMD drivers detect the PCI clock automatically.
> > Because this is a very significant change, I've upped the major release
> > numbers to 4 and 2.
> > 
> > Could anyone with these chipsets check these drivers if they detect the
> > PCI clock correctly on their systems?
> 
> Certainly. I tested this on my machine with PCIClk 33, 34, and 36.6. The driver
> correctly tuned the clocks to 33, 34, and 37 (expected and not harmful). It
> works very well.

Great! I'm glad to hear that it works also elsewhere that on my test
computers.

> One thing to note: You should probably display the new clock speed in the
> kernel debug messages on bootup.

Probably yes.

> Also I don't know if you've done this already,
> but if the user specifies an idebus=xx then that should override the auto
> detection.

It doesn't override it, that'd require patching the generic code so that
it doesn't return '33' in the default case.

> I do have a concern however. When you autodetect the PCI clock, does that
> propagate to other IDE controllers that have been initialized? For instance, my
> Abit KT7-Raid also has a Highpoint 370 controller. My fear is that it may get
> initialized to 33 before the VIA controller is started and before detecting
> that the true PCI clock is really 37. Unless the Highpoint controller has an
> external timing mechanism I think this could pose a problem.

It doesn't propagate, it's local to the via driver. Anyway, I've checked
the sources and the only driver that actually checks the system bus
speed other than my VIA and AMD drivers is the QD6580 VL-BUS IDE driver ...

All others assume 33 MHz PCI. Which in my opinion is a bug. Andre thinks
it's correct.

> If it could help things, maybe a patch can be made to the standard IDE setup
> routines that will replace the message "Assuming 33MHz for PIO modes" to
> "Autodetected PCI Clock at 37MHz". This would ensure that all the IDE drivers
> get set up with the correct detected PCI clock, and not just VIA/AMD's.

Unfortunately the PCI speed measuring code needs help from the chipset
itself, so it isn't possible to implement in generic code. Maybe a
callback could be added to the chipset-specific drivers, though ...

I do have some plans with ide-pci.c, so ...

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
