Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVFNUBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVFNUBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFNUBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:01:10 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:14726 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261315AbVFNUAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:00:51 -0400
Date: Tue, 14 Jun 2005 22:00:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] pcspeaker driver update
Message-ID: <20050614200043.GA4171@ucw.cz>
References: <42AF25C7.90109@aknet.ru> <20050614185535.GA4041@ucw.cz> <42AF2FFC.8010601@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AF2FFC.8010601@aknet.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 11:29:00PM +0400, Stas Sergeev wrote:
> Hello.
> 
> Vojtech Pavlik wrote:
> >>- changes the pcspeaker driver to
> >>use the i8253_lock instead of i8253_beep_lock
> >This doesn't seem right. The driver programs an independent part of the
> >chip and I don't see a reason to cause the time code to wait because
> >we're trying to do a beep.
> Yes, you program 0x42 which is independant,
> but, unless I am missing something, you also
> touch 0x43 and 0x61, which are not, and so I
> thought it would be better to just use the
> i8253_lock alltogether. And it doesn't look
> like the lock is held during the entire beep,
> so it probably doesn't really make anything
> to wait for too long. What am I missing?

You're right, we need to serialize access to 0x43, since it selects
which of the timers will be accessed next. I had to refresh my memory on
how that piece of hardware works.

Regarding 0x61, it's rarely used elsewhere (in MCA case, and for NMI
traps). We may need to modify the other code, but I doubt there is much
worth in it. Anyway, we do a read-modify-write, so locking would be
appropriate.

So I agree with that part of the patch.

> >Can't you just use input_grab() for this?
> I am not sure, I thought I can't. I looked at
> the code and it seems input_event() would call
> the dev->event() regardless, and only at the
> bottom - dev->grab->handler->event().
> While it seems like I want to prevent the
> dev->event() from being called, at the first
> place. And it doesn't look like the grab
> functionality is described in
> Documentation/input at all, and no examples
> around the code that I could use. So I just
> don't know what functionality is that...
> Will try to play around it and maybe I'll
> figure something out:)

Indeed, input_grab() doesn't work on events _to_ the device. And
unfortunately, it probably can't be made to work, since there is no way
to figure out in input_event() which handler it was called from.

It might be desirable to separate the in/out paths in the input layer in
the future.

So indeed, you can't use it.

> >SND_SUSPEND really seems
> >inappropriate, since it's not a sound event.

> Is it just a problem of the name (i.e.
> would the SND_STOP be better), or is it
> conceptually wrong? (I guess for both:)

I don't have a problem with the naming, but indeed the concept. The
SND_* events are for generating sounds, SND_SUSPEND (or _STOP) would be
for enabling/disabling the driver. If anything, it would fall into the
EV_SYN class, but still that doesn't seem like a clean solution.

I don't want to pollute the input API with ad hoc stuff like that.

I think that it'd be best, if you need to share the PC-speaker hardware
with a different driver, to just provide an interface between the two
drivers that doesn't go through the input subsystem.

> >>Can this please be applied?
> >Not yet.

> OK. I'll try to find the better solution.
> Let's just apply the first patch then - it is a
> cleanup, I don't think it could do any harm.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
