Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVAYTZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVAYTZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVAYTZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:25:25 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:49538 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262079AbVAYTZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:25:08 -0500
Date: Tue, 25 Jan 2005 20:25:20 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-input@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
Message-ID: <20050125192519.GA2370@ucw.cz>
References: <200501250241.14695.dtor_core@ameritech.net> <20050125105139.GA3494@pclin040.win.tue.nl> <d120d5000501251117120a738a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000501251117120a738a@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 02:17:33PM -0500, Dmitry Torokhov wrote:
> On Tue, 25 Jan 2005 11:51:39 +0100, Andries Brouwer <aebr@win.tue.nl> wrote:
> > On Tue, Jan 25, 2005 at 02:41:14AM -0500, Dmitry Torokhov wrote:
> > 
> > > Recently there was a patch from Alan regarding access timing violations
> > > in i8042. It made me curious as we only wait between accesses to status
> > > register but not data register. I peeked into FreeBSD code and they use
> > > delays to access both registers and I wonder if that's the piece that
> > > makes i8042 mysteriously fail on some boards.
> > 
> > You are following this much more closely than I do, but isn't the
> > usual complaint "2.4 works, 2.6 fails"?
> > 
> 
> Quite often it is but too much has changed in input layer to pinpoing
> exact cause of the failure and I am open to any suggestions. Common
> problems I see:
> 
> 1. ACPI sometimes interferes with i8042, especially battery status
> polling. I am concerned about embedded controller access as well, it
> looks like it takes sweet time to read/write data to it and ec.c does
> it with interrupts disabled.

Furthermore, the EC and the i8042 are often the same chip, resulting in
the i8042 not answering when EC is busy. Enabling interrupts won't help.

> 2. USB legacy emulation - we used to have PS/2 initialization in
> GPM/Xfree which means that USB modules (if any) are already loaded and
> requested handoff so results were very consistent. Now it all depends
> on who's first. There were couple of PCI quirk patches doing early USB
> handoff but they have not been applied out of fear breaking some
> boxes. I wonder if there are concrete examples of such patches
> breaking boxes, how many and whether DMI decode/workaround will be
> beneficial for these.

I still hope we could get those in after the handoff code is ironed out.
It kept (keeps?) crashing some machines and not using USB is an easy way
out of this if you don't have the handoff in the early init code.

> Also, In 2.4 if BIOS detected PS/2 mouse we trusted it and did not do
> any additional checks, now that i8042 is not x86 specific we do
> everything by hand and it looks like some hardware is not expecting
> it...

We may be able to loosen the checks again now that 98% of machines do
have the PS/2 mouse port if they have the AT keyboard port.

> Still, I wonder if implementing these delays will give IO controller
> better chances to react to our queries and will get rid of some
> failures.

Agreed. I'll check them tomorrow in detail and if I find them OK (I
expect to), I'll merge the patch to my tree. Unfortunately I don't
expect the delays themselves will fix much.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
