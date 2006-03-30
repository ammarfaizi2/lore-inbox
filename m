Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWC3NAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWC3NAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWC3NAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:00:08 -0500
Received: from mga05.intel.com ([192.55.52.89]:34187 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932198AbWC3NAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:00:07 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,146,1141632000"; 
   d="scan'208"; a="17696953:sNHT17214960"
Date: Thu, 30 Mar 2006 05:00:06 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-ID: <20060330050005.A19403@unix-os.sc.intel.com>
References: <20060329220808.GA1716@elf.ucw.cz> <20060329144746.358a6b4e.akpm@osdl.org> <20060329150950.A12482@unix-os.sc.intel.com> <20060329192453.538a131d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060329192453.538a131d.akpm@osdl.org>; from akpm@osdl.org on Wed, Mar 29, 2006 at 07:24:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 07:24:53PM -0800, Andrew Morton wrote:
Hi Andrew,

here is an attempt to explain why...

> 
> Something which remains to be beaten into my head: *why* does HOTPLUG_CPU
> require flat pyhsical mode?  What necessitated that change, and cannot we
> make it work OK in logical mode as well as flat mode?

Short answer

1. Will hotplug work today in logical flat mode without selecting bigsmp?

   	Yes, since we avoid broadcast on i386 IPI's with no_broadcast option.

2. Why use bigsmp then?
   There is no reason to do the same thing in two different ways. i.e using
   logical flat with no_broadcast=1, or use the bigsmp by default when hotplug cpu is
   enabled. IOW we wanted the handling consistent with what we do for x86_64, hence the 
   decision to use bigsmp automatically when hotplug is enabled or we notice >8 CPUS.


Long and detailed ...

1. broadcast IPI's are not hotplug friendly since hw has no control to *not* deliver
   the message to offline cpus. Nice explanation from Vatsa on what the corner cases are
   in link below.

	http://marc.theaimsgroup.com/?l=linux-kernel&m=111695485610434&w=2

2. The discussion above was to support removing shortcuts, and using a send_IPI_mask()
   instead of send_IPI_allbutself() via a shortcut msg. This would not deliver an IPI 
   to offline cpus. Andi Kleen had some doubts about tlb flush performance when we use 
   send_IPI_mask() since it does one cpu at a time. 

   So we added a no_broadcast option, that permits us to continue to use the normal 
   shortcut method for send_IPI_allbutself() when cpu-hotplug is disabled, and use the 
   send_IPI_mask() version when cpu-hotplug is enabled.  
   
   [ set usage of no_broadcast in arch/i386/mach-default/setup.c  and used in 
   include/asm-i386/mach-default/mach_ipi.h]
   
   In addition we also posted some perf testing patch for testing, and it proved we 
   didnt have any perf degradation for using the mask or the shortcut. Based on those 
   results, Andi removed the no_broadcast option in X86_64 and we used the physflat 
   option since it does the unicast method anyway.

   [Physflat mode is equivalent of bigsmp in x86_64]


3. So today using logical flat mode will work with hotlug without any races due to the
   no_broadcast=1 is automatically selected when hotplug cpu is enabled, even without
   bigsmp apic mode. 

   So Why we moved to automatically selecting bigsmp when hotlug was enabled?
   	we really didnt want 2 ways to do the same thing without clear benefit for one 
	over other. (i.e using logical flat mode with no_broadcast v.s using bigsmp that 
	already does send_IPI_sequence() which doesnt do the shortcut msg )

4. Why bigsmp was converted to physical flat mode instead of logical cluster mode?

	We discovered a problem when platform/chipset is working in logical cluster
	mode, and a new CPU is brought up that causes bad interaction. More
	details below in the patch description.

	http://marc.theaimsgroup.com/?l=linux-kernel&m=113261865814107&w=2

	[In i386 bigsmp also means flat physical mode after the above patch was accepted]

5. Ideally the no_broadcast option will be removed soon once things settle down. 

Hope this helps.
-- 
Cheers,
Ashok Raj
- Open Source Technology Center
