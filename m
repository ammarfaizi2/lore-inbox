Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267071AbUBMPzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267073AbUBMPzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:55:09 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:33744 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S267071AbUBMPzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:55:03 -0500
Date: Fri, 13 Feb 2004 16:55:00 +0100
From: cheuche+lkml@free.fr
To: linux-kernel@vger.kernel.org
Subject: Nforce2, APIC, CPU Disconnect and setup_boot_APIC_clock()
Message-ID: <20040213155500.GA6378@localnet>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200402120122.06362.ross@datscreative.com.au> <402CB24E.3070105@gmx.de> <200402140041.17584.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <200402140041.17584.ross@datscreative.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

I once noticed there was a drift between the 8254 timer and the APIC
timer. With vanilla and -mm kernels, APIC timer is running faster. With
Ross' patches I noticed it was running slower, and the crashes go away.
I dig in that direction and found that with a APIC timer directly
programmed slower than calibrated, adding ~20 more bus cycles to the
counter, hangs disappear, at least during the tests (for a few minutes,
maybe they are made much rarer). I eventually disabled altogether the
APIC timer with the patchlet attached, and did an entire test (dumping
the whole hard drive to /dev/null with very high network and soundcard
activity), and it survived. I will continue to test, just to make
sure...

At least there is a way to get nforce2 + APIC + CPU disconnect and
actually have a cooler idle CPU. Side effects are no more LOC rising
counter in /proc/interrupts, no more nmi_watchdog=2 and if you work
around the bios acpi apic source override to get the timer on pin #0, no
more nmi_watchdog=1. This is of course not the best solution.

Now the experts may look why commenting out setup_boot_APIC_clock() in
APIC_init_uniprocessor() of arch/i386/kernel/apic.c works, and find a
better fix if any.

Mathieu

--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="no_boot_apic_clock.patch"

--- arch/i386/kernel/apic.c.old	2004-02-13 16:13:39.000000000 +0100
+++ arch/i386/kernel/apic.c	2004-02-13 14:29:29.000000000 +0100
@@ -1198,7 +1198,7 @@
 		if (!skip_ioapic_setup && nr_ioapics)
 			setup_IO_APIC();
 #endif
-	setup_boot_APIC_clock();
+	/*setup_boot_APIC_clock();*/
 
 	return 0;
 }

--IrhDeMKUP4DT/M7F--
