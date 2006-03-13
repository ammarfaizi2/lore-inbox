Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWCMTgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWCMTgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWCMTgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:36:38 -0500
Received: from fmr22.intel.com ([143.183.121.14]:59557 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932365AbWCMTgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:36:37 -0500
Date: Mon, 13 Mar 2006 11:36:15 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Krzysztof Oledzki <olel@ans.pl>, venkatesh.pallipadi@intel.com,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com,
       suresh.b.siddha@intel.com, rajesh.shah@intel.com
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on 2.6.16-rc6
Message-ID: <20060313113615.A24797@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl> <20060311210353.7eccb6ed.akpm@osdl.org> <Pine.LNX.4.64.0603121202540.31039@bizon.gios.gov.pl> <20060312032523.109361c1.akpm@osdl.org> <Pine.LNX.4.64.0603121359540.31039@bizon.gios.gov.pl> <20060312073524.A9213@unix-os.sc.intel.com> <Pine.LNX.4.64.0603122206110.19689@bizon.gios.gov.pl> <20060312143053.530ef6c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060312143053.530ef6c9.akpm@osdl.org>; from akpm@osdl.org on Sun, Mar 12, 2006 at 02:30:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 02:30:53PM -0800, Andrew Morton wrote:
> 
> Maybe we should have:
> 
> 	if (num_possible_cpus() <= 8)
> 		dont_do_any_of_that_stuff();
> 
> That's assuming that hotplug-cpu-capable platforms are correctly setting
> cpu_possible_map.  Do they?

That wont work, since we use HOTPLUG_CPU to suspend/resume as well. We 
switched to using bigsmp (that uses physflat for IPI's) just to avoid
sending IPI's to offline CPUs. When we use logical flat we use shortcuts
that have ill effects on CPUs that are offline.

Think making CONFIG_HOTPLUG_CPU depend on X86_GENERICARCH, or X86_BIGSMP
seems like a better choice.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


When CONFIG_HOTPLUG_CPU is turned on we always use physflat mode (bigsmp) even 
when #of CPUs are less than 8 to avoid sending IPI to offline processors.

Without having BIGSMP on it spits out a warning during boot on systems that
seems misleading, since it complains even on systems that have less
than 8 cpus.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---------------------------------------------------------

 arch/i386/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc6-mm1/arch/i386/Kconfig
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/Kconfig
+++ linux-2.6.16-rc6-mm1/arch/i386/Kconfig
@@ -760,7 +760,7 @@ config PHYSICAL_START
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
+	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER && (X86_GENERICARCH || X86_BIGSMP)
 	---help---
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
