Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264718AbTIDHRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbTIDHRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:17:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34506 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264718AbTIDHRQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:17:16 -0400
Subject: Re: [PATCH] linux-2.6.0-test4_cyclone-hpet-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, venkatesh.pallipadi@intel.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, Dave H <haveblue@us.ibm.com>
In-Reply-To: <20030903225939.77630b19.akpm@osdl.org>
References: <1062649798.1312.1519.camel@cog.beaverton.ibm.com>
	 <20030903225939.77630b19.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1062659651.2246.11.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Sep 2003 00:14:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 22:59, Andrew Morton wrote:
> john stultz <johnstul@us.ibm.com> wrote:
> >
> > Andrew, All,
> > 	I probably should have been more active in reviewing the HPET code
> > before it went in, but I've been somewhat occupied with other bugs
> > recently. I'm excited to see someone else using my time-source
> > interface, however the HPET patch definitely pushes the interface beyond
> > its design (not a bad thing, just makes for some short term uglies).
> > Having multiple interrupt sources as well as time sources will generate
> > some work for 2.7 to clean it all up.
> > 
> > Anyway, the HPET changes made calibrate_tsc() static, which it probably
> > should be, but it broke the timer_cyclone code. This patch fixes it back
> > up by re-implementing calibrate_tsc() locally as it was done in
> > timer_hpet.c 
> 
> <stdrant>
> Of course if some bozo had stuck this:
> 
> 	extern unsigned long calibrate_tsc(void);
> 
> in a header file rather than in a .c file (timer_cyclone.c), this problem
> would not have occurred.  Nevereverever put extern declarations in .c files!
> </stdrant>

Yea, I'll fess up, I was the bozo (and probably still am). It was my
poor attempt at getting friend-like access to functions I really
shouldn't. 

> 
> Can we not we avoid the cut-n-paste coding?
> 
> There is also timer_tsc.c:calibrate_tsc_hpet() which is almost the same as
> timer_hpet.c:calibrate_tsc().  Seem to me that we could tweak
> calibrate_tsc_hpet() a bit, unstaticalise timer_tsc.c:calibrate_tsc() and
> have two functions rather than four?

Yes, I was just being hesitant and trying to keep changes localized.
I'll try to take a more confident swing at it tomorrow. 


> > Also, while apparently unrelated, but touching code from the HPET patch,
> > I'm seeing some form of memory corruption on the 16way x440 which is
> > overwriting the wait_timer_tick pointer in apic.c I added some
> > initialized corruption pad variables around the pointer and they're
> > definitely being trampled. I'll have to look into it further tomorrow.
> 
> Hum.  Please do this:
> 
> mnm:/usr/src/25> nm -n vmlinux|grep -3 wait_timer_tick
> c043b360 D using_apic_timer
> c043b380 d lapic_sysclass
> c043b3e0 d device_lapic
> c043b41c D wait_timer_tick
> c043b420 D nmi_watchdog
> c043b424 d nmi_hz
> c043b440 d nmi_sysclass

[jstultz@elm3a16 cyclone-hpet-fix]$ nm -n vmlinux | grep -6 wait_timer_tick
c03977e0 D mp_bus_id_to_pci_bus
c0397860 D boot_cpu_physical_apicid
c0397864 D boot_cpu_logical_apicid
c0397868 D bios_cpu_apicid
c0397870 D using_apic_timer
c0397874 D corruption_pad1
c0397878 D wait_timer_tick
c039787c D corruption_pad2
c0397880 D nmi_watchdog
c0397884 d nmi_hz
c0397888 d nmi_print_lock
c03978a0 d ioapic_lock
c03978a4 D sis_apic_bug

I can send you the whole System.map if needed, but
mp_bus_id_to_pci_bus[] looks suspicious to me. 


> It could be an overrun accessing device_lapic.  There's a patch in -mm
> which plays around with kobject.name although I can't immediately see why
> it would cause this to happen.  If the problem ocurs in -mm and not in
> -linus then we need to be looking suspiciously at
> 
> 	kobject-unlimited-name-lengths.patch
> and
> 	kobject-unlimited-name-lengths-use-after-free-fix.patch

I was seeing this in 2.5.bk-current as of a few hours ago.


