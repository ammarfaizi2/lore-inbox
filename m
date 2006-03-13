Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWCMXFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWCMXFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWCMXFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:05:30 -0500
Received: from fmr18.intel.com ([134.134.136.17]:34488 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750807AbWCMXF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:05:29 -0500
Date: Mon, 13 Mar 2006 15:04:35 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, olel@ans.pl,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com, rajesh.shah@intel.com, ak@muc.de
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on 2.6.16-rc6
Message-ID: <20060313150435.A26689@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603121202540.31039@bizon.gios.gov.pl> <20060312032523.109361c1.akpm@osdl.org> <Pine.LNX.4.64.0603121359540.31039@bizon.gios.gov.pl> <20060312073524.A9213@unix-os.sc.intel.com> <Pine.LNX.4.64.0603122206110.19689@bizon.gios.gov.pl> <20060312143053.530ef6c9.akpm@osdl.org> <20060313113615.A24797@unix-os.sc.intel.com> <20060313115155.24dfb6f3.akpm@osdl.org> <20060313120552.A25020@unix-os.sc.intel.com> <20060313142223.7ac20a65.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060313142223.7ac20a65.akpm@osdl.org>; from akpm@osdl.org on Mon, Mar 13, 2006 at 02:22:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 02:22:23PM -0800, Andrew Morton wrote:
> >   config HOTPLUG_CPU
> >   	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> >  -	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
> >  +	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER && !X86_PC
> >   	---help---
> >   	  Say Y here to experiment with turning CPUs off and on.  CPUs
> >   	  can be controlled through /sys/devices/system/cpu.
> 
> Longer term, it appears that we need to do some Kconfig and C work to
> separate out the HOTPLUG_CPU infrastructure which swsusp needs from actual
> CPU hotplugging.

The needs are not any different. Both (swsusp and cpu hotplug) both require
logical cpu offlining which is what CONFIG_HOTPLUG_CPU does.

Physical cpu hotplug is enabled by CONFIG_ACPI_HOTPLUG_CPU.

> 
> What _is_ this IPI problem anyway?  Can't send point-to-point IPIs to
> offlined CPUs?  (Don't do that then?) Or do broadcast IPIs go wrong, or
> what?

Its not the point-to-point..we do that only to wake a CPU, but thats done
in flat physical mode always.

When we do smp_call_function() under X86_PC we use logical flat mode. 
This sends a broadcast IPI by using a shortcut message. This is bad, since 
the offline cpu may also receive it and process just when we bring the cpu 
online. 

send_IPI_allbutself() and send_IPI_all() versions that use the shortcut
values are the ones to avoid. 

> 
> And does it affect pretend-x86-hotplug, or is it only affecting real hotplug?
> 
its no more pretend-x86, in the past we used to put the cpu in idle(), 
now we do put the cpu in halt and bring back by another startup ipi, just like 
boot sequence, both for x86 and x86_64.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
