Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbUKXN1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUKXN1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbUKXN1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:27:38 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:46996 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262652AbUKXNB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:01:59 -0500
Subject: Suspend 2 merge: 19/51: Remove MTRR sysdev support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101295453.5805.263.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:58:16 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes sysdev support for MTRRs (potential SMP hang and
shouldn't be done with interrupts done anyway). Instead, we save and
restore MTRRs when entering and exiting the processor freezers (ie when
saving the registers & context for each CPU via an SMP call).

diff -ruN 510-mtrr-remove-sysdev-old/arch/i386/kernel/cpu/mtrr/main.c 510-mtrr-remove-sysdev-new/arch/i386/kernel/cpu/mtrr/main.c
--- 510-mtrr-remove-sysdev-old/arch/i386/kernel/cpu/mtrr/main.c	2004-11-03 21:51:13.000000000 +1100
+++ 510-mtrr-remove-sysdev-new/arch/i386/kernel/cpu/mtrr/main.c	2004-11-04 16:27:40.000000000 +1100
@@ -167,7 +167,6 @@
 	atomic_dec(&data->count);
 	local_irq_restore(flags);
 }
-
 #endif
 
 /**
@@ -564,7 +563,7 @@
 
 static struct mtrr_value * mtrr_state;
 
-static int mtrr_save(struct sys_device * sysdev, u32 state)
+int mtrr_save(void)
 {
 	int i;
 	int size = num_var_ranges * sizeof(struct mtrr_value);
@@ -584,28 +583,27 @@
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
@@ -692,8 +690,7 @@
 		init_table();
 		init_other_cpus();
 
-		return sysdev_driver_register(&cpu_sysdev_class,
-					      &mtrr_sysdev_driver);
+		return 0;
 	}
 	return -ENXIO;
 }


