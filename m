Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265449AbTFMRUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbTFMRUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:20:03 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:58022 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265449AbTFMRTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:19:54 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Steven Dake <sdake@mvista.com>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Date: Fri, 13 Jun 2003 19:32:44 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <3EE8D038.7090600@mvista.com> <200306130027.09288.oliver@neukum.org> <3EE9F5C7.8070304@mvista.com>
In-Reply-To: <3EE9F5C7.8070304@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306131932.44706.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Aside from that, what exactly are you trying to do?
> >You are not solving the fundamental device node reuse race,
> >yet you are making necessary a further demon.
>
> For device enumeration, I see a daemon as necessary.  The main goal of
> this work is to solve the out-of-order execution of sbin/hotplug and
> improve performance of the system during device enumeration with
> significant (200 disks, 4 partitions each) amounts of devices.  Boot
> time with this scheme appears, in my rudimentary tests, to be faster on
> the order of 1-2 seconds for bootup for the case of just 12 disks.  I
> would imagine 200 disks (which I don't have a good way to test, as I
> don't have 200 disks:) would provide better speed gains during bootup.
> This compares greg's original udev to this patched udev binary.

You will not beat a pure devfs solution in terms of speed.
Enumeration is not a real problem. The real target of the hotplug
system is configuration, not enumeration.

> >You are not addressing queue limits. The current hotplug
> >scheme does so, admittedly crudely by failing to spawn
> >a task, but considering the small numbers of events in
> >question here, for the time being we can live with that.
> >
> >You can just as well add load control and error detection
> >to the current scheme. You fail to do so in your scheme.
> >You cannot queue events forever in unlimited numbers.
>
> I agree there should be some way of limiting events.  I'll add this set
> of code.

And you need to report loss of events. Doing this all by ioctls is
very questionable.

> >As for ordering, this is a real problem, but not fundamental.
> >You can make user space locking work. IMHO it will not be
> >pretty if done with shell scripts, but it can work.
> >There _is_ a basic problem with the kernel 'overtaking'
> >user space in its view of the device tree, but you cannot solve
> >that _at_ _all_ in user space.
> >
> >In short, if you feel that the hotplug scheme is inadequate
> >for your needs, then write industry strength devfs2.
>
> devfs is not appropriate as it does not allow for complex policy with
> external attributes that the kernel is unaware of.  For an example, lets
> take the situation where a policy must access a cluster-wide manager to
> determine some information before it can make a policy decision.  For
> that to occur, there must be sockets, and hopefully libc, which puts the
> entire thing in user space.  Who would want to write policies in the
> kernel?  uck.

Then the method of invocation of your configurator will not matter with
regards to speed. Out of order issues matter, but can be solved easier.

It seems to me that you should take a close look at devfs and devfsd.

	Regards
		Oliver

