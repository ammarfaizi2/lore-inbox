Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWAEV4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWAEV4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWAEV4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:56:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58041 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932231AbWAEV4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:56:02 -0500
Date: Thu, 5 Jan 2006 22:55:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: dtor_core@ameritech.net, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060105215528.GF2095@elf.ucw.cz>
References: <20051227213439.GA1884@elf.ucw.cz> <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com> <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net> <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 05-01-06 13:42:33, Patrick Mochel wrote:
> 
> On Wed, 4 Jan 2006, Pavel Machek wrote:
> 
> > On Út 27-12-05 20:22:04, Patrick Mochel wrote:
> 
> > > Heh, not really. You're not really solving any problems, only giving the
> > > illusion that you've actually fixed something.
> >
> > Except perhaps userspace passing invalid values down to drivers in
> > pm_message_t.event?
> 
> It is up to the layer parsing the value to filter out bad values.

Do you have the patch to filter bad values? I submitted one. You
rejected it, because it does not support D1. Never mind that original
code does not support D1, either. [Should I retransmit the patch?]

If you suggest to just add check for == 0 or == 2... I think I can do
that, but that's going to break userspace, anyway (it passes _3_
there) and have no reasonable path to sane interface.

> > > As I mentioned in the thread (currently happening, BTW) on the linux-pm
> > > list, what you want to do is accept a string that reflects an actual state
> > > that the device supports. For PCI devices that support low-power states,
> > > this would be "D1", "D2", "D3", etc. For USB devices, which only support
> > > an "on" and "suspended" state, the values that this patch parses would
> > > actually work.
> >
> > We want _common_ values, anyway. So, we do not want "D0", "D1", "D2",
> > "D3hot" in PCI cases. We probably want "on", "D1", "D2", "suspend",
> > and I'm not sure about those "D1" and "D2" parts. Userspace should not
> > have to know about details, it will mostly use "on"/"suspend" anyway.
> 
> D0 - D3 are common for all PCI devices. "on" and "suspend" are not device
> states. They are conceptual representations of device states.
> 
> I understand where you are coming from. Most users will only care that a
> particular device is "on" or "off". That is fine. They will click through
> a gui that turns off a device and never think any more about it.
> 
> However, we are not developing an interface for end-users. We're
> developing an interface that the guis may use. And, along with the guis,
> there are also people that care about everything in between "on" and
> "suspend".

There may be more than "D1" and "D2" between "D0" and "D3". There may
be two different ways to put particular device into D1 sleep. This
means buses and devices contributing states, and all this is
complexity noone really wants.

> If we export exactly the device states that a device supports, then
>we can

Exporting multiple states is quite a lot of code, and it needs driver
changes. There's no clear benefit.

> I have a firewire controller in a desktop system, and a ATI Radeon in a
> T42 that support D1 and D2..

Ok, now we have a concrete example. So Radeon supports D1. But putting
radeon into D1 means you probably want to blank your screen and turn
the backlight off; that takes *long* time anyway. So you can simply
put your radeon into D3 and save a bit more power.

So yes, Radeon supports D1, but we probably do not want to use it.

[You may still want to do D1 on radeon for
debugging/testing/something. Fine, but we are trying to build
power-management infrastructure, not debugging one.]

								Pavel
-- 
Thanks, Sharp!
