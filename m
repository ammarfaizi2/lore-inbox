Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVDZHQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVDZHQB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVDZHOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:14:53 -0400
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:61388 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261379AbVDZHOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:14:15 -0400
Subject: Re: [linux-pm] Re: [PATCH] PCI: Add pci shutdown ability
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Adam Belay <ambx1@neo.rr.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alexn@dsv.su.se, gud@eth.net, Adam Belay <abelay@novell.com>,
       Dave Jones <DaveJ@redhat.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Jeff Garzik <jgarzik@pobox.com>, cramerj@intel.com
In-Reply-To: <20050426062314.GC3951@neo.rr.com>
References: <1114458325.983.17.camel@localhost.localdomain>
	 <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
	 <20050425145831.48f27edb.akpm@osdl.org> <20050425221326.GC15366@redhat.com>
	 <20050425232330.GG27771@neo.rr.com> <1114489949.7111.43.camel@gaston>
	 <20050426062314.GC3951@neo.rr.com>
Content-Type: text/plain
Message-Id: <1114499693.30859.151.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 26 Apr 2005 17:14:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-04-26 at 16:23, Adam Belay wrote:
> Ok, here's a new idea.
> 
> For many devices "->suspend" and "->resume" with pm_message_t is exactly what
> we need.  However, as we support more advanced power management features, such
> as runtime power management, or power containers, we need something a little
> more specific.  The exact power state must be specified among other issues.
> 
> We might do something like this:
> 
> Keep "->suspend" and "->resume" around unchanged. (so the states would
> probably remain as PMSG_FREEZE and PMSG_SUSPEND).  If the driver doesn't
> support the more advanced PM methods just use these.  They work well enough
> for system sleep states etc.

Ok, so for each driver we have either ->suspend & ->resume or
->change_state, ->halt and ->continue, right?

Is it safe to assume that these later methods would get called from the
same places in device_suspend and device_resume that ->suspend &
->resume are called from at the moment? That would seem to me to be the
cleanest way of addressing ordering ... but then I find myself asking,
why not just do one or the other?

I have to admit that I've never liked ->suspend & ->resume. They imply
too much knowledge in the caller about what start the device was in. I'd
like, instead, to see all of the decision making as to what state to
actually be in exist in the driver and the helpers it uses. Then the
semantics becomes requests and notifications of system/child/parent
state changes rather than _commands_ to suspend/resume. This should be a
lot cleaner in the context of runtime power management as well.

> When changing system state, we call "change_state" for every device with power
> resources.  Devices that do not directly consume power or have power states
> will not implement "change_state" so we will call "halt" and "continue"
> instead.

Now you're confusing me...

if (driver->suspend | driver->resume)
	driver->suspend|resume
elseif (driver->change_state)
	driver->change_state
elseif (driver->halt | driver->continue)
	driver->halt|continue
else
	printk("Urgh. No driver power management methods for %s.\n");


> When shutting down the system, halt has the option of turning off the device,
> as it will see the SHUTDOWN reason.  So it's a driver-knows-best approach
> instead of assuming everything must be turned off, or everything must just be
> stopped.

I do like this idea. Especially if we can say "I'm rebooting rather than
powering off."

> So in theory, with cpufreq, we could stop userspace, ->halt every device
> (drivers won't do anything if they know it's not necessary), change the
> frequency, and then resume operation.

That looks like a good idea too. But it also sounds like an abuse of
suspend|resume. Perhaps it implies the need/desire for more genericness
to pm_message_t (sounds familiar!).

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

