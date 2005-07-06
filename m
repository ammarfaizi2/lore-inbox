Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVGFCWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVGFCWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVGFCU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:20:29 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:60568 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262042AbVGFCTO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:14 -0400
Subject: [PATCH] [11/48] Suspend2 2.1.9.8 for 2.6.12: 401-e820-table-support.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:40 +1000
Message-Id: <11206164403490@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 402-mtrr-remove-sysdev.patch-old/arch/i386/kernel/cpu/mtrr/main.c 402-mtrr-remove-sysdev.patch-new/arch/i386/kernel/cpu/mtrr/main.c
--- 402-mtrr-remove-sysdev.patch-old/arch/i386/kernel/cpu/mtrr/main.c	2005-06-20 11:46:42.000000000 +1000
+++ 402-mtrr-remove-sysdev.patch-new/arch/i386/kernel/cpu/mtrr/main.c	2005-07-04 23:14:19.000000000 +1000
@@ -166,7 +166,6 @@ static void ipi_handler(void *info)
 	atomic_dec(&data->count);
 	local_irq_restore(flags);
 }
-
 #endif
 
 /**
@@ -560,7 +559,7 @@ struct mtrr_value {
 
 static struct mtrr_value * mtrr_state;
 
-static int mtrr_save(struct sys_device * sysdev, u32 state)
+int mtrr_save(void)
 {
 	int i;
 	int size = num_var_ranges * sizeof(struct mtrr_value);
@@ -580,28 +579,27 @@ static int mtrr_save(struct sys_device *
 	return 0;
 }
 
-static int mtrr_restore(struct sys_device * sysdev)
+/* Restore mtrrs on this CPU only.
+ * Done with interrupts disabled via __smp_lowlevel_suspend
+ */
+int mtrr_restore_one_cpu(void)
 {
 	int i;
 
 	for (i = 0; i < num_var_ranges; i++) {
 		if (mtrr_state[i].lsize) 
-			set_mtrr(i,
+			mtrr_if->set(i,
 				 mtrr_state[i].lbase,
 				 mtrr_state[i].lsize,
 				 mtrr_state[i].ltype);
 	}
-	kfree(mtrr_state);
 	return 0;
 }
 
-
-
-static struct sysdev_driver mtrr_sysdev_driver = {
-	.suspend	= mtrr_save,
-	.resume		= mtrr_restore,
-};
-
+void mtrr_restore_finish(void)
+{
+	kfree(mtrr_state);
+}
 
 /**
  * mtrr_init - initialize mtrrs on the boot CPU
@@ -669,8 +667,7 @@ static int __init mtrr_init(void)
 		init_table();
 		init_other_cpus();
 
-		return sysdev_driver_register(&cpu_sysdev_class,
-					      &mtrr_sysdev_driver);
+		return 0;
 	}
 	return -ENXIO;
 }

