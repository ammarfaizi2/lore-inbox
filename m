Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVILWYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVILWYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVILWYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:24:07 -0400
Received: from fmr23.intel.com ([143.183.121.15]:51432 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932310AbVILWYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:24:05 -0400
Date: Mon, 12 Sep 2005 15:23:08 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/14] x86_64: Use common functions in cluster and physflat mode
Message-ID: <20050912152308.A18649@unix-os.sc.intel.com>
References: <200509032135.j83LZ8gX020554@shell0.pdx.osdl.net> <20050905231628.GA16476@muc.de> <20050906161215.B19592@unix-os.sc.intel.com> <Pine.LNX.4.61.0509091003490.978@montezuma.fsmlabs.com> <20050909134503.A29351@unix-os.sc.intel.com> <Pine.LNX.4.61.0509091439110.978@montezuma.fsmlabs.com> <20050911230220.GA73228@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050911230220.GA73228@muc.de>; from ak@muc.de on Mon, Sep 12, 2005 at 01:02:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 01:02:20AM +0200, Andi Kleen wrote:
> On Sun, Sep 11, 2005 at 09:44:16AM -0700, Zwane Mwaikambo wrote:
> > On Fri, 9 Sep 2005, Ashok Raj wrote:
> > 
> > > IPI performance worse, since it would do one cpu at a time, and requires 2 
> > > writes per cpu for each IPI v.s just 2 for a flat mode mask version of the API.
> > 
> > I don't see the benefit then :/ I certainly hope we don't go that route.
> 
> I originally made that objection, but Ashok then did some benchmarks
> that showed essentially no difference. I can see the point - it's 


Just a minor difference is that for a 8 CPU system

Using IPI shortcut uses just 1 write to local apic
Using mask version of broadcast uses 2 writes to local apic

The stat showed no significant difference when we do the 1 extra write. But
that is for the whole system.

When we use send_IPI_mask_sequence() we use 14 writes to (two writes
for each CPU that we need to target a IPI). 

Using the same stats i used earlier, i see about 0x200 - 0x1000 extra cycles 
when using mask_sequence() on certain long runs about 100K samples.

We should probably remove the !HOTPLUG case and just use the mask version
for all cases <=8 CPUS, use physflat or the cluster mode for >8cpus as 
the case may be, instead of defaulting to sequence_IPI which seems
a little overkill for the intended purpose.

> likely that an access to the local APIC (which is in the CPU) is fast
> (we know it is) and all the time is dominated by sending the 
> requests over the wires between the CPUs. So it shouldn't matter 
> much if you use sequence mode or masks.
> 
> That is why I changed my mind and just made physflat default for the hotplug
> case (which will be essentially everywhere because I expect most kernels
> to have hotplug enabled in the future) 
> 
> It's a bit of a mess in mm right now because me and Ashok have been fixing 
> similar problems in a different way (e.g. the patch in flat to
> use the sequence sending path is also not needed anymore with that) 
> Need to clean this up a bit.
> 
> Handling it properly for i386 is also still needed e.g. the older physflat
> patch I did needs to be merged with bigsmp and cleaned up a bit.
> But I don't have time to do it before monday so it'll miss the 2.6.14
> window anyways.
> 
> -Andi

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
