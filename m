Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933041AbWKMTyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933041AbWKMTyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933043AbWKMTyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:54:13 -0500
Received: from mga07.intel.com ([143.182.124.22]:28454 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S933041AbWKMTyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:54:11 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,418,1157353200"; 
   d="scan'208"; a="145563622:sNHT42493542"
Date: Mon, 13 Nov 2006 11:31:02 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113113102.A23060@unix-os.sc.intel.com>
References: <20061111151414.GA32507@elte.hu> <200611131529.46464.ak@suse.de> <20061113150415.GA20321@elte.hu> <200611131710.13285.ak@suse.de> <20061113163216.GA3480@elte.hu> <20061113100352.C17720@unix-os.sc.intel.com> <20061113184255.GA25528@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061113184255.GA25528@elte.hu>; from mingo@elte.hu on Mon, Nov 13, 2006 at 07:42:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 07:42:56PM +0100, Ingo Molnar wrote:
> 
> * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> 
> > > for that i'd have to know the bug, and this is the third time i'm 
> > > asking about specifics :-) (The URL that was given in the thread was 
> > > about a chipset bug regarding incompatibility with clustered-APIC 
> > > mode - my patch in fact - because it switches small systems to use 
> > > logical flat mode always - solves that kind of regression too.)
> > 
> > Not really. That chipset belongs to a MP platform and with your 
> > proposed patch, we will endup using clustered APIC mode and will hit 
> > the issue(in the presence of cpu hotplug) mentioned in that URL.
> 
> hm, why does it end up in clustered mode? Cluster mode should only 
> trigger if the APIC IDs go beyond 16.

number of cpus >8 we need to switch to either clustered or flat physical mode.

> 
> but i'd be fine with never going into cluster mode, instead always using 
> physical flat mode when having more than 8 APICs (independent of the 
> presence of CPU hotplug). On small systems, logical flat mode is what is 
> the best-tested variant (it's also slightly faster).
> 
> 	Ingo

I think we choose flat physical mode for two reasons, x86_64 was doing the same
so we were consistent with the approach. The other was when we have cpu hotplug
enabled its difficult to say what the max number of cpus will be. So
choosing flat logical was not right even if we had 8 or less cpus, and 
technically we could think of something that starts with less and go beyond 
max cluster limit of 60 as well.

Hence Andi introduces another way to limit it based on disabled cpu count in 
MADT, or user can specify at startup time to specify the limit of potentially
hot-pluggable cpus.

bigsmp was also a relatively new variant at the time, and all agreed to keep
things simple instead of having 3 different approaches, (logical flat,
logical cluster, and flat physical). Running some simple tests we didnt
see any appreciable differences at that time, maybe we were not that exhaustive.



-- 
Cheers,
Ashok Raj
- Open Source Technology Center
