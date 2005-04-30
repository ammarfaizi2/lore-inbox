Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVD3TvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVD3TvO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 15:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVD3TvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 15:51:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:2538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261381AbVD3Tu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 15:50:27 -0400
Date: Sat, 30 Apr 2005 12:46:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Coywolf Qi Hunt" <coywolf@lovecn.org>
Cc: coywolf@gmail.com, zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       ak@muc.de, bunk@stusta.de, Li Shaohua <shaohua.li@intel.com>
Subject: Re: 2.6.12-rc3-mm1
Message-Id: <20050430124611.54b5ab15.akpm@osdl.org>
In-Reply-To: <20050430180823.GA14922@lovecn.org>
References: <20050429231653.32d2f091.akpm@osdl.org>
	<20050430142035.GB3571@stusta.de>
	<Pine.LNX.4.61.0504300940560.12903@montezuma.fsmlabs.com>
	<2cd57c9005043010051c6455fb@mail.gmail.com>
	<20050430180823.GA14922@lovecn.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, guys.  I seem to have it limping along on UP now, partly with the
below.

Li, it's a bit awkward to be calling things by hand on SMP and with an
initcall on UP.  Maybe something neater can be done there.

I quickly tested suspend/resume on UP.  Appears to work.



 arch/i386/kernel/sysenter.c  |   10 ++++++++++
 arch/i386/power/cpu.c        |    2 ++
 include/asm-i386/processor.h |    1 +
 include/asm-i386/smp.h       |    1 -
 4 files changed, 13 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/sysenter.c~sep-initializing-rework-fix arch/i386/kernel/sysenter.c
--- 25/arch/i386/kernel/sysenter.c~sep-initializing-rework-fix	2005-04-30 12:20:20.370077048 -0700
+++ 25-akpm/arch/i386/kernel/sysenter.c	2005-04-30 12:20:20.375076288 -0700
@@ -65,3 +65,13 @@ int __init sysenter_setup(void)
 
 	return 0;
 }
+
+#ifndef CONFIG_SMP
+static int __init sysenter_sep_setup(void)
+{
+	sysenter_setup();
+	enable_sep_cpu();
+	return 0;
+}
+module_init(sysenter_sep_setup);
+#endif
diff -puN arch/i386/power/cpu.c~sep-initializing-rework-fix arch/i386/power/cpu.c
--- 25/arch/i386/power/cpu.c~sep-initializing-rework-fix	2005-04-30 12:20:20.371076896 -0700
+++ 25-akpm/arch/i386/power/cpu.c	2005-04-30 12:20:35.890717552 -0700
@@ -22,9 +22,11 @@
 #include <linux/device.h>
 #include <linux/suspend.h>
 #include <linux/acpi.h>
+
 #include <asm/uaccess.h>
 #include <asm/acpi.h>
 #include <asm/tlbflush.h>
+#include <asm/processor.h>
 
 static struct saved_context saved_context;
 
diff -puN include/asm-i386/processor.h~sep-initializing-rework-fix include/asm-i386/processor.h
--- 25/include/asm-i386/processor.h~sep-initializing-rework-fix	2005-04-30 12:20:41.633844464 -0700
+++ 25-akpm/include/asm-i386/processor.h	2005-04-30 12:21:04.316396192 -0700
@@ -691,5 +691,6 @@ extern void select_idle_routine(const st
 #define cache_line_size() (boot_cpu_data.x86_cache_alignment)
 
 extern unsigned long boot_option_idle_override;
+extern void enable_sep_cpu(void);
 
 #endif /* __ASM_I386_PROCESSOR_H */
diff -puN include/asm-i386/smp.h~sep-initializing-rework-fix include/asm-i386/smp.h
--- 25/include/asm-i386/smp.h~sep-initializing-rework-fix	2005-04-30 12:20:45.463262304 -0700
+++ 25-akpm/include/asm-i386/smp.h	2005-04-30 12:20:53.140095248 -0700
@@ -38,7 +38,6 @@ extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
 
 extern int sysenter_setup(void);
-extern void enable_sep_cpu(void);
 
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
_

