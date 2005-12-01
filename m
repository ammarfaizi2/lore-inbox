Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVLACYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVLACYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 21:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVLACYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 21:24:02 -0500
Received: from fmr14.intel.com ([192.55.52.68]:60077 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751358AbVLACYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 21:24:00 -0500
Subject: [PATCH]nmi VS cpu hotplug
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, zwane <zwane@linuxpower.ca>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 01:46:04 -0800
Message-Id: <1133430364.7980.15.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
With CPU hotplug enabled, NMI watchdog stoped working. It appears the
violation is the cpu_online check in nmi handler. local ACPI based NMI
watchdog is initialized before we set CPU online for APs. It's quite
possible a NMI is fired before we set CPU online, and that's what
happens here.
Zwane, I suppose you saw nmi interrupts on offline CPU, so you added
this one. Several days ago I sent a patch titled 'disable LAPIC
completely for offline CPU', which I guess will make it disappear. Can
you try it?
So the solution is either to initialize nmi later or to delete the
cpu_online check. I just take what x86_64 does.


Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.14-root/arch/i386/kernel/traps.c |    7 -------
 1 files changed, 7 deletions(-)

diff -puN arch/i386/kernel/traps.c~nmi-cpuhotplug arch/i386/kernel/traps.c
--- linux-2.6.14/arch/i386/kernel/traps.c~nmi-cpuhotplug	2005-12-01 01:22:00.000000000 -0800
+++ linux-2.6.14-root/arch/i386/kernel/traps.c	2005-12-01 01:22:22.000000000 -0800
@@ -650,13 +650,6 @@ fastcall void do_nmi(struct pt_regs * re
 
 	cpu = smp_processor_id();
 
-#ifdef CONFIG_HOTPLUG_CPU
-	if (!cpu_online(cpu)) {
-		nmi_exit();
-		return;
-	}
-#endif
-
 	++nmi_count(cpu);
 
 	if (!rcu_dereference(nmi_callback)(regs, cpu))
_


