Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVA1Owd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVA1Owd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVA1Owd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:52:33 -0500
Received: from styx.suse.cz ([82.119.242.94]:51402 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261431AbVA1Ow2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:52:28 -0500
Date: Fri, 28 Jan 2005 15:55:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 access timings
Message-ID: <20050128145536.GA13734@ucw.cz>
References: <200501250241.14695.dtor_core@ameritech.net> <20050125105139.GA3494@pclin040.win.tue.nl> <d120d5000501251117120a738a@mail.gmail.com> <20050125194647.GB3494@pclin040.win.tue.nl> <1106685456.10845.40.camel@krustophenia.net> <1106838875.14782.20.camel@localhost.localdomain> <20050127174506.GB6010@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127174506.GB6010@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 06:45:06PM +0100, Andries Brouwer wrote:
> Discussion:
> 
> Dmitry:
> Here are patches with some delays. One never knows - maybe they
> help someone.
> 
> Andries:
> Only insert delays in the kernel source when either we know about
> at least one person who reports that it helps, or about data sheets
> that specify that the delay is required. Otherwise one creates
> myths and superstition.
> 
> Lee Revell:
> > > Seems like a comment along the lines of "foo hardware doesn't work right
> > > unless we delay a bit here" is the obvious solution.  Then someone can
> > > easily disprove it later.
> 
> At present the comment would be
> "Here is a delay - nobody knows why we are adding it".
> 
> Alan:
> > Myths are not really involved here. The IBM PC hardware specifications
> > are fairly well defined
> 
> If there is a data sheet that requires the delay I am of course happy.
> If there are test results that show that it helps, I am happy as well.
> But the given motivation was "you never know - it might help". Bad.

I fully agree. And I won't merge the delay patch in the current state.
It may be useful for testing with systems that are failing, though.
On the other hand, I don't believe any of todays systems need any
delays, and that most of the problems are caused by the kernel pushing
the limits of what SMM emulation can do, where the real hardware
wouldn't have problems with it.

> The present situation is that often 2.4 works and 2.6 fails.

And the most common case is the SMM code messing up 2.6 detection. 2.4
is lucky by doing the mouse initalization after the USB modules have
loaded, not doing any MUX detection at all, etc. It still has problems
on systems where there is no AUX yet BIOS reports it and a user opens
/dev/psaux.

> Not because of some delay that is also absent in 2.4.
> Often because of all those keyboard commands we send to the hardware.
> Sometimes also because of ACPI.
 
Intel, VIA, nVidia and ALi embedded i8042 cells handle the commands with
ease. Extended notebooks i8042's usually handle multiplexing, and as
such don't have problems with the commands either. SiS seems not to
implement a few commands in some of their chipsets, but issuing the not
implemented commands has no adverse effects.

Where computer makers cut corners a LOT is the BIOS. And doing SMM mouse
emulation when you have both a real PS/2 mouse and an USB mouse is
really tricky, not only because of the data mixing intricacies, but also
because of the wide variety of PS/2 and USB hardware. Some USB mice
ignore the SetIdle call and this causes the SMM to send an endless
stream of simulated PS/2 mouse data for example.

A way to save us most of the headaches in 2.6 would be to always do the
usb handoff, unless disabled by a kernel option, by reversing the logic
of the "usb-handoff" kernel option.

That way, the playing field for i8042.c would be level with 2.4. Without
it, the driver has to avoid much more obstacles.

[Hmm, a thought. Since MUX and SMM emulation are mutually exclusive,
maybe the i8042 driver should disable MUX detection unless usb-handoff
has been specified ... unfortunately most people will not notice and
have problems with their Synaptics touchpads.]

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
