Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWCVNIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWCVNIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 08:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWCVNIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 08:08:52 -0500
Received: from fmr21.intel.com ([143.183.121.13]:50588 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751217AbWCVNIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 08:08:51 -0500
Date: Wed, 22 Mar 2006 05:08:37 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ashok.raj@intel.com
Subject: Re: Linux v2.6.16
Message-ID: <20060322050837.A9452@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <4420DF21.8060700@bigpond.net.au> <20060321223120.A4003@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060321223120.A4003@unix-os.sc.intel.com>; from ashok.raj@intel.com on Tue, Mar 21, 2006 at 10:31:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 10:31:20PM -0800, Ashok Raj wrote:
> On Tue, Mar 21, 2006 at 09:22:41PM -0800, Peter Williams wrote:
> > 
> >    I/O APICs
> >    Mar 22 16:10:31 heathwren kernel: More than 8 CPUs detected and
> >    CONFIG_X86_PC cannot handle it.
> > 
> >    ###  No more CPUs seen but something in there thinks there's more than
> >    8
> >    of them.
> > 
> >    Mar 22 16:10:31 heathwren kernel: Use CONFIG_X86_GENERICARCH or
> >    CONFIG_X86_BIGSMP.
> > 
> 
> 

Hi Andrew

Please consider for inclusion... resending with changelog per Andrew.


-- 
Cheers,
Ashok Raj
- Open Source Technology Center


This patch makes CONFIG_HOTPLUG_CPU depend on !X86_PC, so we need to turn on 
either CONFIG_GENERICARCH, CONFIG_BIGSMP or any other subarch except X86_PC when
CONFIG_HOTPLUG_CPU=y

With 2.6.15+ kernels when CONFIG_HOTPLUG_CPU is turned on we switch to bigsmp mode for
sending IPI's and ioapic configurations that caused the following error message.

>> More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
>> Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.

Originally bigsmp was added just to handle >8 cpus, but now with hotplug cpu support
we need to use bigsmp mode (why? see below), that cause the above error message even 
if there were less than 8 cpus in the system.

The message is bogus, but we are cannot use logical flat mode due to issues with
broadcast IPI can confuse a CPU just comming up. We use flat physical mode just like x86_64
case. More details on why bigsmp now uses flat physical mode (vs. cluster mode)
in following link.

http://marc.theaimsgroup.com/?l=linux-kernel&m=113261865814107&w=2


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
+	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER && !X86_PC
 	---help---
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
