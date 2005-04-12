Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVDLKih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVDLKih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVDLKhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:37:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:6856 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262121AbVDLKbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:10 -0400
Message-Id: <200504121031.j3CAV4PA005229@shell0.pdx.osdl.net>
Subject: [patch 027/198] ppc32: improve timebase sync for SMP
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, paulus@samba.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paul Mackerras <paulus@samba.org>

Currently the procedure in the ppc32 kernel that synchronizes the timebase
registers across an SMP powermac system does so by setting both timebases
to zero.  That is OK at boot but causes problems if done later.  So that we
can do hotplug CPU on these machines, this patch changes the code so it
reads the timebase from one CPU and transfers the value to the other CPU. 
(Hotplug CPU is needed for sleep (aka suspend to RAM) to work.)

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/platforms/pmac_smp.c |   78 +++++++++++++++++++++++-----------
 1 files changed, 54 insertions(+), 24 deletions(-)

diff -puN arch/ppc/platforms/pmac_smp.c~ppc32-improve-timebase-sync-for-smp arch/ppc/platforms/pmac_smp.c
--- 25/arch/ppc/platforms/pmac_smp.c~ppc32-improve-timebase-sync-for-smp	2005-04-12 03:21:09.950624176 -0700
+++ 25-akpm/arch/ppc/platforms/pmac_smp.c	2005-04-12 03:21:09.954623568 -0700
@@ -116,6 +116,8 @@ static unsigned int core99_tb_gpio;
 
 /* Sync flag for HW tb sync */
 static volatile int sec_tb_reset = 0;
+static unsigned int pri_tb_hi, pri_tb_lo;
+static unsigned int pri_tb_stamp;
 
 static void __init core99_init_caches(int cpu)
 {
@@ -453,7 +455,7 @@ static int __init smp_core99_probe(void)
 #endif
 	struct device_node *cpus, *firstcpu;
 	int i, ncpus = 0, boot_cpu = -1;
-	u32 *tbprop;
+	u32 *tbprop = NULL;
 
 	if (ppc_md.progress) ppc_md.progress("smp_core99_probe", 0x345);
 	cpus = firstcpu = find_type_devices("cpu");
@@ -576,46 +578,74 @@ static void __init smp_core99_setup_cpu(
 	}
 }
 
-void __init smp_core99_take_timebase(void)
+/* not __init, called in sleep/wakeup code */
+void smp_core99_take_timebase(void)
 {
-	/* Secondary processor "takes" the timebase by freezing
-	 * it, resetting its local TB and telling CPU 0 to go on
-	 */
-	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, core99_tb_gpio, 4);
-	pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, core99_tb_gpio, 0);
+	unsigned long flags;
+
+	/* tell the primary we're here */
+	sec_tb_reset = 1;
 	mb();
 
-	set_dec(tb_ticks_per_jiffy);
-	set_tb(0, 0);
-	last_jiffy_stamp(smp_processor_id()) = 0;
+	/* wait for the primary to set pri_tb_hi/lo */
+	while (sec_tb_reset < 2)
+		mb();
 
+	/* set our stuff the same as the primary */
+	local_irq_save(flags);
+	set_dec(1);
+	set_tb(pri_tb_hi, pri_tb_lo);
+	last_jiffy_stamp(smp_processor_id()) = pri_tb_stamp;
+	mb();
+
+	/* tell the primary we're done */
+       	sec_tb_reset = 0;
 	mb();
-       	sec_tb_reset = 1;
+	local_irq_restore(flags);
 }
 
-void __init smp_core99_give_timebase(void)
+/* not __init, called in sleep/wakeup code */
+void smp_core99_give_timebase(void)
 {
+	unsigned long flags;
 	unsigned int t;
 
-	/* Primary processor waits for secondary to have frozen
-	 * the timebase, resets local TB, and kick timebase again
-	 */
-	/* wait for the secondary to have reset its TB before proceeding */
-	for (t = 1000; t > 0 && !sec_tb_reset; --t)
-		udelay(1000);
-	if (t == 0)
+	/* wait for the secondary to be in take_timebase */
+	for (t = 100000; t > 0 && !sec_tb_reset; --t)
+		udelay(10);
+	if (!sec_tb_reset) {
 		printk(KERN_WARNING "Timeout waiting sync on second CPU\n");
+		return;
+	}
 
-       	set_dec(tb_ticks_per_jiffy);
-	set_tb(0, 0);
-	last_jiffy_stamp(smp_processor_id()) = 0;
+	/* freeze the timebase and read it */
+	/* disable interrupts so the timebase is disabled for the
+	   shortest possible time */
+	local_irq_save(flags);
+	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, core99_tb_gpio, 4);
+	pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, core99_tb_gpio, 0);
+	mb();
+	pri_tb_hi = get_tbu();
+	pri_tb_lo = get_tbl();
+	pri_tb_stamp = last_jiffy_stamp(smp_processor_id());
 	mb();
 
+	/* tell the secondary we're ready */
+	sec_tb_reset = 2;
+	mb();
+
+	/* wait for the secondary to have taken it */
+	for (t = 100000; t > 0 && sec_tb_reset; --t)
+		udelay(10);
+	if (sec_tb_reset)
+		printk(KERN_WARNING "Timeout waiting sync(2) on second CPU\n");
+	else
+		smp_tb_synchronized = 1;
+
 	/* Now, restart the timebase by leaving the GPIO to an open collector */
        	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, core99_tb_gpio, 0);
         pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, core99_tb_gpio, 0);
-
-	smp_tb_synchronized = 1;
+	local_irq_restore(flags);
 }
 
 
_
