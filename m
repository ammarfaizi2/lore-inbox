Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVIKXCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVIKXCa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 19:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVIKXCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 19:02:30 -0400
Received: from colin.muc.de ([193.149.48.1]:28424 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751071AbVIKXC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 19:02:29 -0400
Date: 12 Sep 2005 01:02:20 +0200
Date: Mon, 12 Sep 2005 01:02:20 +0200
From: Andi Kleen <ak@muc.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/14] x86_64: Use common functions in cluster and physflat mode
Message-ID: <20050911230220.GA73228@muc.de>
References: <200509032135.j83LZ8gX020554@shell0.pdx.osdl.net> <20050905231628.GA16476@muc.de> <20050906161215.B19592@unix-os.sc.intel.com> <Pine.LNX.4.61.0509091003490.978@montezuma.fsmlabs.com> <20050909134503.A29351@unix-os.sc.intel.com> <Pine.LNX.4.61.0509091439110.978@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509091439110.978@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 09:44:16AM -0700, Zwane Mwaikambo wrote:
> On Fri, 9 Sep 2005, Ashok Raj wrote:
> 
> > In general we need
> > 
> > flat_mode - #cpus <= 8 (Hotplug defined or not, so we use mask version 
> >                        for safety)
> > 
> > physflat or cluster_mode when #cpus >8.
> 
> I agree there.
> 
> > If we choose physflat as default for #cpus <=8 (with hotplug) would make
> > IPI performance worse, since it would do one cpu at a time, and requires 2 
> > writes per cpu for each IPI v.s just 2 for a flat mode mask version of the API.
> 
> I don't see the benefit then :/ I certainly hope we don't go that route.

I originally made that objection, but Ashok then did some benchmarks
that showed essentially no difference. I can see the point - it's 
likely that an access to the local APIC (which is in the CPU) is fast
(we know it is) and all the time is dominated by sending the 
requests over the wires between the CPUs. So it shouldn't matter 
much if you use sequence mode or masks.

That is why I changed my mind and just made physflat default for the hotplug
case (which will be essentially everywhere because I expect most kernels
to have hotplug enabled in the future) 

It's a bit of a mess in mm right now because me and Ashok have been fixing 
similar problems in a different way (e.g. the patch in flat to
use the sequence sending path is also not needed anymore with that) 
Need to clean this up a bit.

Handling it properly for i386 is also still needed e.g. the older physflat
patch I did needs to be merged with bigsmp and cleaned up a bit.
But I don't have time to do it before monday so it'll miss the 2.6.14
window anyways.

-Andi
