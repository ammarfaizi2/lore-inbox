Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUFAVGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUFAVGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbUFAVBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:01:46 -0400
Received: from mail.homelink.ru ([81.9.33.123]:42210 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S265273AbUFAVAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:00:38 -0400
Date: Wed, 2 Jun 2004 01:00:36 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: two patches - request for comments
Message-Id: <20040602010036.440fc5b4.zap@homelink.ru>
In-Reply-To: <40BCE28A.1050601@mvista.com>
References: <20040529012030.795ad27e.zap@homelink.ru>
	<40B7B659.9010507@mvista.com>
	<20040529121059.3789c355.zap@homelink.ru>
	<40BCE28A.1050601@mvista.com>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2004 13:09:46 -0700
Todd Poynor <tpoynor@mvista.com> wrote:

> I'm not questioning the usefulness of the other aspects of the patch, 
> such as adding an LCD/backlight class for framebuffer access and adding 
> attributes for the unique features of LCD/backlight devices.  My 
> questions are specific to the power management interfaces, since there's 
> already interfaces for this, with different semantics than the new class 
> interfaces, and there's some value in sticking with a single consistent 
> interface for it.
Well, after thinking awhile, I have changed it so that 0 means power on,
1..3 intermediate values (although for now they are interpreted as poweroff by
existing drivers since there are no intermediate states) and 4 is 'off for
real'. Indeed, there is no much reason to have them use different semantics.

> If I understand correctly, the LCD device is registered on a bus (either 
> a platform-specific bus or the generic "platform" bus)
No, they are registered just as a class device. There is no corresponding
device on any other bus, this would mean a lot of unneeded overhead.

> therefore already has a power/state attribute; the class entry could 
> refer back to that device if needed.  So I'm interested in discussing 
> whether the existing PM interface suffices for LCD/backlight devices, or 
> if not, should the existing interfaces be improved (rather than working 
> around deficiencies via device-specific interfaces)?
Um, well, the LCD device actually has two power controls, like I said
before: one toggles the power to the LCD itself, another one (the 'enable'
attribute) controls power to the LCD controller. Not that this explicit
separate control is required very much, but it would be nice to have a degree
of freedom close to that allowed by hardware.

In theory, if we would use the standard power interface, it could use the
different levels of power saving, e.g. 0 - controller and LCD on, 1,2 - LCD
off, controller on, 3,4 - both off.

> But it also sounds like the single LDM registration for an LCD device 
> could be better handled by registering the LCD display, LCD controller, 
> and backlight as separate devices (which they probably are), allowing 
> individual control through the standard interfaces.
Well, the LCD panel is controllable only through the LCD controller, so for
the most part they are the same. The only thing is that the LCD controller has
a one-bit switch to disable the power to the panel. I don't think it makes
sense to separate that bit into a separate device.

> So none of my objections are terribly crucial, and if Greg et al don't 
> have a problem with device-class-specific PM interfaces that have 
> different semantics and/or capabilities than those of the device 
> power/state attributes then I don't have much of a problem with it 
> either.  Just seems worthwhile to check whether there's improvements 
> needed in the existing PM interfaces instead.
Well, the power interface under drivers/ is available for framebuffer.
If it would handle it properly (the framebuffer drivers I've tried
don't, alas), they would toggle the attached (to the framebuffer) LCD
and backlight power state according to its own state (which is not so fine
grained, but is logical). In any case, one of reasons this backlight/lcd patch
has been written was to avoid that mess with callbacks that lately begun to
appear in ARM-specific framebuffer devices (and I shudder at the thought that
MIPS people should be doing something similar).

--
Greetings,
   Andrew
