Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbTIDF7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 01:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbTIDF7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 01:59:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:29141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264667AbTIDF7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 01:59:03 -0400
Date: Wed, 3 Sep 2003 22:59:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] linux-2.6.0-test4_cyclone-hpet-fix_A0
Message-Id: <20030903225939.77630b19.akpm@osdl.org>
In-Reply-To: <1062649798.1312.1519.camel@cog.beaverton.ibm.com>
References: <1062649798.1312.1519.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> Andrew, All,
> 	I probably should have been more active in reviewing the HPET code
> before it went in, but I've been somewhat occupied with other bugs
> recently. I'm excited to see someone else using my time-source
> interface, however the HPET patch definitely pushes the interface beyond
> its design (not a bad thing, just makes for some short term uglies).
> Having multiple interrupt sources as well as time sources will generate
> some work for 2.7 to clean it all up.
> 
> Anyway, the HPET changes made calibrate_tsc() static, which it probably
> should be, but it broke the timer_cyclone code. This patch fixes it back
> up by re-implementing calibrate_tsc() locally as it was done in
> timer_hpet.c 

<stdrant>
Of course if some bozo had stuck this:

	extern unsigned long calibrate_tsc(void);

in a header file rather than in a .c file (timer_cyclone.c), this problem
would not have occurred.  Nevereverever put extern declarations in .c files!
</stdrant>


Can we not we avoid the cut-n-paste coding?

There is also timer_tsc.c:calibrate_tsc_hpet() which is almost the same as
timer_hpet.c:calibrate_tsc().  Seem to me that we could tweak
calibrate_tsc_hpet() a bit, unstaticalise timer_tsc.c:calibrate_tsc() and
have two functions rather than four?

> 
> Also, while apparently unrelated, but touching code from the HPET patch,
> I'm seeing some form of memory corruption on the 16way x440 which is
> overwriting the wait_timer_tick pointer in apic.c I added some
> initialized corruption pad variables around the pointer and they're
> definitely being trampled. I'll have to look into it further tomorrow.

Hum.  Please do this:

mnm:/usr/src/25> nm -n vmlinux|grep -3 wait_timer_tick
c043b360 D using_apic_timer
c043b380 d lapic_sysclass
c043b3e0 d device_lapic
c043b41c D wait_timer_tick
c043b420 D nmi_watchdog
c043b424 d nmi_hz
c043b440 d nmi_sysclass

It could be an overrun accessing device_lapic.  There's a patch in -mm
which plays around with kobject.name although I can't immediately see why
it would cause this to happen.  If the problem ocurs in -mm and not in
-linus then we need to be looking suspiciously at

	kobject-unlimited-name-lengths.patch
and
	kobject-unlimited-name-lengths-use-after-free-fix.patch


