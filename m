Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTEGJVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTEGJVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:21:04 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:2538 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263019AbTEGJVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:21:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16056.53993.774345.897852@gargle.gargle.HOWL>
Date: Wed, 7 May 2003 11:33:29 +0200
From: mikpe@csd.uu.se
To: Dave Jones <davej@codemonkey.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] restore sysenter MSRs at resume
In-Reply-To: <20030506223534.GA3339@suse.de>
References: <16056.4728.649612.413159@gargle.gargle.HOWL>
	<20030506223534.GA3339@suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:
 > On Tue, May 06, 2003 at 09:52:24PM +0200, mikpe@csd.uu.se wrote:
 >  > suspending the box (apm). At resume, I am immediately greeted with an
 >  > oops looking like:
 >  > 
 >  > general protection fault: 0000 [#?]
 >  > CPU:	0
 >  > EIP:	0060:[<c0109079>]	Not tainted
 >  > EFLAGS:	00010246
 >  > EIP is at systenter_past_esp+0x6e/0x71
 > 
 > I wonder if your BIOS is trashing the sysenter MSRs on suspend.
 > Maybe they need restoring ?

I've confirmed that that's exatly what's happening. EIP points to
the sysexit instruction in entry.S, and the sysenter MSRs are all zero.

The patch below hooks sysenter into the driver model and implements
a resume() method which restores the sysenter MSRs. On my '98 vintage
Latitude, this is necessary since those MSRs are cleared at resume.
Failure to restore them leads to oopses and eventual kernel hang.
(Of course, your user-space must also use sysenter. RH9 does.)

The patch has a debug printk() for problematic systems that require
the fix. If it says your machine didn't preserve the MSRs, please
post a note about this to LKML with your machine model, so we can
estimate the scope of the problem.

/Mikael

diff -ruN linux-2.5.69/arch/i386/kernel/sysenter.c linux-2.5.69.sysenter-pm/arch/i386/kernel/sysenter.c
--- linux-2.5.69/arch/i386/kernel/sysenter.c	2003-05-05 22:56:28.000000000 +0200
+++ linux-2.5.69.sysenter-pm/arch/i386/kernel/sysenter.c	2003-05-07 10:50:39.690468848 +0200
@@ -51,6 +51,53 @@
 	put_cpu();	
 }
 
+#ifdef CONFIG_PM
+#include <linux/device.h>
+
+static int sysenter_resume(struct device *dev, u32 state, u32 level)
+{
+	if (level != RESUME_POWER_ON)
+		return 0;
+	/* for collecting statistics, will go away */
+	{
+		unsigned int h, l0, l1, l2;
+		rdmsr(MSR_IA32_SYSENTER_CS, l0, h);
+		rdmsr(MSR_IA32_SYSENTER_ESP, l1, h);
+		rdmsr(MSR_IA32_SYSENTER_EIP, l2, h);
+		if (!l0 || !l1 || !l2)
+			printk("sysenter_resume: your BIOS didn't preserve the SYSENTER MSRs\n");
+		else
+			printk("sysenter_resume: congratulations, your BIOS seems Ok\n");
+	}
+	enable_sep_cpu(NULL);
+	return 0;
+}
+
+static struct device_driver sysenter_driver = {
+	.name		= "sysenter",
+	.bus		= &system_bus_type,
+	.resume		= sysenter_resume,
+};
+
+static struct sys_device device_sysenter = {
+	.name		= "sysenter",
+	.id		= 0,
+	.dev		= {
+		.name	= "sysenter",
+		.driver	= &sysenter_driver,
+	},
+};
+
+static int __init init_sysenter_devicefs(void)
+{
+	driver_register(&sysenter_driver);
+	return sys_device_register(&device_sysenter);
+}
+
+#else	/* CONFIG_PM */
+static inline int init_sysenter_devicefs(void) { return 0; }
+#endif	/* CONFIG_PM */
+
 /*
  * These symbols are defined by vsyscall.o to mark the bounds
  * of the ELF DSO images included therein.
@@ -76,7 +123,7 @@
 	       &vsyscall_sysenter_end - &vsyscall_sysenter_start);
 
 	on_each_cpu(enable_sep_cpu, NULL, 1, 1);
-	return 0;
+	return init_sysenter_devicefs();
 }
 
 __initcall(sysenter_setup);
