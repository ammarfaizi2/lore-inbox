Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUCTRFS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 12:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbUCTRFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 12:05:18 -0500
Received: from aun.it.uu.se ([130.238.12.36]:7644 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263475AbUCTRFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 12:05:09 -0500
Date: Sat, 20 Mar 2004 18:04:55 +0100 (MET)
Message-Id: <200403201704.i2KH4tTS008272@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Cc: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, phil.el@wanadoo.fr,
       schwab@suse.de, thomas.schlichter@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004 01:52:36 -0800, Andrew Morton wrote:
>Mikael Pettersson <mikpe@csd.uu.se> wrote:
>>
>> Maciej W. Rozycki writes:
>>  > On Wed, 17 Mar 2004, Andrew Morton wrote:
>>  > 
>>  > > I still have a couple of NMI patches in -mm:
>>  > > 
>>  > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/nmi_watchdog-local-apic-fix.patch
>>  > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/nmi-1-hz.patch
>>  > > 
>>  > > What should we do with these?
>>  > 
>>  >  I think we should ask Mikael Pettersson as he is the local APIC watchdog 
>>  > expert.  Mikael?
>> 
>> Will do. Is there a problem with them, or do you just want them
>> reviewed for merging into 2.6.5-rc?
>> 
>
>They seem to work OK - I did a batch of testing with various setups.  But a
>retest wouldn't hurt.
>
>We mainly need a review and general finish-it-off-and-bless-it please.

'nmi_watchdog-local-apic-fix.patch' looks Ok, although I
would prefer if it didn't put a 'static' on nmi_perfctr_msr:
the perfctr driver needs access to it.

I'm not happy with 'nmi-1-hz.patch'. The real problem is that
SMP with nmi_watchdog=2 initialises the lapic NMI watchdog but
doesn't check it and therefore doesn't reduce nmi_hz.
This is an SMP bug, but instead of fixing it the patch removes
the check from UP and changes nmi.c to compensate.

This would be Ok if check_nmi_watchdog() with nmi_watchdog=2
was redundant, but I don't believe it is. It has exposed bugs
and unexpected hardware changes before, and so should remain.

I propose the patch below instead. It changes smpboot.c to do a
check_nmi_watchdog() at the appropriate place, which fixes the
high NMI frequency problem w/o changing anything else.
I've verified that it solves the problem on my MP-capable UP box.

/Mikael

diff -ruN linux-2.6.5-rc2/arch/i386/kernel/smpboot.c linux-2.6.5-rc2.smpboot-lapic-watchdog-fix/arch/i386/kernel/smpboot.c
--- linux-2.6.5-rc2/arch/i386/kernel/smpboot.c	2004-03-11 14:01:25.000000000 +0100
+++ linux-2.6.5-rc2.smpboot-lapic-watchdog-fix/arch/i386/kernel/smpboot.c	2004-03-20 17:21:30.113862000 +0100
@@ -1107,6 +1107,9 @@
 		}
 	}
 
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		check_nmi_watchdog();
+
 	smpboot_setup_io_apic();
 
 	setup_boot_APIC_clock();
