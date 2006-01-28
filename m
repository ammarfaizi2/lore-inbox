Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWA1HEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWA1HEk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 02:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWA1HEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 02:04:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:1761 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932531AbWA1HEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 02:04:39 -0500
Date: Fri, 27 Jan 2006 23:04:29 -0800
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: steiner@sgi.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       rml@novell.com
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-Id: <20060127230429.4af008fb.pj@sgi.com>
In-Reply-To: <20060128052355.GC18730@localhost.localdomain>
References: <20060127230659.GA4752@sgi.com>
	<20060127191400.aacb8539.pj@sgi.com>
	<20060128034241.GB18730@localhost.localdomain>
	<20060127205834.b5821a02.pj@sgi.com>
	<20060128052355.GC18730@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> I'm only recommending not changing the current behavior of
> sched_getaffinity.

Jack is essentially recommending -unchanging- the behaviour of
sched_getaffinity.  CONFIG_HOTPLUG_CPU changed it, as an unintended
side affect, and Jack is asking if we should revert that change.

Prior to CONFIG_HOTPLUG_CPU, on (for example) an ia64 SN2, which is
compiled with 512 or 1024 NR_CPUS, the sched_getaffinity call returned
at most the number of CPUs set as were online.

For example, on an 8 CPU SN2 system (compiled NR_CPUS 512) that is at
hand to me right now, compiled without CONFIG_HOTPLUG_CPU, the command:
	strace -etrace=sched_getaffinity taskset -p $$

produces the strace output:
	sched_getaffinity(13282, 128,  { ff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }) = 128

and produces the taskset output:
	pid 13282's current affinity mask: ff

(why the particular taskset binary I am invoking is compiled
for just 128 CPUs beats me ;).

This is the sort of behaviour that apps might have become to
expect.  And it is not clear that apps would clearly distinguish
between CPUs online at the moment, and possibly online after
some future hotplug event.  Given the paucity of hotpluggable
CPUs, it is a safe bet most apps doing this have not clearly
distinguished these two cases.

Now when we introduce CONFIG_HOTPLUG_CPU, as Jack reports, this
set_getaffinity call is returning with all bits set (Jack was
apparently using a sched_getaffinity call from an app compiled
for 1024 CPUs, on a 512 NR_CPUS kernel):

	(from strace on a 2 cpu system with NR_CPUS = 512)
	sched_getaffinity(0, 1024,  { ffffffffffffffff, ffffff ...

This will break code that thinks this return means that there are
actually available, right now, all those CPUs.

The addition of CONFIG_HOTPLUG_CPU has changed the apparent (what
-seems- to be happening) behaviour of sched_getaffinity.  Without
it, on a small system running a big NR_CPUS kernel, just a small
number of bits were set.  With it, all the bits are set.

We need to choose, with the advent of hotplug, whether the
sched_getaffinity means:
 1) at most, the CPUs online now, or
 2) at most, all possible online CPUs.

This choice did not exist before.  I recommend choosing the way that
will be the "least surprising" to existing code.  I believe that this
would be (1) the CPUs online now, as Jack's patch accomplishes.

We should not stumble blindly into changing the behaviour of a system
call in an effort to seem to avoid changing it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
