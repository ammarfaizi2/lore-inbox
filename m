Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVAMThU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVAMThU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVAMTfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:35:34 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:13266 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261409AbVAMTZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:25:15 -0500
Date: Thu, 13 Jan 2005 20:25:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/16] New set of input patches
Message-ID: <20050113192525.GA4680@ucw.cz>
References: <200412290217.36282.dtor_core@ameritech.net> <20050113153644.GA18939@ucw.cz> <d120d50005011309526326afef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005011309526326afef@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 12:52:14PM -0500, Dmitry Torokhov wrote:

> The problem is not with binding devices, it is with mostly with
> sharing the same IRQ between different ports.
> 
> Look at the MUX case, you have 4 ports all sharing the same IRQ. At
> startup i8042 enables all on-chip ports and registers them with
> serio_register_port(). When first serio driver class i8042_open it
> installs IRQ handler. All 4 ports are enabled now (because we want to
> do hot-plug) but, especially with async. serio registration, only the
> first is fully registered with serio subsystem. If data was to come
> from any other port the shared IRQ handler will call serio_reconnect
> on half-alive port. The similar issues happen when you try to
> unregister port.
> 
> With start/stop methods allow serop core signal driver that the port
> is fully registered and now is safe to use. If IRQ is not shared
> between ports one can safely register/unregister handler in open/close
> methods (at the expense of hotplug device support) but with shared IRQ
> you need additional callbacks.

Yes, this can result in calling serio_reconnect on a port that's not
registered yet. But I believe we don't need a callback for this, just a
flag in the serio struct that will say "live", be set during
registration, and until that time all serio_interrupt() calls would be
ignored?

This is transparent to the port drivers, and doesn't change any
interfaces. What do you think?

> > > 04-serio-suppress-dup-events.patch
> > >       Do not submit serio event into event queue if there is already one
> > >       of the same type for the same port in front of it. Also look for
> > >       duplicat events once event is processed. This should help with
> > >       disconnected ports generating alot of data and consuming memory for
> > >       events when kseriod gets behind and prevents constant rescans.
> > >       This also allows to remove special check for 0xaa in reconnect path
> > >       of interrupt handler known to cause problems with Toshibas keyboards.
> > 
> > Ok. Since we'll be usually scanning an empty list, this shouldn't add
> > any overhead.
> 
> Plus serio events are rare so unless there are "runaway" serio interrupt this
> patch tries to procet from there shoudl not be pretty much any overhead.

Indeed.

> > Btw, why do we need _both_ to scan for duplicate events on event
> > completion and check at event insert time? One should be enough - if we
> > always check, then we cannot have duplicate events and if we always are
> > able to deal with them, we don't have to care ...
> 
> A duplicate event can be queued while kseriod was processing current event,
> checking for a dupe is cheaper then doing duplicate work we'd just done and
> the list is most likely empty anyway.

Yes. So I'd probably drop the check when we're inserting the event?

> > > 09-i8042-sysfs-permissions.patch
> > >       Fix braindamage in sysfs permissions for 'debug' option.
> > 
> > OK.
> 
> This one has already been merged as well I think.

Probably yes.

> > > 14-serio-id-match.patch
> > >       Replace serio's type field with serio_id structure and
> > >       add ids table to serio drivers. This will allow splitting
> > >       initial matching and probing routines for better sysfs
> > >       integration.
> > 
> > OK. Maybe we should add a new SPIOCSTYPE ioctl to pass the structure
> > directly.
> 
> I am not sure it is needed ATM and I am a bit fuzzy on 32/64 bit ioctl
> issues so I'll leave it alone for now ;)

OK.

> > > 15-serio-bus-cleanup.patch
> > >       Make serio implementation more in line with standard
> > >       driver model implementations by removing explicit device
> > >       and driver list manipulations and introducing bus_match
> > >       function. serio_register_port is always asynchronous to
> > >       allow freely registering child ports. When deregistering
> > >       serio core still takes care of destroying children ports
> > >       first.
> > 
> > OK. I suppose the synchronous unregister variant is needed for module
> > unload? I suppose refcounting would be enough there ...
> 
> I don't see how. Kobject refcounting protects data structures but not
> code and I can't bump up module's reference count in module_exit
> function to delay its removal and we do not want to take module's
> reference for every registered port otherwise unload will not be
> possible. That's why synchronous removal method is needed.

I think it could be done by marking the port dead, but still leaving it
there when the module exits, but it's probably not worth it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
