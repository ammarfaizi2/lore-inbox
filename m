Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290136AbSAKWYF>; Fri, 11 Jan 2002 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290141AbSAKWXz>; Fri, 11 Jan 2002 17:23:55 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:55199 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S290136AbSAKWXq>; Fri, 11 Jan 2002 17:23:46 -0500
Date: Fri, 11 Jan 2002 13:52:32 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
To: Kevin Easton <s3159795@student.anu.edu.au>, linux-kernel@vger.kernel.org
Message-id: <24b501c19aee$5e2a29c0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <20020108193604.A27539@beernut.flames.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Hopefully, integration of /sbin/hotplug during the boot process (using 
> > > dietHotplug) will reduce the number of things the "coldplug" issue will 
> > > have to handle. 
> > 
> > Somewhat -- though it only handles the "load a module" 
> > subproblem. When new devices need any more setup 
> > than that, "dietHotplug" isn't enough. 
> 
> What if this was handled by the kernel not sending hotplug messages until it
> had been told that the system was ready to load drivers etc.

That would prevent dynamic loading of modules when they're needed
during the early stages of system booting, not just delay the "etc" set of
device setup subproblems.

However, there's already machinery that handles part of that "queue
up hotplug events for later delivery".  The original issue was that when
the network subsystem needed to report hotplug events, it needed to
be able to do it when some locks were held and sometimes even
in_interrupt(), so the "fork a subprocess" work had to be handed off
to some other kernel thread.


> ...or have I totally misunderstood the coldplug problem?

I suspect so.  The kernel's role with hotplug is intentionally limited:  just
tell userland policy agents "here's a device, it may need to be configured".
Configuring devices can be a complex problem, even when the driver is
already linked into the kernel.

The coldplug problem is that it's saying those things before the system
has been brought up far enough that the agents can do anything!  As in,
sometimes even before a root filesystem is mounted, and often before
other filesystems or essential system servcies are available.

So if in those cases the agent notification can't get the device set up,
then some other boot component needs to do that work.  It's better to
have one subsystem (hotplug) handling that consistently, no matter
when the device needs to be set up, than to have different code to
handle "post-boot" (hotplug) and "during-boot" (kudzu etc) cases.
Which is why the "hotplug" tools have a "coldplug" mode too.

To nudge this slightly back towards the original topic, I'll just point
out that doing this "before-boot" (as part of kernel config) is a horse
of a different color, although it needs most of the same metadata from
the kernel.  The device detection has to be done with a tool other than
the running kernel, and it never actually sets up devices for users.
All it cares about is coming up with config flags that cause the
right modules to be built and (statically or dynamically) linked.

- Dave



