Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVA0STl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVA0STl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVA0STl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:19:41 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:42736 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262684AbVA0SS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:18:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gi696no/3mPwwJrmR00hQrrIcu+zGe2cpy+axu6fiIchM7Onn18y4KGZGdE9L6/9NeHG0V/TcDQ6EIN94fZa6C7WuDI6RPorUcJzP9iFv6n7xK/LdvCLY2wRRUH/BHszesjUygzmdT7QTcFwL6i6Hx7OkCbiwAjjW3pdMlIz2yw=
Message-ID: <d120d5000501271018358c1d56@mail.gmail.com>
Date: Thu, 27 Jan 2005 13:18:55 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/16] New set of input patches
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050127163605.GA15301@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412290217.36282.dtor_core@ameritech.net>
	 <20050113153644.GA18939@ucw.cz>
	 <d120d50005011309526326afef@mail.gmail.com>
	 <20050113192525.GA4680@ucw.cz>
	 <d120d50005011312166fd03c56@mail.gmail.com>
	 <d120d50005012706045b2e84af@mail.gmail.com>
	 <20050127161518.GA14020@ucw.cz> <20050127163605.GA15301@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005 17:36:05 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Thu, Jan 27, 2005 at 05:15:18PM +0100, Vojtech Pavlik wrote:
> 
> > OK. I'll go through them, and apply as appropriate. I still need to wrap
> > my mind around the start() and stop() methods and see the necessity. I
> > still think a variable in the serio struct, only accessed by the serio.c
> > core driver itself (and never by the port driver) that'd cause all
> > serio_interrupt() calls to be ignored until set in the asynchronous port
> > registration would be well enough.
> 
> I've read he start() and stop() code, and I came to the conclusion
> again that we don't need them as serio port driver methods. i8042 uses
> them to set the exists variable only and uses that variable _solely_ for
> the purpose of skipping calls to serio_interrupt(), serio_cleanup() and
> serio_unregister().
> 
> By instead checking a member of the serio struct in these functions, and
> doing nothing if not set, we achieve the same goal, without adding extra
> cruft to the interface, making it allowed to call these serio functions
> on a non-registered or half-registered serio struct, with the effect
> being defined to nothing.
> 

No, you can not peek into serio structure from a driver, not when it
was dynamically allocated and can be gone at any time. Please consider
the following screnario when shutting down 8042 when you have a MUX
with several ports:

The rough call sequence is:
i8042_exit
  serio_unregister_port
     driver->disconnect
        serio_close
           i8042->close
     free(serio)

We need to keep interrupts passed to serio core until serio_close is
completed so device properly ACKs/responds to cleanup commands.
Additionally, in i8042 close we do not free IRQ until last port is
unregistered nor we disable the port because we want to support
hotplugging. If interrupt comes after port was freed but before
serio_unregister_port has returned i8042_interrupt will call
serio_interrupt for port that was just free()ed. Special flag in serio
will not help because you need to know that port pointer is valid. You
could try pinning the port in memory buy taking a refernce but then
asynchronous unregister is not possible and it is needed in some
cases.

I think that having these 2 interface functions helps clearly define
these sequence points when port can/can not be used, simplifies logic
and alerts driver authors of this potential problem.
 
-- 
Dmitry
