Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVA2TKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVA2TKx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVA2TKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:10:18 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:62158 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261537AbVA2TIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:14 -0500
Date: Thu, 27 Jan 2005 23:16:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/16] New set of input patches
Message-ID: <20050127221623.GA2300@ucw.cz>
References: <200412290217.36282.dtor_core@ameritech.net> <20050113153644.GA18939@ucw.cz> <d120d50005011309526326afef@mail.gmail.com> <20050113192525.GA4680@ucw.cz> <d120d50005011312166fd03c56@mail.gmail.com> <d120d50005012706045b2e84af@mail.gmail.com> <20050127161518.GA14020@ucw.cz> <20050127163605.GA15301@ucw.cz> <d120d5000501271018358c1d56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000501271018358c1d56@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 01:18:55PM -0500, Dmitry Torokhov wrote:
> On Thu, 27 Jan 2005 17:36:05 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Thu, Jan 27, 2005 at 05:15:18PM +0100, Vojtech Pavlik wrote:
> > 
> > > OK. I'll go through them, and apply as appropriate. I still need to wrap
> > > my mind around the start() and stop() methods and see the necessity. I
> > > still think a variable in the serio struct, only accessed by the serio.c
> > > core driver itself (and never by the port driver) that'd cause all
> > > serio_interrupt() calls to be ignored until set in the asynchronous port
> > > registration would be well enough.
> > 
> > I've read he start() and stop() code, and I came to the conclusion
> > again that we don't need them as serio port driver methods. i8042 uses
> > them to set the exists variable only and uses that variable _solely_ for
> > the purpose of skipping calls to serio_interrupt(), serio_cleanup() and
> > serio_unregister().
> > 
> > By instead checking a member of the serio struct in these functions, and
> > doing nothing if not set, we achieve the same goal, without adding extra
> > cruft to the interface, making it allowed to call these serio functions
> > on a non-registered or half-registered serio struct, with the effect
> > being defined to nothing.
> > 
> 
> No, you can not peek into serio structure from a driver, not when it
> was dynamically allocated and can be gone at any time. Please consider
> the following screnario when shutting down 8042 when you have a MUX
> with several ports:
> 
> The rough call sequence is:
> i8042_exit
>   serio_unregister_port
>      driver->disconnect
>         serio_close
>            i8042->close
>      free(serio)
> 
> We need to keep interrupts passed to serio core until serio_close is
> completed so device properly ACKs/responds to cleanup commands.
> Additionally, in i8042 close we do not free IRQ until last port is
> unregistered nor we disable the port because we want to support
> hotplugging. If interrupt comes after port was freed but before
> serio_unregister_port has returned i8042_interrupt will call
> serio_interrupt for port that was just free()ed. Special flag in serio
> will not help because you need to know that port pointer is valid. You
> could try pinning the port in memory buy taking a refernce but then
> asynchronous unregister is not possible and it is needed in some
> cases.
> 
> I think that having these 2 interface functions helps clearly define
> these sequence points when port can/can not be used, simplifies logic
> and alerts driver authors of this potential problem.
 
You're right. I forgot that serio isn't anymore tied to the driver and
can cease to exist on its own asynchronously. However, I'm still not
sure whether it's worth it. We might as well simply drop the unregister
call in i8042_open for AUX completely and forget about asynchronous
unregisters and use normal refcounting. As far as grep knows, it's the
only user.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
