Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUIONOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUIONOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUIONOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:14:55 -0400
Received: from soundwarez.org ([217.160.171.123]:42113 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S265973AbUIONOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:14:08 -0400
Date: Wed, 15 Sep 2004 15:14:11 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Tim Hockin <thockin@hockin.org>
Cc: Greg KH <greg@kroah.com>, Robert Love <rml@ximian.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915131411.GA21156@vrfy.org>
References: <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org> <20040915011146.GA27782@hockin.org> <1095214229.20763.6.camel@localhost> <20040915031706.GA909@hockin.org> <20040915034229.GA30747@kroah.com> <20040915044830.GA4919@hockin.org> <20040915050904.GA682@kroah.com> <20040915062129.GA9230@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915062129.GA9230@hockin.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 11:21:29PM -0700, Tim Hockin wrote:
> On Tue, Sep 14, 2004 at 10:09:04PM -0700, Greg KH wrote:
> > > > > As much as we all like to malign "driver hardening", there is a *lot* that
> > > > > can be done to make drivers more robust and to report better diagnostics
> > > > > and failure events.
> > > > 
> > > > I agree.  But this interface is not designed or intended for that.  
> > > 
> > > Right.  I originally asked Robert if there was some way to make this
> > > interface capable of handling that, too.  Maybe the answer is merely "no,
> > > not this API".
> > 
> > Seriously, that's not what this interface is for.  This is a simple
> > event notification interface.
> 
> Well, this API is not far from "good enough".  It's meant to be a "simple
> event system" but with a few expansions, it can be a full-featured event
> system :)  And yes, I know the term "feature creep".
> 
> > > > You are correct.  I also would like to see a way ECC and other types of
> > > > errors and diagnostics be sent to userspace in a common and unified
> > > > manner.  But I have yet to see a proposal to do this that is acceptable.
> > > 
> > > Well, let's open that discussion, then! :)  What requirements do you see?
> > > 
> > > Basically, they need to be exactly like this, except there needs to be
> > > some amount of buffering of messages (somehow) and they need a data
> > > payload.
> > 
> > Sounds good to me.
> 
> So what if the actual event system had a payload, and simple events don't
> use it, and complex events do?  Or what if there were an exactly analogous
> API for messages with payloads?
> 
> > > Really, other than payload, why NOT use this API for ECC and driver
> > > faults?
> > 
> > The payload is a pretty good reason why to not use this right now.  No
> > one has proposed a way to handle such a payload in a sane manner.
> 
> What's insane about a string payload?  Or rather, what are your objections
> to saying that the payload string format is entirely dependant on the
> {source, event} tuple?
> 
> ACPI events might come out of a kobject "/sys/devices/acpi" with an event
> "event" and payload "button/power 00000000 00000001" or whatever the
> actual values work out to be.
> 
> What's insane about that?  Currently we have a separate /proc/acpi/event
> file which spits out "button/power 00000000 00000001".
> 
> > > ACPI *has* it's own event system.  It's fine, but it's Yet Another Event
> > > System.
> > 
> > Yeah, it's pretty old too, that's why it is the way it is.
> 
> But semantically, it's the same as this new API (I think), just less
> elegant.
> 
> > > Again, other than payload, why NOT use this API for ACPI?
> > 
> > Again, the payload is the big thing, right?
> 
> Yes, the payload is the big thing (that I see).  I'm not sure if you're
> posing this as in "See, it needs a payload so we don't want it." or "If we
> find a way to do a payload sanely, will you shut up?".

The problem here is that the current picture is merely a sysfs notification
(like a hotplug event is) and we really don't want to use that for error
handling and other things, that needs a reliable form of communcation.
Here we should consider a new transactional interface which can also carry
binary snapshot data from the drivers.
This is a complete different use and should have something like a event
filesystem (relayfs?) or similar and not in any kind something like the here
proposed printk fallback.

For the hotplug event we use a kind of "payload". It's just the already
computed list of '\0'-terminated environment strings, cause we need to know,
what subsystem we are working on and need the hotplug sequence number.
But hotplug is some special kind of event and every event is still strongly
tight to a sysfs device and all "real data" is available from the device
itself.

The same for the mount event, we don't want to carry any specific data,
cause the real data is already available in /proc/mounts, we just want to
know about the device state change. Then we can reread that data, instead
of constantly polling for it.

Yeah, for the ACPI event, I see that it would be possible to use the
payload model, like we use for the hotplug event, but if we open that in
general to the public, I expect something like printk over netlink.
>From my point of view, the kobject, an event is generated for, should be
a "real" device and never a whole subsystem. As long as ACPI can _not_ send
events for specific sysfs devices, I'm not for using kobject_uevent.

Thanks,
Kay

