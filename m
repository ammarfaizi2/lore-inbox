Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTDNSqa (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTDNSqa (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:46:30 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1540 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id S263793AbTDNSqC (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 14:46:02 -0400
Date: Sun, 13 Apr 2003 20:28:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au
Subject: Re: APIC is not properly suspending in 2.5.67 on UP
Message-ID: <20030413182853.GA293@elf.ucw.cz>
References: <200304130044.h3D0i3lQ029020@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304130044.h3D0i3lQ029020@harpo.it.uu.se>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >This is needed otherwise APIC thinks it is not active, does not
> >suspend properly, and kills machine.
> 
> This can only happen with UP if the machine boots with local
> APIC enabled and the BIOS announces an MP table.
> 
> If this is the case, then yes apic_pm_activate() needs to be done.
> 
> > Extra whitespace killed (looks
> >ugly). Please apply,
> 
> I think some fixes are needed first:
> - You're calling apic_pm_activate() from setup_local_APIC(), which
>   is before its definition. This will cause a compile warning, and
>   a linkage error if CONFIG_PM=n.

Fixed (by adding function prototype). Please apply,
								Pavel

%patch
Index: linux/arch/i386/kernel/apic.c
===================================================================
--- linux.orig/arch/i386/kernel/apic.c	2003-04-08 13:19:44.000000000 +0200
+++ linux/arch/i386/kernel/apic.c	2003-04-13 20:21:39.000000000 +0200
@@ -36,6 +36,8 @@
 
 #include <mach_apic.h>
 
+static void apic_pm_activate(void);
+
 void __init apic_intr_init(void)
 {
 #ifdef CONFIG_SMP
@@ -449,6 +451,7 @@
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		setup_apic_nmi_watchdog();
+	apic_pm_activate();
 }
 
 #ifdef CONFIG_PM
@@ -585,7 +588,7 @@
 
 #else	/* CONFIG_PM */
 
-static inline void apic_pm_activate(void) { }
+static void apic_pm_activate(void) { }
 
 #endif	/* CONFIG_PM */
 
@@ -652,9 +655,7 @@
 		nmi_watchdog = NMI_LOCAL_APIC;
 
 	printk("Found and enabled local APIC!\n");
-
 	apic_pm_activate();
-
 	return 0;
 
 no_apic:
@@ -1133,11 +1134,8 @@
 	}
 
 	verify_local_APIC();
-
 	connect_bsp_APIC();
-
 	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
-
 	setup_local_APIC();
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
@@ -1148,6 +1146,5 @@
 			setup_IO_APIC();
 #endif
 	setup_boot_APIC_clock();
-
 	return 0;
 }

%diffstat
 apic.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)



-- 
When do you have heart between your knees?
