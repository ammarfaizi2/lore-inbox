Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWAEWPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWAEWPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWAEWPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:15:53 -0500
Received: from digitalimplant.org ([64.62.235.95]:28906 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1751318AbWAEWPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:15:52 -0500
Date: Thu, 5 Jan 2006 14:15:39 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: dtor_core@ameritech.net, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <20060105215528.GF2095@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0601051359290.10834-100000@monsoon.he.net>
References: <20051227213439.GA1884@elf.ucw.cz>
 <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
 <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
 <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
 <20060105215528.GF2095@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jan 2006, Pavel Machek wrote:

> Do you have the patch to filter bad values? I submitted one. You
> rejected it, because it does not support D1. Never mind that original
> code does not support D1, either. [Should I retransmit the patch?]

No, I offered guidance in one of the first emails. The code that exports a
'power' file for every single device from the driver model core should be
removed.

It should be replaced with a file exported by the bus driver that exports
the actual states that the device supports. The parsing can easily happen
at this point, because the bus knows what a good value is.

> If you suggest to just add check for == 0 or == 2... I think I can do
> that, but that's going to break userspace, anyway (it passes _3_
> there) and have no reasonable path to sane interface.

The userspace interface is broken. We can keep it for compatability
reasons, but there needs to be a new interface.

> There may be more than "D1" and "D2" between "D0" and "D3". There may
> be two different ways to put particular device into D1 sleep. This
> means buses and devices contributing states, and all this is
> complexity noone really wants.

It is not unnecessary, though. If the buses are the ones exporting the
states, then the number of states and the names of the states can be
accurate.

> > If we export exactly the device states that a device supports, then
> >we can
>
> Exporting multiple states is quite a lot of code, and it needs driver
> changes. There's no clear benefit.

I don't understand what you're saying. If I have a driver that I want to
make support another power state and I'm willing to write that code, then
there is a clear benefit to having the infrastructure for it to "just
work".

> > I have a firewire controller in a desktop system, and a ATI Radeon in a
> > T42 that support D1 and D2..
>
> Ok, now we have a concrete example. So Radeon supports D1. But putting
> radeon into D1 means you probably want to blank your screen and turn
> the backlight off; that takes *long* time anyway. So you can simply
> put your radeon into D3 and save a bit more power.
>
> So yes, Radeon supports D1, but we probably do not want to use it.

I'm sorry, but that's not your call to make.

If the device supports it, and if the driver supports it (or if it is made
to support it), then we don't want to modify the kernel (the core driver
model code, no less) just to add the ability to pass one more state down
to the driver, when we could get it for free now (by having the PCI bus
export the PCI device states it sees the device support via the config
space).

If you want a more concrete example, consider the possibility where it may
be possible to reinitialize the device from D1 or D2, but not from D3. For
the radeon, this is true in some cases (if I understand Ben H correctly).
There is also the case where screen blanking is either free or
non-existent (when the GPU is used for computation).

> [You may still want to do D1 on radeon for
> debugging/testing/something. Fine, but we are trying to build
> power-management infrastructure, not debugging one.]

I see those things as means to the same end. We want a good debugging
interface so people will actually try these things and use them. Plus,
testing is a big piece and going to get bigger - Many people and companies
want to know how much battery life they can squeeze out of a laptop, and
that evaluation involves experiementing with different configurations of
devices being in various states of suspend.

Thanks,


	Patrick

