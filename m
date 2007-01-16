Return-Path: <linux-kernel-owner+w=401wt.eu-S1751427AbXAPRLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbXAPRLY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbXAPRLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:11:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50082 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbXAPRLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 12:11:22 -0500
Date: Tue, 16 Jan 2007 18:09:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Len Brown <lenb@kernel.org>
Subject: [patch] ACPI: fix cpufreq regression
Message-ID: <20070116170925.GA3703@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] ACPI: fix cpufreq regression
From: Ingo Molnar <mingo@elte.hu>

recently cpufreq support on my laptop (Lenovo T60) broke completely: 
when it's plugged into AC it would never go higher than 1 GHz - neither 
1.3 GHz nor 1.83 GHz is possible - no matter which governor (userspace, 
speed or ondemand) is used.

after some cpufreq debugging i tracked the regression back to the 
following (totally correct) bug-fix commit:

   commit 0916bd3ebb7cefdd0f432e8491abe24f4b5a101e
   Author: Dave Jones <davej@redhat.com>
   Date:   Wed Nov 22 20:42:01 2006 -0500

    [PATCH] Correct bound checking from the value returned from _PPC method.

this bugfix, which makes other laptops work, made a previously hidden 
(BIOS) bug visible on my laptop.

The bug is the following: if the _PPC (Performance Present Capabilities) 
optional ACPI object is queried /after/ bootup then the BIOS reports an 
incorrect value of '2'.

My laptop (Lenovo T60) has the following performance states supported:

   0: 1833000
   1: 1333000
   2: 1000000

Per ACPI specification, a _PPC value of '0' means that all 3 performance 
states are usable. A _PPC value of '1' means states 1 .. 2 are usable, a 
value of '2' means only state '2' (slowest) is usable.

now, the _PPC object is optional, and it also comes with notification. 
Furthermore, when a CPU object is initialized, the _PPC object is 
initialized as well. So the following evaluation of the _PPC object is 
superfluous:

 [<c028ba5f>] acpi_processor_get_platform_limit+0xa1/0xaf
 [<c028c040>] acpi_processor_register_performance+0x3b9/0x3ef
 [<c0111a85>] acpi_cpufreq_cpu_init+0xb7/0x596
 [<c03dab74>] cpufreq_add_dev+0x160/0x4a8
 [<c02bed90>] sysdev_driver_register+0x5a/0xa0
 [<c03d9c4c>] cpufreq_register_driver+0xb4/0x176
 [<c068ac08>] acpi_cpufreq_init+0xe5/0xeb
 [<c010056e>] init+0x14f/0x3dd

and this is the point where my laptop's BIOS returns the incorrect value 
of '2'. Note that it has not sent any notification event, so the value 
is probably not really intentional (possibly spurious), and Windows 
likely doesnt query it after bootup either. Maybe the value is kept at 
'2' normally, and is only set to the real value when a true asynchronous 
event (such as AC plug event, battery switch, etc.) occurs.

So i /think/ this is a grey area of the ACPI spec: per the letter of the 
spec the _PPC value only changes when notified, so there's no reason to 
query it after the system has booted up. So in my opinion the best (and 
most compatible) strategy would be to do the change below, and to not 
evaluate the _PPC object in the acpi_processor_get_performance_info() 
call, but only evaluate it if _PPC is present during CPU object init, or 
if it's notified during an asynchronous event. This change is more 
permissive than the previous logic, so it definitely shouldnt break any 
existing system.

This also happens to fix my laptop, which is merrily chugging along at 
1.83 GHz now. Yay!

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/acpi/processor_perflib.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux/drivers/acpi/processor_perflib.c
===================================================================
--- linux.orig/drivers/acpi/processor_perflib.c
+++ linux/drivers/acpi/processor_perflib.c
@@ -322,10 +322,6 @@ static int acpi_processor_get_performanc
 	if (result)
 		return result;
 
-	result = acpi_processor_get_platform_limit(pr);
-	if (result)
-		return result;
-
 	return 0;
 }
 
