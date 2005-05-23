Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVEWRMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVEWRMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 13:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVEWRMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 13:12:24 -0400
Received: from colin.muc.de ([193.149.48.1]:19466 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261915AbVEWRMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 13:12:14 -0400
Date: 23 May 2005 19:12:12 +0200
Date: Mon, 23 May 2005 19:12:12 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: zwane@arm.linux.org.uk, discuss@x86-64.org, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/4] CPU hot-plug support for x86_64
Message-ID: <20050523171212.GF39821@muc.de>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050523164046.GB39821@muc.de> <20050523095450.A8193@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523095450.A8193@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 09:54:51AM -0700, Ashok Raj wrote:
> On Mon, May 23, 2005 at 06:40:46PM +0200, Andi Kleen wrote:
> > On Fri, May 20, 2005 at 03:16:22PM -0700, Ashok Raj wrote:
> > > Andi: You had mentioned that you would not prefer to replace the broadcast IPI
> > >       with the mask version for performance. Currently this seems to be the
> > > 	  most optimal way without putting a sledge hammer on the cpu_up process.
> > 
> > I already put a sledgehammer to __cpu_up with that last
> 
> Yours was a good sledge hammer :-) the way it should have been done
> but carried legacy boot from i386 that wasnt pretty. The one iam referring
> to is pretty darn slow, and think it wont be liked my many to slow down the
> system just to add a new cpu.
> 
> > patch. Some more hammering surely wouldnt be a big issue. Unlike i386
> > we actually still have a chance to test all relevant platforms, so I 
> > dont think it is a big issue.
> > 
> > What changes did you plan?
> 
> The only other workable alternate would be to use the stop_machine() 
> like thing which we use to automically update cpu_online_map. This means we 
> execute a high priority thread on all cpus, bringing the system to knees before

That is not nice agreed.

> just adding a new cpu. On very large systems this will definitly be 
> visible.

I still dont quite get it why it is not enough to keep interrupts
off until the CPU enters idle. Currently we enable them shortly
in the middle of the initialization (whcih is already dangerous
because interrupts can see half initialized state like out of date TSC),
but I hope to get rid of that soon too. With the full startup
in CLI would you problems be gone?

> 
> Just curious, what performance impact did you allude to that would be lost
> if we dont use the shortcut IPI version?

I am worried about the TLB flush interrupt. I used to have
some workloads in 2.4 that stresses it very badly (e.g. process
with working set just above the physical memory. It would always
fault in new pages while on another CPU kswapd would unmap 
and age pages. Leads to a constant flood of flush IPIs). Another
case is COW in a multithreaded process. You always have to flush
all the other CPUs there.

Even smp_call_function is a bit of an issue in slab intensive
loads because the per CPU slab cache relies on them.  I dont
think it is that big an issue as the flush above, but still
would be better to keep it fast.

> > P.S.: An alternative would be to define a new genapic subarch that
> > you only enable when you detect cpuhotplug support at boot.
> > 
> 
> There is nothing currently there to find out if something is hotplug
> capable in a generic way at platform level, other than adding cmdline options 
> etc.  

When you have the command line option you can do it. Later I guess
you will have a way to get it from ACPI (e.g. CPUs in tables
but marked inactive etc.). 

> Also FYI: ACPI folks are experimenting using CPU hotplug to suspend/resume
> support. So hotplug support may be required not just on platforms that support
> it but also for other related uses.

I am aware of that. Also the virtualization people will likely use it.

-Andi
