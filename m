Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUFEGnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUFEGnH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 02:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUFEGnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 02:43:07 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:62952 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262103AbUFEGnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 02:43:02 -0400
Date: Fri, 4 Jun 2004 23:48:26 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604234826.7f13b000.pj@sgi.com>
In-Reply-To: <20040604184214.GJ21007@holomorphy.com>
References: <16576.17673.548349.36588@alkaid.it.uu.se>
	<20040604095929.GX21007@holomorphy.com>
	<16576.23059.490262.610771@alkaid.it.uu.se>
	<20040604112744.GZ21007@holomorphy.com>
	<20040604113252.GA21007@holomorphy.com>
	<20040604092316.3ab91e36.pj@sgi.com>
	<20040604162853.GB21007@holomorphy.com>
	<20040604104756.472fd542.pj@sgi.com>
	<20040604181233.GF21007@holomorphy.com>
	<20040604114219.40e50737.pj@sgi.com>
	<20040604184214.GJ21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 11:42:19AM -0700, Paul Jackson wrote:
> I don't see why user code needs to determine NR_CPUS exactly.

William Lee Irwin III replied:
> Wrong. Apps that want to reconfigure the system to e.g. online more cpus
> in response to heightened load want to know.

Earlier, Andrew Morton wrote:
> Sometimes userspace wants to know NR_CPUS.  Sometimes it wants ...


I disagree, Andrew and William.

What the kernel should provide user space is:

 * cpu_possible_map - which CPU's are possible at all
 * cpu_present_map  - which CPU's are presently plugged in
 * cpu_online_map   - which CPU's are online for scheduling
 * other more specific maps, such as perhaps perfctr stuff
 * the size of these maps, for dynamic allocation

See further the include/linux/cpumask.h file in my recent patch set for
consolidated documentation of these maps.

Currently, in the HOTPLUG configuration, cpu_possible_map happens to be
just all the CPUs from 0 to NR_CPUS-1 (i.e. CPU_MASK_ALL), but that is a
detail of the current implementation that should _not_ be used to drive
the design of what we expose to user space.

The other stuff Andrew mentions, such as max CPU number possible or
whatever, can and should be computed by user space code, from the above.

Just knowing NR_CPUS won't be much use to hotplug user code,
except as an overly specific way to determine the size of these maps.

The size of the CPU maps could be in bytes (the usual sizeof unit) or
for the present format, in number of unsigned longs.  Probably bytes is
less surprising, even though it's slightly overly specified (the bottom
2 or 3 bits will always be zero).

I see no reason why user space needs to distinguish between NR_CPUS == 8
and NR_CPUS == 4, say, beyond what is visible in such maps as above. And
if at any time one of the maps is sparse, then a single small integer
such as NR_CPUS is immediately inadequate.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
