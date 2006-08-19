Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWHSAKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWHSAKB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWHSAKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:10:01 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3793 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751591AbWHSAKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:10:00 -0400
Date: Fri, 18 Aug 2006 17:09:45 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       mingo@redhat.com, apw@shadowen.org
Subject: Re: [patch] sched: generic sched_group cpu power setup
Message-Id: <20060818170945.43ced12b.pj@sgi.com>
In-Reply-To: <20060818154230.A23214@unix-os.sc.intel.com>
References: <20060815175525.A2333@unix-os.sc.intel.com>
	<20060815212455.c9fe1e34.pj@sgi.com>
	<20060816104551.A7305@unix-os.sc.intel.com>
	<20060818142347.A22846@unix-os.sc.intel.com>
	<20060818152954.1ef5aa34.pj@sgi.com>
	<20060818154230.A23214@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If any one has a better suggestion, I am open.

I'm still trying to figure out what the hell it is ;).

Sorry ... as my teenage son would gladly tell you, I can be dense
at times.

If all the CPUs in a system have the same computational capacity,
then is it just the number of CPUs in a group (times a scale factor
of 128, to simulate fixed point arithmetic with integers)?

I presume "yes", from such code lines as:

  power = SCHED_LOAD_SCALE * cpus_weight(sd->groups->cpumask);

If two CPUs, side by side, have the same computational capacity,
but one consumes more electrical power (watts) than the other, do they
have different cpu_power?

I presume "no" - electrical power consumption does not affect this value
(though some effort might be made to minimize electrical power consumption
in these calculations, by letting some CPUs go idle if the job mix allows
for that.)

If I presumed correctly, then apparently what we're talking about here
is computational capacity, as is typically measured in such units as
MIPS, megaflops/sec or Drystones. In other words, what Andrew termed
"computing power" when he fired the starter's pistol on this scrum.

Is that what this is -- computational capacity, aka computing power
(appropriately scaled for the convenience of the arithmetic)?

And is the unit of measure just the number of CPUs in the group
(times 128)?

If the above is accurate, then the group structure member could almost
be called "ncpus" (number of cpus in group), unscaled.  Perhaps you
only need to scale the value for fixed point arithmetic while calculating
what balancing to attempt.

One more  detail, as you likely already noticed, if you rename
"cpu_power" to not mention "power", then consider also the routine 
init_numa_sched_groups_power(), the variables pwr_now, pwr_move and
power, and the mentions of "power" in the comments.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
