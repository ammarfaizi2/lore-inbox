Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQKCEiv>; Thu, 2 Nov 2000 23:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129034AbQKCEil>; Thu, 2 Nov 2000 23:38:41 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:163 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129073AbQKCEie>; Thu, 2 Nov 2000 23:38:34 -0500
Date: Thu, 02 Nov 2000 20:35:42 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: PATCH 2.4.0.10: Update hotplug
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <00fe01c0454f$872bee30$6500000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <007401c04527$dc094510$6500000a@brownell.org>
 <3A020920.4559F400@mandrakesoft.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     - Changing /sbin/hotplug invocations ... now it can
> >       only support "add" and "del" events.  (USB now
> >       uses "add" and "remove", though "remove" doesn't
> >       try to do anything yet.)
> > 
> >       This removes the intended flexibility whereby
> >       different subsystems (such as networking) can
> >       define their own events.
> 
> Wrong.  Different subsystems -do- define their own events. 

I can't read your documentation that way, and you changed
some code that currently passes arbitrary event names into
code that passes magic numbers (0/1 for add/del).


>     However,
> different subsystems should use the same verbs for the same actions.
> We need consistency where possible.

So why change how it's _already_ being done?  And why change
the current policy about the use of /sbin/hotplug parameters?
(Described in kmod.c and the link from HOTPLUG config help.)

It's not that change is bad, but without motivation this one
seems to be gratuitous.  Why impose conversion costs, then?


> >     - "/sbin/hotplug net ..." replaced by "/sbin/network",
> >       with two custom event types.
> 
> Hotplug device insertion and network interface addition/removal are two
> fundamentally different things. 

No, they're the same thing at different levels.  It's telling
a subsystem to react to some entity that wasn't there before,
or which is going away:  hot plugging and unplugging.

You can easily see this by considering what happens when you
connect a USB network adapter.  (Similarly for a Cardbus one.)
Two invocations are needed:

    - From the USB subsystem:  "/sbin/hotplug usb add" tells
      usermode USB tools about the new USB device entity.

      At this level, tools know they _may_ need to choose and
      load a (network) driver; or, it might be in the kernel
      already, needing special setup (maybe load microcode
      or start a special service).  In this case, the driver
      creates a new network interface entity.

    - From the network subsystem:  "/sbin/hotplug net add"
      tells usermode networking tools about the new interface.

      At this level, tools know they may need to activate an
      existing configuration ("ifup eth0") or perhaps alert
      a sysadmin to create a new config.

They're just different subsystems; the "new thing!" alert is
the same event role in both cases.  No matter that the "thing"
differs (USB device vs. network interface) and that the event
receiver differs (USB tools vs. network tools).

If there is going to be any abstraction at all, it's got to be
blind to those particular details ... else every new subsystem
and device type will get new hotplug commands in /sbin and in
/proc/sys/kernel, with eventual chaos.


>     Further, my code purposefully does not
> wrap CONFIG_HOTPLUG around the /sbin/network code,

As we discussed separately, the CONFIG_{HOTPLUG,KMOD} coupling
there isn't quite separable because of how kmod works today.

You'll need CONFIG_HOTPLUG and CONFIG_KMOD unless you shift
some of the guts of kmod; which should happen, but maybe now
isn't the right time for that.


>     because /sbin/network
> has utility outside the domain of hotplug.

Again, not according to the documentation you included; but
then, it doesn't really talk about /sbin/network except to
say that it's used to report additions/removals.  Which is
what /sbin/hotplug was defined to handle ... :-)

- Dave





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
