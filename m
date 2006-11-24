Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934478AbWKXUh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934478AbWKXUh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935051AbWKXUh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:37:56 -0500
Received: from cantor2.suse.de ([195.135.220.15]:61620 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S934478AbWKXUhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:37:55 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
Date: Fri, 24 Nov 2006 21:37:38 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>
References: <20061124170246.GA9956@elte.hu> <200611241813.13205.ak@suse.de> <20061124202514.GA7608@elte.hu>
In-Reply-To: <20061124202514.GA7608@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611242137.39012.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> yeah - the main new bit for x86-64 is the unconditional check for time 
> warps. We shouldnt (and cannot) really trust the CPU and the board/BIOS 
> getting it right. There were always some motherboards using Intel CPUs 
> that had the TSCs wrong.

In the 64bit capable generation I don't know of any run in spec 
(except for multinode systems and there was one overclocked
system where the cores got unsync, but overclocking is an operator error) 
 
> > > The new code only checks for TSC asynchronity - and if it can prove 
> > > a time-warp (if it can observe the TSC going backwards when going 
> > > from one CPU to another within a critical section), then the TSC 
> > > clock-source is turned off.
> > 
> > The trouble is that people are using the RDTSC anyways even if the 
> > kernel doesn't. So some synchronization is probably a good idea.
> 
> which apps are using it? It might be safer in terms of app compatibility 
> if we removed the TSC bit in the case where we know it doesnt work, and 
> if we turned the feature off in the CPU in this case. We could also try 
> to 'approximately' sync up the TSC, 

There was a patch from google for trap -- trapping RDTSC for syncing
on demand. I'm not sure that was the right strategy though.

> but that obviously cannot be used  
> for kernel timekeeping - and by offering an 'almost' good TSC to 
> userspace we'd lure them towards using something we /cannot/ fix.

The trouble is that it's good enough on many systems, probably 
on those that are being developed on.

Anyways I don't feel very strongly about this -- i guess taking
it out would be fine.
 
> nor can the TSC really be synced up properly in the hotplug CPU case, 
> after the fact - what if the app already read out an older TSC value and 
> a new CPU is added. If the TSC isnt sync on SMP then it quickly gets 
> pretty messy, and we should rather take a look at /why/ these apps are 
> using RDTSC.

Because gettimeofday is too slow.
-Andi
