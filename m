Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317770AbSFLT2p>; Wed, 12 Jun 2002 15:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317771AbSFLT2o>; Wed, 12 Jun 2002 15:28:44 -0400
Received: from [195.39.17.254] ([195.39.17.254]:17571 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317770AbSFLT2l>;
	Wed, 12 Jun 2002 15:28:41 -0400
Date: Wed, 12 Jun 2002 21:28:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>,
        ducrot@poupinou.org
Subject: S4bios support
Message-ID: <20020612192820.GA114@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I ported s4bios support to 2.5.21 and make it somehow work on my
machine. It suspend, resumes (with nice graphics ;-), but kernel does
not wake up devices properly. If someone wants to play...
									Pavel
--- linux-swsusp/arch/i386/kernel/suspend.c	Wed Jun 12 08:39:31 2002
+++ linux-s4bios/arch/i386/kernel/suspend.c	Wed Jun 12 20:31:43 2002
@@ -302,3 +302,18 @@
 	do_magic_resume_2();
 }
 #endif
+
+void do_suspend_magic_s4bios(int resume)
+{
+	if (!resume) {
+		save_processor_context();
+		acpi_save_register_state((unsigned long) &&acpi_sleep_done);
+		acpi_enter_s4bios();
+		return;
+	}
+acpi_sleep_done:
+	restore_processor_context();
+	printk("CPU context restored...\n");
+}
+
+
--- linux-swsusp/drivers/acpi/hardware/hwsleep.c	Mon Jun  3 11:43:29 2002
+++ linux-s4bios/drivers/acpi/hardware/hwsleep.c	Wed Jun 12 20:51:44 2002
@@ -24,6 +24,8 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/delay.h>
+
 #include "acpi.h"
 
 #define _COMPONENT          ACPI_HARDWARE
@@ -289,9 +291,10 @@
 		 * away entirely.
 		 */
 		acpi_os_stall (10000000);
-
+#if 0
 		status = acpi_hw_register_write (ACPI_MTX_LOCK, ACPI_REGISTER_PM1_CONTROL,
 				 sleep_enable_reg_info->access_bit_mask);
+#endif
 		if (ACPI_FAILURE (status)) {
 			return_ACPI_STATUS (status);
 		}
@@ -311,6 +314,56 @@
 
 	return_ACPI_STATUS (AE_OK);
 }
+
+
+/******************************************************************************
+ *
+ * FUNCTION:    Acpi_enter_s4bios
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Perform a s4 bios request.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_enter_s4bios (void)
+{
+	acpi_status         status;
+	u32                     in_value;
+
+	ACPI_FUNCTION_TRACE ("Acpi_enter_s4bios");
+	printk("Acpi_enter_s4bios\n");
+
+	acpi_set_register (ACPI_BITREG_WAKE_STATUS, 1, ACPI_MTX_LOCK);
+	printk("2\n");
+	acpi_hw_clear_acpi_status();
+
+	printk("3\n");
+	acpi_hw_disable_non_wakeup_gpes();
+
+	printk("4\n");
+	ACPI_FLUSH_CPU_CACHE();
+
+	printk("go");
+	mdelay(1000);
+	status = acpi_os_write_port (acpi_gbl_FADT->smi_cmd, (acpi_integer) acpi_gbl_FADT->S4bios_req, 8);
+
+	printk("5\n");
+	do {
+		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
+		if (ACPI_FAILURE (status)) {
+			return_ACPI_STATUS (status);
+		}
+
+		printk("6");
+		/* Spin until we wake */
+
+	} while (!in_value);
+
+	return_ACPI_STATUS (AE_OK);
+}
+
 
 /******************************************************************************
  *
--- linux-swsusp/drivers/acpi/system.c	Mon Jun 10 23:03:25 2002
+++ linux-s4bios/drivers/acpi/system.c	Wed Jun 12 21:05:08 2002
@@ -26,6 +26,7 @@
 #define ACPI_C
 #define HAVE_NEW_DEVICE_MODEL
 
+#define HAVE_NEW_DEVICE_MODEL
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -99,6 +100,17 @@
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 
+static void
+acpi_enter_suspend_to_disk(void)
+{
+	acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) acpi_wakeup_address);
+	acpi_enter_sleep_state_prep(ACPI_STATE_S4);
+	ACPI_DISABLE_IRQS();
+	acpi_enter_sleep_state(ACPI_STATE_S4);
+	acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) 0);
+}
+
+
 #endif /*CONFIG_PM*/
 
 
@@ -199,8 +211,10 @@
 		if (state > ACPI_STATE_S1) {
 			error = acpi_save_state_mem();
 
+#if 0
 			if (!error && (state == ACPI_STATE_S4))
 				error = acpi_save_state_disk();
+#endif
 
 #ifdef HAVE_NEW_DEVICE_MODEL
 			if (error) {
@@ -278,6 +292,9 @@
 	case ACPI_STATE_S3:
 		do_suspend_lowlevel(0);
 		break;
+	case ACPI_STATE_S4:
+		do_suspend_magic_s4bios(0);
+		break;
 	}
 	restore_flags(flags);
 
@@ -300,7 +317,21 @@
 	if (state < ACPI_STATE_S1 || state > ACPI_STATE_S5)
 		return AE_ERROR;
 
-	freeze_processes();		/* device_suspend needs processes to be stopped */
+	switch (state) {
+	case ACPI_STATE_S1:
+		break;
+	case ACPI_STATE_S2:
+	case ACPI_STATE_S3:
+	case ACPI_STATE_S4:
+		/* do we have a wakeup address for S2, S3 and S4? */
+		if (!acpi_wakeup_address)
+			return AE_ERROR;
+		freeze_processes();
+		acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) acpi_wakeup_address);
+		break;
+	default:
+		break;
+	}
 
 	/* do we have a wakeup address for S2 and S3? */
 	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3) {
@@ -326,15 +357,22 @@
 	 * mode. So, we run these unconditionaly to make sure we have a usable system
 	 * no matter what.
 	 */
-	acpi_system_restore_state(state);
+	printk("restore_state\n");
+//	acpi_system_restore_state(state);
+	printk("leave_sleep\n");
 	acpi_leave_sleep_state(state);
+	printk("enable\n");
 
 	/* make sure interrupts are enabled */
 	ACPI_ENABLE_IRQS();
 
-	/* reset firmware waking vector */
-	acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) 0);
-	thaw_processes();
+	if (state != ACPI_STATE_S1) {
+		/* reset firmware waking vector */
+		acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) 0);
+
+		thaw_processes();
+	}
+	printk("ready?\n");
 
 	return status;
 }
@@ -717,7 +755,7 @@
 
 	
 #ifdef CONFIG_SOFTWARE_SUSPEND
-	if (state == 4) {
+	if (state == 4 && state_string[1] != 'b') {
 		software_suspend();
 		return_VALUE(count);
 	}
--- linux-swsusp/include/asm-i386/acpi.h	Mon Jun  3 11:43:37 2002
+++ linux-s4bios/include/asm-i386/acpi.h	Wed Jun 12 11:00:21 2002
@@ -138,6 +138,9 @@
 /* early initialization routine */
 extern void acpi_reserve_bootmem(void);
 
+extern void do_suspend_magic(int);
+extern void do_suspend_magic_s4(int);
+
 #endif /*CONFIG_ACPI_SLEEP*/
 
 #endif /*__KERNEL__*/
--- linux-swsusp/include/linux/suspend.h	Wed Jun 12 08:43:51 2002
+++ linux-s4bios/include/linux/suspend.h	Wed Jun 12 11:00:21 2002
@@ -48,6 +48,9 @@
 /* mm/vmscan.c */
 extern int shrink_mem(void);
 
+/* kernel/signal.c */
+extern inline void signal_wake_up (struct task_struct *);
+
 /* kernel/suspend.c */
 extern void software_suspend(void);
 extern void software_resume(void);
@@ -55,6 +58,9 @@
 extern int register_suspend_notifier(struct notifier_block *);
 extern int unregister_suspend_notifier(struct notifier_block *);
 extern void refrigerator(unsigned long);
+
+extern int freeze_processes(void);
+extern void thaw_processes(void); 
 
 extern int freeze_processes(void);
 extern void thaw_processes(void);

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
