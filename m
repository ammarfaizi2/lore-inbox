Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWCMWZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWCMWZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWCMWZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:25:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50835 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964810AbWCMWY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:24:58 -0500
Date: Mon, 13 Mar 2006 14:22:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: ashok.raj@intel.com, olel@ans.pl, venkatesh.pallipadi@intel.com,
       linux-kernel@vger.kernel.org, suresh.b.siddha@intel.com,
       rajesh.shah@intel.com, ak@muc.de
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on
 2.6.16-rc6
Message-Id: <20060313142223.7ac20a65.akpm@osdl.org>
In-Reply-To: <20060313120552.A25020@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl>
	<20060311210353.7eccb6ed.akpm@osdl.org>
	<Pine.LNX.4.64.0603121202540.31039@bizon.gios.gov.pl>
	<20060312032523.109361c1.akpm@osdl.org>
	<Pine.LNX.4.64.0603121359540.31039@bizon.gios.gov.pl>
	<20060312073524.A9213@unix-os.sc.intel.com>
	<Pine.LNX.4.64.0603122206110.19689@bizon.gios.gov.pl>
	<20060312143053.530ef6c9.akpm@osdl.org>
	<20060313113615.A24797@unix-os.sc.intel.com>
	<20060313115155.24dfb6f3.akpm@osdl.org>
	<20060313120552.A25020@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> 
> 
>  When CONFIG_HOTPLUG_CPU is turned on we always use physflat mode (bigsmp) even 
>  when #of CPUs are less than 8 to avoid sending IPI to offline processors.
> 
>  Without having BIGSMP on it spits out a warning during boot on systems that
>  seems misleading, since it complains even on systems that have less
>  than 8 cpus.
> 
>  Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>  ---------------------------------------------------------
> 
>   arch/i386/Kconfig |    2 +-
>   1 files changed, 1 insertion(+), 1 deletion(-)
> 
>  Index: linux-2.6.16-rc6-mm1/arch/i386/Kconfig
>  ===================================================================
>  --- linux-2.6.16-rc6-mm1.orig/arch/i386/Kconfig
>  +++ linux-2.6.16-rc6-mm1/arch/i386/Kconfig
>  @@ -760,7 +760,7 @@ config PHYSICAL_START
>   
>   config HOTPLUG_CPU
>   	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
>  -	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
>  +	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER && !X86_PC
>   	---help---
>   	  Say Y here to experiment with turning CPUs off and on.  CPUs
>   	  can be controlled through /sys/devices/system/cpu.

Still seems wrong.  People _do_ use HOTPLUG_CPU on X86_PCs so they can get
software suspend.  The number of people who do this are probably 100000x
the number of people who have physically hotpluggable CPUs.  And I don't
think we can churn their config requirements this much so late in the game.

So for now I suggest we're best off simply killing the printk (or doing
something smarter, like comparing cpu_online-map with cpu_possible_map
(which isn't right)).

Longer term, it appears that we need to do some Kconfig and C work to
separate out the HOTPLUG_CPU infrastructure which swsusp needs from actual
CPU hotplugging.

What _is_ this IPI problem anyway?  Can't send point-to-point IPIs to
offlined CPUs?  (Don't do that then?) Or do broadcast IPIs go wrong, or
what?

And does it affect pretend-x86-hotplug, or is it only affecting real hotplug?

Thanks.
