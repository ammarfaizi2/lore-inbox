Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWDAXzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWDAXzx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 18:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWDAXzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 18:55:53 -0500
Received: from mga06.intel.com ([134.134.136.21]:2913 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932307AbWDAXzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 18:55:53 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,154,1141632000"; 
   d="scan'208"; a="18101640:sNHT17984169"
Date: Sat, 1 Apr 2006 15:55:45 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Raj, Ashok" <ashok.raj@intel.com>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-ID: <20060401155545.A7466@unix-os.sc.intel.com>
References: <20060329220808.GA1716@elf.ucw.cz> <20060329154748.A12897@unix-os.sc.intel.com> <20060330084153.GC8485@elf.ucw.cz> <200603301817.37315.rjw@sisk.pl> <20060329003012.GC2762@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060329003012.GC2762@ucw.cz>; from pavel@suse.cz on Tue, Mar 28, 2006 at 04:30:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 04:30:13PM -0800, Pavel Machek wrote:
> 
>    Or maybe in i386 .c files :-). Could we just switch to BIGSMP mode by
>    default? Intel claims it has no performance disadvatage, and distros
>    want suspend, anyway...


After some more thought and consulting with Pavel and folks, the path of 
least resistance for now seems like not to switch to bigsmp.

We will need to do a little bit more work to ensure that we can work the
physical flat mode (bigsmp) instead of logical flat mode in i386. Primarily
to ensure configs for SMP_SUSPEND, any memory hotplug prototype in i386 dont
break by  choosing bigsmp as default to ensure transition is smooth.

Andrew, please help queuing this patch. (Since pavel just reverted the 
HOTPLUG_CPU depends on X86_GENERICARCH recently in git9, people will now
see the funky error message that they have more than 8 cpus until this patch 
is included.)

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


Switching to automatic bigsmp causes an misleading error message, that
more then 8 cpus are detected, and user needs to select either X86_GENERICARCH
or X86_BIGSMP to handle. 

Reason is we switched to bigsmp to avoid IP race when new cpu is comming up.
[bigsmp is nothing but using physical flat mode that can work for 1 .. 255 cpus]
[default is X86_PC, that uses logical flat mode up to 8 CPUs max]
Current x86_64 code uses bigsmp as default when hotplug is enabled.

It would be preferable to make bigsmp as default, and work the dependencies
of other related code like SMP_SUSPEND, and some related to memory hotplug
code for i386.

Current logical flat mode doesnt use shortcuts that cause the race by
using the send_IPI_mask() instead of shortcuts when HOTPLUG_CPU is enabled.

In the meantime this patch is the path of lease resistance. 

We will switch to bigsmp default sometime soon, when we get to work it again.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------------------
 arch/i386/kernel/mpparse.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6.16-git19/arch/i386/kernel/mpparse.c
===================================================================
--- linux-2.6.16-git19.orig/arch/i386/kernel/mpparse.c
+++ linux-2.6.16-git19/arch/i386/kernel/mpparse.c
@@ -38,12 +38,6 @@
 int smp_found_config;
 unsigned int __initdata maxcpus = NR_CPUS;
 
-#ifdef CONFIG_HOTPLUG_CPU
-#define CPU_HOTPLUG_ENABLED	(1)
-#else
-#define CPU_HOTPLUG_ENABLED	(0)
-#endif
-
 /*
  * Various Linux-internal data structures created from the
  * MP-table.
@@ -225,7 +219,14 @@ static void __devinit MP_processor_info 
 	cpu_set(num_processors, cpu_possible_map);
 	num_processors++;
 
-	if (CPU_HOTPLUG_ENABLED || (num_processors > 8)) {
+	/*
+	 * Would be preferable to switch to bigsmp when CONFIG_HOTPLUG_CPU=y
+	 * but we need to work other dependencies like SMP_SUSPEND etc
+	 * before this can be done without some confusion.
+	 * if (CPU_HOTPLUG_ENABLED || num_processors > 8)
+	 *       - Ashok Raj <ashok.raj@intel.com>
+	 */
+	if (num_processors > 8) {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_INTEL:
 			if (!APIC_XAPIC(ver)) {
