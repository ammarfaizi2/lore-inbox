Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVAMUXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVAMUXD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVAMUUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:20:37 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:62607 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261403AbVAMUQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:16:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TO3Y7orC5zvICMxJQsU6rN6IWVod/eT7bqx09vNWX0jNAOlEP6HXQlcVLT4hJXuIQB0zIRdhnUsFH2AiWfycs1YExM120a4K/85GgOYRRfaStA0/qK9SncU/qry7ZZRsQy5jVh05zPJGeb7XdStm1DhKj4xTTXfHtRXw956ITHE=
Message-ID: <d120d50005011312166fd03c56@mail.gmail.com>
Date: Thu, 13 Jan 2005 15:16:11 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/16] New set of input patches
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113192525.GA4680@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412290217.36282.dtor_core@ameritech.net>
	 <20050113153644.GA18939@ucw.cz>
	 <d120d50005011309526326afef@mail.gmail.com>
	 <20050113192525.GA4680@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 20:25:25 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Thu, Jan 13, 2005 at 12:52:14PM -0500, Dmitry Torokhov wrote:
> 
> > The problem is not with binding devices, it is with mostly with
> > sharing the same IRQ between different ports.
> >
> > Look at the MUX case, you have 4 ports all sharing the same IRQ. At
> > startup i8042 enables all on-chip ports and registers them with
> > serio_register_port(). When first serio driver class i8042_open it
> > installs IRQ handler. All 4 ports are enabled now (because we want to
> > do hot-plug) but, especially with async. serio registration, only the
> > first is fully registered with serio subsystem. If data was to come
> > from any other port the shared IRQ handler will call serio_reconnect
> > on half-alive port. The similar issues happen when you try to
> > unregister port.
> >
> > With start/stop methods allow serop core signal driver that the port
> > is fully registered and now is safe to use. If IRQ is not shared
> > between ports one can safely register/unregister handler in open/close
> > methods (at the expense of hotplug device support) but with shared IRQ
> > you need additional callbacks.
> 
> Yes, this can result in calling serio_reconnect on a port that's not
> registered yet. But I believe we don't need a callback for this, just a
> flag in the serio struct that will say "live", be set during
> registration, and until that time all serio_interrupt() calls would be
> ignored?
>

You can't have this flag in serio struct because unless this flag is
set you should not access serio struct in question, this is chicken
and egg problem. While you can somewhat control creation the deletion
is especially tricky. You need to service interrupts up until the
close is called but not a moment later as serio structure will be
freed by serio core. Therefore flag should be in the driver and having
code poking in the driver guts is not a giood idea.

start/stop are not mandatory methods so only problem drivers needs to
be adjusted.
 
> 
> > > > 04-serio-suppress-dup-events.patch
> > > >       Do not submit serio event into event queue if there is already one
> > > >       of the same type for the same port in front of it. Also look for
> > > >       duplicat events once event is processed. This should help with
> > > >       disconnected ports generating alot of data and consuming memory for
> > > >       events when kseriod gets behind and prevents constant rescans.
> > > >       This also allows to remove special check for 0xaa in reconnect path
> > > >       of interrupt handler known to cause problems with Toshibas keyboards.
> > >
> > > Ok. Since we'll be usually scanning an empty list, this shouldn't add
> > > any overhead.
> >
> > Plus serio events are rare so unless there are "runaway" serio interrupt this
> > patch tries to procet from there shoudl not be pretty much any overhead.
> 
> Indeed.
> 
> > > Btw, why do we need _both_ to scan for duplicate events on event
> > > completion and check at event insert time? One should be enough - if we
> > > always check, then we cannot have duplicate events and if we always are
> > > able to deal with them, we don't have to care ...
> >
> > A duplicate event can be queued while kseriod was processing current event,
> > checking for a dupe is cheaper then doing duplicate work we'd just done and
> > the list is most likely empty anyway.
> 
> Yes. So I'd probably drop the check when we're inserting the event?
>

No because (potentially) while kseriod is busy waiting on semaphore or
doing something else psmouse with synaptics touchpad can generate
rescan events at rate of 480 events/sec consuming memory for no good
reason.
 
> 
> I think it could be done by marking the port dead, but still leaving it
> there when the module exits, but it's probably not worth it.
> 

Then you would have to have 2 separate paths for hardware cleanup on
unload and for cleanup on driver disconnect...

-- 
Dmitry
