Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWJFIQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWJFIQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 04:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWJFIQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 04:16:25 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:56565 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1750834AbWJFIQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 04:16:24 -0400
Date: Fri, 6 Oct 2006 01:16:07 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] x86_64 add missing enter_idle() calls
Message-ID: <20061006081607.GB8793@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Unless I am mistaken, I think we are missing some calls to enter_idle()
in the x86_64 tree. The following patch adds a bunch of missing
enter_idle() callbacks for some of the "direct" interrupt handlers.

changelog:
	- adds missing enter_idle() calls to most of the "direct" interrupt
	  handlers.

signed-off-by: stephane eranian <eranian@hpl.hp.com>

diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
index af4a1c7..74ed3b8 100644
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -1015,6 +1015,7 @@ #if 0
 	} 
 #endif 
 	irq_exit();
+	enter_idle();
 }
 
 /*
@@ -1047,6 +1048,7 @@ asmlinkage void smp_error_interrupt(void
 	printk (KERN_DEBUG "APIC error on CPU%d: %02x(%02x)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
+	enter_idle();
 }
 
 int disable_apic; 
diff --git a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
index b8a407f..28c73d8 100644
--- a/arch/x86_64/kernel/irq.c
+++ b/arch/x86_64/kernel/irq.c
@@ -127,6 +127,7 @@ #endif
 	irq_exit();
 
 	set_irq_regs(old_regs);
+	enter_idle();
 	return 1;
 }
 
diff --git a/arch/x86_64/kernel/mce_amd.c b/arch/x86_64/kernel/mce_amd.c
index 883fe74..4b458eb 100644
--- a/arch/x86_64/kernel/mce_amd.c
+++ b/arch/x86_64/kernel/mce_amd.c
@@ -224,6 +224,7 @@ asmlinkage void mce_threshold_interrupt(
 	}
 out:
 	irq_exit();
+	enter_idle();
 }
 
 /*
diff --git a/arch/x86_64/kernel/mce_intel.c b/arch/x86_64/kernel/mce_intel.c
index 6551505..030b1e3 100644
--- a/arch/x86_64/kernel/mce_intel.c
+++ b/arch/x86_64/kernel/mce_intel.c
@@ -27,6 +27,7 @@ asmlinkage void smp_thermal_interrupt(vo
 		mce_log_therm_throt_event(smp_processor_id(), msr_val);
 
 	irq_exit();
+	enter_idle();
 }
 
 static void __cpuinit intel_init_thermal(struct cpuinfo_x86 *c)
diff --git a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
diff --git a/arch/x86_64/kernel/smp.c b/arch/x86_64/kernel/smp.c
index 4f67697..c1d70e3 100644
--- a/arch/x86_64/kernel/smp.c
+++ b/arch/x86_64/kernel/smp.c
@@ -520,5 +520,6 @@ asmlinkage void smp_call_function_interr
 		mb();
 		atomic_inc(&call_data->finished);
 	}
+	enter_idle();
 }
 
