Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVAPGmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVAPGmc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 01:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVAPGmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 01:42:31 -0500
Received: from ozlabs.org ([203.10.76.45]:65411 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262435AbVAPGmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 01:42:24 -0500
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, manpreet@fabric7.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <20050116053424.GB2489@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de>
	 <1105765760.12263.12.camel@localhost.localdomain>
	 <20050115052311.GC22863@wotan.suse.de>
	 <1105774495.12263.21.camel@localhost.localdomain>
	 <20050115075946.GA28981@wotan.suse.de>
	 <1105849247.5711.4.camel@localhost.localdomain>
	 <20050116053424.GB2489@wotan.suse.de>
Content-Type: text/plain
Date: Sun, 16 Jan 2005 17:42:02 +1100
Message-Id: <1105857722.24045.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 06:34 +0100, Andi Kleen wrote:
> On Sun, Jan 16, 2005 at 03:20:47PM +1100, Rusty Russell wrote:
> > But adding a bizarro "pre-prepare" notifier verged on nonsensical 8(.  I
> 
> I don't see the big issue. Preparse is just not as early as you thought.

State machine for non-boot CPUs currently goes:

 ------------
|            v
|	CPU_UP_PREPARE <-----
|	     |		     |
|	     v		     |
|	__cpu_up() ---> CPU_UP_CANCELED
|	     |
|	     v
|	CPU_ONLINE
|	     |
|	     v
|	CPU_DOWN_PREPARE <----
|	     |		      |
|	     v	              |
|	__cpu_down()---> CPU_DOWN_FAILED
|	     |
|	     v
|	CPU_DEAD
|	     |
 ------------

You've tacked a CPU_UP_PREPARE_EARLY above this state for two
architectures, which only gets called at boot, and only is used by
timers, to fix the fact that those archs don't actually follow this
state machine yet.

And sure enough, you've added a potential bug, since timer_jiffies
doesn't get reset to jiffies when a CPU comes back up.  Really, a
specific hack as below is required.

> > I'm also not clear on why we need to enable interrupts around
> > calibrate_delay() on secondary processors, but I'll try that too and
> > find out 8)
> 
> Because you cannot calibrate the timer without a timer tick.

AFAICT from a quick reading, that's not true.  CPU0 will bump the
jiffies, which is all you need: local interrupts not required.

> Even if you changed that it wouldn't help because the race can
> as well happen in the idle loop on the secondaries.

Again, I don't think so: the other CPUs are sitting in start_secondary()
waiting for __cpu_up().

As I said, I will try it and see.  It would certainly be the nicest
solution.  If not, I'll code a "timer_smp_boot_init()" function for x86
myself.

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

