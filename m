Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTDMXlJ (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 19:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbTDMXlJ (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 19:41:09 -0400
Received: from [12.47.58.73] ([12.47.58.73]:20253 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262687AbTDMXlH (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 19:41:07 -0400
Date: Sun, 13 Apr 2003 16:52:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: Nicholas Wourms <nwourms@myrealbox.com>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Early boot oops with 2.5.67-bk(current) on a dual Athlon-MP
 [Asus A7M266-D] machine
Message-Id: <20030413165259.36fb0f97.akpm@digeo.com>
In-Reply-To: <3E99B9B4.8000304@myrealbox.com>
References: <3E99B9B4.8000304@myrealbox.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2003 23:52:50.0132 (UTC) FILETIME=[CA7ED940:01C30217]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Wourms <nwourms@myrealbox.com> wrote:
>
> Hi,
> 
> Attached is the oops (which results in a panic) when I 
> attempt to boot the lastest bk current on my machine.

The MCE code is using the workqueue infrastructure waaaaaaay earlier than it
is allowed to.  It looks like the timer went off before the workqueue
initialisation had been run.

This should fix it.


 arch/i386/kernel/cpu/mcheck/k7.c        |    4 ----
 arch/i386/kernel/cpu/mcheck/mce.h       |    2 --
 arch/i386/kernel/cpu/mcheck/non-fatal.c |    5 ++++-
 arch/i386/kernel/cpu/mcheck/p4.c        |    3 ---
 4 files changed, 4 insertions(+), 10 deletions(-)

diff -puN arch/i386/kernel/cpu/mcheck/k7.c~mce-workqueue-startup-fix arch/i386/kernel/cpu/mcheck/k7.c
--- 25/arch/i386/kernel/cpu/mcheck/k7.c~mce-workqueue-startup-fix	2003-04-13 16:41:36.000000000 -0700
+++ 25-akpm/arch/i386/kernel/cpu/mcheck/k7.c	2003-04-13 16:42:24.000000000 -0700
@@ -92,8 +92,4 @@ void __init amd_mcheck_init(struct cpuin
 	set_in_cr4 (X86_CR4_MCE);
 	printk (KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n",
 		smp_processor_id());
-
-#ifdef CONFIG_X86_MCE_NONFATAL
-	init_nonfatal_mce_checker();
-#endif
 }
diff -puN arch/i386/kernel/cpu/mcheck/mce.h~mce-workqueue-startup-fix arch/i386/kernel/cpu/mcheck/mce.h
--- 25/arch/i386/kernel/cpu/mcheck/mce.h~mce-workqueue-startup-fix	2003-04-13 16:41:43.000000000 -0700
+++ 25-akpm/arch/i386/kernel/cpu/mcheck/mce.h	2003-04-13 16:42:27.000000000 -0700
@@ -6,8 +6,6 @@ void intel_p5_mcheck_init(struct cpuinfo
 void intel_p6_mcheck_init(struct cpuinfo_x86 *c);
 void winchip_mcheck_init(struct cpuinfo_x86 *c);
 
-void init_nonfatal_mce_checker(void);
-
 /* Call the installed machine check handler for this CPU setup. */
 extern void (*machine_check_vector)(struct pt_regs *, long error_code);
 
diff -puN arch/i386/kernel/cpu/mcheck/non-fatal.c~mce-workqueue-startup-fix arch/i386/kernel/cpu/mcheck/non-fatal.c
--- 25/arch/i386/kernel/cpu/mcheck/non-fatal.c~mce-workqueue-startup-fix	2003-04-13 16:41:50.000000000 -0700
+++ 25-akpm/arch/i386/kernel/cpu/mcheck/non-fatal.c	2003-04-13 16:45:01.000000000 -0700
@@ -11,6 +11,7 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
+#include <linux/module.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
@@ -65,7 +66,7 @@ static void mce_timerfunc (unsigned long
 	add_timer (&mce_timer);
 }	
 
-void init_nonfatal_mce_checker()
+static int init_nonfatal_mce_checker()
 {
 	if (timerset == 0) {
 		/* Set the timer to check for non-fatal
@@ -78,4 +79,6 @@ void init_nonfatal_mce_checker()
 		timerset = 1;
 		printk(KERN_INFO "Machine check exception polling timer started.\n");
 	}
+	return 0;
 }
+module_init(init_nonfatal_mce_checker);
diff -puN arch/i386/kernel/cpu/mcheck/p4.c~mce-workqueue-startup-fix arch/i386/kernel/cpu/mcheck/p4.c
--- 25/arch/i386/kernel/cpu/mcheck/p4.c~mce-workqueue-startup-fix	2003-04-13 16:42:03.000000000 -0700
+++ 25-akpm/arch/i386/kernel/cpu/mcheck/p4.c	2003-04-13 16:44:22.000000000 -0700
@@ -255,7 +255,4 @@ void __init intel_p4_mcheck_init(struct 
 		intel_init_thermal(c);
 #endif
 	}
-#ifdef CONFIG_X86_MCE_NONFATAL
-	init_nonfatal_mce_checker();
-#endif
 }

_




