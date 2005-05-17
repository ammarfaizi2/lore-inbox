Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVEQHE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVEQHE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVEQHE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:04:57 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:2652 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261267AbVEQHEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:04:45 -0400
Message-ID: <42899797.2090702@sw.ru>
Date: Tue, 17 May 2005 11:04:55 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup and
 AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
References: <42822B5F.8040901@sw.ru> <768860000.1116282855@flay>
In-Reply-To: <768860000.1116282855@flay>
Content-Type: multipart/mixed;
 boundary="------------060603090406020201000701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060603090406020201000701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>>against 2.6.12-rc4
>>
>>This patch adds dumping of calltraces on _all_ CPUs
>>on AltSysRq-P and NMI LOCKUP. It does this via sending
>>NMI IPI interrupts to the cpus.
>>
>>I saw the same patch in RedHat kernels, here goes our own version of the patch, not sure it will be accepted, but I think it can be used by some people at least for debugging lockups etc.
> 
> 
> I'd done a similar thing, but just using smp_call_function (I hacked the
> interrupt routine to fish pt_regs back out, and override *info in some
> cases). Doing NMIs, as you've done, is probably nicer, but a lot more
> work.
Yes, but it catches _all_ calltraces which is very important, espicially 
when you do not have NMI watchdog enabled.

BTW, why NMI watchdog is disabled by default? We constantly making it on 
by default in our kernels and had no problems with it.
I send a patch attached which tunes NMI watchdog by config option...

> The problem with it (and my patch too) is that you're hooking into arch
> specific code from generic code, which means you'll break every other
> arch apart from i386. Fixing this is a pain in the rear end, but would
> be needed to merge the patch. OTOH, the patch is extremely useful, so
> would be nice to fix if you have the energy ...
Well, I used #idef __i386__ to not break generic code for other archs.
I have no any other hardware except for i386+, so it is almost 
impossible for me to make this code work on other archs. I think people 
who are interested in this functionality will provide the required code 
later.

Kirill

--------------060603090406020201000701
Content-Type: text/plain;
 name="diff-nmiwd-default-20050517"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-nmiwd-default-20050517"

--- ./arch/i386/Kconfig.debug.nmiwd	2005-05-10 16:09:57.000000000 +0400
+++ ./arch/i386/Kconfig.debug	2005-05-17 10:49:03.000000000 +0400
@@ -59,6 +59,14 @@ config 4KSTACKS
 	  on the VM subsystem for higher order allocations. This option
 	  will also use IRQ stacks to compensate for the reduced stackspace.
 
+config NMI_WATCHDOG
+	bool "NMI Watchdog"
+	default y
+	help
+	  If you say Y here the kernel will activate NMI watchdog by default
+	  on boot. You can still activate NMI watchdog via nmi_watchdog
+	  command line option even if you say N here.
+
 config X86_FIND_SMP_CONFIG
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
--- ./arch/i386/kernel/nmi.c.nmiwd	2005-05-10 18:20:00.000000000 +0400
+++ ./arch/i386/kernel/nmi.c	2005-05-17 10:47:38.000000000 +0400
@@ -34,7 +34,12 @@
 
 #include "mach_traps.h"
 
-unsigned int nmi_watchdog = NMI_NONE;
+#ifdef CONFIG_NMI_WATCHDOG
+#define NMI_DEFAULT NMI_IO_APIC
+#else
+#define NMI_DEFAULT NMI_NONE
+#endif
+unsigned int nmi_watchdog = NMI_DEFAULT;
 extern int unknown_nmi_panic;
 static unsigned int nmi_hz = HZ;
 static unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */

--------------060603090406020201000701--

