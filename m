Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263443AbUJ2Uns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263443AbUJ2Uns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbUJ2UjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:39:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:13220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263502AbUJ2UdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:33:07 -0400
Date: Fri, 29 Oct 2004 13:32:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
Cc: Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       roland@topspin.com, Andrew Morton <akpm@osdl.org>
Subject: Re: Consistent lock up 2.6.10-rc1-bk7 (mutex/SCHED_RR bug?)
Message-ID: <20041029133254.P2357@build.pdx.osdl.net>
References: <20041029100646.F14339@build.pdx.osdl.net> <OMEGLKPBDPDHAGCIBHHJEEMOFCAA.aathan-linux-kernel-1542@cloakmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OMEGLKPBDPDHAGCIBHHJEEMOFCAA.aathan-linux-kernel-1542@cloakmail.com>; from aathan-linux-kernel-1542@cloakmail.com on Fri, Oct 29, 2004 at 01:44:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew A. (aathan-linux-kernel-1542@cloakmail.com) wrote:
> 
> chrt 25 bash

Try 99.

> Shell remains as badly hung as everything else.  The code sets the SCHED_RR priority of the task and threads in tt1 to 10.  I'm left
> thinking:  Shouldn't the system be scheduling the shell?  Is this a problem with priority inversion due to 2+ threads doing the
> lock()/unlock() dance and never giving the bash a chance to run?  Is the system able to schedule signal and/or select wakeups (for
> bash) in this condition?

Not knowing what tt1 is doing it's hard to say.  Ah, I missed the
priority you used, so 99 above shouldn't be needed.

> Thanks, I wasn't aware of the chrt command and had only been using nice on my shell.  The man pages on all this stuff are rather
> confusing:  Which priority numbers are valid, how priorities interact, negative vs. positive priorities, process vs. thread
> priority, what is a "dynamic" vs. "static" priority, etc.

Dynamic is adjusted by the behaviour (using up timeslice, blocking,
waiting to run) or by nice.  Static is the base value used when figuring
out what the dynamic should be (can be changed via nice or setpriority).
IIRC, realtime priorities effectively stay static (unless changed
via sched_setscheduler).  The dynamic priority is what's used in
scheduling decisions.  The userspace interfaces are a bit confusing.
The kernel keeps track of it a bit more simply.  Internally, the
priority ranges between 0 and 139 (0 is highest priority).  0-99 are for
realtime tasks, and 100-139 are for normal tasks (note how the top 40
priorties can map to nice values -- where -20 == 100, and 19 == 139).
The nice(2) (and setpriority(2)) interface lets you adjust the static
priority in that upper range (and the dynamic changes accordingly).
The sched_setscheduler(2) ranges for realtime [1, 99] map exactly inverted
to the kernels priority (so while the syscall has 99 as highest priority,
that becomes 0 internally).

> My impression after re-re-read reading the man pages was that it would be sufficient to have a non SCHED_RR shell with a high enough
> nice value.

High enough priority set via sched_setscheduler(2), not nice value.
nice [1, 19] actually lowers your priority, while [-20, -1] increases it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
