Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVAMRzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVAMRzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVAMRxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:53:35 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:12926 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261256AbVAMRwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:52:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=D9ZK7YGLCJA0WmbdCdTkchHk0h4VQoUBj26TXavx2F+OCiQFKsAGxGNS+iZGJ6cVtTyKzlLC/2eKOt2EiiR6t20+YGeKQ4/Xa4dRhmpietvcM0+KAdKifHfQtXxqY/7tmhIsVAkuwaK5d8Zc3pjRZbfgUz/0ujLF0OLLbQXhNYU=
Message-ID: <d120d50005011309526326afef@mail.gmail.com>
Date: Thu, 13 Jan 2005 12:52:14 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/16] New set of input patches
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113153644.GA18939@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412290217.36282.dtor_core@ameritech.net>
	 <20050113153644.GA18939@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 16:36:44 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Wed, Dec 29, 2004 at 02:17:36AM -0500, Dmitry Torokhov wrote:
> >
> > 01-i8042-panicblink-cleanup.patch
> >       Move panicblink parameter definition together with the rest of i8042
> >       module parameters, add description and entry in kernel-parameters.txt
> 
> I think I prefer the DELAY definition to be outside the function. Other
> than that the patch is OK.
 
Will do.

> > 02-serio-start-stop.patch
> >       Add serio start() and stop() methods to serio structure that are
> >       called when serio port is about to be fully registered and when
> >       serio port is about to be unregistered. These methods are useful
> >       for drivers that share interrupt among several serio ports. In this
> >       case interrupt can not be enabled/disabled in open/close methods
> >       and it is very hard to determine if interrupt shoudl be ignored or
> >       passed on.
> 
> > 03-i8042-use-start-stop.patch
> >       Make use of new serio start/stop methods to safely activate and
> >       deactivate ports. Also unify as much as possible port handling
> >       between KBD, AUX and MUX ports. Rename i8042_values into i8042_port.
> 
> Would we need this at all if we made the port registration completely
> asynchronous, only binding devices to ports _after_ the port is
> completely registered?
> 
> I'm rather reluctant to add even more callbacks.
> 

The problem is not with binding devices, it is with mostly with
sharing the same IRQ between different ports.

Look at the MUX case, you have 4 ports all sharing the same IRQ. At
startup i8042 enables all on-chip ports and registers them with
serio_register_port(). When first serio driver class i8042_open it
installs IRQ handler. All 4 ports are enabled now (because we want to
do hot-plug) but, especially with async. serio registration, only the
first is fully registered with serio subsystem. If data was to come
from any other port the shared IRQ handler will call serio_reconnect
on half-alive port. The similar issues happen when you try to
unregister port.

With start/stop methods allow serop core signal driver that the port
is fully registered and now is safe to use. If IRQ is not shared
between ports one can safely register/unregister handler in open/close
methods (at the expense of hotplug device support) but with shared IRQ
you need additional callbacks.

> > 04-serio-suppress-dup-events.patch
> >       Do not submit serio event into event queue if there is already one
> >       of the same type for the same port in front of it. Also look for
> >       duplicat events once event is processed. This should help with
> >       disconnected ports generating alot of data and consuming memory for
> >       events when kseriod gets behind and prevents constant rescans.
> >       This also allows to remove special check for 0xaa in reconnect path
> >       of interrupt handler known to cause problems with Toshibas keyboards.
> 
> Ok. Since we'll be usually scanning an empty list, this shouldn't add
> any overhead.

Plus serio events are rare so unless there are "runaway" serio interrupt this
patch tries to procet from there shoudl not be pretty much any overhead.

> Btw, why do we need _both_ to scan for duplicate events on event
> completion and check at event insert time? One should be enough - if we
> always check, then we cannot have duplicate events and if we always are
> able to deal with them, we don't have to care ...

A duplicate event can be queued while kseriod was processing current event,
checking for a dupe is cheaper then doing duplicate work we'd just done and
the lis is mostr likely empty anyway.

> 
> Already merged.
> 
> > 09-i8042-sysfs-permissions.patch
> >       Fix braindamage in sysfs permissions for 'debug' option.
> 
> OK.

This one has already been merged as well I think.

> 
> > 14-serio-id-match.patch
> >       Replace serio's type field with serio_id structure and
> >       add ids table to serio drivers. This will allow splitting
> >       initial matching and probing routines for better sysfs
> >       integration.
> 
> OK. Maybe we should add a new SPIOCSTYPE ioctl to pass the structure
> directly.

I am not sure it is needed ATM and I am a bit fuzzy on 32/64 bit ioctl
issues so I'll leave it alone for now ;)
 
> 
> > 15-serio-bus-cleanup.patch
> >       Make serio implementation more in line with standard
> >       driver model implementations by removing explicit device
> >       and driver list manipulations and introducing bus_match
> >       function. serio_register_port is always asynchronous to
> >       allow freely registering child ports. When deregistering
> >       serio core still takes care of destroying children ports
> >       first.
> 
> OK. I suppose the synchronous unregister variant is needed for module
> unload? I suppose refcounting would be enough there ...

I don't see how. Kobject refcounting protects data structures but not
code and I can't bump up module's reference count in module_exit
function to delay its removal and we do not want to take module's
reference for every registered port otherwise unload will not be
possible. That's why synchronous removal method is needed.

-- 
Dmitry
