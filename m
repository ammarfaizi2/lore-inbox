Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVGHQ3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVGHQ3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVGHQ3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:29:10 -0400
Received: from web81301.mail.yahoo.com ([206.190.37.76]:53601 "HELO
	web81301.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262701AbVGHQ3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:29:09 -0400
Message-ID: <20050708162908.715.qmail@web81301.mail.yahoo.com>
Date: Fri, 8 Jul 2005 09:29:08 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Synaptics Touchpad not detected in 2.6.13-rc2
To: Mattia Dongili <malattia@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
In-Reply-To: <20050708125537.GA4191@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili <malattia@gmail.com> wrote:
> On Thu, Jul 07, 2005 at 11:28:55PM +0200, Vojtech Pavlik wrote:
> > On Thu, Jul 07, 2005 at 11:24:43PM +0200, Mattia Dongili wrote:
> > > On Thu, Jul 07, 2005 at 01:02:38PM -0700, Dmitry Torokhov wrote:
> > > > Mattia Dongili <malattia@gmail.com> wrote:
> [...]
> > > oh, it seems I'm not able to reproduce the error anymore!
> > > I need some rest now, I'll try again tomorrow morning (I must be missing
> > > something stupid right now) and report to you again.
> >  
> > Could be the enabled debug is adding extra delay, making the problem
> > impossible to reproduce. IIRC, we've seen this with an ALPS pad, too,
> > Dmitry, right?
> 
> Sorry, it took me a while but I got the error finally (see below for the
> debug log). Anyway I suspect it's most likely a bios or hw problem, a
> cold boot shows the issue, simply reboot-ing cures it (keeping the
> ps2_adjust_timeout in place).
> Also, not every cold boot shows the issue, I reproduced it at the 3rd
> try today.
> So I believe all my previous suspecions are mostly void.
> 

I see several possible issues:

> PNP: No PS/2 controller found. Probing ports directly.

Does it show this line when touchpad is being detected? 
Do you have PNPACPI turned on?

> i8042.c: Detected active multiplexing controller, rev 5.3.

Revision 5.3 is suspicious. The last posted one is 1.1
Again, when touchpad is detected, does it show this or 1.{0|1}?

> serio: i8042 AUX0 port at 0x60,0x64 irq 12
> serio: i8042 AUX1 port at 0x60,0x64 irq 12
> serio: i8042 AUX2 port at 0x60,0x64 irq 12
> serio: i8042 AUX3 port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice

And now the real problem:

> drivers/input/serio/i8042.c: 91 -> i8042 (command) [220803]
> drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [220803]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [220806]

We are trying to talk to AUX port but KBC replies as if data
is coming from the keyboard port.

Does it help if you boot with "usb-handoff" kernel option? Another
one would be "i8042.nomux". Btw, does your laptop have external
PS/2 ports?

-- 
Dmitry

