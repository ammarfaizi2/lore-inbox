Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVAVCiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVAVCiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 21:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVAVCiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 21:38:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:22954 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262647AbVAVCiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 21:38:51 -0500
Date: Fri, 21 Jan 2005 18:38:50 -0800
From: Chris Wright <chrisw@osdl.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Thoughts about capabilities and prototype patch for user-capabilities
Message-ID: <20050121183849.R469@build.pdx.osdl.net>
References: <1106359723.702.42.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1106359723.702.42.camel@boxen>; from alexn@dsv.su.se on Sat, Jan 22, 2005 at 03:08:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Nyberg (alexn@dsv.su.se) wrote:
> I recently had an idea of having something similar
> to /etc/user_capabilites which would consist of
> username:CAP_CHOWN,CAP_SOMETHING,CAP_SOMETHING2

pam_cap should do this (alas due to brokeness of current scheme it
doesn't).

> This could very well be loaded into linux at the time of an application
> doing sys_setuid, sys_setreuid and the likes by hooking into glibc. The
> kernel also requires a small patch which I'll inline below for comments.
> I sure would use some of these capabilities on my user. And they could
> be used to solve things like a certain program/user needs to use
> real-time scheduling (just something like CAP_SCHED allowing arbitray
> scheduling or CAP_MEMLOCK allowing a user to lock memory. This would
> solve some of the old problems).

ITYM CAP_IPC_LOCK and CAP_SYS_NICE.  The ability to mlock is already
controlled by an rlimit, so the capability is not needed except as an
override.  As for scheduling, this is being actively worked on.  I have
a patch to make scheduling controlled by rlimits as well, and Ingo and
Con are working on scheduler modifications that may allow low-latency
for normal unprivilged users.

> I haven't looked into making capability bits for certain files, mostly
> cause I don't know vfs much and also I don't see this colliding with it,
> I think both should exist. 

This work has been done a few times, but never got much traction mainly
due to the complexity of managing such a scheme.

> I don't know what the plans are for capabilities in the future but there
> are quite some shortcomings in the current implementation. I think it at
> least should allow to set/get capabilites of process ids, user ids and

Olaf Dietsche posted a patch recently that allows you to do this as well,
you might look at that.  It's a bit different approach, but all of these
are working around the fact that it's simply broken right now.

> group ids. These are the things that come to my mind directly. I also
> see that 28 of the 32 currently possible slots are taken which will be a
> problem if capabilities are ever gonna get serious.

Actually we just added two more.  Yes we're against the edge.  FreeBSD
went straight to 64 bits.  That's probably the easiest transistion.
Of course, there's also the problem that some capabilities are so broad
as to be meaningless for privilege separation.

> While looking at it today I noticed user-space over here doesn't even
> seem to have macros/functions to set/test/clear bits in the blackboxed
> types which means anyone want to use it will be exposed to the raw
> structure.

Check libcap, there's quite a few functions for handling that.

> So I'm curious of what the thoughts are for capabilities, are they gonna
> go away some day in the future? I hope not, I think the idea is simple
> and good but something needs to be done about the implementation to
> allow it to be of full use. And yes, I volunteer, but I'm not all sure
> about which direction has been discussed and where this is going.

The biggest thing to fix right now is the fact that you can't allow
capabilities to be inherited as they should be.  This is what makes them
of very limited use.

> Below you will find a test program and at the bottom a patch which allows
> a priviledged user to set the capabilities of another user (i386 only). 
> Setting capabilities on groups does not work, it requires some more code
> (I don't think much though).

This is potentially quite risky.  In fact, the underlying ability is
there already (in capset), but the required privilege has been removed
(CAP_SETPCAP).  As for the syscalls, don't think we want to add them or
this type of functionality now.  We're better off fixing what we have
instead of adding more features.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
