Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUIEMSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUIEMSN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUIEMSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:18:13 -0400
Received: from soundwarez.org ([217.160.171.123]:26790 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S263770AbUIEMSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:18:03 -0400
Date: Sun, 5 Sep 2004 14:18:14 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Robert Love <rml@ximian.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040905121814.GA1855@vrfy.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com> <20040831145643.08fdf612.akpm@osdl.org> <1093989513.4815.45.camel@betsy.boston.ximian.com> <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094353088.2591.19.camel@localhost>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 10:58:08PM -0400, Robert Love wrote:
> On Sat, 2004-09-04 at 02:54 +0200, Greg KH wrote:
> 
> > So, we're back to the original issue.  Why is this kernel event system
> > different from the hotplug system?  I would argue there isn't one,
> > becides the transport, as you seem to want everything that we currently
> > provide in the current kobject_hotplug() call.
> > 
> > But transports are important, I agree.
> > 
> > How about you just add the ability to send hotplug calls across netlink?
> > Make it so the kobject_hotplug() function does both the exec() call, and
> > a netlink call (based on a config option for those people who like to
> > configure such stuff.)
> 
> This smells.
> 
> Look, I agree that unifying the two ideas and transports as much as
> possible is the right way to proceed.  But the fact is, as you said,
> transports _are_ important.  And simply always sending out a hotplug
> event _and_ a netlink event is silly and superfluous.  We need to make
> up our minds.
> 
> I don't think anyone argues that netlink makes sense for these low
> priority asynchronous events.
> 
> I'd prefer to integrate the two approaches as much as possible, but keep
> the two transports separate.  Use hotplug for hotplug events as we do
> now and use kevent, which is over netlink, for the new events we want to
> add.
> 
> Maybe always do the kevent from the hotplug, but definitely do not do
> the hotplug from all kevents.  It is redundant and extra overhead.
> 
> Doing both simultaneous begs the question of why have both.  Picking the
> right tool for the job is, well, the right tool for the job.

Yes, it doesn't make much sense to pipe the kevents through
/sbin/hotplug, but I definitely want the hotplug-events over netlink,
to get rid of the SEQNUM reorder nightmare and unpredictable delay of
the execution of the /etc/hotplug.d/ helpers, we currently can't handle
very well with HAL.

I expect, that we need to have both transports (for hotplug), cause early
boot is unable to react to netlink messages.
The /sbin/hotplug can easily switched off, after some "advanced event daemon"
is running by: "echo -n "" > /proc/sys/kernel/hotplug".

What about moving the /sbin/hotplug execution from lib/kobject.c to
kernel/kobj_notify.c and merge it with our netlink code? This would
separate the "object-storage" from the "object-notification" which is
nice. And we would have a single place to implement all kind of event
transports.
If anybody invents some other kind of transport it can go into
kobj_notify.c. All transports can share some code and are highly
configurable then.

kernel/kobj_notify.c would export:
        kobject_hotplug(const char *action, struct kobject *kobj)
        kobj_notify    (const char *signal, struct kobject *kobj, struct attribute *attr)

lib/kobject.c just calls kobject_hotplug() and we get the event on both
transports at the same time. All other events just use kobj_notify() which
doesn't do /sbin/hotplug.

How does it sound?

Thanks,
Kay
