Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293734AbSCKNcw>; Mon, 11 Mar 2002 08:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293733AbSCKNcl>; Mon, 11 Mar 2002 08:32:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:45929 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293727AbSCKNcf>;
	Mon, 11 Mar 2002 08:32:35 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Wolly <wwolly@gmx.net>
To: andrew.grover@intel.com, acpi-devel@lists.sourceforge.net
Subject: [patch] ACPI power off via sysrq
Date: Mon, 11 Mar 2002 14:30:30 +0100
X-Mailer: KMail [version 1.2.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020311133239Z293727-889+120562@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notized that APM is able to power off the machine using 
sysrq key `o´ while ACPI is not. So, here is a patch to fix that. 

I've tested this patch with and without sysrq config and it 
works fine for me. 

Andy [Grover], please check if things are okay. I inserted a 
> pm_power_off = sm_pm_power_off;
in the cleanup routine as it appears to me that the setup 
routine saves the original power off function in sm_pm_power_off 
and it would probably be wise to restore the original pointer 
upon cleanup...

Regards,
Wolly

Patch is against 2.4.18 kernel;
patched file sm_osl.c is in drivers/acpi/ospm/system/

---------------------------<patch>---------------------------
diff -u sm_osl.c sm_osl.c-patched 
--- sm_osl.c	Mon Mar 11 12:52:07 2002
+++ sm_osl.c-patched	Mon Mar 11 14:01:28 2002
@@ -36,6 +36,8 @@
 #include <linux/mc146818rtc.h>
 #include <linux/delay.h>
 
+#include <linux/sysrq.h>
+
 #include <acpi.h>
 #include "sm.h"
 
@@ -737,6 +739,24 @@
 }
 
 
+#ifdef CONFIG_MAGIC_SYSRQ
+
+/* Simple wrapper calling power down function. */
+static void sysrq_sm_osl_power_down(int key, struct pt_regs *pt_regs,
+	struct kbd_struct *kbd, struct tty_struct *tty)
+{
+	sm_osl_power_down();
+}
+
+struct sysrq_key_op sysrq_acpi_poweroff_op = {
+	handler:	&sm_osl_power_down,
+	help_msg:	"Off",
+	action_msg:	"Power Off\n"
+};
+
+#endif  /* CONFIG_MAGIC_SYSRQ */
+
+
 /****************************************************************************
  *
  * FUNCTION:	sm_osl_add_device
@@ -765,6 +785,7 @@
 	if (system->states[ACPI_STATE_S5]) {
 		sm_pm_power_off = pm_power_off;
 		pm_power_off = sm_osl_power_down;
+		register_sysrq_key('o', &sysrq_acpi_poweroff_op);
 	}
 
 	create_proc_read_entry(SM_PROC_INFO, S_IRUGO,
@@ -828,6 +849,11 @@
 
 	remove_proc_entry(SM_PROC_INFO, sm_proc_root);
 	remove_proc_entry(SM_PROC_DSDT, sm_proc_root);
+
+	unregister_sysrq_key('o', &sysrq_acpi_poweroff_op);
+
+	/* Restore power off vector... */
+	pm_power_off = sm_pm_power_off;
 
 	return(AE_OK);
 }
