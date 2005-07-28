Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVG1TJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVG1TJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVG1TJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:09:19 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:58346 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S262093AbVG1TGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:06:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc3-mm3
Date: Thu, 28 Jul 2005 21:11:32 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
References: <20050728025840.0596b9cb.akpm@osdl.org>
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507282111.32970.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 28 of July 2005 11:58, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm3/
> 
> - Added the anonymous pagefault scalability enhancement patches.
> 
>   I remain fairly dubious about this - it seems a fairly specific and
>   complex piece of work to speed up one extremely specific part of one type of
>   computer's one type of workload.   Surely there's a better way :(
> 
>   The patches at present spit warnings or don't compile on lots of
>   architectures.  x86, x86_64, ppc64 and ia64 are OK.
> 
> - There's a pretty large x86_64 update here which naughty maintainer wants
>   in 2.6.13.  Extra testing, please.

There are two problems with the compilation of arch/x86_64/kernel/nmi.c.
The following patch fixes them.

Greets,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.13-rc3-mm3/arch/x86_64/kernel/nmi.c	2005-07-28 21:05:53.000000000 +0200
+++ patched/arch/x86_64/kernel/nmi.c	2005-07-28 18:58:02.000000000 +0200
@@ -152,8 +152,10 @@ int __init check_nmi_watchdog (void)
 
 	printk(KERN_INFO "testing NMI watchdog ... ");
 
+#ifdef CONFIG_SMP
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
+#endif
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		counts[cpu] = cpu_pda[cpu].__nmi_count; 
@@ -290,7 +292,7 @@ void enable_timer_nmi_watchdog(void)
 
 static int nmi_pm_active; /* nmi_active before suspend */
 
-static int lapic_nmi_suspend(struct sys_device *dev, u32 state)
+static int lapic_nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
 	nmi_pm_active = nmi_active;
 	disable_lapic_nmi_watchdog();
